### clickhouse 扩缩容 by copier to resharding data need tmp table

#### 1 ha 方法

![ha-group](/source/clickhouse-ha-group.jpg)

#### 2 mult disk 3 process at 1 node

- https://github.com/songenjie/daily_notes/blob/master/2020/6%E6%9C%88/%E5%B7%A5%E4%BD%9C/clickhouse-ha-multiproces-multidisk.md

#### 2 设计方法

- https://www.processon.com/view/link/5eec8b70e0b34d4dba4879b3

![设计1](/source/clickhouse-ha-by-copier-resharding1.jpg)
![设计2](/source/clickhouse-ha-by-copier-resharding2.jpg)
![设计3](/source/clickhouse-ha-by-copier-resharding3.jpg)


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

6. crate tabletmp1 table

```
CREATE TABLE jason.tabletmp1 on cluster ck_06
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/ck_06/jdob_ha/jason/{shard}/tabletmp1', '{replica}')
PARTITION BY toYYYYMMDD(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha';

```

7. copier  of resharding

- zookeeper.xml

```
<yandex>
    <logger>
        <level>trace</level>
        <size>100M</size>
        <count>3</count>
    </logger>

    <zookeeper>
      <node index="1">
        <host>zookeepernode1</host>
        <port>2281</port>
      </node>
      <node index="2">
        <host>zookeepernode1</host>
        <port>2281</port>
      </node>
      <node index="3">
        <host>zookeepernode3</host>
        <port>2281</port>
      </node>
    </zookeeper>
</yandex>
```

- schema.xml

```
<yandex>
    <!-- Configuration of clusters as in an ordinary server config -->
    <remote_servers>
        <ck_06>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>node1</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <weight>1</weight>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>node2</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <weight>1</weight>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>node3</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>node4</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>node5</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>node6</host>
                    <port>9600</port>
                </replica>
            </shard>
        </ck_06>

    </remote_servers>

        <!-- How many simultaneously active workers are possible. If you run more workers superfluous workers will sleep. -->
        <max_workers>2</max_workers>

        <!-- Setting used to fetch (pull) data from source cluster tables -->
        <settings_pull>
            <readonly>1</readonly>
        </settings_pull>

        <!-- Setting used to insert (push) data to destination cluster tables -->
        <settings_push>
            <readonly>0</readonly>
        </settings_push>

        <!-- Common setting for fetch (pull) and insert (push) operations. Also, copier process context uses it.
             They are overlaid by <settings_pull/> and <settings_push/> respectively. -->
        <settings>
            <connect_timeout>3</connect_timeout>
            <!-- Sync insert is set forcibly, leave it here just in case. -->
            <insert_distributed_sync>1</insert_distributed_sync>
        </settings>

        <!-- Copying tasks description.
             You could specify several table task in the same task description (in the same ZooKeeper node), they will be performed
             sequentially.
        -->
    <tables>
            <!-- A table task, copies one table. -->
        <tabletmp2>
            <!-- Source cluster name (from <remote_servers/> section) and tables in it that should be copied -->
            <cluster_pull>ck_06</cluster_pull>
            <database_pull>jason</database_pull>
            <table_pull>table1</table_pull>

            <!-- Destination cluster name and tables in which the data should be inserted -->
            <cluster_push>ck_06</cluster_push>
            <database_push>jason</database_push>
            <table_push>tabletmp1</table_push>

            <!-- Engine of destination tables.
                 If destination tables have not be created, workers create them using columns definition from source tables and engine
                 definition from here.

                 NOTE: If the first worker starts insert data and detects that destination partition is not empty then the partition will
                 be dropped and refilled, take it into account if you already have some data in destination tables. You could directly
                 specify partitions that should be copied in <enabled_partitions/>, they should be in quoted format like partition column of
                 system.parts table.
            -->
            <engine>
            ENGINE = ReplicatedMergeTree('/clickhouse/ck_06/jdob_ha/jason/{shard}/tabletmp1', '{replica}')
            PARTITION BY toYYYYMMDD(EventDate)
            ORDER BY (CounterID, EventDate, intHash32(UserID))
            SAMPLE BY intHash32(UserID)
            SETTINGS storage_policy = 'jdob_ha';
            </engine>

            <!-- Sharding key used to insert data to destination cluster 
            <sharding_key>jumpConsistentHash(intHash64(UserID), 2)</sharding_key>-->
            <sharding_key>rand()</sharding_key>

            <!-- Optional expression that filter data while pull them from source servers 
            <where_condition>CounterID != 0</where_condition>-->

            <!-- This section specifies partitions that should be copied, other partition will be ignored.
                 Partition names should have the same format as
                 partition column of system.parts table (i.e. a quoted text).
                 Since partition key of source and destination cluster could be different,
                 these partition names specify destination partitions.

                 NOTE: In spite of this section is optional (if it is not specified, all partitions will be copied),
                 it is strictly recommended to specify them explicitly.
                 If you already have some ready partitions on destination cluster they
                 will be removed at the start of the copying since they will be interpeted
                 as unfinished data from the previous copying!!!
            -->
            <enabled_partitions>
                <partition>20200617</partition>
            </enabled_partitions>
        </tabletmp2>

    </tables>

</yandex>

```
- 执行之前 table1 分布

```
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
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                    0 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                    0 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                    0 |
+----------------------+
```


- copier 执行
https://github.com/ClickHouse/ClickHouse/blob/master/docs/en/operations/utilities/clickhouse-copier.md
https://www.jianshu.com/p/40402320b631
https://clickhouse.tech/docs/en/operations/utilities/clickhouse-copier/

```
./clickhouse copier  --config zookeeper.xml  --task-file schema.xml  --base-dir='/data2/jdolap/clickhouse/lib' --task-path='/data2/jdolap/clickhouse/lib11'
--daemon 就是后台运行 数据量大可以
--base-dir 就是生成的日志
--tak-path 在zk里面是唯一的任务
```


- replace table1 from table2
```
#!/bin/bash

for IP in $(cat  ./$1 )
do

	mysql -h $IP -P 9504 -udefault -e "ALTER TABLE jason.table1 REPLACE PARTITION 20200617 FROM jason.tabletmp1;"
done
```

- 完成 查看数据 table1 分布
```
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   13 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   17 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   15 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   12 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   25 |
+----------------------+
+----------------------+
| uniqExact(CounterID) |
+----------------------+
|                   18 |
+----------------------+
```
