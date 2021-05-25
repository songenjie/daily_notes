```sql
CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    A.day AS day,
    B.number
FROM LEFT_TABLE2 AS A
INNER JOIN RIGHT_TABLE2 AS B ON A.id = B.id

Query id: 235e0e86-356d-4853-9655-ab42700bbdc6

Ok.

0 rows in set. Elapsed: 0.006 sec.

JASONG-MB0 :) show create table meterialized_table_3;

SHOW CREATE TABLE meterialized_table_3

Query id: 20e8e6fe-73d5-49d1-92f2-fa7a710c0f8c

┌─statement──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
(
    `day` Date,
    `id` UInt32,
    `number` UInt32
) AS
SELECT
    A.day AS day,
    B.number
FROM jasong.LEFT_TABLE2 AS A
INNER JOIN jasong.RIGHT_TABLE2 AS B ON A.id = B.id │
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

1 rows in set. Elapsed: 0.006 sec.

JASONG-MB0 :) select * from jasong.RIGHT_TABLE2;

SELECT *
FROM jasong.RIGHT_TABLE2

Query id: 23e00f82-3ba4-4e5b-9803-c8b34139d297

┌─id─┬─number─┐
│ 27 │      1 │
└────┴────────┘

1 rows in set. Elapsed: 0.009 sec.

JASONG-MB0 :) INSERT INTO jasong.LEFT_TABLE2  VALUES ('2021-05-20 10:26:22', 27, 1809);

INSERT INTO jasong.LEFT_TABLE2 VALUES

Query id: d97424b9-3686-439d-ac7a-1211d204646f

Ok.

1 rows in set. Elapsed: 0.058 sec.

JASONG-MB0 :) select * from jasong.meterialized_table_storage;

SELECT *
FROM jasong.meterialized_table_storage

Query id: d8851ccd-ff8f-429f-a57c-96c1e0e3df52

┌────────day─┬─id─┬─number─┐
│ 2021-05-20 │  0 │      0 │
└────────────┴────┴────────┘








CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    A.day AS day,
    B.number AS number
FROM LEFT_TABLE2 AS A
INNER JOIN RIGHT_TABLE2 AS B ON A.id = B.id

Query id: 7ed0fda2-e0ae-481b-b758-fd0c4192dd01

Ok.

0 rows in set. Elapsed: 0.086 sec.


INSERT INTO jasong.LEFT_TABLE2  VALUES ('2021-05-20 10:26:22', 27, 1809);

INSERT INTO jasong.LEFT_TABLE2 VALUES

Query id: ee23a39d-c39e-4e6a-bd03-eb6175ede443

Ok.

1 rows in set. Elapsed: 0.103 sec.

JASONG-MB0 :) select * from meterialized_table_storage;

SELECT *
FROM meterialized_table_storage

Query id: 5fb71caf-abd6-4fa2-87ca-935c1f17998a

┌────────day─┬─id─┬─number─┐
│ 2021-05-20 │  0 │      0 │
└────────────┴────┴────────┘
┌────────day─┬─id─┬─number─┐
│ 2021-05-20 │  0 │      1 │
└────────────┴────┴────────┘
```









```sql
//这里的区域实际上是最不关键的，这里这涉及到meterialized_table_3 查询使用
CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
AS
SELECT
    A.day AS day,
    B.number AS number
FROM jasong.LEFT_TABLE2 AS A
INNER JOIN jasong.RIGHT_TABLE2 AS B ON A.id = B.id

CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
(
    `day` Date,
    `id` UInt32,
    `number` UInt32
) AS
SELECT
    A.day AS day,
    B.number AS number
FROM jasong.LEFT_TABLE2 AS A
INNER JOIN jasong.RIGHT_TABLE2 AS B ON A.id = B.id


```





```c++
            /*
            if (properties.columns.size() == to_storage_columns.size())
            {
                auto column = properties.columns.begin();
                auto to_storage_column = to_storage_columns.begin();
                for (; column != properties.columns.end(); column++, to_storage_column++)
                    if (column->name != to_storage_column->name)
                        throw Exception(
                            create.database + "." + create.table + " column: " + column->name + " is matched "
                            + create.to_table_id.database_name + "." + create.to_table_id.table_name
                            + " column: " + to_storage_column->name + "!\n The order of the table:" + create.database + "."
                            + create.table + " is different from the order of the table:" + create.to_table_id.database_name + "."
                            + create.to_table_id.table_name + "!\n please check you sql! ",
                            ErrorCodes::INCORRECT_QUERY);
            }*/
```





```
cat /proc/meminfo | grep -i swap
```

