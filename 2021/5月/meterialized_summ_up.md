## 一 问题

### 1 no alias create table 

- create 成功

```sql
CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    LEFT_TABLE2.day,
    RIGHT_TABLE2.id,
    RIGHT_TABLE2.number
FROM LEFT_TABLE2 
INNER JOIN RIGHT_TABLE2 ON LEFT_TABLE2.id = RIGHT_TABLE2.id

show create 
库的名字也补齐了 ,物化视图字段错误

CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
(
    `day` Date,
    `RIGHT_TABLE2.id` UInt32,
    `RIGHT_TABLE2.number` UInt32
) AS
SELECT
    LEFT_TABLE2.day,
    RIGHT_TABLE2.id,
    RIGHT_TABLE2.number
FROM jasong.LEFT_TABLE2
INNER JOIN jasong.RIGHT_TABLE2 ON LEFT_TABLE2.id = RIGHT_TABLE2.id

```

- 插入成功
- 查询错误

```sql
192.168.19.12 :) select * from jasong.meterialized_table_3;

SELECT *
FROM jasong.meterialized_table_3

Query id: 095e9530-41ee-4d6e-b46f-5b6ec2176678


0 rows in set. Elapsed: 0.001 sec.

Received exception from server (version 20.7.2):
Code: 16. DB::Exception: Received from 10.0.0.14:9000. DB::Exception: There is no column with name `RIGHT_TABLE2.id` in table jasong.meterialized_table_storage. There are columns: day, id, number, _part, _part_index, _partition_id, _sample_factor.
```



- 问题

1. 物化视图 字段修复





### 2 alias 

- create 失败

```sql
CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    A.day,
    B.number,
    B.id
FROM LEFT_TABLE2 AS A
INNER JOIN RIGHT_TABLE2 AS B ON A.id = B.id

- alias table 不支持

Received exception from server (version 21.6.1):
Code: 352. DB::Exception: Received from 127.0.0.1:19000. DB::Exception: Cannot detect left and right JOIN keys. JOIN ON section is ambiguous.: While processing A.id = B.id.
```

- 加 database 成功

```sql
CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    A.day,
    B.id,
    B.number
FROM jasong.LEFT_TABLE2 AS A
INNER JOIN jasong.RIGHT_TABLE2 AS B ON A.id = B.id

show create
- 物化视图 字段错误
CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
(
    `day` Date,
    `B.id` UInt32,
    `B.number` UInt32
) AS
SELECT
    A.day,
    B.id,
    B.number
FROM jasong.LEFT_TABLE2 AS A
INNER JOIN jasong.RIGHT_TABLE2 AS B ON A.id = B.id
```

- 写入正常

```sql
INSERT INTO RIGHT_TABLE2  VALUES  (27, 1);
INSERT INTO jasong.LEFT_TABLE2  VALUES ('2021-05-03 10:26:22', 27, 1809);
select * from meterialized_table_3;
```



- 查询失败

```sql
 查询错误
SELECT *
FROM meterialized_table_3

Query id: e997f965-6b57-4b4c-a948-c23902d09ace


0 rows in set. Elapsed: 0.001 sec.

Received exception from server (version 20.7.2):
Code: 16. DB::Exception: Received from 10.0.0.14:9000. DB::Exception: There is no column with name `B.id` in table jasong.meterialized_table_storage. There are columns: day, id, number, _part, _part_index, _partition_id, _sample_factor.

物化视图
```



- 解决

1. 修复no database 建表失败问题 补充database 

2. alias 物化视图 字段错误





## 二 问题总结

1. 不添加database 不支持alias
2. 修复no database 建表失败问题 补充database 
3. alias 物化视图 字段错误





## 三  修复

### 1 table no alias 修复

```sql
CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    LEFT_TABLE2.day,
    RIGHT_TABLE2.id,
    RIGHT_TABLE2.number
FROM LEFT_TABLE2
INNER JOIN RIGHT_TABLE2 ON LEFT_TABLE2.id = RIGHT_TABLE2.id

- show create 
修复物化视图字段
CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
(
    `day` Date,
    `id` UInt32,
    `number` UInt32
) AS
SELECT
    LEFT_TABLE2.day,
    RIGHT_TABLE2.id,
    RIGHT_TABLE2.number
FROM jasong.LEFT_TABLE2
INNER JOIN jasong.RIGHT_TABLE2 ON LEFT_TABLE2.id = RIGHT_TABLE2.id


插入数据
INSERT INTO RIGHT_TABLE2  VALUES  (27, 1);
INSERT INTO jasong.LEFT_TABLE2  VALUES ('2021-05-03 10:26:22', 27, 1809);
select * from meterialized_table_3;

查询表正常
JASONG-MB0 :) select * from meterialized_table_3;

SELECT *
FROM meterialized_table_3

Query id: 0f3ae532-325b-4419-b265-4ac6b0261cc7

┌────────day─┬─id─┬─number─┐
│ 2021-05-03 │ 27 │      1 │
└────────────┴────┴────────┘

1 rows in set. Elapsed: 0.006 sec.
```





### 2 table alias 修复

```sql
 - 修复 no database create 失败
CREATE MATERIALIZED VIEW meterialized_table_3 TO meterialized_table_storage AS
SELECT
    A.day as day ,
    B.number as number ,
    B.id  as id
FROM LEFT_TABLE2 AS A
INNER JOIN RIGHT_TABLE2 AS B ON A.id = B.id


- show create  补齐database 修复物化视图字段
CREATE MATERIALIZED VIEW jasong.meterialized_table_3 TO jasong.meterialized_table_storage
(
    `day` Date,
    `id` UInt32,
    `number` UInt32
) AS
SELECT
    A.day,
    B.id,
    B.number
FROM jasong.LEFT_TABLE2 AS A
INNER JOIN jasong.RIGHT_TABLE2 AS B ON A.id = B.id
```





### 3 节点重启 验证

通过