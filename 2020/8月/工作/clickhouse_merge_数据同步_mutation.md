## 机器HA的问题

1. 字节内部使用 单个集群多副本，不同副本时间使用不同的cluster

- 优点
  - 我理解是 可以做到读写分离 一个集群支持 写 一个集群支持读
- 缺点
  - 单个集群内单个节点发生故障，整个集群就不可用了
  - 复制滞后的问题（这里因为使用不同的cluster,那可能就是使用了不同的机房，不同机房副本同步的问题，肯定也是使用异步同步的，同步写入同步的话，对写入会因为机房网络问题，成为瓶颈）
  - 复制滞后的问题 就是数据已经在写入leader节点写入成功了，用户插入成功后，在查询节点可能是查不到数据的
- google bing 还是主要针对5分钟后离线的数据 package 进行分析
  - 因为没有 transaction 



### 关于集群 HA的设计方案 不知道你们这边有么有调研过，存储

- ppt
- 单个instance 支持多个replica(除了自己shard leader replica ,还需要有其他shard 从节点的replica)

现在 clickhouse 存储的设计 就是单纯的 cluster/table/parts

可以设计为 /cluster/table/partition/shard***/parts 查询计划也可以按照这个方式路由

Partition-shard-parts.   或者 partition+shard 回形成一个唯一id+1_1  start_end version 

Partiton-shard 可以成为最小的单位

·`第一个副本起来的时候，它呢还需要重新争回leader 节点`·



因为还有比的table的别的partition ,可以完全的使用到所有磁盘

- 优点 都可以解决因为hash key 存储不均匀的情况
- 后期reshard 也可以慢慢自己做均衡 跟doris 就有点像了就

- policy 整个的优化







## 数据导入

1. 数据导入到查询可以使用 ACID的过程

数据写入失败(很可能是shard后部分的导入数据) 数据需要重新写入，这个问题

- 概率上机器如果正常运行 是很小的
- 数据是需要写入的 因为导入的数据批次 是按照当前导入的数据为一个整体



2. 为了导入加快，将数据导入过程的 其中的这个索引构建过程 放到了后面异步的执行

那么导入数据对外而言已经生效了，数据是可查还是不可查呢



3. 实时的kafka导入(topic 对应partition ,每个partition 每天的量）针对数据量，进行这种 consumer的调整

| partition 一天数据量     | 加入集群的集群的建议参数为 1G/s 100w/s 一分钟一分钟导入      |
| ------------------------ | ------------------------------------------------------------ |
| 1                        | 1G/s  60 60  3.6T  （这里也取决于topic的 对应到每个parition 所分配的带宽 |
| 10个partition 每个360G/T | 10个consumer(这里需要<shard数量，多了性能没有太大意义)，每个consumer 消费一个partition |
| 10个partition 每个160G/T | 5个consumer ,每个consumer 消费两个partition                  |
| ...                      |                                                              |
|                          |                                                              |



4. Background_pool_size 线程池的大小最好还是< cpu核数-4



5. doris clickhouse block(page)定义就是 64k 1M就会形成一个block吗，block也是zookeeper 数据间同步的单位，数据去重的单位





## 多数据类型兼容，提高压缩和存储量

6. 数据类型 后期可以支持 char varchar 







1. distributed write reshard



2. 多副本同步 （同步原则设计为 true),这样通过 分布式表写入，分布式表就不必要再做数据同步的负载了







### roaring bitmap 

4096  4bytes (int) 

2 32 bit 512M



复制分为 主从复制 多主几点复制 无主节点复制

主从的变异吧 当副本>3 的时候，会出现非主从复制，首先你的知道他的这个复制的原理

1. 依赖zk  主副本的选举（leader_election) 谁先注册,谁就是leader (这里我们可以统一优化为第一副本)

2. 副本的感知能力  
3. 操作日志的分发
4. 任务队列管理
5. BockID去重



首先 replicatedMerge 前缀 zkpath，会为每个shard 创建一组监听的节点

1 元数据 metadata columns replicas 

2 判断

- Leader_election merge mutation alter 
- Blocks_numbers 记录每个block数据块的hash (这里自己将 4096->100会很 )

- Quorum 每次导入 多少个副本写入成功才算写入成功

3 操作日志

log insert merge drop partition 

mutatiton 

replica/replicaname  每个副本自己也有监听的节点

- - queue 任务队列 当副本从 log/mutation 监听到操作指令的时候，将执行任务放到执行队列
  - log pointer 
  - mutatiton pointer 



Entry 的object 

logEntry MutationEntry对象



Insert merge mutation alter 

get merge mutation alter 



## 副本同步设计

1. 两个节点初始化 zkpath 会在第一次的时候初始化完成，各个节点的监听任务会起来

2. Insert *** block_id 可能是多个 也可能是一个 (server 不停止写入)

3. 推送insert 日志 logEntry  get 任务数据logEntry

4. 副本监听到log变化，创建task  

5. 数据源的选择优化算法

   - 找到所有副本
   - 选择 log_pointer 最大的，也就是最新的（也就是它需要更新的数据的replica)
   - 选择节点内 任务最少的额副本

   Fetch part ** fron 源节点

   Max_fetch_partition_retris_count =5 

6. 源 主节点接受 返回 part 数据

7. 副本接受和创建tmp_fetch_**. 重命名 ***



## merge 操作



1. 从 节点 optimze table
2. 建立连接 到主节点
3. 主节点 执行merge计划，推送 log日志 type merge command 2000* 20002 int ***

- 2020_0_0_0 2020_1_1_0. -> 2020_0_1_1

4. 主从都监听到log操作日志，拉去日志 logEntry对象，加入自己的task queue
5. 相应任务合并

merge 操作，不涉及数据内容的传输



### mutation 

1. 从节点 alter delete command
2. 创建muattions 日志 mutationEntry 推送日志
3. 主从都监听到  
4. 主副本响应mutation  推送 mutation 操作日志 mutata 空 mutate 
5. 主从拉取日志，放入队列
6. 主从响应 







## distributed

shard -> replica

weigth 

user

password



weight +++ = sum 

slot 槽的概念。 slot=shardvalue&sum_weight 



distribute table insert

1. Insert ** value (0,30,**)

2. 跟进shard 就会将数据分片 2 shard 两份
3. 自己的一份 insert to local, tmp_insert *** to ***
4. 将另一个副本的数据写入到临时文件 /table/host:port/.bin
5. 创建远程连接 host:port  
6. 发送数据
7. execute query rename _ ***
8. 接受发送完成

Internal_replication 





