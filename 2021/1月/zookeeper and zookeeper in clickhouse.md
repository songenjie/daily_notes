# zookeeper 详细设计 及 clickhouse 在 zookeeper 中使用的深度改造





### 1 clickhouse 

- 复制表，internal_replication=true。插入到分布式表中的数据仅插入到其中一个本地表中，但通过复制机制传输到另一个主机上的表中。因此两个本地表上的数据保持同步。这是官方推荐配置。
- 复制表，internal_replication=false。数据被插入到两个本地表中，但同时复制表的机制保证重复数据会被删除。数据会从插入的第一个节点复制到其它的节点。其它节点拿到数据后如果发现数据重复，数据会被丢弃。这种情况下，虽然复制保持同步，没有错误发生。但由于不断的重复复制流，会导致写入性能明显的下降。所以这种配置实际应该是避免的。

zookeeper blockid/part 做数据的一致性校验  去重使用 完成就删除了

确实 这些逻辑放到ck本身是不合理的





### 2  zookeeper 

1. paxos (zab), raft 我这里不介绍 

   

   

   ![img](https://yuzhouwan.com/picture/zk/zk_vote_server_state.png)

2. 介绍 强一致性的分布式好存储系统 所以能支持高并发的读 写反而吞吐量就会收到影响
3. master follower slave 三个角色
   - Leader
     Leader服务器在整个正常运行期间有且仅有一台,集群会通过选举的方式选举出Leader服务器,由它同统一处理集群的事务性请求以及集群内各服务器的调度。
   - Follower
     Follower的主要职责有以下几点:
     - 1.参与Leader选举投票
     - 2.参与事务请求Proposal的投票
     - 3.处理客户端非事务请求(读),并转发事务请求(写)给Leader服务器。
   - Observer
     Observer是弱化版的Follower。其像Follower一样能够处理非事务也就是读请求,并转发事务请求给Leader服务器,但是其不参与任何形式的投票,不管是Leader选举投票还是事务请求Proposal的投票。引入这个角色主要是为了在不影响集群事务处理能力的前提下提升集群的非事务处理的吞吐量。





### 3 zode

最小存储单元

之间是关联的，所以并不是很适合深层存储

![img](https://yuzhouwan.com/picture/zk/zk_znode.png)



### 4 znode watch 

watch api

ZNode 发生了变化时，例如 创建、删除、数据变更、添加或移除子节点，watch API 就会发出通知，这是 zookeeper 非常重要的功能。

zookeeper 的 watch 有一个缺点，就是这个 watch 只能被触发一次，一旦发出了通知，如果还想对这个节点继续 watch，用户需要重新设置 watch。





### 5 设计



![图片描述](https://img1.sycdn.imooc.com/5d2c4d0400018f6b09000673.jpg)





ZKDatabase 作为 ZooKeeper 内存数据库的主体，包含了

Session 会话、

DataTree、

Snapshot（记录 ZooKeeper 服务器上某一个时刻全量的内存数据内容）、

事务日志（事务操作时间 、客户端会话 ID、 CXID [客户端的操作序列号]、ZXID、操作类型、会话超时时间、节点路径、节点数据内容、

节点的 ACL 信息、 
是否为临时节点 和 父节点的子节点版本号）等信息。ZKDatabase 会定时地向磁盘 dump 快照数据，并会在 ZooKeeper 服务端节点启动/重启的时候，read 磁盘上的事务日志和 Snapshot 文件，load 相关数据到内存中，重新恢复出整个 ZKDatabase

1、事务日志log，对应代码类：org.apache.zookeeper.server.persistence.FileTxnLog 2、快照日志snapshot，对应代码类：org.apache.zookeeper.server.persistence.FileTxnSnapLog





### 6 数据持久化



持久化的数据有哪些  数据、事务  加起来就是全量的数据

snapshot log可视化解析

java -cp /data0/jdolap/zookeeper/pkg/zookeeper-3.4.12.jar:/data0/jdolap/zookeeper/pkg/lib/slf4j-api-1.7.25.jar  

org.apache.zookeeper.server.LogFormatter              /data0/jdolap/zookeeper/txnlog/version-2/log.e000f871b

org.apache.zookeeper.server.SnapshotFormatter   /data0/jdolap/zookeeper/snapshot/version-2/log.e000f871b

目前的场景

1. zookeeper 吞吐量过高 220txn/s
2. snapshot 2g
3. txn. 2g



### 6. 1 snapshot

Snapshot（记录 ZooKeeper 服务器上某一个时刻全量的内存数据内容）、

所有的节点数据

/data0/

**

/data0/clickhouse/

**





### 6.2 事务

事务日志（事务操作时间 、客户端会话 ID、 CXID [客户端的操作序列号]、ZXID、操作类型、会话超时时间、节点路径、节点数据内容、

```
12/31/20 10:00:19 AM CST session `0x200bff123b7000b` cxid `0x6746de73` zxid `0x208974078` delete 
12/31/20 10:00:21 AM CST session 0x200bff123b7000b cxid 0x6746e207 zxid 0x2089741b2 multi 
12/31/20 10:00:21 AM CST session 0x200bff123b7000b cxid 0x6746e208 zxid 0x2089741b3 multi
12/31/20 10:00:21 AM CST session 0x200bff123b7000b cxid 0x6746e209 zxid 0x2089741b4 multi 
12/31/20 10:00:21 AM CST session 0x200bff123b7000b cxid 0x6746e20a zxid 0x2089741b5 multi 
12/31/20 10:00:21 AM CST session 0x200bff123b7000b cxid 0x6746e20c zxid 0x2089741b6 mult
```

cxid 客户端递增的一个数据

zxid 事务





### 6.3 snaptshot 和txn落盘



开始快照时，首先关闭当前日志文件（已经到了该快照的数了），重新创建一个新的日志文件，创建单独的异步线程来进行数据快照以避免影响Zookeeper主流程，从内存中获取zookeeper的全量数据和校验信息，并序列化写入到本地磁盘文件中，以本次写入的第一个事务ZXID作为后缀

snapshot 后缀为最后一个事务的id  snapped

txnshot 的后缀新进入的事务的id. Txnid. 比snaptshot文件大于1 





### 6.4 讲解一下怎么落盘 

和集群的配置一起将

dataDir：ZooKeeper的数据目录，主要目的是存储内存数据库序列化后的快照路径。如果没有配置事务日志(即dataLogDir配置项)的路径，那么ZooKeeper的事务日志也存放在数据目录中。

dataLogDir：指定事务日志的存放目录。事务日志对ZooKeeper的影响非常大，强烈建议事务日志目录和数据目录分开，不要将事务日志记录在数据目录(主要用来存放内存数据库快照)下。

preAllocSize：为事务日志预先开辟磁盘空间。默认是64M，意味着每个事务日志大小就是64M(可以去事务日志目录中看一下，每个事务日志只要被创建出来，就是64M)。如果ZooKeeper产生快照频率较大，可以考虑减小这个参数，因为每次快照后都会切换到新的事务日志，但前面的64M根本就没写完。(见snapCount配置项)

事务日志的写入是采用了磁盘预分配的策略。因为事务日志的写入性能直接决定看Zookeeper服务器对事务请求的响应，也就是说事务写入可被看做是一个磁盘IO过程，所以为了提高性能，避免磁盘寻址seek所带来的性能下降，所以zk在创建事务日志的时候就会进行文件空间“预分配”，即：在文件创建之初就想操作系统预分配一个很大的磁盘块，默认是64M，而一旦已分配的文件空间不足4KB时，那么将会再次进行预分配，再申请64M空间。

snapCount：ZooKeeper使用事务日志和快照来持久化每个事务(注意是日志先写)。该配置项指定ZooKeeper在将内存数据库序列化为快照之前，需要先写多少次事务日志。也就是说，每写几次事务日志，就快照一次。默认值为100000。为了防止所有的ZooKeeper服务器节点同时生成快照(一般情况下，所有实例的配置文件是完全相同的)，当某节点的先写事务数量在(snapCount/2+1,snapCount)范围内时(挑选一个随机值)，这个值就是该节点拍快照的时机。

autopurge.snapRetainCount：该配置项指定开启了ZooKeeper的自动清理功能后(见下一个配置项)，每次自动清理时要保留的版本数量。默认值为3，最小值也为3。它表示在自动清理时，会保留最近3个快照以及这3个快照对应的事务日志。其它的所有快照和日志都清理。

autopurge.purgeInterval：指定触发自动清理功能的时间间隔，单位为小时，值为大于或等于1的整数，默认值为0，表示不开启自动清理功能。



### 6.5 加载

1. 加载的本地快照文件（最近的一百个，如果没有就是全量），从最新的快照开始校验，校验失败则启动失败
2. 启动成功 会形成 datatree,和sessiontimeouts 集合，根据文件名(`文件后缀即为最新的快照，事务的id`)
3. 根据事务id,从事务文件中查找，更新元数据，从事务文件获取到最新的事务id
4. 选举 2n+1 ,大于n个节点选举通过，即成为leader 选举过程
5. 事务id最大的成为leader, 否则myid最大的成为leader
6. 启动完成





### 6.6 回顾snapshot 和 事务

在ZooKeeper集群启动后，当第一个客户端连接到某个服务器节点时，会创建一个会话，这个会话也是事务，于是创建第一个事务日志，一般名为log.100000001，这里的100000001是这次会话的事务id(zxid)。之后的事务都将写入到这个文件中，直到拍下一个快照。如果是事务ZXID5触发的拍快照，那么快照名就是snapshot.ZXID5，拍完后，下一个事务的ID就是ZXID6，于是新的事务日志名为log.ZXID6。

使用ZXID作为文件后缀，可以帮助我们迅速定位到某一个事务操作所在的事务日志。同时，使用ZXID作为事务日志后缀的另一个优势是：ZXID本身由两部分组成，高32位代表当前leader周期（epoch）,低32位则是真正的操作序列号，因此，将ZXID作为文件后缀，我们就可以清楚地看出当前运行时的zookeeper的leader周期。



当基于快照文件构建了一个完整的DataTree实例和sessionWithTimeouts集合后，此时根据这个快照文件的文件名就可以解析出最新的ZXID，该ZXID代表了zookeeper开始进行数据快照的时刻，然后利用此ZXID定位到具体事务文件从哪一个开始，然后执行事务日志对应的事务，恢复到最新的状态，并得到最新的ZXID。



### 6.7 出现 非leader 事务 > leader id的情况 eg:选举完成后  非leader节点起来了

zookeeper 为强一致的分布式事务集群，leader会让该节点truncate 进行日志的截断，删掉大于leader 最大事务id的所有日志

在Zookeeper运行过程中，可能出现非Leader记录的事务ID比Leader上大，这是非法运行状态。此时，需要保证所有机器必须与该Leader的数据保持同步，即Leader会发送TRUNC命令给该机器，要求进行日志截断，Learner收到该命令后，就会删除所有包含或大于该事务ID的事务日志文件



### 7 zode 详解

Znode按其生命周期的长短可以分为持久结点(PERSISTENT)和临时结点(EPHEMERAL);在创建时还可选择是否由Zookeeper服务端在其路径后添加一串序号用来区分同一个父结点下多个结点创建的先后顺序。
经过组合就有以下4种Znode结点类型

- 1.持久结点(PERSISTENT)
  最常见的Znode类型,一旦创建将在一直存在于服务端,除非客户端通过删除操作进行删除。持久结点下可以创建子结点。
- 2.持久顺序结点(PERSISTENT_SEQUENTIAL)
  在具有持久结点基本特性的基础上,会通过在结点路径后缀一串序号来区分多个子结点创建的先后顺序。这工作由Zookeeper服务端自动给我们做,只要在创建Znode时指定结点类型为该类型。
  ![img](https://images2018.cnblogs.com/blog/1422237/201808/1422237-20180820225900000-1047286049.png)
- 3.临时结点(EPHEMERAL)
  临时结点的生命周期和客户端会话保持一致。客户端段会话存在的话临时结点也存在,客户端会话断开则临时结点会自动被服务端删除。临时结点下不能创建子结点。
- 4.临时顺序结点(EPHEMERAL_SEQUENTIAL)
  具有临时结点的基本特性,又有顺序性。



### 8 优点

- 强一致性可以做读写分离

- 非阻塞全部快照（达成最终一致）
- 高效的内存管理
- 高可靠
- API 简单
- 连接管理可以自动重试
- ZooKeeper recipes 的实现是经过完整良好的测试的。
- 有一套框架使得写新的 ZooKeeper recipes 非常简单。
- 支持监听事件
- 发生网络分区时，各个区都会开始选举 leader，那么节点数少的那个分区将会停止运行





### 9 缺点

- zookeeper 是 java 写的，那么自然就会继承 java 的缺点，例如 GC 暂停。
- 如果开启了快照，数据会写入磁盘，此时 zookeeper 的读写操作会有一个暂时的停顿。
- 对于每个 watch 请求，zookeeper 都会打开一个新的 socket 连接，这样 zookeeper 就需要实时管理很多 socket 连接，比较复杂。





### 10 需要优化的点



内存 zk> etcd

zookeeper tree 深度较高 需要优化

zookeeper 当前节点太少 故障一台 集群不可用





### 11 zookeeper + clickhouse

数据分层 需要有三个zookeeper 集群

事实 离线 确实是可以分开的 超过12个小时 未更新的数据示为cold 数

存储媒介/shard/replica

zookeeper 存储



btree 本身是没有问题的 我个人就觉得是单纯的kv存储不咋样

btree 里面也是可以有 k v 的

采集多长时间没有被操作的table ,邮件通知进行清理

zookeeper 3个节点的数据设计是不合理的

zookeeper 冷热隔离

需要有一套完整的zk部署自动化





#### 1 

/业务/主cluster   

/业务/备cluster

get cluster znode

set cluster znode



#### 2 

/cluster/db/table/partition/存储介质/shard/bucket

/cluster/db/table/partition/存储介质/bucket



理论上 需要从partition 层级判断更合理

get storage medium

set storage medium



get shard znode

set shard znode 



cold partition

hot partititon 



#### 4 

shard/replicas

append add 

update

delete 









