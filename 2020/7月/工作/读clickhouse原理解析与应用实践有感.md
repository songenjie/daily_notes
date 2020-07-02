# clickhouse 原理解析与应用实践有感

## 前四章 没啥看的

## 第五章  用到的时候可以仔细看看咋用

## 第六章  比较合适我们看

### MergeTree

#### 结构

| Replicated | Replcaing           | MergeTree |
| ---------- | ------------------- | --------- |
|            | Summing             |           |
|            | Aggregating         |           |
|            | Collapsing          |           |
|            | VersionedCollapsing |           |
|            | Graphite            |           |

#### 设置

| Create Table                                     | 含义                                                         |
| ------------------------------------------------ | ------------------------------------------------------------ |
| PARTITION BY [选填]                              | 分区键(可以是单个列的字段，也可以通过元祖的形式使用多列)，不使用会生成一个all的分区 |
| ORDER BY [必填]                                  | 排序键(指定一个数据片段内，数据以何种标准排序，默认情况下主键<PRIMARY KEY>与排序键线通,可以是单个列的字段，也可以是通过元组的形式使用多个列字段，*个人记录（ORDER BY)会影响压缩,前序相同的会压缩到一个文件中，所以很重要，尤其是针对大量数据，（性别，年龄，城市，日期这种字段） |
| PRIMARY KEY [选填]                               | 主键(主键字段,声明后，会依照主键字段生成一级索引），加速表查询<这里看来，order by 尽量和 主键一致>),两者相同，order by 直接代位主键， |
| SAMPLE BY [必填]                                 | 抽样表达式（用于声明数据以何种标准进行采样，此配置项需要出现在主键的配置项中 |
| SETTINGS：  index_granulartity [选填]            | Index_granularitry 对于MergeTree,表示索引的粒度，默认是8192，意思就是每隔8192行数据才生成一条索引。    8192 clickhouse大量使用，可以被最小压缩块 min_compress_block_size: 655354 整除。通常情况不需要修改此参数 |
| SETTINGS: index_granularity_bytes [选填]         | 自适应间隔大小的特性，即根据每一批写入数据的体量大小，动态划分间隔大小，二数据的体量大小，是由index_granularity_bytes参数控制，默认是10M(10*1024*1024),设置为0表示不启动自适应功能 |
| SETTINGS: enable_mixed_granularity_parts  [选填] | 设置是否开启自适应索引间隔的功能，默认开启                   |
| SETTINGS: merge_with_ttl_timeout [选填]          | 第7章                                                        |
| SETTINGS: storage_policy [选填]                  | 多路径存储策略 第七章                                        |

#### 存储结构

![存储结构](/source/clickhouse 存储结构.jpg)

| 结构                                 | 含义                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| Part                                 | Part (类似分区的一个叶子结点的一个part)                      |
| checksums.txt                        | 校验文件，二进制存储，保存了当前目录下各类文件（primary.idx count.txt等）的size大小及size的哈希值，快速校验文件的完整性和正确性 |
| columns.txt                          | 列信息文件,明文存储，保存此数据分片part 下的列信息           |
| count.txt                            | 计数文件，明文格式存储，当前数据分片下目录数据的行数         |
| primary.idx                          | 一级索引文件，使用二进制格式存储，存放哈希索引，一张MergeTree表只能声明一次一级索引，稀疏索引 6.3节 |
| [Column.]bin                         | 数据文件，压缩格式存储 默认LZ4压缩格式，存储某一列的数据 6.5节 |
| [Column.]mrk                         | 列字段标记文件，使用二进制格式存储。保存了.bin文件中国呢数据的偏移量信息。标记文件与稀疏索引对齐，又与.bin文件一一对应，所以MergeTree 通过标记文件建立了 primary.idx 稀疏索引与.bin数据文件之间的映射关系。查询的流程就是1 通过 primary.idx稀疏索引与.bin数据文件之间的映射关系。即首先通过稀疏索引 primary.idx 找到对应数据的偏移量信息(.mrk),再通过偏移量直接从.bin文件中读取数据，由于.mrk标记文件和.bin文件一一对应。所以mergetree中每隔字段都会拥有与其对应的.mrk标记文件 6.6节 |
| [Column].mark2                       | 如果使用了自适应大小的索引间隔，则标记文件会以.mrk2命名。它的工作原理与作用与.mrk相同 |
| Partition.dat 与 minmax_[Column].idx | 如果使用了分区键，例如 PARTITION BY EventTime,则会额外生成 partititon.dat 与 minmax索引文件，它们均使用二进制格式文件存储. Partition.dat 用于保存当前分区下分区表达式最终生成的值；而minmax索引用户记录当前part 下，字段对应原始数据的最小和最大值。toYYYYMM(EventTIME) ,minmax 2019-05-012019-05-05 |

| Skip_idx_[Column].idex | 如果建表语句声明了二级索引，会额外生成相应的二级索引与标记文件，它们同样适用二进制存储，二级索引再Clickhouse中又称跳数索引，目前拥有 minmax、set、ngrambf_v1 和 tokenbf_v1四种类型最终目标与一级索引相同，减少所需扫描的数据范围，加速这个那个查询过程 6.4 |
| ---------------------- | ------------------------------------------------------------ |
| Skip_idx_[Column].mrk  |                                                              |



#### Part 命名规则

```
202006018_0_100_3

partitionid minBlockNum MaxBlockNum Level

分区id,最小/最大块的编号

歧义：很多人理解 max-min = level

BlockNumn是一个整形的自增长编号 

MinBlockNum: 取的是当前分区内所有目录中最小MinBlockNum
MaxBlockNum: 取的是当前分区内所有目录中最大的MaxBlockNum
Level: 同一个分区内最大的Level +1 

Level: 合并的层级 可以理解为该 part 是被合并 level次后形成的，或者说是该part的年龄
对于新创建的分区而言 初始值均为0，合并一次累加一次
```



#### Part 合并

![merge1](/source/clickhouse_part_merge1.jpg)

![merge2](/source/clichouse_part_merge2.jpg)

- 旧的分区不会被立马删除，会留存一段时间，但是就的分区目录已不再是激活状态（activate==0),所以数据查询，旧的分区会被过滤掉



#### 一级索引

也就是稀疏索引，默认每隔 8192 行，报错一个当前列行的索引到 列的idx文件中

##### 索引参数控制

Index_granularity ,新版本 clickhouse适应自适应粒度大小的特性

- 数据

| 序号      | 0          | 1          | ...  | 8192       | 8193       | ...  | 16384      | 16385      | ...  |
| --------- | ---------- | ---------- | ---- | ---------- | ---------- | ---- | ---------- | ---------- | ---- |
| CounterID | 57         | 58         | ...  | 1635       | 1636       | ...  | 3266       | 3267       | ...  |
| EventDate | 2014-03-17 | 2014-03-17 | ...  | 2014-03-20 | 2014-03-20 | ...  | 2014-03-19 | 2014-03-19 | ...  |



- 索引构建过程1 

| order by CounterId | 编号  |
| ------------------ | ----- |
| 57                 | 编号0 |
| 1635               | 编号1 |
| 3266               | 编号2 |

- 索引构建过程12

| order by (CounterId,EventDate) | 编号  |
| ------------------------------ | ----- |
| 572014-03-17                   | 编号0 |
| 16352014-03-20                 | 编号1 |
| 32662014-03-19                 | 编号2 |



#### 索引查询过程

- markrange: 用户定义标记区间的对象 一个markrange ,也就是 完成的数据被按照 index_granularity的间隔粒度，划分成的数据段

Start-end 表示其区间范围 一个 index_granularity 称为 一个 步长 1



- eg index_granularity=3

| A000,A003                  | A003,A006                  |
| -------------------------- | -------------------------- |
| MarkRange:(start:0 ,end:1) | MarkRange(start:1 , end:2) |





### 二级索引

- Index_granularity: 定义数据的粒度
- Granularity: 定义了一行跳数索引能够跳过多少个index_granularity区间的数据

granularity: 就是聚合granularity 个 index_granularitiy个数据 生成一行跳数索引数据



| 类型       | e g                                                          | 含义                                                         |                                                              |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| minmax     | INDEX a ID TYPE minmax GRANULARITY 5                         | 每5个index_granularity区间的数据，ID的最小最大值             |                                                              |
| set        | INDEX b( length(ID) * 8 ) TYPE set(100) GRANULARITY 5        | ID的长度*8后的取值，每隔 set(MAX_ROWS) 是阈值，每个index_granularity 内最多纪录100条 |                                                              |
| ngrambf_v1 | INDEX c(ID,Code) TYPE ngrambf_v1(3,256,2,0) GRANULARITY 5    INDEX(n, size_of_bloom_filter_in_bytes, number_of_hash_functions,random_seed) | 记录数据短语的布隆过滤器，只支持String和FixedString类型 按照3的粒度将数据切割成短语token,token会经过2个Hash函数映射后再被写入，大小为256字节 | n: token 长度 size_of_bloom_filter_in_bytes: 布隆过滤器的大小 number_of_hash_functions: 布隆过滤器中使用Hash函数的个数 rand_seed: Hash函数的随机种子 |
| Tokenbf_v1 | INDEX d ID TYPE tokenbf_v1(256,2,0) GRANULARITY 5            | 自动按照非字符的，数字的字符分割token                        |                                                              |



#### 列式存储

1. 可以更好地进行数据要缩 相同的类型的数据房子啊一起，对压缩更加友好
2. 能够最小化数据扫描的范围



### 数据压缩过程

bin. 文件解析 有多个压缩数据块组成，一个压缩数据块的组成如下：

头信息固定使用9位字节表示，具体由一个Uint8(1字节)整形和2个UInt32(4字节)整型组成，分别代表使用的压缩算法类型，要缩后的数据大小和压缩前的数据大小 0x821200065536

| 压缩方法 CompressionMethod_                 | 数据压缩后字节大小 CompressedSize_ | 数据压缩前数据大小 UncompressedSize |
| ------------------------------------------- | ---------------------------------- | ----------------------------------- |
| Type: UInt8 ,Size: 1Byte                    | Type :UInt32,Size 4Byte            | Type :UInt32,Size 4Byte             |
| 82                                          | 12000                              | 65535                               |
| LZ4:0x82 ZSTD:0x90 Multiple:0x91 Delta:0x92 |                                    |                                     |

执行以下命令：

clickhouse compress --stata < /chbase/ data/default/hits_v1/201403_1_34_3/JavaEnable.bin



- 信息如下

65535 12000

65535 14161

65535 4936

65535 7506



- 数据块大小有 上下线设置 64k~1M 

min_compress_block_size(65535 默认 16k) ~ max_compress_block_size(1048576 1M) ,最终压缩的大小，和一个间隔(index_granularity) 内实际大小有关



- 每一批 默认每次取 8192行数据，一批数据未压缩大小设置为size,写入过程为

1. 单个批次数据 size<64KB，如果单个批次数据小于64KB,则继续获取下一批数据，直至累积到>64Kb,直接生成下一个压缩数据块
2. 单个批次64Kb<size<=1MB,直接生成下一个压缩数据块
3. size>1MB,首先会按照1MB截断并生成下一个压缩数据块，剩余数据，依照上述规则执行



- 形成要缩数据块的目的

1. 虽然能有效减少数据大小，降低存储空间，并加速数据传输效率，单数据的压缩和解压动作，基本也会带来额外的性能损耗。所以需要控制被压缩数据的大小，以求在性能损耗和压缩效率之间寻求一种平衡
2. 在具体读取某一列数据.bin文件的时候，首先需要将压缩数据加载到内存并解压，这样才能进行后续的数据处理，通过压缩数据块，可以不读区整个.bin文件的情况下，将读取粒度降低到压缩数据块级别，进一步缩小数据读取的范围





