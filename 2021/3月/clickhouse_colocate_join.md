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
```





5. 操作流程

... 设计隐私数据 [可参数 clickhouse join 文章](https://github.com/songenjie/daily_notes/blob/master/2021/3%E6%9C%88/clickhouse_join.md)

实现细节主要为，根据id,将数据进行分片，是的id相同的两张表的数据，落入相同的分片中，使用 分布式表join 本地表的方式，下发后，直接在各分片  本地表join本地表，聚合后数据即为准确数据，实现 colocate join