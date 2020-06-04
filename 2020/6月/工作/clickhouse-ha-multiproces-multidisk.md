## ip
4 machine : node1 node2 node3 node4

## replica
3 replica 

## disk
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       5.5T  178G  5.1T   4% /data1
/dev/sdf1       5.5T  142G  5.1T   3% /data3
/dev/sdj1       5.5T  176G  5.1T   4% /data7
/dev/sde1       5.5T  178G  5.1T   4% /data2
/dev/sdc1       5.5T  144G  5.1T   3% /data0
/dev/sdi1       5.5T  170G  5.1T   4% /data6
/dev/sdg1       5.5T  140G  5.1T   3% /data4
/dev/sdh1       5.5T  272G  5.0T   6% /data5
```

## metrika.xml multi process 
![image](https://user-images.githubusercontent.com/37113176/83725415-7bb38080-a674-11ea-9d1f-94f57d7e40d8.png)

```

        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node1</host>
                <port>port1</port>
            </replica>
            <replica>
                <host>node2</host>
                <port>port2</port>
            </replica>
            <replica>
                <host>node3</host>
                <port>port3</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node2</host>
                <port>port1</port>
            </replica>
            <replica>
                <host>node3</host>
                <port>port2</port>
            </replica>
            <replica>
                <host>node4</host>
                <port>port3</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node3</host>
                <port>port1</port>
            </replica>
            <replica>
                <host>node4</host>
                <port>port2</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>port3</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>node4</host>
                <port>port1</port>
            </replica>
            <replica>
                <host>node1</host>
                <port>port2</port>
            </replica>
            <replica>
                <host>node2</host>
                <port>port3</port>
            </replica>
        </shard>
```

## for multi process i want 
1 . example at node1
```
node1 process port1 use data0、data1
node1 process port2 use data2、data3
node1 process port3 use data4、data5
all process use data6、data7 
```


# question 
2.  for example  node1 process port1    ```question```
- config.xml node1 process port1 
```

<path>/data0/clickhouse/data/</path>
<storage_policy>/data0/clickhouse/conf/storage_policy.xml</storage_policy>
```

- storage_policy.xml  node1 process port1 
```
<yandex>
    <storage_configuration>
        <disks>
            <disk0>
                <path>/data0/clickhouse/data/</path>
            </disk0>
            <disk1>
                <path>/data1/clickhouse/data/</path>
            </disk1>
            <disk2>
                <path>/data2/clickhouse/data/</path>
            </disk2>
            <disk3>
                <path>/data3/clickhouse/data/</path>
            </disk3>
            <disk4>
                <path>/data4/clickhouse/data/</path>
            </disk4>
            <disk5>
                <path>/data5/clickhouse/data/</path>
            </disk5>
            <disk6>
                <path>/data6/clickhouse/data/</path>
            </disk6>
            <disk7>
                <path>/data7/clickhouse/data/</path>
            </disk7>
        </disks>

        <policies>
            <default>
                <volumes>
                    <hot>
                        <disk>disk0</disk>
                        <disk>disk1</disk>
                    </hot>
                    <cold>
                        <disk>disk6</disk>
                        <disk>disk7</disk>
                    </cold>
                </volumes>
                <move_factor>0.25</move_factor>
            </default>
        </policies>
    </storage_configuration>
</yandex>
```

if create table storage policy use default ,did disk0 disk1 storage work ```round-robin ``` ???????
![image](https://user-images.githubusercontent.com/37113176/83726540-3c862f00-a676-11ea-95e3-e11d1a2b9e39.png)

