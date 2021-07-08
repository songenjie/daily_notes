# ClickHouse使用操作

这章主要介绍在ClickHouse使用的各个操作的注意点。常规的统一语法不做详细介绍。

 https://github.com/ClickHouse/ClickHouse/issues/14794











## 1. Join操作

在ClickHouse中，对连接操作定义了不同的精度，包含ALL、ANY和ASOF三种类型，默认为ALL。可以通过join_default_strictness配置修改默认精度（位于system.setting表中）。下面分别说明这3种精度。

首先建表并插入测试数据：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
--表join_tb1
CREATE TABLE join_tb1
(
    `id` String,
    `name` String,
    `time` DateTime
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(time)
ORDER BY id

--表 join_tb2
CREATE TABLE join_tb2
(
    `id` String,
    `rate` UInt8,
    `time` DateTime
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(time)
ORDER BY id

--表 join_tb3
CREATE TABLE join_tb3
(
    `id` String,
    `star` UInt8
)
ENGINE = MergeTree
ORDER BY id

--插入数据
INSERT INTO join_tb1 VALUES 
('1', 'ClickHouse', '2019-05-01 12:00:00')
('2', 'Spark', '2019-05-01 12:30:00')
('3', 'ElasticSearch', '2019-05-01 13:00:00')
('4', 'HBase', '2019-05-01 13:30:00')
(NULL, 'ClickHouse', '2019-05-01 14:00:00')
(NULL, 'Spark', '2019-05-01 14:30:00')

INSERT INTO join_tb2 VALUES 
('1', 100, '2019-05-01 11:55:00')
('1', 105, '2019-05-01 11:50:00')
('2', 90, '2019-05-01 12:01:00')
('3', 80, '2019-05-01 13:10:00')
('5', 70, '2019-05-01 14:00:00')
('6', 60, '2019-05-01 13:55:00')

INSERT INTO join_tb3 VALUES 
('1', 1000)
('2', 900)
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

### 1.1. ALL

如果左表内的一行数据，在右表中有多行数据与之连接匹配，则返回右表种全部连接的数据。连接依据为：left.key=right.key。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
SELECT a.id, a.name, b.rate FROM join_tb1 AS a ALL INNER JOIN join_tb2 AS b ON a.id=b.id

SELECT
    a.id,
    a.name,
    b.rate
FROM join_tb1 AS a
ALL INNER JOIN join_tb2 AS b ON a.id = b.id

┌─id─┬─name──────────┬─rate─┐
│ 1  │ ClickHouse    │  100 │
│ 1  │ ClickHouse    │  105 │
│ 2  │ Spark         │   90 │
│ 3  │ ElasticSearch │   80 │
└────┴───────────────┴──────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

### 1.2. ANY

如果左表内的一行数据，在右表中有多行数据与之连接匹配，则仅返回右表中第一行连接的数据。连接依据同样为：left.key=right.key

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
SELECT
    a.id,
    a.name,
    b.rate
FROM join_tb1 AS a
ANY INNER JOIN join_tb2 AS b ON a.id = b.id

┌─id─┬─name──────────┬─rate─┐
│ 1  │ ClickHouse    │  100 │
│ 2  │ Spark         │   90 │
│ 3  │ ElasticSearch │   80 │
└────┴───────────────┴──────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

### 1.3. ASOF

ASOF 是一种模糊连接，允许在连接键之后追加定义一个模糊连接的匹配条件asof_column，例如：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
SELECT
    a.id,
    a.name,
    b.rate,
    a.time,
    b.time
FROM join_tb1 AS a
ASOF INNER JOIN join_tb2 AS b ON (a.id = b.id) AND (a.time >= b.time)

┌─id─┬─name───────┬─rate─┬────────────────time─┬──────────────b.time─┐
│ 1  │ ClickHouse │  100 │ 2019-05-01 12:00:00 │ 2019-05-01 11:55:00 │
│ 2  │ Spark      │   90 │ 2019-05-01 12:30:00 │ 2019-05-01 12:01:00 │
└────┴────────────┴──────┴─────────────────────┴─────────────────────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

根据官网介绍的语法：

```
SELECT expressions_list
FROM table_1
ASOF LEFT JOIN table_2
ON equi_cond AND closest_match_cond
```

https://clickhouse.tech/docs/en/sql-reference/statements/select/join/

 

ASOF会先以 left.key = right.key 进行连接匹配，然后根据AND 后面的 closest_match_cond（也就是这里的a.time >= b.time）过滤出最符合此条件的第一行连接匹配的数据。

 另一种写法是使用USING，语法为：

```
SELECT expressions_list
FROM table_1
ASOF JOIN table_2
USING (equi_column1, ... equi_columnN, asof_column)
```

 

举例：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
SELECT
    a.id,
    a.name,
    b.rate,
    a.time,
    b.time
FROM join_tb1 AS a
ASOF INNER JOIN join_tb2 AS b USING (id, time)

Query id: 075f7e4a-7355-4e11-ae3b-0e3275912a3e

┌─id─┬─name───────┬─rate─┬────────────────time─┬──────────────b.time─┐
│ 1  │ ClickHouse │  100 │ 2019-05-01 12:00:00 │ 2019-05-01 11:55:00 │
│ 2  │ Spark      │   90 │ 2019-05-01 12:30:00 │ 2019-05-01 12:01:00 │
└────┴────────────┴──────┴─────────────────────┴─────────────────────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

对 asof_colum 字段的使用有2点需要注意：

1. asof_column 必须是整型、浮点型和日期型这类有序序列的数据类型
2. asof_column不能是数据表内的唯一字段，也就是说连接键（JOIN KEY）和asof_column不能是同一字段

 

### 1.4. Join性能

在执行JOIN时，ClickHouse对执行的顺序没有特别优化，JOIN操作会在WHERE以及聚合查询前运行。

JOIN操作结果不会缓存，所以每次JOIN操作都会生成一个全新的执行计划。如果应用程序会大量使用JOIN，则需进一步考虑借助上层应用侧的缓存服务或使用JOIN表引擎来改善性能（JOIN表引擎不支持ASOF精度）。JOIN表引擎会在内存中保存JOIN结果。

在某些情况下，IN的效率比JOIN要高。

在使用JOIN连接维度表时，JOIN操作可能并不会特别高效，因为右则表对每个query来说，都需要加载一次。在这种情况下，外部字典（external dictionaries）的功能会比JOIN性能更好。

 

### 1.5. JOIN的内存限制

默认情况下，ClickHouse使用Hash Join 算法。它会将右侧表（right_table）加载到内存，并为它创建一个hash table。在达到了内存使用的一个阈值后，ClickHouse会转而使用Merge Join 算法。

可以通过以下参数限制JOIN操作消耗的内存：

1. max_rows_in_join：限制hash table中的行数
2. max_bytes_in_join：限制hash table的大小

在达到任何上述limit后，ClickHouse会以join_overflow_mode 的参数进行动作。此参数包含2个可选值：

1. THROW：抛出异常并终止操作
2. BREAK：终止操作但并不抛出异常

 

## 2. WHERE与PREWHERE子句

WHERE可以通过表达式来过滤数据，如果过滤条件恰好为主键字段，则可以进一步借助索引加速查询，所以WHERE子句是决定查询语句是否能使用索引的判断依据（前提是表引擎支持索引）。

除此之外，ClickHouse还提供了PREWHERE子句用于条件过滤，它可以更有效地进行过滤优化，仅用于MergeTree表系列引擎。

PREWHERE与WHERE不同之处在于：使用PREWHERE时，首先只会去PREWHERE指定的列字段数据，用于数据过滤的条件判断。在数据过滤之后再读取SELECT声明的列字段以补全其余属性。所以在一些场合下，PREWHERE相比WHERE而言，处理的数据更少，性能更高。

默认情况下，即使在PREWHERE子句没有显示指定的情况下，它也会自动移动到WHERE条件到PREWHERE阶段。

下面做个对比：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
# 默认自动开启了PREWHERE，查询速度为：
select WatchID, Title, GoodEvent from hits_v1 where JavaEnable=1;

…
6535088 rows in set. Elapsed: 1.428 sec. Processed 8.87 million rows, 863.90 MB (6.21 million rows/s., 604.82 MB/s.)

# 关闭PREWHERE
set optimize_move_to_prewhere=0


# 关闭自动PREWHERE，查询速度为
6535088 rows in set. Elapsed: 1.742 sec. Processed 8.87 million rows, 864.55 MB (5.09 million rows/s., 496.20 MB/s.)
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

可以看到2条语句处理的数据总量没有变化，但是其数据处理量稍有降低（PREWHERE为863.90MB），且每秒吞吐量上升（PREWHER为604.82MB/s，WHERE为496.20MB/s）。

对比2条语句的执行计划：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
# PREWHERE
explain select WatchID, Title, GoodEvent from hits_v1 prewhere JavaEnable=1;

EXPLAIN
SELECT
    WatchID,
    Title,
    GoodEvent
FROM hits_v1
PREWHERE JavaEnable = 1

Query id: 103fd24a-e718-4304-9f75-4900528c1d1a

┌─explain───────────────────────────────────────────────────────────────────┐
│ Expression ((Projection + Before ORDER BY))                               │
│   SettingQuotaAndLimits (Set limits and quota after reading from storage) │
│     ReadFromStorage (MergeTree)                                           │
└───────────────────────────────────────────────────────────────────────────┘

# WHERE
explain select WatchID, Title, GoodEvent from hits_v1 where JavaEnable=1;

EXPLAIN
SELECT
    WatchID,
    Title,
    GoodEvent
FROM hits_v1
WHERE JavaEnable = 1

Query id: 9b470524-1320-4e9f-bade-cf8c2c9944c8

┌─explain─────────────────────────────────────────────────────────────────────┐
│ Expression ((Projection + Before ORDER BY))                                 │
│   Filter (WHERE)                                                            │
│     SettingQuotaAndLimits (Set limits and quota after reading from storage) │
│       ReadFromStorage (MergeTree)                                           │
└─────────────────────────────────────────────────────────────────────────────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

可以看到相比WHERE语句，PREWHERE语句的执行计划省去了一次Filter操作。

 

## 3. Group By

Group By的用法非常常见，ClickHouse中执行聚合查询时，若是SELECT后面只声明了聚合函数，则GROUP BY 关键字可以省略：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
SELECT
    SUM(data_compressed_bytes) AS compressed,
    SUM(data_uncompressed_bytes) AS uncompressed
FROM system.parts

Query id: e38e3ec1-968d-4442-ba7d-b8555f27e0d0

┌─compressed─┬─uncompressed─┐
│ 1851073942 │   9445387666 │
└────────────┴──────────────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

聚合查询还能配合WITH ROLLUP、WITH CUBE和WITH TOTALS三种修饰符获取额外的汇总信息。

 

### 3.1. WITH ROLLUP

ROLLUP便是上卷数据，按聚合键从右到左，基于聚合函数依次生成分组小计和总计。如果设聚合键的个数为n，则最终会生成小计的个数为n+1。例如：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
SELECT
    table,
    name,
    SUM(bytes_on_disk)
FROM system.parts
GROUP BY
    table,
    name
    WITH ROLLUP
ORDER BY table ASC

┌─table──────────────────────────────────────────┬─name───────────────────────────────────┬─SUM(bytes_on_disk)─┐
│                                                │                                        │         1857739143 │
│ .inner_id.604be4d8-bb5c-437b-ada9-3d3d5a91fc24 │                                        │                638 │
│ .inner_id.604be4d8-bb5c-437b-ada9-3d3d5a91fc24 │ 953e60a1e8747360786c2b70a223788d_2_4_1 │                318 │
│ .inner_id.604be4d8-bb5c-437b-ada9-3d3d5a91fc24 │ acb795a12c7ba41b0ed4c3d94a008ecd_1_3_1 │                320 │
│ agg_table                                      │                                        │                358 │
│ agg_table                                      │ 201909_2_2_0                           │                358 │
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

可以看到第1行是一个汇总，统计的SUM（bytes_on_disk）的总行数。而每个table字段都有一个汇总（例如.inner_id.604be4d8-bb5c-437b-ada9-3d3d5a91fc24 表第一行以及agg_table 第一行）。

 

### 3.2. WITH CUBE

CUBE也是数仓里重要的概念，基于聚合键之间所有的组合生成统计信息。如果聚合键的个数为n，则最终聚合数据的个数为2的n次方。例如：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
--建表
CREATE TABLE person
(
    `id` int,
    `name` String,
    `course` String,
    `year` DateTime,
    `points` int
)
ENGINE = MergeTree
ORDER BY id

--插入数据
INSERT INTO person VALUES
 (1, 'jane', 'CS', '2021-01-02 11:00:00', 50),
 (2, 'tom', 'CS', '2021-01-03 11:00:00', 60),
 (3, 'bob', 'BS', '2021-01-03 11:00:00', 50),
 (4, 'alice', 'BS', '2021-01-01 11:00:00', 40),
 (5, 'jane', 'ACC', '2021-01-02 11:00:00', 70),
 (6, 'bob', 'ACC', '2021-01-03 11:00:00', 90),
 (7, 'jane', 'MATH', '2021-01-04 11:00:00', 100)

--Cube计算
SELECT
    name,
    course,
    year,
    AVG(points)
FROM person
GROUP BY
    name,
    course,
    year
WITH CUBE


┌─name──┬─course─┬────────────────year─┬─AVG(points)─┐
│ jane  │ ACC    │ 2021-01-02 11:00:00 │          70 │
│ bob   │ ACC    │ 2021-01-03 11:00:00 │          90 │
│ alice │ BS     │ 2021-01-01 11:00:00 │          40 │
…

┌─name─┬─course─┬────────────────year─┬───────AVG(points)─┐
│      │        │ 2021-01-01 11:00:00 │                40 │
│      │        │ 2021-01-03 11:00:00 │ 66.66666666666667 │
│      │        │ 2021-01-02 11:00:00 │                60 │
│      │        │ 2021-01-04 11:00:00 │               100 │
└──────┴────────┴─────────────────────┴───────────────────┘
┌─name─┬─course─┬────────────────year─┬───────AVG(points)─┐
│      │        │ 1970-01-01 00:00:00 │ 65.71428571428571 │
└──────┴────────┴─────────────────────┴───────────────────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

可以看到结果中会生成 8 个统计结果（部分结果已省略）。

 

### 3.3. WITH TOTALS

WITH TOTALS会基于聚合函数对所有数据进行统计（比原结果多一行总的统计结果），例如：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```sql
SELECT
    name,
    course,
    year,
    AVG(points)
FROM person
GROUP BY
    name,
    course,
    year
    WITH TOTALS

┌─name──┬─course─┬────────────────year─┬─AVG(points)─┐
│ jane  │ ACC    │ 2021-01-02 11:00:00 │          70 │
│ bob   │ ACC    │ 2021-01-03 11:00:00 │          90 │
│ alice │ BS     │ 2021-01-01 11:00:00 │          40 │
│ jane  │ CS     │ 2021-01-02 11:00:00 │          50 │
│ jane  │ MATH   │ 2021-01-04 11:00:00 │         100 │
│ tom   │ CS     │ 2021-01-03 11:00:00 │          60 │
│ bob   │ BS     │ 2021-01-03 11:00:00 │          50 │
└───────┴────────┴─────────────────────┴─────────────┘

Totals:
┌─name─┬─course─┬────────────────year─┬───────AVG(points)─┐
│      │        │ 1970-01-01 00:00:00 │ 65.71428571428571 │
└──────┴────────┴─────────────────────┴───────────────────┘
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

## 4. 查看SQL执行计划

ClickHouse目前并没有直接提供EXPLAIN的详细查询计划，当前EXPLAIN仅是输出一个简单的计划。不过我们仍可以借助后台服务日志来实现此功能，例如执行以下语句即可看到详细的执行计划：

clickhouse-client --password xxx --send_logs_level=trace <<<'select * from tutorial.hits_v1' > /dev/null

 

打印信息如下（仅截取关键信息）：



[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```sql
tutorial.hits_v1  (SelectExecutor): Key condition: unknown
=> 查询未使用主键索引

tutorial.hits_v1  (SelectExecutor): MinMax index condition: unknown
=> 未使用分区索引

tutorial.hits_v1  (SelectExecutor): Not using primary index on part 201403_1_29_2
=> 未在分区 201403_1_29_2 下使用primary index

tutorial.hits_v1  (SelectExecutor): Selected 1 parts by partition key, 1 parts by primary key, 1094 marks by primary key, 1094 marks to read from 1 ranges
=> 选择了1个分区，共计1094个marks

executeQuery: Read 8873898 rows, 7.88 GiB in 21.9554721 sec., 404177 rows/sec., 367.50 MiB/sec.
=> 读取 8873898条数据，7.88G 数据，耗时21.955秒…

MemoryTracker: Peak memory usage (for query): 361.67 MiB.
=> 消耗内存量
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

下面优化一下查询：

clickhouse-client --password xxx --send_logs_level=trace <<<"select WatchID from tutorial.hits_v1 where EventDate='2014-03-17'" > /dev/null

 

打印结果为：





[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```sql
InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "EventDate = '2014-03-17'" moved to PREWHERE
=> 自动调用了PREWHERE

tutorial.hits_v1 (SelectExecutor): Key condition: (column 1 in [16146, 16146])
=> 使用了主键索引

tutorial.hits_v1 (SelectExecutor): MinMax index condition: (column 0 in [16146, 16146])
=> 使用了分区索引

tutorial.hits_v1 (SelectExecutor): Selected 1 parts by partition key, 1 parts by primary key, 755 marks by primary key, 755 marks to read from 64 ranges
=> 根据分区键选择了一个分区

executeQuery: Read 6102294 rows, 58.19 MiB in 0.032661599 sec., 186833902 rows/sec., 1.74 GiB/sec.
=> 读到的数据，以及速度

MemoryTracker: Peak memory usage (for query): 11.94 MiB.
=> 消耗内存量
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

总的来说，ClickHouse未直接通过EXPLAIN语句提供查看语句执行的详细过程，但是可以变相的将日志设置到DEBUG或是TRACE级别，实现此功能，并分析SQL的执行日志。