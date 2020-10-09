# 1 本地表



## 1.1 table 总存储粒度统计

```
--create view meta.tables_info as
SELECT 
    database,
    table,
   formatReadableSize(size) AS size,
   formatReadableSize(bytes_on_disk) AS bytes_on_disk,
   formatReadableSize(data_uncompressed_bytes) AS data_uncompressed_bytes,
   formatReadableSize(data_compressed_bytes) AS data_compressed_bytes,
   compress_rate,
   rows,
   days,
   formatReadableSize(avgDaySize) AS avgDaySize
FROM 
(
    SELECT 
        database,
        table,
        sum(bytes) AS size,
        sum(rows) AS rows,
        min(min_date) AS min_date,
        max(max_date) AS max_date,
        sum(bytes_on_disk) AS bytes_on_disk,
        sum(data_uncompressed_bytes) AS data_uncompressed_bytes,
        sum(data_compressed_bytes) AS data_compressed_bytes,
       (data_compressed_bytes / data_uncompressed_bytes) * 100 AS compress_rate,
       max_date - min_date AS days,
       size / (max_date - min_date) AS avgDaySize
    FROM system.parts
    GROUP BY 
        database,
        table
)order by database,table;

```

## 1.2 table 在 磁盘存储 统计

```mysql
SELECT 
    database,
    table,
   disk_name,
   formatReadableSize(size) AS size,
   formatReadableSize(bytes_on_disk) AS bytes_on_disk,
   formatReadableSize(data_uncompressed_bytes) AS data_uncompressed_bytes,
   formatReadableSize(data_compressed_bytes) AS data_compressed_bytes,
   compress_rate,
   rows,
   days,
   formatReadableSize(avgDaySize) AS avgDaySize
FROM 
(
    SELECT 
        database,
        table,
       disk_name,
        sum(bytes) AS size,
        sum(rows) AS rows,
        min(min_date) AS min_date,
        max(max_date) AS max_date,
        sum(bytes_on_disk) AS bytes_on_disk,
        sum(data_uncompressed_bytes) AS data_uncompressed_bytes,
        sum(data_compressed_bytes) AS data_compressed_bytes,
       (data_compressed_bytes / data_uncompressed_bytes) * 100 AS compress_rate,
       max_date - min_date AS days,
       size / (max_date - min_date) AS avgDaySize
    FROM system.parts
    GROUP BY 
        database,
        table,
       disk_name
)order by database,table;
```



## 1.3 partition 在磁盘占用情况

```mysql
SELECT 
    database,
    table,
    partition,
   formatReadableSize(size) AS size,
   formatReadableSize(bytes_on_disk) AS bytes_on_disk,
   formatReadableSize(data_uncompressed_bytes) AS data_uncompressed_bytes,
   formatReadableSize(data_compressed_bytes) AS data_compressed_bytes,
   compress_rate,
   rows,
   days,
   formatReadableSize(avgDaySize) AS avgDaySize
FROM 
(
    SELECT 
        database,
        table,
        partition,
        sum(bytes) AS size,
        sum(rows) AS rows,
        min(min_date) AS min_date,
        max(max_date) AS max_date,
        sum(bytes_on_disk) AS bytes_on_disk,
        sum(data_uncompressed_bytes) AS data_uncompressed_bytes,
        sum(data_compressed_bytes) AS data_compressed_bytes,
       (data_compressed_bytes / data_uncompressed_bytes) * 100 AS compress_rate,
       max_date - min_date AS days,
       size / (max_date - min_date) AS avgDaySize
    FROM system.parts
    GROUP BY 
        database,
        table,
        partition
)
ORDER BY 
    database ASC,
    table ASC,
    partition ASC
```



这样的话 就知道 每个表在集群的存储，每个表partition的存储，每个表在磁盘上的占用情况

# 2 集群汇总粒度

- 需求,创建分布式表

**ATTACH TABLE IF NOT EXISTS** system.parts_dis **ON CLUSTER** ZYX_CK_Pub_11 **AS** system.parts

**ENGINE** = Distributed('ZYX_CK_Pub_11', 'system', 'parts', rand());



```
ATTACH TABLE IF NOT EXISTS system.parts_dis ON CLUSTER ZYX_CK_Pub_11 AS system.parts

ENGINE = Distributed('ZYX_CK_Pub_11', 'system', 'parts', rand());
```



```mysql
CREATE TABLE system.parts_dis
(
    `partition` String,
    `name` String,
    `part_type` String,
    `active` UInt8,
    `marks` UInt64,
    `rows` UInt64,
    `bytes_on_disk` UInt64,
    `data_compressed_bytes` UInt64,
    `data_uncompressed_bytes` UInt64,
    `marks_bytes` UInt64,
    `modification_time` DateTime,
    `remove_time` DateTime,
    `refcount` UInt32,
    `min_date` Date,
    `max_date` Date,
    `min_time` DateTime,
    `max_time` DateTime,
    `partition_id` String,
    `min_block_number` Int64,
    `max_block_number` Int64,
    `level` UInt32,
    `data_version` UInt64,
    `primary_key_bytes_in_memory` UInt64,
    `primary_key_bytes_in_memory_allocated` UInt64,
    `is_frozen` UInt8,
    `database` String,
    `table` String,
    `engine` String,
    `disk_name` String,
    `path` String,
    `hash_of_all_files` String,
    `hash_of_uncompressed_files` String,
    `uncompressed_hash_of_compressed_files` String,
    `delete_ttl_info_min` DateTime,
    `delete_ttl_info_max` DateTime,
    `move_ttl_info.expression` Array(String),
    `move_ttl_info.min` Array(DateTime),
    `move_ttl_info.max` Array(DateTime),
    `bytes` UInt64 ALIAS bytes_on_disk,
    `marks_size` UInt64 ALIAS marks_bytes
)
ENGINE = Distributed('ZYX_CK_Pub_062', 'system', 'parts', rand()) 
```





## 2.1 table 总存储粒度统计



```mysql
--create view meta.tables_info as
SELECT 
    database,
    table,
   formatReadableSize(size) AS size,
   formatReadableSize(bytes_on_disk) AS bytes_on_disk,
   formatReadableSize(data_uncompressed_bytes) AS data_uncompressed_bytes,
   formatReadableSize(data_compressed_bytes) AS data_compressed_bytes,
   compress_rate,
   rows,
   days,
   formatReadableSize(avgDaySize) AS avgDaySize
FROM 
(
    SELECT 
        database,
        table,
        sum(bytes) AS size,
        sum(rows) AS rows,
        min(min_date) AS min_date,
        max(max_date) AS max_date,
        sum(bytes_on_disk) AS bytes_on_disk,
        sum(data_uncompressed_bytes) AS data_uncompressed_bytes,
        sum(data_compressed_bytes) AS data_compressed_bytes,
       (data_compressed_bytes / data_uncompressed_bytes) * 100 AS compress_rate,
       max_date - min_date AS days,
       size / (max_date - min_date) AS avgDaySize
    FROM system.parts_dis
    GROUP BY 
        database,
        table
)order by database,table;
```

## 2.2 table 在 磁盘存储 统计

```mysql
SELECT 
    database,
    table,
   disk_name,
   formatReadableSize(size) AS size,
   formatReadableSize(bytes_on_disk) AS bytes_on_disk,
   formatReadableSize(data_uncompressed_bytes) AS data_uncompressed_bytes,
   formatReadableSize(data_compressed_bytes) AS data_compressed_bytes,
   compress_rate,
   rows,
   days,
   formatReadableSize(avgDaySize) AS avgDaySize
FROM 
(
    SELECT 
        database,
        table,
       disk_name,
        sum(bytes) AS size,
        sum(rows) AS rows,
        min(min_date) AS min_date,
        max(max_date) AS max_date,
        sum(bytes_on_disk) AS bytes_on_disk,
        sum(data_uncompressed_bytes) AS data_uncompressed_bytes,
        sum(data_compressed_bytes) AS data_compressed_bytes,
       (data_compressed_bytes / data_uncompressed_bytes) * 100 AS compress_rate,
       max_date - min_date AS days,
       size / (max_date - min_date) AS avgDaySize
    FROM system.parts_dis
    GROUP BY 
        database,
        table,
       disk_name
)order by database,table;
```

## 2.3 partition 在磁盘占用情况

```mysql
SELECT 
    database,
    table,
    partition,
   formatReadableSize(size) AS size,
   formatReadableSize(bytes_on_disk) AS bytes_on_disk,
   formatReadableSize(data_uncompressed_bytes) AS data_uncompressed_bytes,
   formatReadableSize(data_compressed_bytes) AS data_compressed_bytes,
   compress_rate,
   rows,
   days,
   formatReadableSize(avgDaySize) AS avgDaySize
FROM 
(
    SELECT 
        database,
        table,
        partition,
        sum(bytes) AS size,
        sum(rows) AS rows,
        min(min_date) AS min_date,
        max(max_date) AS max_date,
        sum(bytes_on_disk) AS bytes_on_disk,
        sum(data_uncompressed_bytes) AS data_uncompressed_bytes,
        sum(data_compressed_bytes) AS data_compressed_bytes,
       (data_compressed_bytes / data_uncompressed_bytes) * 100 AS compress_rate,
       max_date - min_date AS days,
       size / (max_date - min_date) AS avgDaySize
    FROM system.parts_dis
    GROUP BY 
        database,
        table,
        partition
)
ORDER BY 
    database ASC,
    table ASC,
    partition ASC
```