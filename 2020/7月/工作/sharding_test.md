```
CREATE TABLE jason.table4 on cluster ck_06
(
  `EventDate` DateTime, 
  `CounterID` UInt32, 
  `UserID` UInt32
)
ENGINE = ReplicatedMergeTree('/clickhouse/ck_06/jdob_ha/jason/{shard}/table4', '{replica}')
PARTITION BY toYYYYMMDD(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha', index_granularity = 8192


CREATE TABLE jason.table4_d on cluster ck_06
(
    `EventDate` DateTime, 
    `CounterID` UInt32, 
    `UserID` UInt32
)
ENGINE = Distributed('ck_06', 'jason', 'table4', CounterID)



```

