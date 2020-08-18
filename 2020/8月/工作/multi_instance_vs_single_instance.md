## 一 现状

在某些情况下，需要配置具有复制功能的分布式群集，但是`没有足够的服务器`才能将每个副本放置在单独的节点上。最好以特殊方式在`同一节点上配置多个副本`，这样即使在节点出现故障的情况下也可以继续执行查询。可以在不同的分布式系统中找到这种复制配置，通常将其称为“`循环”或“环形”`复制



## 二 目标

可以在ClickHouse中设置循环或环形复制拓扑，尽管这并不简单，但需要进行不明显的配置和其他数据库来分隔分片和副本。除了复杂的配置之外，由于`每个群集节点的INSERT负载都加倍`，因此与单独的副本节点相比，这种设置的`执行效果更差`。尽管将相同的节点重用于副本似乎很有吸引力，但是在考虑循环复制部署时，必须考虑`性能和配置`方面的问题。



## 三 概念



![img](https://altinity.com/wp-content/uploads/2018/05/07c9f-concept.png)



## 四 HA

![img](https://altinity.com/wp-content/uploads/2018/05/0e935-distrib.png)



如果节点之一关闭，则仍有足够的数据来运行查询：



![目标](https://altinity.com/wp-content/uploads/2018/05/2d176-failover.png)







## 五 方案



### 方案一  机器数量=instance



#### 1 设计目标 一个instance 可以代表多个replica

3shard  2replica

```xml
<clickhouse_remote_servers>
    <ZYX_CK_Pub_04>
        <shard>
            <replica>
                <host>cluster_node_1</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>cluster_node_2</host>
                <port>9600</port>
            </replica>
        </shard>
        <shard>
            <replica>
                <host>cluster_node_2</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>cluster_node_3</host>
                <port>9600</port>
            </replica>
        </shard>
        <shard>
            <replica>
                <host>cluster_node_3</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>cluster_node_1</host>
                <port>9600</port>
            </replica>
        </shard>
    </ZYX_CK_Pub_04>
</clickhouse_remote_servers>
```

`这是行不通的，因为分片具有相同的表名，并且当它们位于同一服务器上时，ClickHouse无法将一个分片/副本与另一个分开`





#### 2 解决方案

这里的技巧是将每个分片放入一个单独的数据库中！ ClickHouse允许为每个分片定义“ default_database”，然后在查询时使用它，以便将特定表的查询路由到正确的数据库。

```xml
<clickhouse_remote_servers>
    <ZYX_CK_Pub_04>
        <shard>
            <replica>
                <default_database>testcluster_shard_1</default_database>
                <host>cluster_node_1</host>
                <port>9600</port>
            </replica>
            <replica>
                <default_database>testcluster_shard_2</default_database>
                <host>cluster_node_2</host>
                <port>9600</port>
            </replica>
        </shard>
        <shard>
            <replica>
                <default_database>testcluster_shard_1</default_database>
                <host>cluster_node_2</host>
                <port>9600</port>
            </replica>
            <replica>
                <default_database>testcluster_shard_2</default_database>
                <host>cluster_node_3</host>
                <port>9600</port>
            </replica>
        </shard>
        <shard>
            <replica>
                <default_database>testcluster_shard_1</default_database>
                <host>cluster_node_3</host>
                <port>9600</port>
            </replica>
            <replica>
                <default_database>testcluster_shard_2</default_database>
                <host>cluster_node_1</host>
                <port>9600</port>
            </replica>
        </shard>
    </ZYX_CK_Pub_04>
</clickhouse_remote_servers>
```



#### 3 使用方法 

- Node1

```mysql
CREATE TABLE testcluster_shard_1.tc_shard 
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/tc_shard_1/events’, ‘replica_1’, …)

CREATE TABLE testcluster_shard_3.tc_shard 
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/tc_shard_3/events’, ‘replica_2’, …)
```



- Node2

```mysql
CREATE TABLE testcluster_shard_2.tc_shard 
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/tc_shard_2/events’, ‘replica_1’, …)

CREATE TABLE testcluster_shard_1.tc_shard 
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/tc_shard_1/events’, ‘replica_2’, …)
```



- Node3

```mysql
CREATE TABLE testcluster_shard_3.tc_shard 
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/tc_shard_3/events’, ‘replica_1’, …)

CREATE TABLE testcluster_shard_2.tc_shard 
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/tc_shard_2/events’, ‘replica_2’, …)
```





- Distributed Table Schema

唯一剩下的就是分布式表。为了使ClickHouse为本地分片表选择适当的默认数据库，需要使用空数据库创建分布式表。这触发了默认值的使用。

```mysql
CREATE TABLE tc_distributed
… 
ENGINE = Distributed( ‘testcluster’, ‘’, tc_shard, rand() )
```





### 方案二：instance count  in every node = replicated*shard/ipcount

#### 一个instance 就是一个replica

3shard  2replica

```xml
<clickhouse_remote_servers>
    <clustername>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node1</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node2</host>
                <port>9700</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node2</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node3</host>
                <port>9700</port>
            </replica>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node3</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>9700</port>
            </replica>
        </shard>
    </clustername>
</clickhouse_remote_servers>
```





2. macros

```xml
<macros>
	<shard>***<shard>
	<replica>***<replica>
</macros>
```





#### 3 使用方法

本地表

```mysql
CREATE TABLE if not existst db.tablename on cluster clustername
… 
Engine=ReplicatedMergeTree(‘/clickhouse/tables/{shard}’, ‘{replica}’, …)
```


分布式表

```mysql
CREATE TABLE if not existst db.tc_shard on cluster clustername
… 
ENGINE = Distributed( clustername, db, tablename, rand() )
```







## 优缺点

1. 部署
   - 方案一：部署instance少✅
   - 方案二：部署复杂较
2. 用户使用
   - 方案一： 需要用户多次创建本地表(单个节点不同的db)
   - 方案二：一键创建完成 ✅
3. 节点故障
   1. 实例故障
      - 方案一： node不可用，多个replica 故障
      - 方案二：只影响单个replica✅
   2. Node故障
      - node 不可用
4. 限制
   - 方案一：dbname需要配置到 clickhouse server中，db那么比较单一 本地表 ddl 
   - 方案二：基本都可以支持✅





https://github.com/ClickHouse/ClickHouse/issues/7611





















