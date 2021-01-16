# Zookeeper 冷热分区设计





### 1 zookeeper 设计

![图片描述](https://img1.sycdn.imooc.com/5d2c4d0400018f6b09000673.jpg)





### 2 zookeeper 缺点

1 读写节点达到 400w 的时候，对集群的读写性能是有影响

2 java 写到的 频繁gc的问题

3 snapt shot ，写入磁盘，读写会有短暂的暂停 (1h小时一次 snap shot) 2G



### 3 目前olap 已经进行的优化

1. 延长snapt shot 时间
2. 预申请事务日志大小



###  4 解决方案

#### 4.1 clickhouse 官方

ClickHouse also supports to store replicas meta information in the auxiliary ZooKeeper cluster by providing ZooKeeper cluster name and path as engine arguments. In other word, it supports to store the metadata of differnt tables in different ZooKeeper clusters.

Example of setting the addresses of the auxiliary ZooKeeper cluster:

```xml
<auxiliary_zookeepers>
    <zookeeper2>
        <node>
            <host>example_2_1</host>
            <port>2181</port>
        </node>
        <node>
            <host>example_2_2</host>
            <port>2181</port>
        </node>
        <node>
            <host>example_2_3</host>
            <port>2181</port>
        </node>
    </zookeeper2>
    <zookeeper3>
        <node>
            <host>example_3_1</host>
            <port>2181</port>
        </node>
    </zookeeper3>
</auxiliary_zookeepers>
```

To store table datameta in a auxiliary ZooKeeper cluster instead of default ZooKeeper cluster, we can use the SQL to create table with ReplicatedMergeTree engine as follow:

```sql
CREATE TABLE table_name ( ... ) ENGINE = ReplicatedMergeTree('zookeeper_name_configured_in_auxiliary_zookeepers:path', 'replica_name') ...
```

You can specify any existing ZooKeeper cluster and the system will use a directory on it for its own data (the directory is specified when



#### 4.2 znode 冷热分离， znode partition 粒度的冷热分离

原因：热数据基本就是最近一天落入的数据，OLAP业务基本属于增量数据，历史数据不变化

好处：

- 降级znode 数量，提高zookeeper 处理能力
- btree 存储量减少，加速snapshot





### 5 设计



5.1 clickhouse table in zookeeper storage

![image-20210116174208452](/Users/songenjie/Library/Application Support/typora-user-images/image-20210116174208452.png)





5.2 parition state

/clickhouse/ZYX_CK_TS_WQ/jdob_ha/test_db/table_2/02/block_numbers/20190101/State

COLD/HOT



5.3 node stat 

![img](https://yuzhouwan.com/picture/zk/zk_znode.png)

/clickhouse/ZYX_CK_TS_WQ/jdob_ha/test_db/table_2/02/replicas/01/20190101_0_0_0

/clickhouse/ZYX_CK_TS_WQ/jdob_ha/test_db/table_2/02/replicas/01/20190101_0_0_0

get partition 20190101 最后一次修改的时间



partition State COLD 的parts 迁移到另外一个集群



5.4  part move

![image-20210116180922216](/Users/songenjie/Library/Application Support/typora-user-images/image-20210116180922216.png)



5.5  改动

1. clickhouse 改动
2. partmove 代码



### 6 测试

1 java part move 程序
```
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Replica - start init /clickhouse/***/jdob_ha/jason/table_test_local/02/replicas/02 part done
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - start init /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02  replicas done
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191214_0_0_0 date time is 2021-01-11 20:11:00
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - update parition time to 2021-01-11 20:11:00
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191215_0_0_0 date time is 2021-01-11 20:11:05
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - update parition time to 2021-01-11 20:11:05
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191213_0_0_0 date time is 2021-01-11 20:10:56
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - update parition time to 2021-01-11 20:10:56
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191213_0_0_0 date time is 2021-01-11 20:10:55
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191214_0_0_0 date time is 2021-01-11 20:11:00
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191215_0_0_0 date time is 2021-01-11 20:11:05
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191215_0_0_0 date time is 2021-01-11 20:11:05
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191213_0_0_0 date time is 2021-01-11 20:10:56
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191214_0_0_0 date time is 2021-01-11 20:11:00
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - partition : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191213 time: + 2021-01-11 20:10:56 state: HOT
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - partition : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215 time: + 2021-01-11 20:11:05 state: COLD
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - partition : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214 time: + 2021-01-11 20:11:00 state: COLD
2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191213/State to HOT
2021-01-12 09:38:01,288 [Timer-0] INFO  metadata.Shard - set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191213/State to HOT done
2021-01-12 09:38:01,288 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to HOT
2021-01-12 09:38:01,296 [Timer-0] INFO  metadata.Shard - set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to HOT done
2021-01-12 09:38:01,296 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to HOT
2021-01-12 09:38:01,304 [Timer-0] INFO  metadata.Shard - set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to HOT done
2021-01-12 09:38:01,304 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to COLD
2021-01-12 09:38:01,313 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to COLD done
2021-01-12 09:38:01,313 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to COLD
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to COLD done
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - cold partition :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - cold partition :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191214
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191214_0_0_0 need move
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191215
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191215_0_0_0 need move
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191213
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191213_0_0_0 need drop
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191213
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191213_0_0_0 need drop
2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191214
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191214_0_0_0 need move
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191215
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191215_0_0_0 need move
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191215
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191215_0_0_0 need move
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191213
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191213_0_0_0 need drop
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191214
2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191214_0_0_0 need move
2021-01-12 09:38:01,322 [Timer-0] INFO  jdbc.ClickHouse - Init Shards done ..
2021-01-12 09:38:01,322 [Timer-0] INFO  PartMove - source of shard path  : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas
2021-01-12 09:38:01,323 [Timer-0] INFO  zkreader.Reader - Reading /clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas from ip-.58:port
2021-01-12 09:38:02,324 [Timer-0] INFO  zkreader.Reader - Processing, total=29, processed=29
2021-01-12 09:38:02,324 [Timer-0] INFO  zkreader.Reader - Completed.
2021-01-12 09:38:02,405 [Timer-0] INFO  PartMove - start copy znode :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas
2021-01-12 09:38:02,407 [Timer-0] INFO  PartMove - target of shard path ip-.6:port/clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas
2021-01-12 09:38:02,408 [Timer-0] INFO  zkwriter.Writer - Writing data...
2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Writing data completed.
2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Wrote 27 nodes
2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Created 0 nodes; Updated 27 nodes
2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Ignored 2 ephemeral nodes
2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Skipped 0 nodes older than -1
2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Max mtime of copied nodes: 1610367341877
2021-01-12 09:38:02,463 [Timer-0] INFO  PartMove - hot parts size 0
2021-01-12 09:38:02,463 [Timer-0] INFO  PartMove - source of shard path  : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas
2021-01-12 09:38:02,463 [Timer-0] INFO  zkreader.Reader - Reading /clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas from ip-.58:port
2021-01-12 09:38:03,464 [Timer-0] INFO  zkreader.Reader - Processing, total=29, processed=29
2021-01-12 09:38:03,464 [Timer-0] INFO  zkreader.Reader - Completed.
2021-01-12 09:38:03,572 [Timer-0] INFO  PartMove - start copy znode :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas
2021-01-12 09:38:03,573 [Timer-0] INFO  PartMove - target of shard path ip-.6:port/clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas
2021-01-12 09:38:03,573 [Timer-0] INFO  zkwriter.Writer - Writing data...
2021-01-12 09:38:03,624 [Timer-0] INFO  zkwriter.Writer - Writing data completed.
2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Wrote 27 nodes
2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Created 0 nodes; Updated 27 nodes
2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Ignored 2 ephemeral nodes
2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Skipped 0 nodes older than -1
2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Max mtime of copied nodes: 1610366881035
2021-01-12 09:38:03,625 [Timer-0] INFO  PartMove - hot parts size 0
2021-01-12 09:38:03,625 [Timer-0] INFO  PartMove - source of shard path  : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas
2021-01-12 09:38:03,625 [Timer-0] INFO  zkreader.Reader - Reading /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas from ip-.58:port
2021-01-12 09:38:04,625 [Timer-0] INFO  zkreader.Reader - Processing, total=52, processed=52
2021-01-12 09:38:04,626 [Timer-0] INFO  zkreader.Reader - Completed.
2021-01-12 09:38:04,705 [Timer-0] INFO  PartMove - start copy znode :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas
2021-01-12 09:38:04,706 [Timer-0] INFO  PartMove - target of shard path ip-.6:port/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas
2021-01-12 09:38:04,706 [Timer-0] INFO  zkwriter.Writer - Writing data...
2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Writing data completed.
2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Wrote 49 nodes
2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Created 0 nodes; Updated 49 nodes
2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Ignored 3 ephemeral nodes
2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Skipped 0 nodes older than -1
2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Max mtime of copied nodes: 1610367548873
2021-01-12 09:38:04,794 [Timer-0] INFO  PartMove - hot parts size 3
2021-01-12 09:38:04,794 [Timer-0] INFO  PartMove - drop hot part from targe path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191213_0_0_0
2021-01-12 09:38:04,798 [Timer-0] INFO  PartMove - drop hot part from targe path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191213_0_0_0
2021-01-12 09:38:04,802 [Timer-0] INFO  PartMove - drop hot part from targe path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191213_0_0_0
2021-01-12 09:38:04,806 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191214_0_0_0
2021-01-12 09:38:04,812 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191215_0_0_0
2021-01-12 09:38:04,821 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191214_0_0_0
2021-01-12 09:38:04,829 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191215_0_0_0
2021-01-12 09:38:04,837 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191215_0_0_0
2021-01-12 09:38:04,846 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191214_0_0_0
```

2. 主 zookeeper 状态
```
20191213 HOT
20191214 COLD
20191215 COLD
![image](/uploads/bee71b4d3774fc09700444cd3655393d/image.png)
```

3. 备用 zookeeper
```
COLD par 存储备用zookeeper 集群,并删除源集群 part
HOT  par 不变更
![image](/uploads/742d0014bd934a2fb9eb26c98fab9847/image.png)
```

4. clickhouse 配置
- config.xml
```xml
    <zookeeper incl="zookeeper-servers" optional="true" />
    <cold_zookeeper incl="cold-zookeeper-servers" optional="true" />
```
- metrika.xml
```xml
<zookeeper-servers>
  <node index="1">
    <host>ip-.58</host>
    <port>port</port>
  </node>
  <node index="2">
    <host>ip-.91</host>
    <port>port</port>
  </node>
  <node index="3">
    <host>ip-.69</host>
    <port>port</port>
  </node>
</zookeeper-servers>

<cold-zookeeper-servers>
  <node index="1">
    <host>ip-.6</host>
    <port>port</port>
  </node>
  <node index="2">
    <host>ip-.7</host>
    <port>port</port>
  </node>
  <node index="3">
    <host>ip-.8</host>
    <port>port</port>
  </node>
</cold-zookeeper-servers>
```

5. 重启验证成功
6. drop parition 验证
- clickhouse drop parition sql
```sql
ip :) alter table  jason.table_test_local drop partition 20191213;

ALTER TABLE jason.table_test_local
    DROP PARTITION 20191213


[ip] 2021.01.12 10:18:58.930225 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> executeQuery: (from [::ffff:172.18.160.19]:10942) alter table jason.table_test_local drop partition 20191213;
[ip] 2021.01.12 10:18:58.930338 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Trace> ContextAccess (default): Access granted: ALTER DELETE ON jason.table_test_local
[ip] 2021.01.12 10:18:58.963670 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Trace> jason.table_test_local: Deleted 0 deduplication block IDs in partition ID 20191213
[ip] 2021.01.12 10:18:58.963691 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: Disabled merges covered by range 20191213_0_2_999999999
[ip] 2021.01.12 10:18:58.971998 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: Waiting for 00 to pull log-0000000005 to queue
[ip] 2021.01.12 10:18:59.024518 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: Looking for node corresponding to log-0000000005 in 00 queue
[ip] 2021.01.12 10:18:59.039725 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: No corresponding node found. Assuming it has been already processed. Found 0 nodes
[ip] 2021.01.12 10:18:59.046882 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
Ok.

0 rows in set. Elapsed: 0.121 sec.

ip :) alter table  jason.table_test_local drop partition 20191215;

ALTER TABLE jason.table_test_local
    DROP PARTITION 20191215


[ip] 2021.01.12 10:19:02.208074 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> executeQuery: (from [::ffff:172.18.160.19]:10942) alter table jason.table_test_local drop partition 20191215;
[ip] 2021.01.12 10:19:02.208189 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Trace> ContextAccess (default): Access granted: ALTER DELETE ON jason.table_test_local
[ip] 2021.01.12 10:19:02.238566 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Trace> jason.table_test_local: Deleted 0 deduplication block IDs in partition ID 20191215
[ip] 2021.01.12 10:19:02.238589 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: Disabled merges covered by range 20191215_0_2_999999999
[ip] 2021.01.12 10:19:02.246703 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: Waiting for 00 to pull log-0000000006 to queue
[ip] 2021.01.12 10:19:02.263364 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: Looking for node corresponding to log-0000000006 in 00 queue
[ip] 2021.01.12 10:19:02.271617 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: No corresponding node found. Assuming it has been already processed. Found 0 nodes
[ip] 2021.01.12 10:19:02.271952 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
Ok.

0 rows in set. Elapsed: 0.068 sec.

```

- clickhouse log
```
2021.01.12 10:09:15.358487 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> executeQuery: (from [::ffff:172.18.160.19]:52644) alter table jason.table_test_local drop partition 20191215;
2021.01.12 10:09:15.358682 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Trace> ContextAccess (default): Access granted: ALTER DELETE ON jason.table_test_local
2021.01.12 10:09:15.430511 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Trace> jason.table_test_local: Deleted 1 deduplication block IDs in partition ID 20191215
2021.01.12 10:09:15.430577 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Disabled merges covered by range 20191215_0_1_999999999
2021.01.12 10:09:15.439021 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Waiting for 01 to pull log-0000000003 to queue
2021.01.12 10:09:15.440626 [ 24036 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000003 - log-0000000003
2021.01.12 10:09:15.463915 [ 24036 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.
2021.01.12 10:09:15.464253 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Looking for node corresponding to log-0000000003 in 01 queue
2021.01.12 10:09:15.464510 [ 24079 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Removed 0 entries from queue. Waiting for 0 entries that are currently executing.
2021.01.12 10:09:15.464545 [ 24079 ] {} <Debug> jason.table_test_local: Removing parts.
2021.01.12 10:09:15.464668 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Waiting for queue-0000000003 to disappear from 01 queue
2021.01.12 10:09:15.465803 [ 24079 ] {} <Debug> jason.table_test_local: Removed 1 parts inside 20191215_0_1_999999999.
2021.01.12 10:09:15.465907 [ 24044 ] {} <Trace> jason.table_test_local: Found 1 old parts to remove.
2021.01.12 10:09:15.465927 [ 24044 ] {} <Debug> jason.table_test_local: Removing 1 old parts from ZooKeeper
2021.01.12 10:09:15.472331 [ 24044 ] {} <Debug> jason.table_test_local: There is no part 20191215_0_0_0 in ZooKeeper, it was only in filesystem
2021.01.12 10:09:15.472368 [ 24044 ] {} <Debug> jason.table_test_local: Removed 1 old parts from ZooKeeper. Removing them from filesystem.
2021.01.12 10:09:15.472787 [ 24044 ] {} <Debug> jason.table_test_local: Removed 1 old parts
2021.01.12 10:09:15.472793 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
2021.01.12 10:09:15.473007 [ 24059 ] {} <Debug> TCPHandler: Processed in 0.114860664 sec.
```

7. 单个shard 内其他副本同步日志
```
2021.01.12 10:22:30.890412 [ 24036 ] {} <Debug> DNSResolver: Updating DNS cache
2021.01.12 10:22:30.890447 [ 24036 ] {} <Debug> DNSResolver: Updated DNS cache
2021.01.12 10:22:42.832496 [ 24041 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000008 - log-0000000008
2021.01.12 10:22:42.857994 [ 24041 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.
2021.01.12 10:22:42.858786 [ 24078 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Removed 0 entries from queue. Waiting for 0 entries that are currently executing.
2021.01.12 10:22:42.858819 [ 24078 ] {} <Debug> jason.table_test_local: Removing parts.
2021.01.12 10:22:42.860059 [ 24078 ] {} <Debug> jason.table_test_local: Removed 1 parts inside 20191214_0_1_999999999.
2021.01.12 10:22:42.860147 [ 24038 ] {} <Trace> jason.table_test_local: Found 1 old parts to remove.
2021.01.12 10:22:42.860181 [ 24038 ] {} <Debug> jason.table_test_local: Removing 1 old parts from ZooKeeper
2021.01.12 10:22:42.866228 [ 24038 ] {} <Debug> jason.table_test_local: There is no part 20191214_0_0_0 in ZooKeeper, it was only in filesystem
2021.01.12 10:22:42.866258 [ 24038 ] {} <Debug> jason.table_test_local: Removed 1 old parts from ZooKeeper. Removing them from filesystem.
2021.01.12 10:22:42.866563 [ 24038 ] {} <Debug> jason.table_test_local: Removed 1 old parts
2021.01.12 10:22:45.714737 [ 24042 ] {} <Trace> SystemLog (system.part_log): Flushing system log, 1 entries to flush
2021.01.12 10:22:45.715050 [ 24042 ] {} <Debug> DiskLocal: Reserving 1.00 MiB on disk `default`, having unreserved 1.68 TiB.
2021.01.12 10:22:45.715713 [ 24042 ] {} <Trace> system.part_log: Renaming temporary part tmp_insert_20210111_3_3_0 to 20210111_6_6_0.
2021.01.12 10:22:45.715812 [ 24042 ] {} <Trace> SystemLog (system.part_log): Flushed system log
2021.01.12 10:22:45.890611 [ 24046 ] {} <Debug> DNSResolver: Updating DNS cache
2021.01.12 10:22:45.890666 [ 24046 ] {} <Debug> DNSResolver: Updated DNS cache
2021.01.12 10:23:00.890834 [ 24031 ] {} <Debug> DNSResolver: Updating DNS cache
2021.01.12 10:23:00.890905 [ 24031 ] {} <Debug> DNSResolver: Updated DNS cache
2021.01.12 10:23:15.891062 [ 24040 ] {} <Debug> DNSResolver: Updating DNS cache
2021.01.12 10:23:15.891103 [ 24040 ] {} <Debug> DNSResolver: Updated DNS cache
2021.01.12 10:23:17.114863 [ 24035 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000009 - log-0000000009
2021.01.12 10:23:17.130722 [ 24035 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.
2021.01.12 10:23:17.131568 [ 24079 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Removed 0 entries from queue. Waiting for 0 entries that are currently executing.
2021.01.12 10:23:17.131602 [ 24079 ] {} <Debug> jason.table_test_local: Removing parts.
2021.01.12 10:23:17.131610 [ 24079 ] {} <Debug> jason.table_test_local: Removed 0 parts inside 20191214_0_2_999999999.
2021.01.12 10:23:30.000143 [ 24026 ] {} <Debug> AsynchronousMetrics: MemoryTracking: was 118.81 MiB, peak 177.50 MiB, will set to 118.92 MiB (RSS), difference: -58.58 MiB
2021.01.12 10:23:30.891280 [ 24055 ] {} <Debug> DNSResolver: Updating DNS cache
2021.01.12 10:23:30.891358 [ 24055 ] {} <Debug> DNSResolver: Updated DNS cache
2021.01.12 10:23:45.891516 [ 24040 ] {} <Debug> DNSResolver: Updating DNS cache
2021.01.12 10:23:45.891576 [ 24040 ] {} <Debug> DNSResolver: Updated DNS cache
```

## 5 是否有其他问题
1. drop part 功能需要过滤

2. 需单个shard 所有实例 统一上线

3. 配置更新4 测试

   1 java part move 程序
   ```
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Replica - start init /clickhouse/***/jdob_ha/jason/table_test_local/02/replicas/02 part done
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - start init /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02  replicas done
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191214_0_0_0 date time is 2021-01-11 20:11:00
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - update parition time to 2021-01-11 20:11:00
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191215_0_0_0 date time is 2021-01-11 20:11:05
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - update parition time to 2021-01-11 20:11:05
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191213_0_0_0 date time is 2021-01-11 20:10:56
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - update parition time to 2021-01-11 20:10:56
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191213_0_0_0 date time is 2021-01-11 20:10:55
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191214_0_0_0 date time is 2021-01-11 20:11:00
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191215_0_0_0 date time is 2021-01-11 20:11:05
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191215_0_0_0 date time is 2021-01-11 20:11:05
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191213_0_0_0 date time is 2021-01-11 20:10:56
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - part /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191214_0_0_0 date time is 2021-01-11 20:11:00
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - partition : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191213 time: + 2021-01-11 20:10:56 state: HOT
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - partition : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215 time: + 2021-01-11 20:11:05 state: COLD
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - partition : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214 time: + 2021-01-11 20:11:00 state: COLD
   2021-01-12 09:38:01,278 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191213/State to HOT
   2021-01-12 09:38:01,288 [Timer-0] INFO  metadata.Shard - set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191213/State to HOT done
   2021-01-12 09:38:01,288 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to HOT
   2021-01-12 09:38:01,296 [Timer-0] INFO  metadata.Shard - set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to HOT done
   2021-01-12 09:38:01,296 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to HOT
   2021-01-12 09:38:01,304 [Timer-0] INFO  metadata.Shard - set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to HOT done
   2021-01-12 09:38:01,304 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to COLD
   2021-01-12 09:38:01,313 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215/State to COLD done
   2021-01-12 09:38:01,313 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to COLD
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - start set /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214/State to COLD done
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - cold partition :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191215
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - cold partition :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/block_numbers/20191214
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191214
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191214_0_0_0 need move
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191215
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191215_0_0_0 need move
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191213
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191213_0_0_0 need drop
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191213
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191213_0_0_0 need drop
   2021-01-12 09:38:01,321 [Timer-0] INFO  metadata.Shard - partnumber : 20191214
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191214_0_0_0 need move
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191215
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191215_0_0_0 need move
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191215
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191215_0_0_0 need move
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191213
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191213_0_0_0 need drop
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - partnumber : 20191214
   2021-01-12 09:38:01,322 [Timer-0] INFO  metadata.Shard - parts : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191214_0_0_0 need move
   2021-01-12 09:38:01,322 [Timer-0] INFO  jdbc.ClickHouse - Init Shards done ..
   2021-01-12 09:38:01,322 [Timer-0] INFO  PartMove - source of shard path  : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas
   2021-01-12 09:38:01,323 [Timer-0] INFO  zkreader.Reader - Reading /clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas from ip-.58:port
   2021-01-12 09:38:02,324 [Timer-0] INFO  zkreader.Reader - Processing, total=29, processed=29
   2021-01-12 09:38:02,324 [Timer-0] INFO  zkreader.Reader - Completed.
   2021-01-12 09:38:02,405 [Timer-0] INFO  PartMove - start copy znode :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas
   2021-01-12 09:38:02,407 [Timer-0] INFO  PartMove - target of shard path ip-.6:port/clickhouse/ClusterName/jdob_ha/jason/table_test_local/00/replicas
   2021-01-12 09:38:02,408 [Timer-0] INFO  zkwriter.Writer - Writing data...
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Writing data completed.
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Wrote 27 nodes
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Created 0 nodes; Updated 27 nodes
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Ignored 2 ephemeral nodes
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Skipped 0 nodes older than -1
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkwriter.Writer - Max mtime of copied nodes: 1610367341877
   2021-01-12 09:38:02,463 [Timer-0] INFO  PartMove - hot parts size 0
   2021-01-12 09:38:02,463 [Timer-0] INFO  PartMove - source of shard path  : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas
   2021-01-12 09:38:02,463 [Timer-0] INFO  zkreader.Reader - Reading /clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas from ip-.58:port
   2021-01-12 09:38:03,464 [Timer-0] INFO  zkreader.Reader - Processing, total=29, processed=29
   2021-01-12 09:38:03,464 [Timer-0] INFO  zkreader.Reader - Completed.
   2021-01-12 09:38:03,572 [Timer-0] INFO  PartMove - start copy znode :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas
   2021-01-12 09:38:03,573 [Timer-0] INFO  PartMove - target of shard path ip-.6:port/clickhouse/ClusterName/jdob_ha/jason/table_test_local/01/replicas
   2021-01-12 09:38:03,573 [Timer-0] INFO  zkwriter.Writer - Writing data...
   2021-01-12 09:38:03,624 [Timer-0] INFO  zkwriter.Writer - Writing data completed.
   2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Wrote 27 nodes
   2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Created 0 nodes; Updated 27 nodes
   2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Ignored 2 ephemeral nodes
   2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Skipped 0 nodes older than -1
   2021-01-12 09:38:03,625 [Timer-0] INFO  zkwriter.Writer - Max mtime of copied nodes: 1610366881035
   2021-01-12 09:38:03,625 [Timer-0] INFO  PartMove - hot parts size 0
   2021-01-12 09:38:03,625 [Timer-0] INFO  PartMove - source of shard path  : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas
   2021-01-12 09:38:03,625 [Timer-0] INFO  zkreader.Reader - Reading /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas from ip-.58:port
   2021-01-12 09:38:04,625 [Timer-0] INFO  zkreader.Reader - Processing, total=52, processed=52
   2021-01-12 09:38:04,626 [Timer-0] INFO  zkreader.Reader - Completed.
   2021-01-12 09:38:04,705 [Timer-0] INFO  PartMove - start copy znode :/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas
   2021-01-12 09:38:04,706 [Timer-0] INFO  PartMove - target of shard path ip-.6:port/clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas
   2021-01-12 09:38:04,706 [Timer-0] INFO  zkwriter.Writer - Writing data...
   2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Writing data completed.
   2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Wrote 49 nodes
   2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Created 0 nodes; Updated 49 nodes
   2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Ignored 3 ephemeral nodes
   2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Skipped 0 nodes older than -1
   2021-01-12 09:38:04,794 [Timer-0] INFO  zkwriter.Writer - Max mtime of copied nodes: 1610367548873
   2021-01-12 09:38:04,794 [Timer-0] INFO  PartMove - hot parts size 3
   2021-01-12 09:38:04,794 [Timer-0] INFO  PartMove - drop hot part from targe path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191213_0_0_0
   2021-01-12 09:38:04,798 [Timer-0] INFO  PartMove - drop hot part from targe path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191213_0_0_0
   2021-01-12 09:38:04,802 [Timer-0] INFO  PartMove - drop hot part from targe path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191213_0_0_0
   2021-01-12 09:38:04,806 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191214_0_0_0
   2021-01-12 09:38:04,812 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/00/parts/20191215_0_0_0
   2021-01-12 09:38:04,821 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191214_0_0_0
   2021-01-12 09:38:04,829 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/01/parts/20191215_0_0_0
   2021-01-12 09:38:04,837 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191215_0_0_0
   2021-01-12 09:38:04,846 [Timer-0] INFO  PartMove - drop cold  part from source path : /clickhouse/ClusterName/jdob_ha/jason/table_test_local/02/replicas/02/parts/20191214_0_0_0
   ```

   2. 主 zookeeper 状态
   ```
   20191213 HOT
   20191214 COLD
   20191215 COLD
   ![image](/uploads/bee71b4d3774fc09700444cd3655393d/image.png)
   ```

   3. 备用 zookeeper
   ```
   COLD par 存储备用zookeeper 集群,并删除源集群 part
   HOT  par 不变更
   ![image](/uploads/742d0014bd934a2fb9eb26c98fab9847/image.png)
   ```

   4. clickhouse 配置
   - config.xml
   ```xml
       <zookeeper incl="zookeeper-servers" optional="true" />
       <cold_zookeeper incl="cold-zookeeper-servers" optional="true" />
   ```
   - metrika.xml
   ```xml
   <zookeeper-servers>
     <node index="1">
       <host>ip-.58</host>
       <port>port</port>
     </node>
     <node index="2">
       <host>ip-.91</host>
       <port>port</port>
     </node>
     <node index="3">
       <host>ip-.69</host>
       <port>port</port>
     </node>
   </zookeeper-servers>
   
   <cold-zookeeper-servers>
     <node index="1">
       <host>ip-.6</host>
       <port>port</port>
     </node>
     <node index="2">
       <host>ip-.7</host>
       <port>port</port>
     </node>
     <node index="3">
       <host>ip-.8</host>
       <port>port</port>
     </node>
   </cold-zookeeper-servers>
   ```

   5. 重启验证成功
   6. drop parition 验证
   - clickhouse drop parition sql
   ```sql
   ip :) alter table  jason.table_test_local drop partition 20191213;
   
   ALTER TABLE jason.table_test_local
       DROP PARTITION 20191213
   
   
   [ip] 2021.01.12 10:18:58.930225 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> executeQuery: (from [::ffff:172.18.160.19]:10942) alter table jason.table_test_local drop partition 20191213;
   [ip] 2021.01.12 10:18:58.930338 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Trace> ContextAccess (default): Access granted: ALTER DELETE ON jason.table_test_local
   [ip] 2021.01.12 10:18:58.963670 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Trace> jason.table_test_local: Deleted 0 deduplication block IDs in partition ID 20191213
   [ip] 2021.01.12 10:18:58.963691 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: Disabled merges covered by range 20191213_0_2_999999999
   [ip] 2021.01.12 10:18:58.971998 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: Waiting for 00 to pull log-0000000005 to queue
   [ip] 2021.01.12 10:18:59.024518 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: Looking for node corresponding to log-0000000005 in 00 queue
   [ip] 2021.01.12 10:18:59.039725 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> jason.table_test_local: No corresponding node found. Assuming it has been already processed. Found 0 nodes
   [ip] 2021.01.12 10:18:59.046882 [ 147090 ] {9552c576-5ef4-4181-901f-acfc15de094b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
   Ok.
   
   0 rows in set. Elapsed: 0.121 sec.
   
   ip :) alter table  jason.table_test_local drop partition 20191215;
   
   ALTER TABLE jason.table_test_local
       DROP PARTITION 20191215
   
   
   [ip] 2021.01.12 10:19:02.208074 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> executeQuery: (from [::ffff:172.18.160.19]:10942) alter table jason.table_test_local drop partition 20191215;
   [ip] 2021.01.12 10:19:02.208189 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Trace> ContextAccess (default): Access granted: ALTER DELETE ON jason.table_test_local
   [ip] 2021.01.12 10:19:02.238566 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Trace> jason.table_test_local: Deleted 0 deduplication block IDs in partition ID 20191215
   [ip] 2021.01.12 10:19:02.238589 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: Disabled merges covered by range 20191215_0_2_999999999
   [ip] 2021.01.12 10:19:02.246703 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: Waiting for 00 to pull log-0000000006 to queue
   [ip] 2021.01.12 10:19:02.263364 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: Looking for node corresponding to log-0000000006 in 00 queue
   [ip] 2021.01.12 10:19:02.271617 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> jason.table_test_local: No corresponding node found. Assuming it has been already processed. Found 0 nodes
   [ip] 2021.01.12 10:19:02.271952 [ 147090 ] {463ea1cf-5b03-4451-926c-998507eff901} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
   Ok.
   
   0 rows in set. Elapsed: 0.068 sec.
   
   ```

   - clickhouse log
   ```
   2021.01.12 10:09:15.358487 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> executeQuery: (from [::ffff:172.18.160.19]:52644) alter table jason.table_test_local drop partition 20191215;
   2021.01.12 10:09:15.358682 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Trace> ContextAccess (default): Access granted: ALTER DELETE ON jason.table_test_local
   2021.01.12 10:09:15.430511 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Trace> jason.table_test_local: Deleted 1 deduplication block IDs in partition ID 20191215
   2021.01.12 10:09:15.430577 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Disabled merges covered by range 20191215_0_1_999999999
   2021.01.12 10:09:15.439021 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Waiting for 01 to pull log-0000000003 to queue
   2021.01.12 10:09:15.440626 [ 24036 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000003 - log-0000000003
   2021.01.12 10:09:15.463915 [ 24036 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.
   2021.01.12 10:09:15.464253 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Looking for node corresponding to log-0000000003 in 01 queue
   2021.01.12 10:09:15.464510 [ 24079 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Removed 0 entries from queue. Waiting for 0 entries that are currently executing.
   2021.01.12 10:09:15.464545 [ 24079 ] {} <Debug> jason.table_test_local: Removing parts.
   2021.01.12 10:09:15.464668 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> jason.table_test_local: Waiting for queue-0000000003 to disappear from 01 queue
   2021.01.12 10:09:15.465803 [ 24079 ] {} <Debug> jason.table_test_local: Removed 1 parts inside 20191215_0_1_999999999.
   2021.01.12 10:09:15.465907 [ 24044 ] {} <Trace> jason.table_test_local: Found 1 old parts to remove.
   2021.01.12 10:09:15.465927 [ 24044 ] {} <Debug> jason.table_test_local: Removing 1 old parts from ZooKeeper
   2021.01.12 10:09:15.472331 [ 24044 ] {} <Debug> jason.table_test_local: There is no part 20191215_0_0_0 in ZooKeeper, it was only in filesystem
   2021.01.12 10:09:15.472368 [ 24044 ] {} <Debug> jason.table_test_local: Removed 1 old parts from ZooKeeper. Removing them from filesystem.
   2021.01.12 10:09:15.472787 [ 24044 ] {} <Debug> jason.table_test_local: Removed 1 old parts
   2021.01.12 10:09:15.472793 [ 24059 ] {fa31ebd4-0b25-4d92-9b78-099a357dc363} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
   2021.01.12 10:09:15.473007 [ 24059 ] {} <Debug> TCPHandler: Processed in 0.114860664 sec.
   ```

   7. 单个shard 内其他副本同步日志
   ```
   2021.01.12 10:22:30.890412 [ 24036 ] {} <Debug> DNSResolver: Updating DNS cache
   2021.01.12 10:22:30.890447 [ 24036 ] {} <Debug> DNSResolver: Updated DNS cache
   2021.01.12 10:22:42.832496 [ 24041 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000008 - log-0000000008
   2021.01.12 10:22:42.857994 [ 24041 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.
   2021.01.12 10:22:42.858786 [ 24078 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Removed 0 entries from queue. Waiting for 0 entries that are currently executing.
   2021.01.12 10:22:42.858819 [ 24078 ] {} <Debug> jason.table_test_local: Removing parts.
   2021.01.12 10:22:42.860059 [ 24078 ] {} <Debug> jason.table_test_local: Removed 1 parts inside 20191214_0_1_999999999.
   2021.01.12 10:22:42.860147 [ 24038 ] {} <Trace> jason.table_test_local: Found 1 old parts to remove.
   2021.01.12 10:22:42.860181 [ 24038 ] {} <Debug> jason.table_test_local: Removing 1 old parts from ZooKeeper
   2021.01.12 10:22:42.866228 [ 24038 ] {} <Debug> jason.table_test_local: There is no part 20191214_0_0_0 in ZooKeeper, it was only in filesystem
   2021.01.12 10:22:42.866258 [ 24038 ] {} <Debug> jason.table_test_local: Removed 1 old parts from ZooKeeper. Removing them from filesystem.
   2021.01.12 10:22:42.866563 [ 24038 ] {} <Debug> jason.table_test_local: Removed 1 old parts
   2021.01.12 10:22:45.714737 [ 24042 ] {} <Trace> SystemLog (system.part_log): Flushing system log, 1 entries to flush
   2021.01.12 10:22:45.715050 [ 24042 ] {} <Debug> DiskLocal: Reserving 1.00 MiB on disk `default`, having unreserved 1.68 TiB.
   2021.01.12 10:22:45.715713 [ 24042 ] {} <Trace> system.part_log: Renaming temporary part tmp_insert_20210111_3_3_0 to 20210111_6_6_0.
   2021.01.12 10:22:45.715812 [ 24042 ] {} <Trace> SystemLog (system.part_log): Flushed system log
   2021.01.12 10:22:45.890611 [ 24046 ] {} <Debug> DNSResolver: Updating DNS cache
   2021.01.12 10:22:45.890666 [ 24046 ] {} <Debug> DNSResolver: Updated DNS cache
   2021.01.12 10:23:00.890834 [ 24031 ] {} <Debug> DNSResolver: Updating DNS cache
   2021.01.12 10:23:00.890905 [ 24031 ] {} <Debug> DNSResolver: Updated DNS cache
   2021.01.12 10:23:15.891062 [ 24040 ] {} <Debug> DNSResolver: Updating DNS cache
   2021.01.12 10:23:15.891103 [ 24040 ] {} <Debug> DNSResolver: Updated DNS cache
   2021.01.12 10:23:17.114863 [ 24035 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000009 - log-0000000009
   2021.01.12 10:23:17.130722 [ 24035 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.
   2021.01.12 10:23:17.131568 [ 24079 ] {} <Debug> jason.table_test_local (ReplicatedMergeTreeQueue): Removed 0 entries from queue. Waiting for 0 entries that are currently executing.
   2021.01.12 10:23:17.131602 [ 24079 ] {} <Debug> jason.table_test_local: Removing parts.
   2021.01.12 10:23:17.131610 [ 24079 ] {} <Debug> jason.table_test_local: Removed 0 parts inside 20191214_0_2_999999999.
   2021.01.12 10:23:30.000143 [ 24026 ] {} <Debug> AsynchronousMetrics: MemoryTracking: was 118.81 MiB, peak 177.50 MiB, will set to 118.92 MiB (RSS), difference: -58.58 MiB
   2021.01.12 10:23:30.891280 [ 24055 ] {} <Debug> DNSResolver: Updating DNS cache
   2021.01.12 10:23:30.891358 [ 24055 ] {} <Debug> DNSResolver: Updated DNS cache
   2021.01.12 10:23:45.891516 [ 24040 ] {} <Debug> DNSResolver: Updating DNS cache
   2021.01.12 10:23:45.891576 [ 24040 ] {} <Debug> DNSResolver: Updated DNS cache
   ```

   

   

   ### 7 其他问题

   1. drop part 功能需要过滤
   2. 需单个shard 所有实例 统一上线
   3. 配置更新









