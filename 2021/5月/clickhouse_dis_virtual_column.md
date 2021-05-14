

```sql
JASONG-MB0 :) select _shard_num,database,name from system.system_tables_dis where database !='system';

SELECT
    _shard_num,
    database,
    name
FROM system.system_tables_dis
WHERE database != 'system'

Query id: 5648ee87-44bf-4e75-b980-257bc7adb2f5

┌─_shard_num─┬─database─┬─name───────────────────────┐
│          1 │ default  │ jasong_tables_dis          │
│          1 │ jasong   │ LEFT_TABLE2                │
│          1 │ jasong   │ RIGHT_TABLE2               │
│          1 │ jasong   │ meterialized_table_storage │
└────────────┴──────────┴────────────────────────────┘
┌─_shard_num─┬─database─┬─name───────────────────────┐
│          2 │ default  │ download                   │
│          2 │ default  │ download_daily             │
│          2 │ default  │ download_daily2            │
│          2 │ default  │ download_daily_mv          │
│          2 │ default  │ download_daily_mv_test_2   │
│          2 │ default  │ download_daily_test_2      │
│          2 │ default  │ price                      │
│          2 │ default  │ user                       │
│          2 │ jasong   │ LEFT_TABLE1                │
│          2 │ jasong   │ LEFT_TABLE2                │
│          2 │ jasong   │ RIGHT_TABLE1               │
│          2 │ jasong   │ RIGHT_TABLE2               │
│          2 │ jasong   │ meterialized_table_3       │
│          2 │ jasong   │ meterialized_table_storage │
└────────────┴──────────┴────────────────────────────┘
```





```sql
CREATE TABLE system.system_tables_dis as system.tables
ENGINE = Distributed('system_cluster', 'system', 'tables', rand())
```

