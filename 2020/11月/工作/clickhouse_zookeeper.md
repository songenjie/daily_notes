clickhouse zookeeper 优化，官方建议这里不再赘述[连接](https://clickhouse.tech/docs/en/operations/tips/#zookeeper)



#### 1. zookeeper 配置问题

1. datalog 指定食物日志的存储目录，事务日志对zookeeper的影响非常大，强烈建议事务日志于数据目录分开
2. dataDIR  zookeeper 的数据目录，存储内存数据库序列话后的快照路径
3. minSessionTimeout maxSessionTimeout 回话窗口超时实践，client 与 server建立连接后，正常情况下，客户端会时不时向server发送心跳
4. Sync,warningthredsholdms 事务日志输入实践，超过时间会告警



#### 2  zookeeper 部署

1. 创建 zookeeper observer roles,较多的做到 读写分离
2. 多zookeeper 集群，federation [这里clickhouse优化时介绍]，也给予当前zookeeper 机器资源利用率较低的情况下



#### 3 clickhouse 配置

1. 降低 max_part_insert_per_block （单词一个instance ，一次导入最多生成的part数据量，这里和zookeeper znode是成正比的），也影响 多副本数据同步和小文件生成较多的问题
2. 调整 zookeeper session timeout 
3. use_minimalistic_part_header_in_zookeeper 1 将紧凑零件元数据存储在单个零件znode中。这可以大大减少ZooKeeper快照大小多列压缩为一列



#### 4 clickhouse 使用

1. replicated merge tree ,shard part too deep ,不建议用户使用深层目录，一个shard 两层即可  eg /cluster-db-table/shard/



#### 5 clickhouse-shard-map-zookeeper-cluster

只有clickhouse replicated mergre 家族对 zookeeper 存储,数据同步，数据merge,mutatition zookeeper 成为导入瓶颈,压力太大会成为只读，主要压力基本来源于 zookeeper master 

调查发现，数据间同步只有同一个shard会依赖zookeeper ,我们可以为负载较大的集群，每个shard创建一个zookeeper 集群，相当于一个clickhouse cluster 对应多个 zookeeper 集群（https://github.com/ClickHouse/ClickHouse/issues/4146#issuecomment-457559927）,



- zookeeper 实践

1. 创建超大规模的zookeeper federation 集群, 以及like paxos 样的虚拟映射机制,为所有clickhouse的集群的每个shard分派虚拟映射节点,冷热备份等等
2. 每个zookeeper instance 占用两块磁盘，当前节点 cpu,memory ,disk 占用率都很低，可以在单个节点，创建多zookeeper 实例





