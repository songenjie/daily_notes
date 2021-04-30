```sql

CREATE TABLE if not exists jasong.table_test_local on cluster jasong (     EventDate DateTime,     CounterID UInt32,     UserID UInt32 ) ENGINE = ReplicatedMergeTree('/jasong/jasong/table_test_local/{shard}', '{replica}') PARTITION     BY toYYYYMMDD(EventDate) ORDER BY (CounterID, EventDate, intHash32(UserID)) ;


```

