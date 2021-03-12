```sql


```

# clickhouse 3 亿 join 百万,  查询时间500ms 优化



1. 数据量

```sql


SELECT count(*)
FROM jason.app_gesc_kylin_sku_flag_fact_d AS fact
WHERE (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))

┌───count()─┐
│ 309436581 │
└───────────┘

1 rows in set. Elapsed: 0.042 sec. Processed 880.19 million rows, 2.64 GB (20.89 billion rows/s., 62.67 GB/s.)


SELECT count(*)
FROM jason.app_gesc_kylin_sku_fact_d AS skudict
WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33')

┌─count()─┐
│  822856 │
└─────────┘

1 rows in set. Elapsed: 0.026 sec. Processed 922.11 thousand rows, 21.56 MB (35.35 million rows/s., 826.48 MB/s.)
```



2. 单个分片数据 

```sql
SELECT
    _shard_num,
    count(*)
FROM
(
    SELECT
        _shard_num,
        dt
    FROM jason.app_gesc_kylin_sku_flag_fact_d
    WHERE dt IN ('2021-03-01')
)
GROUP BY _shard_num
ORDER BY _shard_num ASC

┌─_shard_num─┬──count()─┐
│          1 │ 26690538 │
│          2 │ 26706286 │
│          3 │ 26638403 │
│          4 │ 26634592 │
│          5 │ 26601199 │
│          6 │ 26685921 │
│          7 │ 26705344 │
│          8 │ 26669128 │
│          9 │ 26636145 │
│         10 │ 26697201 │
│         11 │ 26704727 │
│         12 │ 26687047 │
│         13 │ 26669720 │
│         14 │ 26644807 │
│         15 │ 26691574 │
│         16 │ 26614544 │
│         17 │ 26642359 │
│         18 │ 26661177 │
│         19 │ 26684192 │
│         20 │ 26717314 │
│         21 │ 26684993 │
│         22 │ 26673377 │
│         23 │ 26644035 │
│         24 │ 26681215 │
│         25 │ 26651995 │
│         26 │ 26698477 │
│         27 │ 26682029 │
│         28 │ 26708277 │
│         29 │ 26661222 │
│         30 │ 26636694 │
│         31 │ 26672563 │
│         32 │ 26734018 │
│         33 │ 26674963 │
└────────────┴──────────┘


SELECT
    _shard_num,
    count(*)
FROM
(
    SELECT
        _shard_num,
        dt
    FROM jason.app_gesc_kylin_sku_flag_fact_d
    WHERE (dt IN ('2021-03-01')) AND (total_sku_flag = '1')
)
GROUP BY _shard_num
ORDER BY _shard_num ASC

┌─_shard_num─┬─count()─┐
│          1 │ 9376648 │
│          2 │ 9397436 │
│          3 │ 9373301 │
│          4 │ 9376442 │
│          5 │ 9323862 │
│          6 │ 9411940 │
│          7 │ 9370988 │
│          8 │ 9387051 │
│          9 │ 9325775 │
│         10 │ 9374624 │
│         11 │ 9381832 │
│         12 │ 9356042 │
│         13 │ 9382742 │
│         14 │ 9355673 │
│         15 │ 9393897 │
│         16 │ 9371737 │
│         17 │ 9376685 │
│         18 │ 9367962 │
│         19 │ 9411155 │
│         20 │ 9417480 │
│         21 │ 9374497 │
│         22 │ 9350298 │
│         23 │ 9361038 │
│         24 │ 9361960 │
│         25 │ 9376455 │
│         26 │ 9379839 │
│         27 │ 9388414 │
│         28 │ 9413832 │
│         29 │ 9380624 │
│         30 │ 9345802 │
│         31 │ 9391772 │
│         32 │ 9379129 │
│         33 │ 9399649 │
└────────────┴─────────┘

SELECT
    _shard_num,
    count(sku_id)
FROM
(
    SELECT
        _shard_num,
        sku_id
    FROM jason.app_gesc_kylin_sku_flag_fact_d AS fact
    INNER JOIN jason.app_gesc_kylin_sku_fact AS skudict ON fact.sku_id = skudict.sku_id
    WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33') AND (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))
)
GROUP BY _shard_num
ORDER BY _shard_num ASC

┌─_shard_num─┬─count(sku_id)─┐
│          1 │        380196 │
│          2 │        387099 │
│          3 │        375160 │
│          4 │        379349 │
│          5 │        365886 │
│          6 │        374372 │
│          7 │        374452 │
│          8 │        373470 │
│          9 │        368012 │
│         10 │        382203 │
│         11 │        370695 │
│         12 │        376915 │
│         13 │        377454 │
│         14 │        367050 │
│         15 │        378101 │
│         16 │        372607 │
│         17 │        379879 │
│         18 │        375290 │
│         19 │        378601 │
│         20 │        375327 │
│         21 │        380330 │
│         22 │        369585 │
│         23 │        378741 │
│         24 │        380750 │
│         25 │        382064 │
│         26 │        376687 │
│         27 │        368923 │
│         28 │        369241 │
│         29 │        376499 │
│         30 │        376488 │
│         31 │        378727 │
│         32 │        372203 │
│         33 │        376959 │
└────────────┴───────────────┘


SELECT
    _shard_num,
    countDistinct(sku_id) AS totalskunum
FROM
(
    SELECT
        _shard_num,
        sku_id
    FROM jason.app_gesc_kylin_sku_flag_fact_d AS fact
    INNER JOIN jason.app_gesc_kylin_sku_fact AS skudict ON fact.sku_id = skudict.sku_id
    WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33') AND (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))
)
GROUP BY _shard_num
ORDER BY _shard_num ASC

┌─_shard_num─┬─totalskunum─┐
│          1 │        6030 │
│          2 │        6164 │
│          3 │        5959 │
│          4 │        6005 │
│          5 │        5799 │
│          6 │        5916 │
│          7 │        5946 │
│          8 │        5917 │
│          9 │        5854 │
│         10 │        6064 │
│         11 │        5881 │
│         12 │        5981 │
│         13 │        6001 │
│         14 │        5828 │
│         15 │        5999 │
│         16 │        5902 │
│         17 │        6038 │
│         18 │        5964 │
│         19 │        6017 │
│         20 │        5964 │
│         21 │        6041 │
│         22 │        5867 │
│         23 │        6029 │
│         24 │        6029 │
│         25 │        6065 │
│         26 │        5993 │
│         27 │        5865 │
│         28 │        5871 │
│         29 │        5969 │
│         30 │        6003 │
│         31 │        6017 │
│         32 │        5926 │
│         33 │        5977 │
└────────────┴─────────────┘

33 rows in set. Elapsed: 0.219 sec. Processed 880.19 million rows, 2.64 GB (4.02 billion rows/s., 12.05 GB/s.)

SELECT count(*)
FROM jason.app_gesc_kylin_sku_flag_fact AS fact
WHERE (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))

┌─count()─┐
│ 9413832 │
└─────────┘

1 rows in set. Elapsed: 0.022 sec. Processed 26.71 million rows, 80.12 MB (1.19 billion rows/s., 3.58 GB/s.)


SELECT count(*)
FROM jason.app_gesc_kylin_sku_fact AS skudict
WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33')

┌─count()─┐
│   25100 │
└─────────┘

1 rows in set. Elapsed: 0.008 sec. Processed 28.16 thousand rows, 658.01 KB (3.38 million rows/s., 78.98 MB/s.)
```





3. 数据未执行优化执行查询的结果 6.5s

```sql
SELECT
    day_str,
    COUNTDistinct(sku_id) AS totalSkuNum
FROM gesc.app_gesc_kylin_sku_flag_fact_d AS fact
INNER JOIN gesc.dim_time_d AS dim ON fact.dt = dim.dt
WHERE (total_sku_flag = '1') AND (dictGet('gesc.app_gesc_kylin_sku_dict', 'bu_id', toUInt64(sku_id)) = '1727') AND (dictGet('gesc.app_gesc_kylin_sku_dict', 'dept_id_1', toUInt64(sku_id)) = '33') AND (dt IN ('2021-03-01'))
GROUP BY day_str

┌─day_str──┬─totalSkuNum─┐
│ 2021-060 │      196881 │
└──────────┴─────────────┘

1 rows in set. Elapsed: 6.527 sec. Processed 880.33 million rows, 18.25 GB (134.87 million rows/s., 2.80 GB/s.)




SELECT
    COUNT(sku_id) AS totalSkuNum
FROM gesc.app_gesc_kylin_sku_flag_fact_d AS fact
WHERE (total_sku_flag = '1') AND (dictGet('gesc.app_gesc_kylin_sku_dict', 'bu_id', toUInt64(sku_id)) = '1727') AND (dictGet('gesc.app_gesc_kylin_sku_dict', 'dept_id_1', toUInt64(sku_id)) = '33') AND (dt IN ('2021-03-01'))


```



4. 这里忽略 坐下记录

```sql
SELECT COUNTDistinct(sku_id) AS totalSkuNum
FROM gesc.app_gesc_kylin_sku_flag_fact_d AS fact
INNER JOIN jason.app_gesc_kylin_sku_fact AS skudict ON fact.sku_id = skudict.sku_id
WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33') AND (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))

┌─totalSkuNum─┐
│        5871 │
└─────────────┘

1 rows in set. Elapsed: 2.535 sec. Processed 907.59 million rows, 19.44 GB (358.05 million rows/s., 7.67 GB/s.)
```





4. 优化后结果 0.5s

```sql
SELECT COUNTDistinct(sku_id) AS totalSkuNum
FROM jason.app_gesc_kylin_sku_flag_fact_d AS fact
INNER JOIN jason.app_gesc_kylin_sku_fact AS skudict ON fact.sku_id = skudict.sku_id
WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33') AND (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))

┌─totalSkuNum─┐
│      196881 │
└─────────────┘

1 rows in set. Elapsed: 0.490 sec. Processed 907.59 million rows, 21.13 GB (1.85 billion rows/s., 43.16 GB/s.)


SELECT COUNTDistinct(sku_id) AS totalSkuNum
FROM gesc.app_gesc_kylin_sku_flag_fact_d AS fact
INNER JOIN jason.app_gesc_kylin_sku_fact AS skudict ON fact.sku_id = skudict.sku_id
WHERE (skudict.bu_id = '1727') AND (skudict.dept_id_1 = '33') AND (fact.total_sku_flag = '1') AND (fact.dt IN ('2021-03-01'))

┌─totalSkuNum─┐
│      196881 │
└─────────────┘

1 rows in set. Elapsed: 0.490 sec. Processed 907.59 million rows, 21.13 GB (1.85 billion rows/s., 43.16 GB/s.)
```





5. 操作流程

... 设计隐私数据 [可参数 clickhouse join 文章](https://github.com/songenjie/daily_notes/blob/master/2021/3%E6%9C%88/clickhouse_join.md)

实现细节主要为，根据id,将数据进行分片，是的id相同的两张表的数据，落入相同的分片中，使用 分布式表join 本地表的方式，下发后，直接在各分片  本地表join本地表，聚合后数据即为准确数据，实现 colocate join









1. 用户的一天的数据在一个分片上
2. 字典表30G将近
3. 查询时间是 0.5ms



3亿 join 百万左右的总的数据量



Sku_id 关联





3亿

每个分片 26697201 2700万

大表where 条件后 是 9399649 900万 1000万



小表

3000万

每个分片 830904 百万

每个几点 25100 2.5万



字典 30G







