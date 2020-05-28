### clickhouse ha

. 将分布式表 map 到 多一个datatbaes 下的相同表  支持论点：

- ClickHouse allows to define ‘default_database’ for each shard and then use it in query time in order to route the query for a particular table to the right database.（https://www.altinity.com/blog/2018/5/10/circular-replication-cluster-topology-in-clickhouse）



## 配置

### 1 config.xml
```
<remote_servers incl="clickhouse_remote_servers" >
   </remote_servers>
   <include_from>/data0/doris/clickhouse/conf/metrika.xml</include_from>
```

### 2 metrika.xml

```
2 <clickhouse_remote_servers>
  3     <doris_ck_02>
  4         <shard>
  5             <weight>1</weight>
  6             <internal_replication>true</internal_replication>
  7             <replica>
  8                 <host>node1</host>
  9                 <port>9300</port>
 10             </replica>
 11             <replica>
 12                 <host>node2</host>
 13                 <port>9400</port>
 14             </replica>
 15             <replica>
 16                 <host>node3</host>
 17                 <port>9500</port>
 18             </replica>
 19         </shard>
 20         <shard>
 21             <weight>1</weight>
 22             <internal_replication>true</internal_replication>
 23             <replica>
 24                 <host>node2</host>
 25                 <port>9300</port>
 26             </replica>
 27             <replica>
 28                 <host>node3</host>
 29                 <port>9400</port>
 30             </replica>
 31             <replica>
 32                 <host>node1</host>
 33                 <port>9500</port>
 34             </replica>
 35         </shard>
 36         <shard>
 37             <weight>1</weight>
 38             <internal_replication>true</internal_replication>
 39             <replica>
 40                 <host>node3</host>
 41                 <port>9300</port>
 42             </replica>
 43             <replica>
 44                 <host>node1</host>
 45                 <port>9400</port>
 46             </replica>
 47             <replica>
 48                 <host>node2</host>
 49                 <port>9500</port>
 50             </replica>
 51         </shard>
 52     </doris_ck_02>
 53 </clickhouse_remote_servers>
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
mysql --protocol=tcp -h node1 -P 9204 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_01/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);


mysql --protocol=tcp -h node1 -P 9304 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_02/localtable', 'replica_03')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);



mysql --protocol=tcp -h node1 -P 9404 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32

) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_3/localtable', 'replica_02')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);
```


- node2
```
mysql --protocol=tcp -h node2 -P 9204 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_02/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

mysql --protocol=tcp -h node2 -P 9304 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_01/localtable', 'replica_02')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

mysql --protocol=tcp -h node2 -P 9404 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_03/localtable', 'replica_03')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);
```

- node 3
```
mysql --protocol=tcp -h node3 -P 9204 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_03/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

mysql --protocol=tcp -h node3 -P 9304 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_01/localtable', 'replica_03')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);

mysql --protocol=tcp -h node3 -P 9404 -udefault
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_02/localtable', 'replica_02')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);
```

### 3 分布式表
```
CREATE TABLE IF NOT EXISTS localtable_dis(
   CounterID UInt32,
   UserID UInt32)
ENGINE = Distributed(doris_ck_02, '', localtable, rand());
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



MySQL [(none)]> select * from localtable_dis;
Query OK, 99 rows affected, 26144 warnings (0.01 sec)

MySQL [(none)]> select * from localtable_dis;
+-----------+--------+
| CounterID | UserID |
+-----------+--------+
|         1 |      2 |
+-----------+--------+
1 row in set (0.01 sec)


2020.05.28 20:52:33.536924 [ 25607 ] {} <Debug> default.localtable: Trying to finalize mutations
2020.05.28 20:52:35.188690 [ 25621 ] {} <Debug> MySQLHandler: Received command: 3. Connection id: 3.
2020.05.28 20:52:35.188990 [ 25621 ] {} <Debug> executeQuery: (from [::ffff:172.18.160.19]:7456) select * from localtable_dis
2020.05.28 20:52:35.189268 [ 25621 ] {} <Trace> ContextAccess (default): Access granted: SELECT(CounterID, UserID) ON default.localtable_dis
2020.05.28 20:52:35.189438 [ 25621 ] {} <Trace> ContextAccess (default): Access granted: SELECT(CounterID, UserID) ON default.localtable_dis
2020.05.28 20:52:35.189586 [ 25621 ] {} <Trace> ContextAccess (default): Access granted: SELECT(CounterID, UserID) ON default.localtable
2020.05.28 20:52:35.189645 [ 25621 ] {} <Debug> default.localtable (SelectExecutor): Key condition: unknown
2020.05.28 20:52:35.189659 [ 25621 ] {} <Debug> default.localtable (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
2020.05.28 20:52:35.189695 [ 25621 ] {} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
2020.05.28 20:52:35.189778 [ 25621 ] {} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
2020.05.28 20:52:35.192684 [ 25621 ] {} <Information> executeQuery: Read 1 rows, 8.00 B in 0.004 sec., 273 rows/sec., 2.14 KiB/sec.
2020.05.28 20:52:38.537109 [ 25601 ] {} <Debug> default.localtable: Trying to finalize mutations
2020.05.28 20:52:43.537296 [ 25604 ] {} <Debug> default.localtable: Trying to finalize mutations
2020.05.28 20:52:48.537536 [ 25615 ] {} <Debug> default.localtable: Trying to finalize mutations
2020.05.28 20:52:53.537742 [ 25602 ] {} <Debug> default.localtable: Trying to finalize mutations



MySQL [(none)]> select * from localtable_dis;
+-----------+--------+
| CounterID | UserID |
+-----------+--------+
|         3 |      4 |
|         2 |      3 |
|         4 |      5 |
|         1 |      2 |
+-----------+--------+
4 rows in set (0.00 sec)

MySQL [(none)]> select * from localtable;
+---------------------+-----------+--------+
| EventDate           | CounterID | UserID |
+---------------------+-----------+--------+
| 0000-00-00 00:00:00 |         3 |      4 |
+---------------------+-----------+--------+
1 row in set (0.00 sec)

MySQL [(none)]> exit
Bye
[songenjie@A02-R12-I160-19 doris-engine]$ mysql --protocol=tcp -h node1 -P 9304 -udefault
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 20.4.3.1-ClickHouse 67108864

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> select * from localtable;
+---------------------+-----------+--------+
| EventDate           | CounterID | UserID |
+---------------------+-----------+--------+
| 0000-00-00 00:00:00 |         4 |      5 |
| 0000-00-00 00:00:00 |         1 |      2 |
| 0000-00-00 00:00:00 |         2 |      3 |
+---------------------+-----------+--------+
3 rows in set (0.01 sec)

MySQL [(none)]> Ctrl-C -- exit!
Aborted
[songenjie@A02-R12-I160-19 doris-engine]$ mysql --protocol=tcp -h node1 -P 9404 -udefault
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 20.4.3.1-ClickHouse 67108864

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> select * from localtable;
Query OK, 99 rows affected, 26144 warnings (0.01 sec)

MySQL [(none)]> Ctrl-C -- exit!
Aborted
[songenjie@A02-R12-I160-19 doris-engine]$ mysql --protocol=tcp -h node2 -P 9304 -udefault
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 20.4.3.1-ClickHouse 67108864

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> select * from localtable;
+---------------------+-----------+--------+
| EventDate           | CounterID | UserID |
+---------------------+-----------+--------+
| 0000-00-00 00:00:00 |         3 |      4 |
+---------------------+-----------+--------+
1 row in set (0.00 sec)

MySQL [(none)]> Ctrl-C -- exit!
Aborted
[songenjie@A02-R12-I160-19 doris-engine]$ mysql --protocol=tcp -h node2 -P 9304 -udefault
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 20.4.3.1-ClickHouse 67108864

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> select * from localtable_dis;
+-----------+--------+
| CounterID | UserID |
+-----------+--------+
|         3 |      4 |
|         1 |      2 |
|         2 |      3 |
|         4 |      5 |
+-----------+--------+
4 rows in set (0.00 sec)

MySQL [(none)]> select * from localtable;
+---------------------+-----------+--------+
| EventDate           | CounterID | UserID |
+---------------------+-----------+--------+
| 0000-00-00 00:00:00 |         3 |      4 |
+---------------------+-----------+--------+
1 row in set (0.01 sec)

MySQL [(none)]> select * from localtable_dis;
+-----------+--------+
| CounterID | UserID |
+-----------+--------+
|         3 |      4 |
|         4 |      5 |
|         1 |      2 |
|         2 |      3 |
+-----------+--------+
4 rows in set (0.01 sec)



与 click-ha by database 比较

共同优点: ha

优缺点，互为优缺点

clickhouse by muti process
1. 优点
- 多进程管理
- 单进程down数据 只需要恢复一个副本，click-ha by database 需要恢复一个node ,三个副本
- 相对 click-ha by database 可以建立多个database， 从database 层隔离,clickhouse by database,database 在单个集群已经固定

2. 缺点
- 缺点，进程数目太多，占用机器端口太多，管理元数据增多
- 部署相对复杂, 每个进程配置都不相同
- Distributed 表也需要建 总的副本数据,也即是进程数,是 click-ha by database 的三倍 


