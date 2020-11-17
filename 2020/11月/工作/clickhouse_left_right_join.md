```mysql
CREATE TABLE jason.local_t1 ON CLUSTER clustername
(
    `I_ID` String,
    `CTIME` DateTime
)
ENGINE = ReplicatedReplacingMergeTree('/clickhouse/jason/tables/{shard}/local_t1', '{replica}')
PARTITION BY toDate(CTIME)
ORDER BY I_ID
SETTINGS index_granularity = 8192

CREATE TABLE jason.local_t2 ON CLUSTER clustername
(
    `I_ID` String,
    `CTIME` DateTime
)
ENGINE = ReplicatedReplacingMergeTree('/clickhouse/jason/tables/{shard}/local_t2', '{replica}')
PARTITION BY toDate(CTIME)
ORDER BY I_ID
SETTINGS index_granularity = 8192



CREATE TABLE jason.t1 ON CLUSTER clustername
(
    `I_ID` String,
    `CTIME` DateTime
)
ENGINE = Distributed('clustername', 'jason', 'local_t1', rand())

CREATE TABLE jason.t2 ON CLUSTER clustername
(
    `I_ID` String,
    `CTIME` DateTime
)
ENGINE = Distributed('clustername', 'jason', 'local_t2', rand())


insert into jason.t1 values(1,now());
insert into jason.t1 values(2,now());
insert into jason.t1 values(3,now());
insert into jason.t1 values(4,now());
insert into jason.t1 values(5,now());
insert into jason.t1 values(6,now());
insert into jason.t1 values(7,now());
insert into jason.t1 values(8,now());




insert into jason.t2 values(1,now());
insert into jason.t2 values(3,now());
insert into jason.t2 values(5,now());
insert into jason.t2 values(7,now());
insert into jason.t2 values(9,now());
insert into jason.t2 values(11,now());
insert into jason.t2 values(13,now());
insert into jason.t2 values(14,now());



SELECT 
    a.I_ID, 
    b.I_ID
FROM jason.t2 AS a
LEFT JOIN jason.t1 AS b ON a.I_ID = b.I_ID
ORDER BY a.I_ID ASC

SELECT 
    a.I_ID, 
    b.I_ID
FROM jason.t1 AS b
RIGHT JOIN jason.t2 AS a ON a.I_ID = b.I_ID
ORDER BY a.I_ID ASC




select _shard_num,I_ID from jason.t1;

SELECT
    _shard_num,
    I_ID
FROM jason.t1

┌─_shard_num─┬─I_ID─┐
│          7 │ 2    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          4 │ 8    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          8 │ 5    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          5 │ 4    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          8 │ 6    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│         13 │ 1    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│         11 │ 3    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          5 │ 7    │
└────────────┴──────┘

8 rows in set. Elapsed: 0.007 sec.

kc-bcc-pod22-10-196-102-231.hadoop.jd.local :) select _shard_num,I_ID from jason.t2;

SELECT
    _shard_num,
    I_ID
FROM jason.t2

┌─_shard_num─┬─I_ID─┐
│          4 │ 9    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          3 │ 5    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          5 │ 7    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│          8 │ 13   │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│         16 │ 14   │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│         16 │ 1    │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│         18 │ 11   │
└────────────┴──────┘
┌─_shard_num─┬─I_ID─┐
│         18 │ 3    │
└────────────┴──────┘

8 rows in set. Elapsed: 0.006 sec.

kc-bcc-pod22-10-196-102-231.hadoop.jd.local :) SELECT
:-]     a.I_ID,
:-]     b.I_ID
:-] FROM jason.t2 AS a
:-] LEFT JOIN jason.t1 AS b ON a.I_ID = b.I_ID
:-] ORDER BY a.I_ID ASC;

SELECT
    a.I_ID,
    b.I_ID
FROM jason.t2 AS a
LEFT JOIN jason.t1 AS b ON a.I_ID = b.I_ID
ORDER BY a.I_ID ASC

┌─I_ID─┬─b.I_ID─┐
│ 1    │ 1      │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 11   │        │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 13   │        │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 14   │        │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 3    │ 3      │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 5    │ 5      │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 7    │ 7      │
└──────┴────────┘
┌─I_ID─┬─b.I_ID─┐
│ 9    │        │
└──────┴────────┘

8 rows in set. Elapsed: 0.059 sec.

kc-bcc-pod22-10-196-102-231.hadoop.jd.local :) SELECT
:-]     a.I_ID,
:-]     b.I_ID
:-] FROM jason.t1 AS b
:-] RIGHT JOIN jason.t2 AS a ON a.I_ID = b.I_ID
:-] ORDER BY a.I_ID ASC;

SELECT
    a.I_ID,
    b.I_ID
FROM jason.t1 AS b
RIGHT JOIN jason.t2 AS a ON a.I_ID = b.I_ID
ORDER BY a.I_ID ASC

┌─a.I_ID─┬─I_ID─┐
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
└────────┴──────┘
┌─a.I_ID─┬─I_ID─┐
│ 1      │ 1    │
└────────┴──────┘
┌─a.I_ID─┬─I_ID─┐
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 1      │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 11     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 13     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 14     │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │ 3    │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 3      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │ 5    │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 5      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │ 7    │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 7      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
│ 9      │      │
└────────┴──────┘

144 rows in set. Elapsed: 0.076 sec.
```









