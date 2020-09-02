## TTL for Columns and Tables[ ](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-ttl)

Determines the lifetime of values.

The `TTL` clause can be set for the whole table and for each individual column. Table-level TTL can also specify logic of automatic move of data between disks and volumes.

Expressions must evaluate to [Date](https://clickhouse.tech/docs/en/sql-reference/data-types/date/) or [DateTime](https://clickhouse.tech/docs/en/sql-reference/data-types/datetime/) data type.

Example:

```
TTL time_column
TTL time_column + interval
```

To define `interval`, use [time interval](https://clickhouse.tech/docs/en/sql-reference/operators/#operators-datetime) operators.

```
TTL date_time + INTERVAL 1 MONTH
TTL date_time + INTERVAL 15 HOUR
```

### Column TTL[ ](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-column-ttl)

When the values in the column expire, ClickHouse replaces them with the default values for the column data type. If all the column values in the data part expire, ClickHouse deletes this column from the data part in a filesystem.

The `TTL` clause can’t be used for key columns.

Examples:

Creating a table with TTL

```
CREATE TABLE example_table
(
    d DateTime,
    a Int TTL d + INTERVAL 1 MONTH,
    b Int TTL d + INTERVAL 1 MONTH,
    c String
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(d)
ORDER BY d;
```

Adding TTL to a column of an existing table

```
ALTER TABLE example_table
    MODIFY COLUMN
    c String TTL d + INTERVAL 1 DAY;
```

Altering TTL of the column

```
ALTER TABLE example_table
    MODIFY COLUMN
    c String TTL d + INTERVAL 1 MONTH;
```

### Table TTL[ ](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl)

Table can have an expression for removal of expired rows, and multiple expressions for automatic move of parts between [disks or volumes](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#table_engine-mergetree-multiple-volumes). When rows in the table expire, ClickHouse deletes all corresponding rows. For parts moving feature, all rows of a part must satisfy the movement expression criteria.

```
TTL expr [DELETE|TO DISK 'aaa'|TO VOLUME 'bbb'], ...
```

Type of TTL rule may follow each TTL expression. It affects an action which is to be done once the expression is satisfied (reaches current time):

- `DELETE` - delete expired rows (default action);
- `TO DISK 'aaa'` - move part to the disk `aaa`;
- `TO VOLUME 'bbb'` - move part to the disk `bbb`.

Examples:

Creating a table with TTL

```
CREATE TABLE example_table
(
    d DateTime,
    a Int
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(d)
ORDER BY d
TTL d + INTERVAL 1 MONTH [DELETE],
    d + INTERVAL 1 WEEK TO VOLUME 'aaa',
    d + INTERVAL 2 WEEK TO DISK 'bbb';
```

Altering TTL of the table

```
ALTER TABLE example_table
    MODIFY TTL d + INTERVAL 1 DAY;
```

**Removing Data**

Data with an expired TTL is removed when ClickHouse merges data parts.

When ClickHouse see that data is expired, it performs an off-schedule merge. To control the frequency of such merges, you can set `merge_with_ttl_timeout`. If the value is too low, it will perform many off-schedule merges that may consume a lot of resources.

If you perform the `SELECT` query between merges, you may get expired data. To avoid it, use the [OPTIMIZE](https://clickhouse.tech/docs/en/sql-reference/statements/optimize/) query before `SELECT`.