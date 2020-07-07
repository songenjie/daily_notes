```c++
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



- 数据part由开始创建到全部完成

1. 内存：数据首先会被写入内存缓存区
2. 本地磁盘：数据接着回被写入tmp临时目录分区，待全部完成后再将临时目录重命名为正式分区part



- ReplicatedMergeTree

增加Zookeeper 的部分，它会进一步在Zookeeper 创建一系列坚挺节点。并以实现多个实例之间的通信，Zookeep 不涉及数据的传输



