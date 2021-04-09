### STOP MERGES[ ](https://clickhouse.tech/docs/zh/sql-reference/statements/system/#query_language-system-stop-merges)

为MergeTree系列引擎表停止后台合并操作。

```
SYSTEM STOP MERGES [[db.]merge_tree_family_table_name]
```





stop insert 权限





1. 停止数据写入，确保迁移的数据的全量性
2. 停止merge  确保当前查到的所有数据 文件都没有变化





开始 fetch part 

https://github.com/ClickHouse/ClickHouse/pull/22706

