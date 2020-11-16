# 1.znode

znode的官方说明：http://zookeeper.apache.org/doc/r3.4.12/zookeeperProgrammers.html#sc_zkDataModel_znodes

ZooKeeper以一种类似于文件系统的树形数据结构实现名称空间。名称空间中的每个节点都是一个znode。znode和文件系统的路径不一样，在文件系统中，路径只是一个名称，不包含数据。而znode不仅是一个路径，还携带数据。

![img](https://images2018.cnblogs.com/blog/733013/201806/733013-20180627120322365-702119801.png)

需要注意，虽然是树形数据结构，但ZooKeeper是内存数据库，节点的信息全都存放在内存中(在写操作达到一定次数后，会对内存数据库拍快照，将其序列化到磁盘上)，所以在文件系统中是看不到这个树形结构的，不过可以借助ZooKeeper的第三方web工具来查看。

此外，znode还维护了包括版本号和时间戳的状态信息。通过版本号和时间戳信息，可以让ZooKeeper验证缓存、协调每次的更改操作。每当znode数据发生更改时，版本号都会递增。客户端检索znode时，同时也会收到关于该节点的状态信息。当客户端执行更改、删除操作时，它必须提供它正在更改的znode数据的版本，如果它提供的版本与数据的实际版本不匹配，则更新将失败。

znode有几个需要关注的点：

- `Watches`：
  客户端可在znode上设置watchs。每当该znode发生改变时，就会触发设置在这个znode上的watch。当触发了watch，ZooKeeper会发送一个通知给客户端。关于ZooKeeper的watch详细内容，见：http://zookeeper.apache.org/doc/r3.4.12/zookeeperProgrammers.html#ch_zkWatches。

- `Data Access`：
  在每个znode名称空间中存储的数据的读、写操作都是原子性的。读操作将获取与znode关联的所有数据(包括数据的状态信息)，写操作将替换该znode所携带的所有数据。每个节点都有一个访问控制列表(ACL)来限制谁可以做什么。

  ZooKeeper并没有被设计成一般的数据库或大型对象存储。相反，它只是管理协调数据。这些数据可以以配置、状态信息等形式出现。各种形式的协调数据的一个共同特点是它们相对较小，一般以kb作为度量度量。ZooKeeper客户端和服务器实现都有完整的检查功能，以确保znode的数据少于1M，一般来说，协调数据占用的空间都远远小于1M。在相对较大的数据大小上操作会导致一些操作比其他操作花费更多的时间，并且会影响一些操作的延迟，因为它要在网络上传输更多数据。如果需要存储较大数据，可以将它们存储在大型存储系统(如NFS或HDFS)上，然后在ZooKeeper中使用指针指向这些较大数据。

- `Ephemeral Nodes`：
  ZooKeeper允许使用临时(ephemeral)节点。只要创建临时znode的会话还存在，临时znode就存在。会话退出，这个会话上创建的临时节点都会删除。因此，临时节点上不允许出现子节点。

- `Sequence Nodes -- Unique Naming`
  创建znode时，还可以请求ZooKeeper将单调递增的计数器追加到znode路径的末尾。这个计数器是父znode独有的。计数器的格式为`%010d`，即使用0来填充的10位数字(计数器以这种方式进行格式化以简化排序)，例如`<path>0000000001`。注意:用于存储下一个序列号的计数器是由父节点维护的有符号整数(4bytes)，当计数器的增量超过2147483647时，计数器将溢出。



# 2.ZooKeeper中的时间

时间相关的官方说明：http://zookeeper.apache.org/doc/r3.4.12/zookeeperProgrammers.html#sc_timeInZk

- `Zxid`：
  每次更改ZooKeeper的状态，都会设置到一个zxid(ZooKeeper的事务id)格式的版本戳。zxid暴露了ZooKeeper中所有更改操作的总顺序。因为每次更改都会设置一个全局唯一的zxid值，如果zxid1小于zxid2，说明zxid1对应的操作比zxid2对应的事务先发生。

- ```
  Version numbers
  ```

  ：

  每次对某节点进行更改，都会递增这个节点的版本号。有三种版本号：

  - dataVersion：znode的更改次数。
  - cversion：子节点的更改次数。
  - aversion：节点的ACL的更改次数。

- `Ticks`：
  当使用多节点(这个节点代表的是组成ZooKeeper的server，而非znode)的ZooKeeper集群时，各节点使用ticks来定义事件的时间。例如传播状态、会话超时时间、节点间连接超时时间等。tick时间间接设置了会话连接的最小超时时长(tick的两倍时长)。如果客户端在2倍tick时间内还没有成功连接server，那么连接失败。

- `Real time`
  除了在创建和修改znode时会将当前实时时间戳放入stat结构之外，ZooKeeper根本不使用实时时间或时钟时间。



# 3.znode的状态

状态相关的官方说明：http://zookeeper.apache.org/doc/r3.4.12/zookeeperProgrammers.html#sc_zkStatStructure

| field          | description                                                  |
| -------------- | ------------------------------------------------------------ |
| czxid          | 创建znode的zxid                                              |
| mzxid          | 最近一次修改znode的zxid(创建、删除、set直系子节点、set自身节点都会计数) |
| pzxid          | 最近一次修改子节点的zxid(创建、删除直系子节点都会计数，set子节点不会计数) |
| ctime          | 创建znode的时间，单位毫秒                                    |
| mtime          | 最近一次修改znode的时间，单位毫秒                            |
| version        | 修改znode的次数                                              |
| cversion       | 修改子节点的次数(创建、删除直系子节点都会计数，set子节点不会计数) |
| aversion       | 该znode的ACL修改次数                                         |
| ephemeralOwner | 临时znode节点的session id，如果不是临时节点，值为0           |
| dataLength     | znode携带的数据长度，单位字节                                |
| numChildren    | 直系子节点的数量(不会递归计算孙节点)                         |