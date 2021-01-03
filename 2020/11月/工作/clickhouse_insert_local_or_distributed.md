

1. 如果预估自己的业务数据不大 日增加不到百万行，写分布式表和本地表都是可以的

2. 写本地表，请保证每次写入数据都建立新的连接，每个连接写入的数据量基本相同
3. 如果预估自己的业务量很大，日增加超过了百万，并发插入大于10，那么请写入本地表
4. 建议每次插入20w-50w行左右的数据，每次不能超过100w
5. ClickHouse不像Mysql要小失误，比如1000w行的数据，Mysql建议插入1w左右，使用小事务，执行1000次，ClickHouse建议20次，每次50w,这也是MergeTree引擎原理决定的，频繁少量插入会导致data part 过多，合并不过来
6. AP不像TP,TP为了避免建立新的连接产生的损耗影响性能，通常会使用长连接，连接池等技术做优化，AP业务不需要，因为AP的属性就不会有高并发，小Sql
7. 如果internal_replication=true,使用ReplicatedMergeTree引擎，除了写本地表更灵活可控外



大小50-200MB/批次  

时间30s-1m/批次  

行数20-50w/批次

```
按照用户id的余数划分
Distributed(cluster, database, table ,userid)
```

------

也可以是一个返回整型的表达式：

------

```
--按照随机数划分
Distributed(cluster, database, table ,rand())
--按照用户id的散列值划分
Distributed(cluster, database, table , intHash64(userid))
```



100M 10wk 20w行





```
<sharding_simple><!-- 自定义集群名称 -->
    <shard><!-- 分片 -->
        <weight>10</weight><!-- 分片权重 -->
            ……
    </shard>
    <shard>
        <weight>20</weight>
            ……
    </shard>
…
```



spark sql scala repartion 

flink fromat 







# [Question] insert data via the distributed table or local table #1854

 Closed

[lamber-ken](https://github.com/lamber-ken) opened this issue on 3 Feb 2018 · 1 comment

## Comments

### **[lamber-ken](https://github.com/lamber-ken)** commented [on 3 Feb 2018](https://github.com/ClickHouse/ClickHouse/issues/1854#issue-293977319) • edited 

hi, distributed table based on local table. when insert data, one way is to write data to distributed table, the another is to write data to local table on nodes.questionif create distributed table use shard key, but insert data via local table, when query the distributed table using shard key, will it impact results?official document says:`You should be concerned about the sharding scheme in the following cases: - Queries are used that require joining data (IN or JOIN) by a specific key. If data is sharded by this key, you can use local IN or JOIN instead of GLOBAL IN or GLOBAL JOIN, which is much more efficient. `



https://github.com/alexey-milovidov)

 

Member

### **[alexey-milovidov](https://github.com/alexey-milovidov)** commented [on 6 Feb 2018](https://github.com/ClickHouse/ClickHouse/issues/1854#issuecomment-363197252)

Sharding key in Distributed table is used only at INSERT. For SELECTs, sharding key does not make sense and Distributed tables always query all shards.Insertion to local tables is more efficient and more flexible than insertion to Distributed table. It is more efficient because it avoids excessive copying of temporary data. It is more flexible because you can use any sophisticated sharding schemas, not only simple sharding by modulo of division.Insertion to local tables require more logic on your client application and can be more difficult to use. But also it is conceptually more simple.If your queries rely on some assumptions on data distribution, like queries that use IN or JOIN (joining co-located data) instead of GLOBAL IN, GLOBAL JOIN, then you have to maintain correctness by yourself.

上面文档内容我理解意思是说假如我有S1 S2 S3 三个节点,每个节点都有local表和分布式表. 我向S1的分布式表写数据1, 2, 3，
1写入S1, 2,3先写到S1本地文件系统, 然后异步发送到S2 S3 , 比如2发给S2, 3发给S3, 如果此时S3宕机了, 则3发到S3失败, 但是1,2还是成功写到S1,S2了? 所以整个过程不能保证原子性?