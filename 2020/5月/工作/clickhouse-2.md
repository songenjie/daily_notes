

分布式表创建

https://suncle.me/2019/07/27/clickhouse-create-distributed-table-and-table-engine-introduction/


ReplicatedMergeTree

https://clickhouse.tech/docs/zh/engines/table-engines/mergetree-family/replication/

创建流程
https://blog.csdn.net/jiangshouzhuang/article/details/100762451




比较完成的分片规则讲解

https://www.jianshu.com/p/20639fdfdc99


clickhouse 精华社区
http://www.clickhouse.com.cn/?tab=good&page=3


高可用
https://www.cnblogs.com/freeweb/p/9352947.html

https://www.slideshare.net/jackgao946/clickhouse-data-replication-in-34-pages
https://www.altinity.com/blog/2018/5/10/circular-replication-cluster-topology-in-clickhouse



分布式表查询规则就是：

分别从一个shard了任意取一个replica,去查，最终结果合并
所以一个replica不能同时在两个shard里面存(这里指的是完全相同的存储路径),否则它可能会在查询的时候命中两次



高可能解决方案：3副本的情况
1. 单分片单副本 -- 单机器（单进程） (查询只会命中1/3的分区)

2. 单机器3进程  -- 单分片单副本 （shard==机器数量) 
(现在ck是单目录存储结构，所以也挺合适，缺点就是需要单台机器部署多个clickhouse server - 端口占用较多)

2. 






本地表建立
1. internal_replication=true：数据不会在不同节点之间自动同步,也就是只写入一个shard的里面的副本（写入分布式表的时候)
2. internal_replication=false: 数据写入分布式表，数据会自动同步（本地表不会同步）
false:情况称之为 poor man's relication ,需要自动处理存储数据、数据迁移等工作，不建议使用

3. internal_replication=true 加上 同时开启表级别的复制，这样无论上述哪个副本被吸入，数据都会同步到其他副本（也即是节点)


那怎么开启表的复制呢，其实就是在zk中设置相同的存储路径 ReplicatedMergeTree(/clickhouse/tables/{shard}, {replica}),这就是两个副本之间的配置，shard一样，replica不一样，zk就会管理

一般还会有个 layer 配置，layer 指的第几层，同一层的数据量一样{shard},没啥用 layer - shard 现在一个意思









circle in clickhouse cluster ha

metrics.xml set internal_replication = true

users.xml set load_balancing=in_order






create table shard_01.localtable (
column1 Int32,
column2 Int32
) Engine=ReplicatedMergeTree(‘/clickhouse/jdolap_ck_01/tables/shard_01’, ‘replica_1’,,(sort columns),8192);


CREATE TABLE shard_01.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_01/localtable', 'replica_01')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_02.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_02/localtable', 'replica_03')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_03.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_03/localtable', 'replica_02')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);




CREATE TABLE shard_01.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_01/localtable', 'replica_02')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_02.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_02/localtable', 'replica_01')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_03.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_03/localtable', 'replica_03')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);




CREATE TABLE shard_01.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_01/localtable', 'replica_03')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_02.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_02/localtable', 'replica_02')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_03.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_03/localtable', 'replica_01')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID);







CREATE TABLE IF NOT EXISTS localtable_dis(
   EventDate Date,
   CounterID UInt32,
   UserID UInt32)
ENGINE = Distributed(jdolap_ck_01, '', localtable, rand());




CREATE TABLE shard_03.localtable2
(
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_01/shard_03/localtable2', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);







CREATE TABLE IF NOT EXISTS localtable_dis(
   EventDate Date,
   CounterID UInt32,
   UserID UInt32)
ENGINE = Distributed(jdolap_ck_01, '', localtable, rand());




