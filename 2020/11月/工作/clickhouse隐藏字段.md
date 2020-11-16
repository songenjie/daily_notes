```c++
NamesAndTypesList StorageDistributed::getVirtuals() const
{
    /// NOTE This is weird. Most of these virtual columns are part of MergeTree
    /// tables info. But Distributed is general-purpose engine.
    return NamesAndTypesList{
            NameAndTypePair("_table", std::make_shared<DataTypeString>()),
            NameAndTypePair("_part", std::make_shared<DataTypeString>()),
            NameAndTypePair("_part_index", std::make_shared<DataTypeUInt64>()),
            NameAndTypePair("_partition_id", std::make_shared<DataTypeString>()),
            NameAndTypePair("_sample_factor", std::make_shared<DataTypeFloat64>()),
            NameAndTypePair("_shard_num", std::make_shared<DataTypeUInt32>()),
    };
}
```





## Virtual Columns[ ](https://clickhouse.tech/docs/en/engines/table-engines/#table_engines-virtual_columns)

Virtual column is an integral table engine attribute that is defined in the engine source code.

You shouldn’t specify virtual columns in the `CREATE TABLE` query and you can’t see them in `SHOW CREATE TABLE` and `DESCRIBE TABLE` query results. Virtual columns are also read-only, so you can’t insert data into virtual columns.

To select data from a virtual column, you must specify its name in the `SELECT` query. `SELECT *` doesn’t return values from virtual columns.

If you create a table with a column that has the same name as one of the table virtual columns, the virtual column becomes inaccessible. We don’t recommend doing this. To help avoid conflicts, virtual column names are usually prefixed with an underscore.







https://github.com/ClickHouse/ClickHouse/issues/11210
