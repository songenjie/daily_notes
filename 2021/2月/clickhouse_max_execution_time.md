```

```



time size 



```sql
SELECT
    query_start_time,
    user,
    query_duration_ms / 1000 AS querytime,
    type,
    substring(query, 1, 6) AS squery,
    formatReadableSize(memory_usage) AS memory,
    formatReadableSize(written_bytes) AS writesize,
    formatReadableSize(read_bytes) AS readsize
FROM system.query_log_all
WHERE (query_start_time > '2021-02-19 11:00:00') AND (type = 'QueryFinish')
ORDER BY query_duration_ms DESC limit 50;


SELECT
    query_start_time,
    user,
    query_duration_ms / 1000 AS querytime,
    type,
    substring(query, 1, 6) AS squery,
    formatReadableSize(memory_usage) AS memory,
    formatReadableSize(written_bytes) AS writesize,
    formatReadableSize(read_bytes) AS readsize,
    query
FROM system.query_log_all
WHERE (query_start_time > '2021-02-19 11:00:00') AND (type = 'QueryFinish')
ORDER BY query_duration_ms DESC limit 50;
```



