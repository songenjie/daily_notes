Clickhouse堪称OLAP领域的黑马，最近发布的几个版本在多表关联分析上也有了极大的性能提升，尤其是还引入了MaterializeMySQL Database Engine做到了实时对齐业务线mysql中的数据。

# 表优化

### 数据类型

- 建表时能用数值型或日期时间型表示的字段，就不要用字符串——全String类型在以Hive为中心的数仓建设中常见，但CK环境不应受此影响。
- 虽然clickhouse底层将DateTime存储为时间戳Long类型，但不建议直接存储Long类型，因为DateTime不需要经过函数转换处理，执行效率高、可读性好。
- 官方已经指出Nullable类型几乎总是会拖累性能，因为存储Nullable列时需要创建一个额外的文件来存储NULL的标记，并且Nullable列无法被索引。因此除非极特殊情况，应直接使用字段默认值表示空，或者自行指定一个在业务中无意义的值（例如用-1表示没有商品ID）。
- 数值类型分组最快，在新版本中ck会对string类型进行一次hash映射再分组

### 分区和索引

- 分区粒度根据业务特点决定，不宜过粗或过细。一般选择按天分区，也可指定为tuple()；以单表1亿数据为例，分区大小控制在10-30个为最佳。



```undefined
PARTITION BY tuple() 
```

- 必须指定索引列，clickhouse中的索引列即排序列，通过order  by指定，一般在查询条件中经常被用来充当筛选条件的属性被纳入进来；可以是单一维度，也可以是组合维度的索引；通常需要满足高基列在前、查询频率大的在前原则；还有基数特别大的不适合做索引列，如用户表的userid字段；通常筛选后的数据满足在百万以内为最佳。

### 表参数

- index_granularity 是用来控制索引粒度的 默认是8192，如非必须不建议调整。
- 如果表中不是必须保留全量历史数据，建议指定TTL，可以免去手动过期历史数据的麻烦。TTL也可以通过ALTER TABLE语句随时修改。

# 查询优化

### 单表查询

- 使用prewhere替代where关键字；当查询列明显多于筛选列时使用prewhere可十倍提升查询性能



```csharp
# prewhere 会自动优化执行过滤阶段的数据读取方式，降低io操作
select * from work_basic_model  where product='tracker_view' and ( id='eDf8fZky' or code='eDf8fZky' ) 
#替换where关键字
select * from work_basic_model  prewhere product='tracker_view' and ( id='eDf8fZky' or code='eDf8fZky' ) 
```

- 数据采样，通过采用运算可极大提升数据分析的性能



```php
SELECT
    Title,
    count() * 10 AS PageViews
FROM hits_distributed
SAMPLE 0.1   #代表采样10%的数据，也可以是具体的条数
WHERE
    CounterID = 34
GROUP BY Title
ORDER BY PageViews DESC LIMIT 1000
```

采样修饰符只有在mergetree engine表中才有效，且在创建表时需要指定采样策略；

- 数据量太大时应避免使用select * 操作，查询的性能会与查询的字段大小和数量成线性变换；字段越少，消耗的io资源就越少，性能就会越高。
- 千万以上数据集进行order by查询时需要搭配where条件和limit语句一起使用

- 如非必须不要在结果集上构建虚拟列，虚拟列非常消耗资源浪费性能，可以考虑在前端进行处理，或者在表中构造实际字段进行额外存储。



```csharp
select id ,pv, uv , pv/uv rate 
```

- 使用 uniqCombined 替代 distinct 性能可提升10倍以上，uniqCombined 底层采用类似HyperLogLog算法实现，如能接收2%左右的数据误差，可直接使用这种去重方式提升查询性能。
- 对于一些确定的数据模型，可将统计指标通过物化视图的方式进行构建，这样可避免数据查询时重复计算的过程；物化视图会在有新数据插入时进行更新。



```php
# 通过物化视图提前预计算用户下载量
CREATE MATERIALIZED VIEW download_hour_mv
ENGINE = SummingMergeTree
PARTITION BY toYYYYMM(hour) ORDER BY (userid, hour)
AS SELECT
  toStartOfHour(when) AS hour,
  userid,
  count() as downloads,
  sum(bytes) AS bytes
FROM download WHERE when >= toDateTime('2020-10-01 00:00:00')  #设置更新点，该时间点之前的数据可以通过insert into select的方式进行插入
GROUP BY userid, hour

## 或者
CREATE MATERIALIZED VIEW db.table_MV TO db.table_new  ## table_new 可以是一张mergetree表
AS SELECT * FROM db.table_old; 

# 不建议添加populate关键字进行全量更新
```

- 不建议在高基列上执行distinct去重查询，改为近似去重 uniqCombined

### 多表关联

- 当多表联查时，查询的数据仅从其中一张表出时，可考虑使用IN操作而不是JOIN。



```csharp
select a.* from a where a.uid in (select uid from b)
# 不要写成
select a.* from a left join b on a.uid=b.uid
```

- 多表Join时要满足小表在右的原则，右表关联时被加载到内存中与左表进行比较。
- clickhouse在join查询时不会主动发起谓词下推的操作，需要每个子查询提前完成过滤操作；需要注意的是，是否主动执行谓词下推，对性能影响差别很大【新版本中已不再存在此问题，但是需要注意的是谓词位置的不同依然有性能的差异】。
- 将一些需要关联分析的业务创建成字典表进行join操作，前提是字典表不易太大，因为字典表会常驻内存。



```undefined
ENGINE = Dictionary(dict_name)
或者
create database db_dic ENGINE = Dictionary
```

# 写入和删除优化

- 尽量不要执行单条或小批量删除和插入操作，这样会产生大量小分区文件，给后台merge任务带来巨大压力。
- 不要一次写入太多分区，或数据写入太快，数据写入太快会导致merge速度跟不上而报错；一般建议每秒中发起2-3次写入操作，每次操作写入2w-5w条数据。

# 运维相关

### 配置

| 配置                               | 描述                                                         |
| ---------------------------------- | ------------------------------------------------------------ |
| background_pool_size               | 后台用来merge进程的大小，默认是16，建议改成cpu个数的2倍      |
| log_queries                        | 默认值为0，修改为1，系统会自动创建system_query_log表，并记录每次查询的query信息 |
| max_execution_time                 | 设置单次查询的最大耗时，单位是秒；默认无限制；需要注意的是客户端的超时设置会覆盖该参数 |
| max_threads                        | 设置单个查询所能使用的最大cpu个数；默认是CPU核数             |
| max_memory_usage                   | 一般按照CPU核心数的2倍去设置最大内存使用                     |
| max_bytes_before_external_group_by | 一般按照max_memory_usage的一半设置内存，当group使用内存超出阈值后会刷新到磁盘进行 |

### 存储

clickhouse不支持设置多数据目录，为了提升数据io性能，可以挂载虚拟券组，一个券组绑定多块物理磁盘提升读写性能；多数查询场景SSD盘会比普通机械硬盘快2-3倍。

### 数据同步

新版clickhouse提供了一个实验性的功能，那就是我们可以将clickhouse伪装成mysql的一个备库去实时对齐mysql中的数据，当mysql库表数据发生变化时会实时同步到clickhouse中；这样就省掉了单独维护实时spark/flink任务读取kafka数据再存入clickhouse的环节，大大降低了运维成本提升了效率。



```bash
CREATE DATABASE ckdb ENGINE = MaterializeMySQL('172.17.0.2:3306', 'ckdb', 'root', '123');
```

### 查询熔断

为了避免因个别慢查询引起的服务雪崩问题，除了可以为单个查询设置超时以外，还可以配置周期熔断；在一个查询周期内，如果用户频繁进行慢查询操作超出规定阈值后将无法继续进行查询操作：



![img](https:////upload-images.jianshu.io/upload_images/17243194-d2d7101dd1e1d5fa.png?imageMogr2/auto-orient/strip|imageView2/2/w/519/format/webp)

熔断策略



![img](https:////upload-images.jianshu.io/upload_images/17243194-44beb869dc5a78e4.png?imageMogr2/auto-orient/strip|imageView2/2/w/531/format/webp)

绑定用户



作者：码到成功_易企秀
链接：https://www.jianshu.com/p/a72a4782a102
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。