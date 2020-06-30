### clickhouse 扩缩容 by fetch partition to move partition between two different node

#### 1 ha 方法

![ha-group](/source/clickhouse-ha-group.jpg)

#### 2 mult disk 3 process at 1 node

- https://github.com/songenjie/daily_notes/blob/master/2020/6%E6%9C%88/%E5%B7%A5%E4%BD%9C/clickhouse-ha-multiproces-multidisk.md

#### 2 设计方法

- https://www.processon.com/view/link/5eec8b70e0b34d4dba4879b3

![设计](/source/clickhouse-ha-by-fetch-partition.jpg)


#### 3 原始节点

source
1 group
2 3 node 
```
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
            <replica>
                <host>node3</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node2</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node3</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node3</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node2</host>
                <port>9800</port>


```


add 1 group 3 node


now 2 group 6 node 

```
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
            <replica>
                <host>node3</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node2</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node3</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node3</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node2</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node4</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node5</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node6</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node5</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node6</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node4</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node6</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>node4</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>node5</host>
                <port>9800</port>
            </replica>
        </shard>
```


#### 流程

1. source node 部署

2. create table 

```
CREATE TABLE jason.table1 on cluster ck_06
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/ck_06/jdob_ha/jason/{shard}/table1', '{replica}')
PARTITION BY toYYYYMMDD(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha';


CREATE TABLE jason.table1_d on cluster ck_06
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = Distributed(ck_06, jason, table1, rand());  


```


3. insert data have 20200616 20200617 20200618 partition


#!/bin/bash

```
for((i=1;i<=100;i++))
do   
	mysql --protocol=tcp -h node1 -P 9504 -udefault -e "insert into jason.table1_d values  ('2020-06-16 00:00:00',$i,$(($i+1)));"
	mysql --protocol=tcp -h node1 -P 9504 -udefault -e "insert into jason.table1_d values  ('2020-06-17 00:00:00',$i,$(($i+1)));"
	mysql --protocol=tcp -h node1 -P 9504 -udefault -e "insert into jason.table1_d values  ('2020-06-18 00:00:00',$i,$(($i+1)));"
	echo  "insert into table values  ('2020-06-18',$i,$(($i+1)));"
done
```



- ipfile
```
node1
node2
node3
```

- select
#!/bin/bash

```
for IP in $(cat  ./ipfile )
do


        mysql -h $IP -P 9604 -udefault -e "select count(distinct CounterID)  from jason.table3 where EventDate='2020-06-17 00:00:00';"
done


+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   30 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   32 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   38 |
+----------------------+
```



4. add 3 node 
- 添加节点重新部署


5. recreate table1 table1_d at node4 node5 node6

```
CREATE TABLE jason.table1 on cluster ck_06
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/ck_06/jdob_ha/jason/{shard}/table1', '{replica}')
PARTITION BY toYYYYMMDD(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha';


CREATE TABLE jason.table1_d on cluster ck_06
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = Distributed(ck_06, jason, table1, rand());  

```


6. fetch

```
node4 shard1 replace1 
ALTER TABLE jason.table1 FETCH PARTITION 20200617 FROM '/clickhouse/ck_06/jdob_ha/jason/01/table1';
ALTER TABLE jason.table1 ATTACH PARTITION 20200617;

node5 shard2 replace1 
ALTER TABLE jason.table1 FETCH PARTITION 20200617 FROM '/clickhouse/ck_06/jdob_ha/jason/02/table1';
ALTER TABLE jason.table1 ATTACH PARTITION 20200617;

node6 shard3 replace1 
ALTER TABLE jason.table1 FETCH PARTITION 20200617 FROM '/clickhouse/ck_06/jdob_ha/jason/03/table1';
ALTER TABLE jason.table1 ATTACH PARTITION 20200617;
```

7. select node4 5 6  === node 1 2 3 

```
mysql -h $IP -P 9604 -udefault -e "select count(distinct CounterID)  from jason.table3 where EventDate='2020-06-17 00:00:00';"
```

8. drop partiton 20200617 at node1 node2 node3

ALTER TABLE jason.table1 DROP PARTITION 20200617

9. 完成

