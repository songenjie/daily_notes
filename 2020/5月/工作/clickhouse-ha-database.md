### clickhouse ha

. 将分布式表 map 到 多一个datatbaes 下的相同表  支持论点：

- ClickHouse allows to define ‘default_database’ for each shard and then use it in query time in order to route the query for a particular table to the right database.（https://www.altinity.com/blog/2018/5/10/circular-replication-cluster-topology-in-clickhouse）



## 配置

### 1 config.xml
```
<remote_servers incl="clickhouse_remote_servers" >
   </remote_servers>
   <include_from>/data0/jdolap/clickhouse/conf/metrika.xml</include_from>
```

### 2 metrika.xml

```
<yandex>
<clickhouse_remote_servers>
    <cluster-001>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <default_database>shard_01</default_database>
                <host>node1</host>
                <port>9200</port>
            </replica>
            <replica>
                <default_database>shard_01</default_database>
                <host>node1</host>
                <port>9200</port>
            </replica>
            <replica>
                <default_database>shard_01</default_database>
                <host>node3</host>
                <port>9200</port>

            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <default_database>shard_02</default_database>
                <host>node1</host>
                <port>9200</port>
            </replica>
            <replica>
                <default_database>shard_02</default_database>
                <host>node3</host>
                <port>9200</port>
            </replica>
            <replica>
                <default_database>shard_02</default_database>
                <host>node1</host>
                <port>9200</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <default_database>shard_03</default_database>
                <host>node3</host>
                <port>9200</port>
            </replica>
            <replica>
                <default_database>shard_03</default_database>
                <host>node1</host>
                <port>9200</port>
            </replica>
            <replica>
                <default_database>shard_03</default_database>
                <host>node1</host>
                <port>9200</port>
            </replica>
        </shard>
    </cluster-001>
</clickhouse_remote_servers>
```


### 3 users.xml

```
<load_balancing>in_order</load_balancing>

```

## 模型

### 1 create database
- create shard_01,shard_2,shard_03 database int every node 

### 2 local table

- node1
```
CREATE TABLE shard_01.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_01/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);


CREATE TABLE shard_02.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_02/localtable', 'replica_03')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);



CREATE TABLE shard_03.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32

) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_03/localtable', 'replica_02')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);
```


- node2
```
CREATE TABLE shard_01.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_01/localtable', 'replica_02')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_02.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_02/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_03.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_03/localtable', 'replica_03')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);
```

- node 3
```
CREATE TABLE shard_01.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_01/localtable', 'replica_03')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_02.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_02/localtable', 'replica_02')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

CREATE TABLE shard_03.localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/cluster-001/shard_03/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);
```

### 3 分布式表
```
CREATE TABLE IF NOT EXISTS localtable_dis(
   CounterID UInt32,
   UserID UInt32)
ENGINE = Distributed(cluster-001, '', localtable, rand());
```

### 4 test
- insert
```
insert into localtable_dis  values  (1,2);
insert into localtable_dis  values  (2,3);
insert into localtable_dis  values  (3,4);
insert into localtable_dis  values  (4,5);
```
- select 
```
MySQL [(none)]> select * from localtable_dis;
+-----------+--------+
| CounterID | UserID |
+-----------+--------+
|         3 |      4 |
|         2 |      3 |
|         4 |      5 |
|         1 |      2 |
+-----------+--------+
4 rows in set (0.01 sec)
```

### log 
```
020.05.27 19:54:14.561013 [ 61061 ] {} <Trace> MySQLHandlerFactory: MySQL connection. Id: 0. Address: [::ffff:172.18.160.19]:29232
2020.05.27 19:54:14.561233 [ 61061 ] {} <Trace> MySQLHandler: Sent handshake
2020.05.27 19:54:14.563607 [ 61061 ] {} <Trace> MySQLHandler: payload size: 63
2020.05.27 19:54:14.563651 [ 61061 ] {} <Trace> MySQLHandler: Capabilities: 537896581, max_packet_size: 16777216, character_set: 33, user: default, auth_response length: 0, database: , auth_plugin_name: mysql_native_password
2020.05.27 19:54:14.563891 [ 61061 ] {} <Information> MySQLHandler: Authentication for user default succeeded.
2020.05.27 19:54:14.566407 [ 61061 ] {} <Debug> MySQLHandler: Received command: 3. Connection id: 0.
2020.05.27 19:54:14.566713 [ 61061 ] {} <Debug> executeQuery: (from [::ffff:172.18.160.19]:29232) select * from localtable_dis
2020.05.27 19:54:14.567180 [ 61061 ] {} <Trace> ContextAccess (default): List of all grants: GRANT SHOW, SELECT, INSERT, ALTER, CREATE, DROP, TRUNCATE, OPTIMIZE, KILL QUERY, SYSTEM, dictGet, SOURCES ON *.*
2020.05.27 19:54:14.567198 [ 61061 ] {} <Trace> ContextAccess (default): Settings: readonly=0, allow_ddl=1, allow_introspection_functions=0
2020.05.27 19:54:14.567212 [ 61061 ] {} <Trace> ContextAccess (default): Access granted: SELECT(CounterID, UserID) ON default.localtable_dis
2020.05.27 19:54:14.567384 [ 61061 ] {} <Trace> ContextAccess (default): Access granted: SELECT(CounterID, UserID) ON default.localtable_dis
2020.05.27 19:54:14.567555 [ 61061 ] {} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete

2020.05.27 19:54:14.568446 [ 61356 ] {} <Trace> Connection (node1:9200): Connecting. Database: shard_01. User: default
2020.05.27 19:54:14.568487 [ 61357 ] {} <Trace> Connection (node1:9200): Connecting. Database: shard_02. User: default
2020.05.27 19:54:14.568552 [ 61358 ] {} <Trace> Connection (node3:9200): Connecting. Database: shard_03. User: default

2020.05.27 19:54:14.569088 [ 61062 ] {} <Trace> TCPHandlerFactory: TCP Request. Address: [::ffff:node3]:39588
2020.05.27 19:54:14.569231 [ 61357 ] {} <Trace> Connection (node1:9200): Connected to ClickHouse server version 20.4.3.
2020.05.27 19:54:14.569325 [ 61062 ] {} <Debug> TCPHandler: Connected ClickHouse server version 20.4.0, revision: 54434, database: shard_03, user: default.
2020.05.27 19:54:14.569336 [ 61356 ] {} <Trace> Connection (node1:9200): Connected to ClickHouse server version 20.4.3.
2020.05.27 19:54:14.569494 [ 61358 ] {} <Trace> Connection (node3:9200): Connected to ClickHouse server version 20.4.3.
2020.05.27 19:54:14.569633 [ 61358 ] {} <Trace> ConnectionPoolWithFailover: Server node3:9200 has unacceptable replica delay for table .localtable: 1590580454
2020.05.27 19:54:14.569654 [ 61358 ] {} <Trace> Connection (node1:9200): Connecting. Database: shard_03. User: default
2020.05.27 19:54:14.570321 [ 61358 ] {} <Trace> Connection (node1:9200): Connected to ClickHouse server version 20.4.3.
2020.05.27 19:54:14.572051 [ 61061 ] {} <Information> executeQuery: Read 4 rows, 32.00 B in 0.005 sec., 756 rows/sec., 5.91 KiB/sec.
```
