|      类别      |                   Doris                   |      Clickhouse      |                             备注                             |
| :------------: | :---------------------------------------: | :------------------: | :----------------------------------------------------------: |
|      类别      |                   Doris                   |      Clickhouse      |                             备注                             |
|    总体架构    |            Share-Nothing + MPP            |         相同         |          方便横向扩展添加节点，并行可以提高处理速度          |
|                |                   列存                    |         相同         |           查询少量列时减少扫描数据量，可以支持压缩           |
|                |           内置分布式协议类似ZAB           |    依赖Zookeeper     |               Master/Follower/Observer节点类型               |
|                |              事务和MVCC机制               |   100万以内原子性    |                      可以保证数据一致性                      |
|                |               支持数据规模                |    单集群 < 10PB     |                        单集群 < 10 PB                        |
|                |                                           |                      |                                                              |
|    导入方式    |          从Kafka导入数据（内置）          |       内置支持       |                  分钟级(1-15分钟)，配置即可                  |
|                |         从HDFS上导入数据（内置）          | 外部通过HTTP接口导入 |                 离线数据或历史数据，配置即可                 |
|                |           分布式Spark/Flink导入           | 外部通过HTTP接口导入 |                         业务方写代码                         |
|                |               本地JDBC/HTTP               |         支持         |           本地代码导入，JDBC少数据量，HTTP大数据量           |
|                |        INSERT INTO ... SELECT ...         |         支持         |          可以把一张维度多的表汇总成另一张维度少的表          |
|                |               数据格式支持                |                      |                       orc/parquet/json                       |
|                |                                           |                      |                                                              |
|    存储架构    |               一级范围分区                |         支持         |                     一般日期天/周/月范围                     |
|                |               二级Hash分桶                |         支持         |                     按ID等分布均匀的字段                     |
|                |                支持多副本                 |         支持         |                 单个节点故障不影响写入和查询                 |
|                |              结构化数据支持               |   结构化、半结构化   |                不支持半结构化/嵌套的数据类型                 |
|                |               压缩格式支持                |      LZ4，ZSTD       |                           LZO，LZ4                           |
|                |                 前缀索引                  |       稀疏索引       |                      36个字节的前缀索引                      |
|                |                 物化视图                  |                      |           支持创建常用维度的物化视图，加快查询速度           |
|                | 支持Bitmap索引精确去重支持HLL索引抽样计算 |   不支持Bitmap索引   |                         可以加快查询                         |
|                |             增量数据后台合并              |                      |                       不影响导入和查询                       |
|                |            支持自动分区（TTL）            |         支持         |                可以指定分区策略，自动创建分区                |
|                |               支持类型转换                |                      |     比如Date/DateTime，float/double → decimal，增加长度      |
|                |         变通的数据更新和删除支持          |                      | 更新：用替换的方式，或用变化量的方式求和删除：用软删除和分区重建（需要外部工具支持） |
|                |                 写入性能                  |                      |                 可以并行写，10M/桶（1万条）                  |
|                |                 读写分离                  |                      |                       支持云存储和读取                       |
|                |                                           |                      |                                                              |
|    计算能力    |                 并发能力                  |                      |            QPS 100/台，要看扫描数据量和计算复杂度            |
|                |                 查询时间                  |                      |             TP99 < 100ms - 1S，要看查询数据大小              |
|                |                 编译执行                  |                      |             可以把多个SQL函数编译成一个方法执行              |
|                |                 谓词下推                  |                      |                可以把Where条件下推到扫描节点                 |
|                |              BroadCast Join               |                      |                 小表广播到大表节点上参与计算                 |
|                |                 Hash Join                 |                      |           类似Spark Shuffle，都分发到同一台服务器            |
|                |               Colocate Join               |                      |            相同ID数据在一台服务器，本地Join速度快            |
|                |                自定义函数                 |                      |                  支持UDF/UDAF，暂不支持UDTF                  |
|                |             查询结果整体缓存              |                      |                             支持                             |
|                |              查询按分区缓存               |                      |                           正在进行                           |
|                |                                           |                      |                                                              |
|     扩展性     |             支持JDBC/ODBC协议             |                      |                        支持多种客户端                        |
|                |                兼容标准SQL                |                      |                        扩展了高级写法                        |
|                |                 容器部署                  |                      |                             支持                             |
|                |               外查MySQL的表               |                      |                             支持                             |
|                |                外查ES的表                 |                      |                             支持                             |
|                |              Spark查JD-OLAP               |                      |                             支持                             |
|                |                查Hive的表                 |                      |                           暂不支持                           |
|                |                                           |                      |                                                              |
|     管理性     |              元数据自动同步               |                      |                       方便上下线服务器                       |
|                |               副本自动均衡                |                      |                      节点故障不影响使用                      |
|                |                 数据备份                  |                      |                        支持备份到HDFS                        |
|                |                监控和报警                 |                      |                     较为完善的监控和后台                     |
|                |             多租户和资源隔离              |                      |          按业务分数据库、分账号，但硬件资源无法隔离          |
|                |                                           |                      |                                                              |
| 权限/安全/审计 |                   权限                    |                      |                 数据库用户和权限控制，表级别                 |
|                |                   审计                    |                      |                          有审计日志                          |
|                |                端到端加密                 |                      |                            不支持                            |
|                |                 网络隔离                  |                      |                             暂无                             |
|                |                                           |                      |                                                              |
|    一些局限    |           没有Update/Delete语法           |                      |                       只支持Append操作                       |
|                |            DDL/DML操作后台异步            |                      |         一般很快，系统繁忙时需要等待，或超时后要重试         |
|                |        跨数据中心数据一致性不完善         |                      |                   目前需要业务方双写来保证                   |
|                |                                           |                      |                                                              |



元数据一致性 轻量 更好一些

副本一致性



1. update 

2. 存储计算分离 会解决很多的问题 可以尝试一些别的问题 - 这个主要我们也测试过一些东西  数据是强一致性的

3. 逻辑的概念可以更大一些-头条在这样-可能是个比较好的方向  设计元数据的问题

单纯的配置化，不是一个好问题，应该是一个集群通用的配置，资源控制控制好了以后，就不需要再动它了

大的Cluster的概念。逻辑集群可以更大一些  metrika 读写分离

4. 容器化 计算存储分离 扩容 缩容 发现一个节点是可以放到配置里面不使用的，但可能是其他集群在使用 

5. 618 双十一这样的场景 有些集群可以缩容 有些集群扩容
6. join 不是不好 ，按照doris的join设计的方案 现在clickhouse 也是可以变现实现对的 join 不是不好,是没有特定数据场景，sql返回
7. zookeeper 的脱离 写 merge mutation 
8. 慢查询group by 跟查询本身是相关的

10. 真实节点脱离配置的问题

往往中间加一层虚拟节点，或者说管理节点管理这些副本 能解决问题 高可用

11. 冷热数据的问题
12. 读写 cpu占用的问题



1 doris 多列索引的支持 没有 clickhouse 好，doris 前36bytes

2 导入顺序，是实际的表字段数据 ，clickhouse有 order  by ,重新规划，doris 表的列，必须和primary key 顺序一致

3 doris 有 多列rollup(定制化 kylin cube),空间换时间

4 TTL clickhouse有 行 列 分区级别不同的ttl



|              | Doris RollUp                                     | Clickhouse                                       |
| ------------ | ------------------------------------------------ | ------------------------------------------------ |
| 定义成本     | 需要手动逐个定义                                 | 需要手动逐个定义                                 |
| 定义的灵活性 | 维度列和指标列可以自由定义                       | 维度列和指标列可以自由定义                       |
| 计算方式     | 从原始数据直接生成每个RollUp表数据               | 从原始数据直接生成每个RollUp表数据               |
| 物理存储     | 每个RollUp表是独立存储                           | 每个RollUp表是独立存储                           |
| 查询路由     | 会根据过滤列，排序列，join列，行数，列数进行路由 | 会根据过滤列，排序列，join列，行数，列数进行路由 |







读少 写入也少 读写理论上同步即可 broker 是非常需要的 broker 我理解就是部门flink 程序 





1 实时导入到底需不需要（时间维度，和数据量维度）





- 列式存储
  - 压缩率高（1 数据相似 2 连续相同的数据挨着）
  - 压缩算法对不同数据类型还可以选择自己最优的
  - 查询统计,对于维度比较少的情况，只需要loadwhere条件，和需要计算的列的数据 mem消耗
  - 多磁道空间，写入对多个文件并行写入（这里是否可以设计为 一个列一个disk)虚拟化成都加高 优秀了就，每一列建立一个软链



- 索引
  - 二分查找
  - 结合磁盘属性
  - 

ClickHouse在计算层做了非常细致的工作，竭尽所能榨干硬件能力，提升查询速度。它实现了单机多核并行、分布式计算、向量化执行与SIMD指令、代码生成等多种重要技术





Merge 

Order by 最终去重

Replicaing 通过某一个列最新时间戳

CollapsingMerge: sign

VersionedCollapsingMerge: sign + version 



查询 

Replicing sql执行max最新的，且只能做模型中更新的场景，sum,avg就不是和了

CollapsingMerge: sign是正负情况，两个行抵消的情况 sum(sign*Column) 结果为0 

VersionCollapsingMerge: sign 基础上加一层 version控制，对用户使用就比较苛刻了











### Why Not Other ROLAP

我们当时主要调研了 SQL on Hadoop，ClickHouse，SnappyData，TiDB，Doris 等系统， 这些系统都是优秀的开源系统，并且都有其适用场景。我们在选型时主要从功能，架构，性能，易用性，运维成本等几个维度去考虑。

下面我先介绍下我们为什么没有选择这些系统，再介绍我们为什么选择了 Doris。

- **SQL on Hadoop 系统**：无法支持更新，性能也较差。
- **TiDB**： TiDB 虽然当初号称可以支撑 100%的 TP 和 80%的 AP，但是架构设计主要是面向 TP 场景，缺少针对 AP 场景专门的优化，所以 OLAP 查询性能较差，TiDB 团队目前正在研发专门的 OLAP 产品：TiFlash，TiFlash 具有以下特点：列存，向量化执行，MPP，而这些特点 Doris 也都有。
- **SnappyData**：SnappyData 是基于 Spark + GemFire 实现的内存数据库，机器成本较高，而我们机器资源很有限，此外 SnappyData 的计算是基于 JVM 的，会有 GC 问题，影响查询稳定性。
- **ClickHouse**：Clickhouse 是一款单机性能十分彪悍的 OLAP 系统，但是当集群加减节点后，系统不能自动感知集群拓扑变化，也不能自动 balance 数据，导致运维成本很高，此外 Clickhouse 也不支持标准 SQL，我们用户接入的成本也很高。





两年

-  clickhouse 

zookeeper 被替换 

Clickhouse 分布式 优化

raft 一致性协议 zk zab协议

Es clickhouse 存储打通

ES 集群

数据自动同步

用户使用 物化视图的优化 

sql改写

排序键 调整 

引擎核心作为基础

- 分享越来越多





依赖 metric.xml 读写分离





1. 强悍的向量化查询引擎，特殊即为性能十分有益
2. 运维方面较为复杂，面临用户管理、扩缩容、配置管理的问题



Clickhouse HA

我们实现了

```

```





域名健康检测

shard skip_unsed_replica











Clickhouse AdminServer





全局监控

配置及创建system.cluster,











机会



spark batch 

flink stream

clickhouse olap:





前面的面试 平面二级部门 谢谢

hr的联系



clickhouse doris 争议：







### Why Doris

对我们用户来说，**Doris 的优点是功能强大，易用性好**。 功能强大指可以满足我们用户的需求，易用性好主要指 **兼容 Mysql 协议和语法，以及 Online Schema Change**。 兼容 Mysql 协议和语法让用户的学习成本和开发成本很低， Online Schema Change 也是一个很吸引人的 feature，因为在业务快速发展和频繁迭代的情况下，Schema 变更会是一个高频的操作。

对我们平台侧来说，Doris 的优点是**易运维，易扩展和高可用**：

- 易运维指 Doris 无外部系统依赖，部署和配置都很简单。
- 易扩展指 Doris 可以一键加减节点，并自动均衡数据。
- 高可用值 Dors 的 FE 和 BE 都可以容忍少数节点挂掉。







- [clickhouse VS Apache Doris](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-clickhouseVSApacheDoris)
  - [1 系统架构](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-1系统架构)
    - [1.1 What is clickhouse](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-1.1Whatisclickhouse)
    - [真正的列式数据库。 没有任何内容与值一起存储。例如，支持常量长度值，以避免将它们的长度“ number”存储在值的旁边。](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-真正的列式数据库。没有任何内容与值一起存储。例如，支持常量长度值，以避免将它们的长度“number”存储在值的旁边。)
    - [1.2 What is Doris](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-1.2WhatisDoris)
  - [2 数据模型](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-2数据模型)
    - [2.1 Clickhouse聚合模型](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-2.1Clickhouse聚合模型)
    - [2.2 Doris的聚合模型](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-2.2Doris的聚合模型)
    - [2.3 Clickhouse VS Doris RollUp](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-2.3ClickhouseVSDorisRollUp)
    - [2.4 Doris的明细模型](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-2.4Doris的明细模型)
  - [3 存储引擎](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-3存储引擎)
    - [Clickhouse存储引擎：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Clickhouse存储引擎：)
    - [Doris存储引擎：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Doris存储引擎：)
  - [4 数据导入](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-4数据导入)
    - [Clickhouse数据导入：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Clickhouse数据导入：)
    - [Doris数据导入：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Doris数据导入：)
  - [5 查询](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-5查询)
    - [Clickhouse查询：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Clickhouse查询：)
    - [Doris查询：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Doris查询：)
  - [6 精确去重](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-6精确去重)
    - [Clickhouse的精确去重：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Clickhouse的精确去重：)
    - [Doris的精确去重：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Doris的精确去重：)
  - [7 元数据](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-7元数据)
    - [Clickhouse的元数据 ：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Clickhouse的元数据：)
    - [Doris的元数据：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Doris的元数据：)
  - [8 高性能](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-8高性能)
    - [Why Clickhouse Query Fast：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-WhyClickhouseQueryFast：)
    - [Why Doris Query Fast：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-WhyDorisQueryFast：)
  - [9 高可用](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-9高可用)
    - [Clickhouse高可用：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Clickhouse高可用：)
    - [Doris高可用：](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-Doris高可用：)
  - [10 可维护性](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-10可维护性)
    - [10.1 部署](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-10.1部署)
    - [10.2 运维](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-10.2运维)
  - [11 易用性](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-11易用性)
    - [11.1 查询接入](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-11.1查询接入)
    - [11.2 学习成本](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-11.2学习成本)
    - [11.3 Schema Change](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-11.3SchemaChange)
  - [12 功能](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-12功能)
  - [13 社区和生态](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-13社区和生态)
  - [14 总结](https://cf.jd.com/pages/viewpage.action?pageId=275476811#clickhousevsdoris功能对比-14总结)



# clickhouse VS Apache Doris



Clickhouse 和 Apache Doris 都是优秀的开源OLAP系统，本文将全方位地对比clickhouse和Doris。Clickhouse和Doris分别是ROLAP的代表，对比这两个系统的目的不是为了说明哪个系统更好，**只是为了明确每个系统的设计思想和架构原理，让大家可以根据自己的实际需求去选择合适的系统，也可以进一步去思考我们如何去设计出更优秀的OLAP系统**。

**注： 本文的对比基于clickhouse 19.7.0 和Apache Doris 0.9.0****。**



## **1** **系统架构**

### **1.1 What is clickhouse**

- ### *真正的列式数据库。* 没有任何内容与值一起存储。例如，支持常量长度值，以避免将它们的长度“ number”存储在值的旁边。

- *线性可扩展性。* 可以通过添加服务器来扩展集群。

- *容错性。* 系统是一个分片集群，其中每个分片都是一组副本。ClickHouse使用异步多主复制。数据写入任何可用的副本，然后分发给所有剩余的副本。Zookeeper用于协调进程，但不涉及查询处理和执行。

- *能够存储和处理数PB的数据。*

- [*SQL*](https://zh.wikipedia.org/wiki/SQL)*支持。* Clickhouse支持类似[SQL](https://zh.wikipedia.org/wiki/SQL)的扩展语言，包括数组和嵌套数据结构、近似函数和[URI](https://zh.wikipedia.org/wiki/统一资源标志符)函数，以及连接外部键值存储的可用性。

- *高性能。*[[12\]](https://zh.wikipedia.org/wiki/ClickHouse#cite_note-:2-12)

o  使用向量计算。数据不仅由列存储，而且由向量处理（一部分列）。这种方法可以实现高[CPU](https://zh.wikipedia.org/wiki/中央处理器)性能。

o  支持采样和近似计算。

o  可以进行并行和分布式查询处理（包括[JOIN](https://zh.wikipedia.org/wiki/连接)）。

- *数据压缩。*
- [*HDD*](https://zh.wikipedia.org/wiki/硬盘)*优化。* 该系统可以处理不适合[内存](https://zh.wikipedia.org/wiki/随机存取存储器)的数据。
- *用于[数据库](https://zh.wikipedia.org/wiki/数据库)（DB）连接的客户端。* 数据库连接方式包括控制台客户端、[HTTP](https://zh.wikipedia.org/wiki/HTTP) [API](https://zh.wikipedia.org/wiki/API)，或者各种编程语言。ClickHouse也可以使用JDBC驱动



### **1.2 What is Doris**

Doris是一个MPP的OLAP系统，主要整合了Google Mesa（数据模型），Apache Impala（MPP Query Engine)和Apache ORCFile (存储格式，编码和压缩) 的技术。

![img](https://cf.jd.com/download/attachments/275476811/1.jpeg?version=1&modificationDate=1585282814000&api=v2)

Doris的系统架构如下，Doris主要分为FE和BE两个组件，FE主要负责查询的编译，分发和元数据管理（基于内存，类似HDFS NN）；BE主要负责查询的执行和存储系统。

![img](https://cf.jd.com/download/attachments/275476811/2.jpeg?version=1&modificationDate=1585282888000&api=v2)

## **2** **数据模型**

### **2.1 Clickhouse****聚合模型**

聚合模型基于MergeTree

- ReplicatedSummingMergeTree

具有相同主键的行合并为一行，该行包含了被合并的行中具有数值数据类型的列的汇总值

- ReplicatedReplacingMergeTree

删除具有相同主键的重复项

数据的去重只会在合并的过程中出现。合并会在未知的时间在后台进行，因此你无法预先作出计划。有一些数据可能仍未被处理。尽管你可以调用 `OPTIMIZE` 语句发起计划外的合并，但请不要指望使用它，因为 `OPTIMIZE` 语句会引发对大量数据的读和写。



- ReplicatedAggregatingMergeTree

相同主键的所有行（在一个数据片段内）替换为单个存储一系列聚合函数状态的行。

可以使用 `AggregatingMergeTree` 表来做增量数据统计聚合，包括物化视图的数据聚合

- ReplicatedCollapsingMergeTree

异步的删除（折叠）这些除了特定列 `Sign` 有 `1` 和 `-1` 的值以外，其余所有字段的值都相等的成对的行。没有成对的行会被保留

- ReplicatedVersionedCollapsingMergeTree

为了解决CollapsingMergeTree乱序写入情况下无法正常折叠问题，VersionedCollapsingMergeTree表引擎在建表语句中新增了一列Version，用于在乱序情况下记录状态行与取消行的对应关系。主键相同，且Version相同、Sign相反的行，在Compaction时会被删除。

- ReplicatedGraphiteMergeTree



  ClickHouse通过SummingMergeTree来支持对主键列进行预先聚合。在后台Compaction时，会将主键相同的多行进行sum求和，然后使用一行数据取而代之，从而大幅度降低存储空间占用，提升聚合计算性能。

值得注意的是：

\1.    ClickHouse只在后台Compaction时才会进行数据的预先聚合，而compaction的执行时机无法预测，所以可能存在部分数据已经被预先聚合、部分数据尚未被聚合的情况。因此，在执行聚合计算时，SQL中仍需要使用GROUP BY子句。

\2.    在预先聚合时，ClickHouse会对主键列之外的其他所有列进行预聚合。如果这些列是可聚合的（比如数值类型），则直接sum；如果不可聚合（比如String类型），则随机选择一个值。

\3.    通常建议将SummingMergeTree与MergeTree配合使用，使用MergeTree来存储具体明细，使用SummingMergeTree来存储预先聚合的结果加速查询





### **2.2 Doris****的聚合模型**

Doris的聚合模型借鉴自Mesa，但本质上和Kylin的聚合模型一样，只不过Doris中将维度称作Key，指标称作Value。





Doris中比较独特的聚合函数是Replace函数，这个聚合函数能够保证相同Keys的记录只保留最新的Value，可以借助这个Replace函数来实现点更新。一般OLAP系统的数据都是只支持Append的，但是像电商中交易的退款，广告点击中的无效点击处理，都需要去更新之前写入的单条数据，在Kylin这种没有Relpace函数的系统中我们必须把包含对应更新记录的整个Segment数据全部重刷，但是有了Relpace函数，我们只需要再追加1条新的记录即可。 但是Doris中的Repalce函数有个缺点：无法支持预聚合，就是说只要你的SQL中包含了Repalce函数，即使有其他可以已经预聚合的Sum，Max指标，也必须现场计算。

为什么Doirs可以支持点更新呢？

Doris的聚合模型：就是一个Column只能有一个预聚合函数，无法设置多个预聚合函数。 不过Doris可以现场计算出其他的聚合函数。 Apache Doris的开发者Review时提到，针对这个问题，Doris还有一种解法：由于Doris支持多表导入的原子更新，所以1个Column需要多个聚合函数时，可以在Doris中建多张表，同一份数据导入时，Doris可以同时原子更新多张Doris表，缺点是多张Doris表的查询路由需要应用层来完成。

Doris中和Kylin的Cuboid等价的概念是RollUp表，Cuboid和RollUp表都可以认为是一种Materialized Views或者Index。Doris的RollUp表和Kylin的Cuboid一样，在查询时不需要显示指定，系统内部会根据查询条件进行路由。 如下图所示：



Doris中RollUp表的路由规则如下：

- 选择包含所有查询列的RollUp表
- 按照过滤和排序的Column筛选最符合的RollUp表
- 按照Join的Column筛选最符合的RollUp表
- 行数最小的
- 列数最小的





### **2.3 Clickhouse VS Doris RollUp**



|              | Doris RollUp                                     | Clickhouse                                       |
| ------------ | ------------------------------------------------ | ------------------------------------------------ |
| 定义成本     | 需要手动逐个定义                                 | 需要手动逐个定义                                 |
| 定义的灵活性 | 维度列和指标列可以自由定义                       | 维度列和指标列可以自由定义                       |
| 计算方式     | 从原始数据直接生成每个RollUp表数据               | 从原始数据直接生成每个RollUp表数据               |
| 物理存储     | 每个RollUp表是独立存储                           | 每个RollUp表是独立存储                           |
| 查询路由     | 会根据过滤列，排序列，join列，行数，列数进行路由 | 会根据过滤列，排序列，join列，行数，列数进行路由 |





### **2.4 Doris****的明细模型**

由于Doris的聚合模型存在下面的缺陷，Doris引入了明细模型。

- 必须区分维度列和指标列
- 维度列很多时，Sort的成本很高
- Count成本很高，需要读取所有维度列

Doris的明细模型不会有任何预聚合，不区分维度列和指标列，但是在建表时需要指定Sort Columns，**数据导入时会根据Sort Columns进行排序，查询时根据Sort Column过滤会比较高效**。

如下图所示，Sort Columns是Year和City。



这里需要注意一点，**Doris中一张表只能有一种数据模型**，即要么是聚合模型，要么是明细模型，而且**Roll Up表的数据模型必须和Base表一致**，也就是说明细模型的Base 表不能有聚合模型的Roll Up表。





## **3** **存储引擎**

### **Clickhouse****存储引擎：**



MergeTree表中的数据存储在“parts”中。每个部分以主键顺序存储数据（数据按主键元组的字典顺序排序）。所有表的列都存储他们的column.bin文件中。文件由压缩块组成，每个块通常是64 KB到1 MB的未压缩数据，具体取决于平均值大小。这些块由一个接一个地连续放置的列值组成，每列的列值的顺序相同（顺序由主键定义），因此当您按多列进行迭代时，您将获得相应行的值。

上图展示的birth.bin，id.bin，name.bin，point.bin这些文件中存储的就是数据文件。

主键本身是“稀疏的”。它不是针对每一行，而是针对某些范围的数据。单独的primary.idx文件具有每个第N行的主键值，其中N称为index_granularity（通常，N = 8192）。此外，对于每一列，我们都有带有“标记”的column.mrk文件，这些文件是数据文件中每个第N行的偏移量。每个标记都是一对：文件中的偏移量到压缩块的开头，以及解压缩块中的偏移量到数据的开头。通常，压缩块通过标记对齐，并且解压缩块中的偏移量为零。 primary.idx的数据始终驻留在内存中，并缓存column.mrk文件的数据。

上图展示birth.mrk, id.mrk, name.mrk, point.mrk 就是带标记的文件。

当我们要从MergeTree中的某个部分读取内容时，我们会查看primary.idx数据并查找可能包含请求数据的范围，然后查看column.mrk数据并计算从哪里开始读取这些范围的偏移量。由于稀疏性，可能会读取过多的数据。 ClickHouse不适用于高负载的简单点查询，因为必须为每个键读取具有index_granularity行的整个范围，并且必须为每列解压缩整个压缩块。我们使索引稀疏，因为我们必须能够为每个服务器维护数万亿行，而索引没有明显的内存消耗。此外，由于主键是稀疏的，因此它不是唯一的：它无法在INSERT时检查表中是否存在键。您可以在表中使用相同的键创建许多行。



**数据以压缩数据为单位，存储在bin文件中。**

**压缩数据对应的压缩数据块，严格限定按照64K~1M byte的大小来进行存储。
（1）如果一个block对应的大小小于64K，则需要找下一个block来拼凑，直到拼凑出来的大小大于等于64K。
（2）如果一个block的大小在64K到1M的范围内，则直接生成1个压缩数据块。
（3）如果一个block的大小大于了1M，则切割生成多个压缩数据块。**

**一个part下不同的列分别存储，不同的列存储的行数是一样的。**



主键是有序数据的稀疏索引。我们用图的方式看一部分的数据（原则上，图中应该保持标记的平均长度，但是用ASCI码的方式不太方便）。 mark文件，就像一把尺子一样。主键对于范围查询的过滤效率非常高。对于查询操作，CH会读取一组可能包含目标数据的mark文件。

MergeTree引擎中，默认的index_granularity(索引粒度)设置是8192；

在CH里，主键索引用的并不是B树，而是稀疏索引。

每隔8192行数据，是1个block 主键会每隔8192，取一行主键列的数据，同时记录这是第几个block 查询的时候，如果有索引，就通过索引定位到是哪个block，然后找到这个block对应的mrk文件 mrk文件里记录的是某个block的数据集，在整列bin文件的哪个物理偏移位置 加载数据到内存，之后并行化过滤 索引长度越低，索引在内存中占的长度越小，排序越快，然而区分度就越低。这样不利于查找。 索引长度越长，区分度就高，虽然利于查找了，但是索引在内存中占得空间就多了。

 

### **Doris****存储引擎：**



如上图所示，Doris的Table支持二级分区，可以先按照日期列进行一级分区，再按照指定列Hash分桶。具体来说，1个Table可以按照日期列分为多个Partition， 每个Partition可以包含多个Tablet，**Tablet是数据移动、复制等操作的最小物理存储单元**，各个Tablet之间的数据没有交集，并且在物理上独立存储。Partition 可以视为逻辑上最小的管理单元，**数据的导入与删除，仅能针对一个 Partition进行**。1个Table中Tablet的数量= Partition num * Bucket num。Tablet会按照一定大小（256M）拆分为多个Segment文件，Segment是列存的，但是会按行（1024）拆分为多个Rowblock。



下面我们来看下Doris Segment文件的具体格式，Doris文件格式主要参考了Apache ORC。如上图所示，Doris文件主要由Meta和Data两部分组成，Meta主要包括文件本身的Header，Segment Meta，Column Meta，和每个Column 数据流的元数据，每部分的具体内容大家看图即可，比较详细。Data部分主要包含每一列的Index和Data，这里的Index指每一列的Min,Max值和数据流Stream的Position；Data就是每一列具体的数据内容，Data根据不同的数据类型会用不同的Stream来存储，Present Stream代表每个Value是否是Null，Data Stream代表二进制数据流，Length Stream代表非定长数据类型的长度。下图是String使用字典编码和直接存储的Stream例子。



下面我们来看下Doris的前缀索引：



本质上，Doris 的数据存储是类似 SSTable（Sorted String Table）的数据结构。该结构是一种有序的数据结构，可以按照指定的列有序存储。在这种数据结构上，以排序列作为条件进行查找，会非常的高效。而前缀索引，即在排序的基础上，实现的一种根据给定前缀列，快速查询数据的索引方式。前缀索引文件的格式如上图所示，**索引的Key是每个Rowblock第一行记录的Sort Key的前36个字节，Value是Rowblock在Segment文件的偏移量**。

有了前缀索引后，我们查询特定Key的过程就是两次二分查找：

- 先加载Index文件，二分查找Index文件获取包含特定Key的Row blocks的Offest,然后从Sement Files中获取指定的Rowblock；
- 在Rowblocks中二分查找特定的Key

## **4** **数据导入**

### **Clickhouse****数据导入：**





### **Doris****数据导入：**



Doris 数据导入的两个核心阶段是ETL和LOADING, ETL阶段主要完成以下工作：

- 数据类型和格式的校验
- 根据Tablet拆分数据
- 按照Key列进行排序, 对Value进行聚合

LOADING阶段主要完成以下工作：

- 每个Tablet对应的BE拉取排序好的数据
- 进行数据的格式转换，生成索引

LOADING完成后会进行元数据的更新。



































## **5** **查询**



### **![img](https://cf.jd.com/download/thumbnails/275476811/image2020-3-27_12-15-28.png?version=1&modificationDate=1585282528000&api=v2) Clickhouse****查询：**







前面说过，ClickHouse集群的每一个ClickHouse实例都知道完整的集群拓扑结构(每一个ClickHouse实例上都有一个Distibute引擎实例)，所以客户端可以接入任何一个ClickHouse实例，进行分发表数据读取

在all表上读数据时CH数据流程如下：

1.分发SQL到对应多个shard上执行SQL。

(Distribute引擎会选择每个分发到的Shard中的”健康的”副本执行SQL)

(所谓健康的广义上来说就是存货的，当前负载小的)

2.执行SQL后的数据的中间结果发送到主server上

(主Server就是接受到客户端查询命令的那台ClickHouse实例)

3.数据再次汇总过滤，然后返回给客户端







### **Doris****查询：**

![img](https://cf.jd.com/download/attachments/275476811/image2020-3-27_12-17-44.png?version=1&modificationDate=1585282665000&api=v2)

Doris的查询引擎使用的是Impala，是MPP架构。Doris的FE 主要负责SQL的解析，语法分析，查询计划的生成和优化。查询计划的生成主要分为两步：

- 生成单节点查询计划 （上图左下角）
- 将单节点的查询计划分布式化，生成PlanFragment（上图右半部分）

第一步主要包括Plan Tree的生成，谓词下推， Table Partitions pruning，Column projections，Cost-based优化等；第二步 将单节点的查询计划分布式化，分布式化的目标是**最小化数据移动和最大化本地Scan**，分布式化的方法是增加ExchangeNode，执行计划树会以ExchangeNode为边界拆分为PlanFragment，1个PlanFragment封装了在一台机器上对同一数据集的部分PlanTree。如上图所示：各个Fragment的数据流转和最终的结果发送依赖：DataSink。

当FE生成好查询计划树后，BE对应的各种Plan Node（Scan, Join, Union, Aggregation, Sort等）执行自己负责的操作即可。

## **6** **精确去重**

### **Clickhouse****的精确去重：**

Clickhouse的精确去重是基于ReplacingMergeTree实现的基于预计算的精确去重。

### **Doris****的精确去重：**

Doris的精确去重是现场精确去重，Doris计算精确去重时会拆分为两步：

- 按照所有的group by 字段和精确去重的字段进行聚合
- 按照所有的group by 字段进行聚合

SELECT a, COUNT(DISTINCT b, c), MIN(d), COUNT(*) FROM T GROUP BY a

\* - 1st phase grouping exprs: a, b, c

\* - 1st phase agg exprs: MIN(d), COUNT(*)

\* - 2nd phase grouping exprs: a

\* - 2nd phase agg exprs: COUNT(*), MIN(<MIN(d) from 1st phase>), SUM(<COUNT(*) from 1st phase>)

下面是个简单的等价转换的例子：

select count(distinct lo_ordtotalprice) from ssb_sf20.v2_lineorder;



select count(*) from (select count(*) from ssb_sf20.v2_lineorder group by lo_ordtotalprice) a;

Doris现场精确去重计算性能和**去重列的基数**、**去重指标个数**、**过滤后的数据大小**成**负相关**；

## **7** **元数据**

### **Clickhouse****的元数据** ：

Clickhouse的元数据是利用zookeeper存储的，可以很好地横向扩展。同时基于内存缓存。





### **Doris****的元数据**：

Doris的元数据是基于内存的，这样做的好处是性能很好且不需要额外的系统依赖。 缺点是单机的内存是有限的，扩展能力受限，但是根据Doris开发者的反馈，由于Doris本身的元数据不多，所以元数据本身占用的内存不是很多，目前用大内存的物理机，应该可以支撑数百台机器的OLAP集群。 此外，OLAP系统和HDFS这种分布式存储系统不一样，我们部署多个集群的运维成本和1个集群区别不大。

关于Doris元数据的具体原理大家可以参考Doris官方文档Doris 元数据设计文档

## **8** **高性能**

### **Why Clickhouse Query Fast****：**



l **数据压缩：**在一些列式数据库管理系统中(例如：InfiniDB CE 和 MonetDB) 并没有使用数据压缩。但是, 若想达到比较优异的性能，数据压缩确实起到了至关重要的作用。

l **多核心并行处理：**ClickHouse会使用服务器上一切可用的资源，从而以最自然的方式并行处理大型查询。

l **多服务器分布式处理[:](https://clickhouse.tech/docs/zh/introduction/distinctive_features/#duo-fu-wu-qi-fen-bu-shi-chu-li)**上面提到的列式数据库管理系统中，几乎没有一个支持分布式的查询处理。
在ClickHouse中，数据可以保存在不同的shard上，每一个shard都由一组用于容错的replica组成，查询可以并行地在所有shard上进行处理。这些对用户来说是透明的

l **向量引擎[:](https://clickhouse.tech/docs/zh/introduction/distinctive_features/#xiang-liang-yin-qing)**为了高效的使用CPU，数据不仅仅按列存储，同时还按向量(列的一部分)进行处理，这样可以更加高效地使用CPU。

l 列式存储+**索引:**按照主键对数据进行排序，这将帮助ClickHouse在几十毫秒以内完成对数据特定值或范围的查找。









### **Why Doris Query Fast****：**

l In-Memory Metadata。 Doris的元数据就在内存中，元数据访问速度很快。

l 聚合模型可以在数据导入时进行预聚合。

l 和Kylin一样，也支持预计算的RollUp Table。

l MPP的查询引擎。

l 向量化执行。 相比Kylin中Calcite的代码生成，向量化执行在处理高并发的低延迟查询时性能更好，**Kylin的代码生成本身可能会花费几十ms甚至几百ms**。

l 列式存储 + 前缀索引。

## **9** **高可用**

### **Clickhouse****高可用：**



**Zookeeper****的高可用**：

**Clickhouse** **引擎的高可用：通过多副本，**



### **Doris****高可用：**



**Doris FE****的高可用**： Doris FE的高可用主要基于BerkeleyDB java version实现，BDB-JE实现了**类Paxos一致性协议算法**。

**Doris BE****的高可用：** Doris会保证每个Tablet的多个副本分配到不同的BE上，所以一个BE down掉，不会影响查询的可用性。

## **10** **可维护性**

### **10.1** **部署**

**Clickhouse****部署**：直接部署Clickhouse 运行程序和zookeeper。

**Doris****部署**： 直接部署FE和BE组件即可。

### **10.2** **运维**

**clickhouse****运维：** 只需要理解和掌握系统本身即可。

**Doris****运维：** Doris只需要理解和掌握系统本身即可。

**10.3** **客服**

**Clickhouse****客服：**需要教会分布式表和ReplicatedMergeTree引擎；

**Doris** **客服：** 需要教会用户聚合模型，明细模型，前缀索引，RollUp表这些概念。

## **11** **易用性**

### **11.1** **查询接入**

**Clickhouse****查询接入**：Clickhouse支持Mysql协议、Htpp,JDBC种查询方式。

**Doris****查询接入：** Doris支持Mysql协议，现有的大量Mysql工具都可以直接使用，用户的学习和迁移成本较低。

### **11.2** **学习成本**

**Clickhouse****学习成本**：用户需要理解分布式表和ReplicatedMergeTree引擎，学习成本低。

**Doris****学习成本**：用户需要理解聚合模型，明细模型，前缀索引，RollUp表这些概念。

### **11.3 Schema Change**

Schema在线变更是一个十分重要的feature，因为在实际业务中，Schema的变更会十分频繁。

**Clickhouse Schema Change**：Clickhouse支持Online Schema Change。

**Doris Schema Change**：Doris支持Online Schema Change。

所谓的Schema在线变更就是指**Scheme的变更不会影响数据的正常导入和查询**，Doris中的Schema在线变更有3种：

- direct schema change： 就是重刷全量数据，成本最高，和kylin的做法类似。 当修改列的类型，稀疏索引中加一列时需要按照这种方法进行。
- sorted schema change: 改变了列的排序方式，需对数据进行重新排序。 例如删除排序列中的一列, 字段重排序。
- linked schema change: 无需转换数据，直接完成。 对于历史数据不会重刷，新摄入的数据都按照新的Schema处理，对于旧数据，新加列的值直接用对应数据类型的默认值填充。 例如加列操作。 Druid也支持这种做法。

## **12** **功能**



| 功能                     | Clickhouse | Doris  |
| ------------------------ | ---------- | ------ |
| 标准SQL                  | 支持       | 支持   |
| Mysql 协议               | 支持       | 支持   |
| 离线导入                 | 支持       | 支持   |
| 实时导入                 | 支持       | 支持   |
| 聚合查询                 | 支持       | 支持   |
| 明细查询                 | 支持       | 支持   |
| Adhoc查询                | 支持       | 支持   |
| 点更新                   | 支持       | 支持   |
| 高并发，低延迟的精准去重 | 不支持     | 不支持 |



注：虽然Doirs理论上可以同时支持高并发，低延迟的OLAP查询和高吞吐的Adhoc查询，但显然这两类查询会相互影响。所以Baidu在实际应用中也是用两个集群分别满足OLAP查询和Adhoc查询需求。

## **13** **社区和生态**

Doris社区刚刚起步，目前核心用户只有Baidu；

clickhouse的社区和生态已经比较成熟，目前已经在多家大型公司的生产环境中使用。





为了支持高并发、高可用、低延迟



目前还没有一个OLAP系统能够满足各种场景的查询需求。 其本质原因是， 没有一个系统能同时在数据量、性能、和灵活性三个方面做到完美， 每个系统在设计时都需要在这三者间做出取舍。 这个就有点像我们的CAP理论了~~~



1. clickhouse 多列存储，会出现，并发多个文件的写入，这个不太好
2. 这点满足CAP定理（**任何分布式系统在可用性、一致性、分区容错性方面，不能兼得，最多只能得其二**） 需要用户根据具体使用场景平衡一下
3. 查询性能、易用性和使用时的灵活性角度出发，Palo的表现非常优秀，当然由于Palo刚开源还是会存在一些问题，比如监控工具还不太完善，没有方便的后台管理界面，
4. ck join 差



