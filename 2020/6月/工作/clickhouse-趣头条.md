## clickhuse 趣趣头条


### 现状
![现状](/source/趣头条现状.png)

### 查询性能
1. 一个查询经常会按照机器cpu核数并发查询
![查询性能](/source/趣头条性能.jpg)

### 索引
![索引](/source/趣头条索引.jpg)

### 写入
![写入](/source/趣头条写入.jpg)

写入Distributed 表时候，是先将数据写入到分布式表，然后本地表再分发到各个本地表

这里利用这个逻辑，是不是可以并发写入到各个本地表，然后自己同步呢？

### confg
metrics.xml
<internal_replication>true</internal_replication>
false: 数据会并发异步写入副本，意思就是写入时，不会只往一个里面写，一会replace1 一会replace2
容易操作数据不一致

true: 保证数据一致，写入性能会降低


### par
![调优](/source/趣头条参数调优.jpg)

3 order by 内存不够的情况，当我们的order 达到多少的时候，就换到磁盘到做，磁盘就会查询很慢
log_queries ,存储查询的日志信息
skip_unavailable_shards: 跳过异常的分片

backgroud_pool_size: 异步merge过程，就在线程池，所有表使用，默认16 设置为 cpu/3-1 个吧


### 内存
限制单条 sql 查询的内存使用
max_memory_usage 太大容易造成，因为一个大查询影响比的查询的问题

max_memory_usage_for_all_queries ,单个节点最大使用量，避免 oom down 机


### group by
group by 往往磁盘占用很大
max_bytes_befor_external_group
内存使用量已经达到 external_group 的时候，就写入磁盘，保证进程正常工作，不过查询会慢，毕竟是使用磁盘

- 建议 大小为 max_memory_usage 的一半大小
原因：在clickhouse 中聚合分两个阶段

1. 查询并且建立中间数据
2. 合并中间数据，写磁盘在第一个阶段，如果无需写入磁盘，clickhouse 在第一个和第二个节点需要使用相同的内存


### ananlyzie math 

- uniq 
uniq :基于自适应采样算法

uniqCombined: 基于数组（基数小）+ 哈希表（基数中） + HyperLogLog (基数大)

- 比较：
1: uniqCombined 的精度高
2: uniqCombined 的消耗内存要小
3: 一般情况下 uniqCombined的性能要比uniq略低


### 扩缩容

- 缩容：
1. 如果数据的存储时间N不是很长，建议直接调整写入的机器，等N天以后，直接调整机器配置，下线机器就OK
2. 如果数据存储的时间太长，需要进行数据的迁移

- 扩容
1. 旧数据没有办法自动进行rebalance 新机器调整分片负载，调整balance
balance 后，重新调整配置


### 迁移
1. 小数据量 小于亿行的数据
直接 insert int table select * from remote ()

2. 大数据量迁移.clickhouse-copier


### 待优化
1. zk重度依赖
每一个文件的block在zk上面都有一个对应的节点，随着集群的数据越来越多，zk上的节点也就越来越多，这个时间zk的snapshot文件就会越来越大，zk相应就会受到影响

