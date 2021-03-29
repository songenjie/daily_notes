![image-20210304195711626](image-20210304195711626.png)



![img](https://pic3.zhimg.com/80/67eecf7262927f728dd1c00aa9e0fe46_720w.png)





团队组成

1. 演讲型的选手
2. 重点把 放在 ppt上
3. 大数据与算法通道 未来可落地的 宏观的展望
4. 算法、痛点的优化





存储

1. 深度的列存储

2. 大宽表，每个模型也就是表包含了大量的列

3. 写入，数据总是以相当大的批次写入

4. 数据一致性 更高要求在数据可用性 容错性事务不是必须的，对数据一致性要求低

5. 较少甚至不修改数据

   



查询

1. 读大于写，且大部分是读请求，但是查询也是较少了 偏分析型的数据库 通常每台服务器每秒数百个查询或更少
2. 每次查询都从数据库中读取大量的行，但是同时又仅需要少量的列
3. 处理单个查询时需要高吞吐量（每个服务器每秒高达数十亿行）
4. 查询结果明显小于源数据，换句话说，数据被过滤或聚合后能够被盛放在单台服务器的内存中
5. 查询更适应于只有一个大表的场景





1. 不支持Transaction：想快就别想Transaction
2. 聚合结果必须小于一台机器的内存大小：不是大问题
3. 缺少完整的Update/Delete操作
4. 支持有限操作系统





日增加不到百万行，可以写分布式表和本地表，如果数据量很大建议写本地表

最佳实践：(10-100w/批次) || (1-5/并发) || (30s-～/批次) 





### clickhouse  存储



- partition.dat: 分区信息
- checksum.txt: 数据校验信息
- columns.txt: 列信息
- count.txt: 计数信息
- primary.idx: 一级索引信息，用于存储稀疏索引信息
- [column].bin: 存储某一列的信息，默认使用lz4压缩算法存储
- [column].mrk: 列字段标记问题，保存.bin文件中数据的偏移量信息
- [column].mrk2: 如果定义了自适应索引，则会出现该文件，作用和.mrk文件一样
- partition.dat、minmax_[column].idx: 定义了分区键，会出现这二个文件，partition存储当前分区下分区表达式最终生成的值，minmax_[column].idx记录当前分区下对应原始数据的最小最大值
- skp_idx_[Column].idx与skp_idx_[Column].mrk: 二级索引信息







## 创建方式和存储结构

Mergetree在写入数据时，数据总会以数据片段的形式写入磁盘，为了避免片段过多，ClickHouse会通过后台线程，定期合并这些数据片段，属于相同分区的数据片段会被合并成一个新的片段，正式合并树名称的由来。

### 创建方式

```
CREATE TABLE [IF NOT EXISTS] [db.]table_name [ON CLUSTER cluster]
(
    name1 [type1] [DEFAULT|MATERIALIZED|ALIAS expr1],
    name2 [type2] [DEFAULT|MATERIALIZED|ALIAS expr2],
    ...
    INDEX index_name1 expr1 TYPE type1(...) GRANULARITY value1,
    INDEX index_name2 expr2 TYPE type2(...) GRANULARITY value2
) ENGINE = MergeTree()
[PARTITION BY expr]
[ORDER BY expr]
[PRIMARY KEY expr]
[SAMPLE BY expr]
[SETTINGS name=value, ...]
```

主要参数：

#### PARTITION BY

分区键，不声明分区键，则会默认生成一个名为all的分区。

##### ORDER BY

`必填`，排序键，默认情况下主键与排序键相同。

#### PRIMARY KEY

会根据主键字段生成一级索引，用于加速查询，可不声明，默认是ORDER BY定义的字段。

#### SAMPLE BY

抽样表达式，声明数据以何种标准进行采样，如果使用此配置，必须子主键的配置中也声明同样的表达式。
ORDER BY (CounterID,intHash32(UserID))
SAMPLE BY intHash32(UserID)

#### SETTINGS

index_granularity:索引粒度，默认8192，也就每隔8192行才生成一条索引
enable_mixed_granularity_parts:是否开启自适应索引间隔功能，默认开启
index_granularity_bytes:索引粒度，根据每一批次写入数据的大小，动态划分间隔大小，默认10M(`10*1024*1024`)

### 存储结构

创建测试表

```
CREATE TABLE test.part_v1
(
    `ID` String,
    `URL` String,
    `age` UInt8 DEFAULT 0,
    `EventTime` Date
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(EventTime)
ORDER BY ID
SETTINGS index_granularity = 8192
```

插入数据

```
insert into test.part_v1 values
('A001', 'www.test1.com', 1,'2020-08-01')
('A001', 'www.test1.com', 1,'2020-08-02')
('A002', 'www.test1.com', 1,'2020-08-03');
```

查看目录结构

```
[root@test 20200801_12_12_0]# ll
总用量 56
-rw-r----- 1 clickhouse clickhouse  29 8月  18 15:56 age.bin
-rw-r----- 1 clickhouse clickhouse  48 8月  18 15:56 age.mrk2
-rw-r----- 1 clickhouse clickhouse 456 8月  18 15:56 checksums.txt
-rw-r----- 1 clickhouse clickhouse  91 8月  18 15:56 columns.txt
-rw-r----- 1 clickhouse clickhouse   1 8月  18 15:56 count.txt
-rw-r----- 1 clickhouse clickhouse  32 8月  18 15:56 EventTime.bin
-rw-r----- 1 clickhouse clickhouse  48 8月  18 15:56 EventTime.mrk2
-rw-r----- 1 clickhouse clickhouse  42 8月  18 15:56 ID.bin
-rw-r----- 1 clickhouse clickhouse  48 8月  18 15:56 ID.mrk2
-rw-r----- 1 clickhouse clickhouse   4 8月  18 15:56 minmax_EventTime.idx
-rw-r----- 1 clickhouse clickhouse   4 8月  18 15:56 partition.dat
-rw-r----- 1 clickhouse clickhouse  10 8月  18 15:56 primary.idx
-rw-r----- 1 clickhouse clickhouse  49 8月  18 15:56 URL.bin
-rw-r----- 1 clickhouse clickhouse  48 8月  18 15:56 URL.mrk2
[root@test 20200801_12_12_0]# pwd
/var/lib/clickhouse/data/test/part_v1/20200801_12_12_0
```

目录层次：数据库名 > 数据表名 > 分区目录 > 分区下具体文件
20200801_12_12_0是分区名

.txt是明文存储，.bin/.dex/.mrk二进制存储

- partition.dat: 分区信息
- checksum.txt: 数据校验信息
- columns.txt: 列信息
- count.txt: 计数信息
- primary.idx: 一级索引信息，用于存储稀疏索引信息
- [column].bin: 存储某一列的信息，默认使用lz4压缩算法存储
- [column].mrk: 列字段标记问题，保存.bin文件中数据的偏移量信息
- [column].mrk2: 如果定义了自适应索引，则会出现该文件，作用和.mrk文件一样
- partition.dat、minmax_[column].idx: 定义了分区键，会出现这二个文件，partition存储当前分区下分区表达式最终生成的值，minmax_[column].idx记录当前分区下对应原始数据的最小最大值
- skp_idx_[Column].idx与skp_idx_[Column].mrk: 二级索引信息





## 数据分区

### 数据的分区规则

分区规则由分区ID决定，，分区ID生成规则有四种逻辑

- 不指定分区键：没有定义PARTITION BY，分区ID默认all
- 使用整型：直接按该整型的字符串形式输出，做为分区ID
- 使用日期类型：分区键时日期类型，或者可以转化成日期类型，比如用today转化，YYYYMMDD格式按天分区，YYYYMM按月分区等
- 使用其他类型：String、Float类型等，通过128位的Hash算法取其Hash值作为分区ID

![image.png](https://segmentfault.com/img/bVbLXJh)

数据进行分区存储，在查询时可以快速定位数据位置

### 分区目录的命名规则

分区命名规则，对于20200801_1_1_0
PartitionID_MinBlockNum_MaxBlockNum_Level

- PartitionID: 分区ID，20200801就是分区ID
- MinBlockNum、MaxBlockNum: 最小分区块编号和最大分区块编号，BlockNum是整型的自增长编号，从1开始，新创建一个分区目录时，会+1，新创建的分区MinBlockNum=MaxBlockNum
- Level：合并的层级，被合并的次数

### 分区目录的合并过程

每次数据insert写入，都会生成新的分区目录，在之后的某个时刻（写入后的10-15分钟，也可以手动执行optimize强制合并）会通过后台任务再将属于相同分区的多个目录合并成一个新的目录，已经存在的目录通过后台任务删除（默认8分钟）。

合并之后新目录名规则：

- MinBlockNum：取同一分区内所有目录中最小的MinBlockNum值
- MaxBlockNum：取同一分区内所有目录中最大的MaxBlockNum值
- Level：取同以分区内最大Level值并+1

![image.png](https://segmentfault.com/img/bVbLXJq)

## 一级索引

一级索引也就是主键索引，通过PRIMARY KEY/ORDER BY定义
会写入primary.idx文件中

![image.png](https://segmentfault.com/img/bVbLXJL)

稀疏索引和稠密索引的区别

稀疏索引使用一个索引标记一大段时间，减少了索引的数据量，使得primary.idx可以常驻内存，加速数据查询

### 数据索引的生成过程

PARTITION BYtoYYYYMM(EventDate)），所以2014年3月份的数据最终会被划分到同一个分区目录内。使用CounterID作为主键（ORDER BY CounterID），每间隔8192行会生成一个主键索引保存到primary.idx文件中
![image.png](https://segmentfault.com/img/bVbLXKc)

压缩数据块
![image.png](https://segmentfault.com/img/bVbLXJ4)

### 数据标记的生成规则

数据标记是衔接一级索引和数据的桥梁
![image.png](https://segmentfault.com/img/bVbLXKx)

数据标记和索引区间是对齐的，均按照index_granularity的粒度间隔。只需简单通过索引区间的下标编号就可以直接找到对应的数据标记。每一个列字段[Column].bin文件都有一个与之对应的[Column].mrk数据标记文件，用于记录数据在．bin文件中的偏移量信息
![image.png](https://segmentfault.com/img/bVbLXKL)

一行标记数据使用一个元组表示，元组内包含两个整型数值的偏移量信息。对应的.bin压缩文件中，压缩数据块的起始偏移量；以及将该数据压缩块解压后，其未压缩数据的起始偏移量
每一行标记数据都表示了一个片段的数据（默认8192行）在.bin压缩文件中的读取位置信息。标记数据与一级索引数据不同，它并不能常驻内存，而是使用LRU（最近最少使用）缓存策略加快其取用速度。





bitshuffler 

### 分区、索引、标记和压缩数据的协同总结

#### 写入过程

首先生成分区目录，属于相同分区的目录会依照规则合并到一起
紧接着按照index_granularity索引粒度，会分别生成primary.idx一级索引（如果声明了二级索引，还会创建二级索引文件）、每一个列字段的．mrk数据标记和．bin压缩数据文件
![image](https://segmentfault.com/img/bVbLXNH)

#### 查询过程

查询的本质，可以看作一个不断减小数据范围的过程。在最理想的情况下，MergeTree首先可以依次借助分区索引、一级索引和二级索引，将数据扫描范围缩至最小。然后再借助数据标记，将![image](https://segmentfault.com/img/bVbLXNr)需要解压与计算的数据范围缩至最小

如果一条查询语句用不到索引会进行分区目标扫描，虽不能缩小数据范围，但是MergeTree仍然能够借助数据标记，以多线程的形式同时读取多个压缩数据块，以提升性能



#### 数据标记和压缩数据块的对应关系

每个压缩数据块的体积都被严格控制在64KB～1MB。而一个间隔（index_granularity）的数据，又只会产生一行数据标记，根据一个间隔内数据的实际字节大小，数据标记和压缩数据块之间会产生三种不同的对应关系



##### 多对一

多个数据标记对应一个压缩数据块，当一个间隔（index_granularity）内的数据未压缩大小size小于64KB时，会出现这种对应关系。
![image](https://segmentfault.com/img/bVbLXMm)



##### 一对一

一个数据标记对应一个压缩数据块，当一个间隔（index_granularity）内的数据未压缩大小size大于64KB小于1M时，会出现这种对应关系。
![image](https://segmentfault.com/img/bVbLXMx)



##### 一对多

一个数据标记对应多个压缩数据块，当一个间隔（index_granularity）内的数据未压缩大小size大于1M时，会出现这种对应关系。
![image](https://segmentfault.com/img/bVbLXM6)

## 二级索引

二级索引又称跳数索引，由数据的聚合信息构建而成，根据索引类型的不同，其聚合信息的内容也不同。
需要在CREATE语句内定义，定义了跳数索引会额外生成相应的索引文件后标记文件
skp_idx_[Column].idx和skp_idx_[Column].mrk

1.定义表结构

```
CREATE TABLE test.part_v2
(
    `ID` String,
    `URL` String,
    `age` UInt8 DEFAULT 0,
    `EventTime` Date
)
ENGINE = MergeTree()
    PARTITION BY toYYYYMMDD(EventTime)
    ORDER BY ID
    SETTINGS index_granularity = 8192
```

查看文件目录

```
总用量 4
drwxr-x--- 2 clickhouse clickhouse 6 8月  20 18:54 detached
-rw-r----- 1 clickhouse clickhouse 1 8月  20 18:54 format_version.txt
```











column storage



列存 

索引的索引

每一列数据 排序 字符串 字典编码



compact min batch





事实引擎

压缩 历史数据索引

实时索引



列压缩 nblock 

parquet 



Insert delete bit set ,compact 

Update 主键更新





k v 



simd 指令



avg min max 



Adb 2-3 熵加 减小

rollup 表 





1 榨干系统 driect io page cache

2 simd 指令

3 cpu cache 

jvm 自动 simd



4 多核 

5 ssd 

nvme cache 

Inter aep 







doris clickhouse

aep 

