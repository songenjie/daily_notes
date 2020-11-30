

# ClickHouse查询分布式表LEFT JOIN改RIGHT JOIN的大坑





## A LEFT JOIN B != B RIGHT JOIN A





# 由一个慢查询衍生出的问题

我们线上有一个ClickHouse集群, 总共6个服务器, 配置均为16C 64G SSD, 集群配置为三分片两副本

有两个表这里称为`small_table`和`big_table`. 都是`ReplicatedMergeTree`引擎(三个分片两个副本).

`small_table`有79w数据, `big_table`有5亿数据(数据在之后的示例中没有任何变化), 在下文中`small_table`和`big_table`都为分布式表, 可以获取全量数据, `small_table_local`和`big_table_local`为各节点上的本地表名称



`small_table`有79w数据, `big_table`有5亿数据(数据在之后的示例中没有任何变化), 在下文中`small_table`和`big_table`都为分布式表, 可以获取全量数据, `small_table_local`和`big_table_local`为各节点上的本地表名称

```mysql
SELECT 
    table, 
    formatReadableSize(sum(data_compressed_bytes)) AS tc, 
    formatReadableSize(sum(data_uncompressed_bytes)) AS tu, 
    sum(data_compressed_bytes) / sum(data_uncompressed_bytes) AS ratio
FROM system.columns
WHERE (database = currentDatabase()) AND (table IN ('small_table_local', 'big_table_local'))
GROUP BY table
ORDER BY table ASC

┌─table─────────────────────────┬─tc────────┬─tu────────┬──────────────ratio─┐
│ small_table_local             │ 12.87 MiB │ 14.91 MiB │ 0.8633041477100831 │
│ big_table_local               │ 15.46 GiB │ 57.31 GiB │ 0.2697742507036428 │
└───────────────────────────────┴───────────┴───────────┴────────────────────┘
```



```mysql
SELECT count(*)
FROM small_table

┌─count()─┐
│  794469 │
└─────────┘
SELECT count(*)
FROM big_table

┌───count()─┐
│ 519898780 │
└───────────┘
```



```mysql
#time clickhouse-client --time --progress --query="
SELECT 
    a.UID, B.UID
FROM
    dwh.small_table a
        LEFT JOIN
    dwh.big_table b ON a.UID = b.UID
" > /dev/null
293.769

real    4m53.798s
user    0m0.574s
sys     0m0.225s
```



![单个节点](https://raw.githubusercontent.com/Fanduzi/Figure_bed/master/img/%E6%9F%A5%E8%AF%A2%E5%8D%A0%E7%94%A8%E5%86%85%E5%AD%98.png)









LET JOIN

```mysql
#time clickhouse-client --time --progress --query="
SELECT 
    COUNT(*)
FROM
    dwh.small_table a
        LEFT JOIN
    dwh.big_table b ON a.UID = b.UID
"
6042735 --count
917.560 --时间

real    15m17.580s
user    0m0.253s
sys     0m0.489s
```



RIGHT JOIN

```mysql
#time clickhouse-client --time --progress --query="
SELECT 
    COUNT(*)
FROM
    dwh.big_table b
        RIGHT JOIN
    dwh.small_table a ON a.UID = b.UID
"
6897617 --count
11.655 --时间

real    0m11.675s
user    0m0.014s
sys     0m0.017s
```







