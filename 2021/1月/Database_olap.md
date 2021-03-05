



## ***OLTP和OLAP的区别\***

***参考：\***

从大数据谈起1：OLTP和OLAP的设计区别

[从大数据谈起2：分片和分层-GavinGuo-51CTO博客](https://link.zhihu.com/?target=http%3A//blog.51cto.com/guolingyu/1189390)

**联机事务处理OLTP（On-line Transaction Processing）**

**联机分析处理OLAP（On-Line Analytical Processing）**



**多维分析中的常用操作：**

下面介绍数据立方体中最常见的五大操作：切片，切块，旋转，上卷，下钻。

![img](https://pic4.zhimg.com/80/v2-ad261bc2d128ee5ed62146290c9e0763_1440w.jpg)



下钻（Drill-down）：在维的不同层次间的变化，从上层降到下一层，或者说是将汇总数据拆分到更细节的数据，比如通过对2010年第二季度的总销售数据进行钻取来查看2010年第二季度4、5、6每个月的消费数据，如上图；当然也可以钻取浙江省来查看杭州市、宁波市、温州市……这些城市的销售数据。

上卷（Roll-up）：钻取的逆操作，即从细粒度数据向高层的聚合，如将江苏省、上海市和浙江省的销售数据进行汇总来查看江浙沪地区的销售数据，如上图。

切片（Slice）：选择维中特定的值进行分析，比如只选择电子产品的销售数据，或者2010年第二季度的数据。

切块（Dice）：选择维中特定区间的数据或者某批特定值进行分析，比如选择2010年第一季度到2010年第二季度的销售数据，或者是电子产品和日用品的销售数据。

旋转（Pivot）：即维的位置的互换，就像是二维表的行列转换，如图中通过旋转实现产品维和地域维的互换。



在调研了市面上主流的开源OLAP引擎后发现，目前还没有一个系统能够满足各种场景的查询需求。其本质原因是，没有一个系统能同时在数据量、性能、和灵活性三个方面做到完美，每个系统在设计时都需要在这三者间做出取舍。

![img](https://pic2.zhimg.com/80/v2-12268959c89202c2c810c2df53a01271_1440w.jpg)





cap



一致性

可用性

容忍性



数据量

性能

灵活





例如:

MPP架构的系统（Presto/Impala/SparkSQL/Drill等）有很好的数据量和灵活性支持，但是对响应时间是没有保证的。**当数据量和计算复杂度增加后，响应时间会变慢**，从秒级到分钟级，甚至小时级都有可能。

> MPP即大规模并行处理（Massively Parallel Processor ）。 在数据库非共享集群中，每个节点都有独立的磁盘存储系统和内存系统，业务数据根据数据库模型和应用特点划分到各个节点上，每台数据节点通过专用网络或者商业通用网络互相连接，彼此协同计算，作为整体提供数据 库服务。非共享数据库集群有完全的可伸缩性、高可用、高性能、优秀的性价比、资源共享等优势。

缺点：性能不稳定

搜索引擎架构的系统（Elasticsearch等）相对比MPP系统，在入库时将数据转换为倒排索引，采用Scatter-Gather计算模型，牺牲了灵活性换取很好的性能，在搜索类查询上能做到亚秒级响应。**但是对于扫描聚合为主的查询，随着处理数据量的增加**，响应时间也会退化到分钟级。
缺点：性能不稳定

预计算系统（Druid/Kylin等）则在入库时对数据进行预聚合，进一步牺牲灵活性换取性能，以实现对超大数据集的秒级响应。
缺点：不太灵活

MPP和搜索引擎系统无法满足超大数据集下的性能要求，因此很自然地会考虑预计算系统。而Druid主要面向的是实时Timeseries数据，我们虽然也有类似的场景，但主流的分析还是面向数仓中按天生产的结构化表，因此Kylin的MOLAP Cube方案是最适合作为大数据量时候的引擎。





下面列举了三个olap系统

## **ImPala**

![img](https://pic3.zhimg.com/80/v2-01195139f28a6556aca10838f4e051ca_1440w.jpg)



## **Druid**

![img](https://pic2.zhimg.com/80/v2-ac109cb17d281bc562d8ec99e9eca42d_1440w.jpg)

Druid是广告分析公司Metamarkets开发的一个用于大数据实时查询和分析的分布式实时处理系统，主要用于广告分析，互联网广告系统监控、度量和网络监控。

特点：

\1. 快速的交互式查询——Druid的低延迟数据摄取架构允许事件在它们创建后毫秒内可被查询到。

\2. 高可用性——Druid的数据在系统更新时依然可用，规模的扩大和缩小都不会造成数据丢失；

\3. 可扩展——Druid已实现每天能够处理数十亿事件和TB级数据。

\4. 为分析而设计——Druid是为OLAP工作流的探索性分析而构建，它支持各种过滤、聚合和查询。

应用场景：

\1. 需要实时查询分析时；

\2. 具有大量数据时，如每天数亿事件的新增、每天数10T数据的增加；

\3. 需要一个高可用、高容错、高性能数据库时。

\4. 需要交互式聚合和快速探究大量数据时

架构图：

Druid官网 [Druid | About Druid](https://link.zhihu.com/?target=http%3A//druid.io/druid.html)

Druid：一个用于大数据实时处理的开源分布式系统



## **Presto**

![img](https://pic4.zhimg.com/80/v2-53beb643399eb77385ed17bdef8106eb_1440w.jpg)

Presto是Facebook开发的分布式大数据SQL查询引擎，专门进行快速数据分析。

特点：

\1. 可以将多个数据源的数据进行合并，可以跨越整个组织进行分析。

\2. 直接从HDFS读取数据，在使用前不需要大量的ETL操作。

查询原理：

\1. 完全基于内存的并行计算

\2. 流水线

\3. 本地化计算

\4. 动态编译执行计划

\5. 小心使用内存和数据结构

\6. 类BlinkDB的近似查询

\7. GC控制





Kylin



![img](https://pic1.zhimg.com/80/v2-d352662b79b771a5ee2c91d4c9a66db0_1440w.jpg)



Apache Kylin最初由eBay开发并贡献至开源社区的分布式分析引擎，提供

Hadoop之上的SQL查询接口及多维分析（OLAP）能力以支持超大规模数据。

特点:

\1. 用户为百亿以上数据集定义数据模型并构建立方体

\2. 亚秒级的查询速度，同时支持高并发

\3. 为Hadoop提供标准SQL支持大部分查询功能

\4. 提供与BI工具，如Tableau的整合能力

\5. 友好的web界面以管理，监控和使用立方体

\6. 项目及立方体级别的访问控制安全











# 大数据OLAP常用的技术

- 大规模并行处理： 可以通过增加机器的方式来扩容处理速度， 在相同的时间里处理更多的数据。
- 列式存储： 通过按列存储提高单位时间里数据的I/O吞吐率， 还能跳过不需要访问的列。
- 索引： 利用索引配合查询条件， 可以迅速跳过不符合条件的数据块， 仅扫描需要扫描的数据内容。
- 压缩： 压缩数据然后存储， 使得存储的密度更高， 在有限的I/O速率下，在单位时间里读取更多的记录。

以上是在大数据处理方面常用的四种技术原理， 上面这些处理数据的方式极大程度的提高了单位时间内数据处理的能力， 但是其还是没有摆脱数据量和查询时间的线性关系。 于是在OLAP处理方式上， 我们多了一种：

- 维度聚合，预计算 该方式是通过预先组合好的维度， 来离线预计算需要处理的数据， 这样就可以实现在实时查询的实时响应， 并且数据量只和组合的维度有关系， 而不再受限于数据的体量。 但是该方式也有其自身的劣势， 那就是不够灵活， 超出预计算的维度将无法再被实时响应。

目前还没有一个OLAP系统能够满足各种场景的查询需求。 其本质原因是， 没有一个系统能同时在数据量、性能、和灵活性三个方面做到完美， 每个系统在设计时都需要在这三者间做出取舍。 这个就有点像我们的CAP理论了~~~

这点满足CAP定理（**任何分布式系统在可用性、一致性、分区容错性方面，不能兼得，最多只能得其二**） 需要用户根据具体使用场景平衡一下









![image](https://ask.qcloudimg.com/http-save/yehe-4501479/qslkyon0sz.png?imageView2/2/w/1620)

![img](https://picb.zhimg.com/80/67eecf7262927f728dd1c00aa9e0fe46_720w.png)

- 数据组织方式 传统OLAP根据数据存储组织方式的不同分为 ROLAP（relational olap）以及 MOLAP（multi-dimension olap） 
  - ROLAP 传统数据库 以关系模型的方式存储用作多维分析用的数据， 优点在于存储体积小，查询方式灵活， 然而缺点也显而易见，每次查询都需要对数据进行聚合计算， 为了改善短板，ROLAP使用了列存、并行查询、查询优化、位图索引等技术。
  - MOLAP  kylin 将分析用的数据物理上存储为多维数组的形式， 形成CUBE结构。维度的属性值映射成多维数组的下标或者下标范围， 事实以多维数组的值存储在数组单元中，优势是查询快速， 缺点是数据量不容易控制，可能会出现维度爆炸的问题。
- rolap 灵活。数据没有预聚合 relational 
- molap 查询块。数据量翻倍 multi-dimension
- holap : rolap + molap 多维数据集的技术



Mpp: 灵活、实时导入和分析。内存，量大会影响性能

预计算：不灵活、稳定、体量增大不影响查询，影响存储



ck vs doris :不同天相同的数据，很可能在不同的机器上，clickhouse 不同天，相同的数据，肯定在一台机器上



并行计算，减少节点之间数据的传输

快速计算 count distinct 



我们分析后得出结论，实际上 ClickHouse 把 ZK 当成了三种服务的结合，而不仅把它当作一个 Coordinate service，可能这也是大家使用 ZK 的常用用法。ClickHouse 还会把它当作 Log Service，很多行为日志等数字的信息也会存在 ZK 上；还会作为表的 catalog service，像表的一些 schema 信息也会在 ZK 上做校验，这就会导致 ZK 上接入的数量与数据总量会成线性关系。按照这样的数据增长预估，ClickHouse 可能就根本无法支撑头条抖音的全量需求。







# 目前市面上常用的OLAP框架

-  基于MPP (Massively Parallel Processing) 和 ROLAP 
   - Presto Presto 是由 Facebook 开源的大数据分布式 SQL 查询引擎， 适用于交互式分析查询，可支持众多的数据源，包括 HDFS，RDBMS，KAFKA 等， 而且提供了非常友好的接口开发数据源连接器。 Presto支持标准的ANSI SQL， 包括复杂查询、聚合（aggregation）、连接（join）和窗口函数（window functions)。 Presto 本身并不存储数据，但是可以接入多种数据源， 并且支持跨数据源的级联查询。
   - clickHouse ClickHouse是一个开源的面向列基于MPP的数据库管理系统， 能够使用SQL 查询实时生成分析数据报告。
   - Impala Impala也是一个SQL on Hadoop的查询工具， 底层采用MPP技术，支持快速交互式SQL查询。 与Hive共享元数据存储。
   - SparkSQL SparkSQL的前身是Shark， 它将 SQL 查询与 Spark 程序无缝集成, 可以将结构化数据作为 Spark 的 RDD 进行查询。 SparkSQL作为Spark生态的一员继续发展， 而不再受限于Hive，只是兼容Hive。
   - HAWQ Hawq是一个Hadoop原生大规模并行SQL分析引擎， Hawq采用 MPP 架构， 改进了针对 Hadoop 的基于成本的查询优化器。 除了能高效处理本身的内部数据， 还可通过 PXF 访问 HDFS、Hive、[HBase](https://cloud.tencent.com/product/hbase?from=10680)、JSON 等外部数据源。
   - Greenplum Greenplum是一个开源的大规模并行数据分析引擎。 借助MPP架构，在大型数据集上执行复杂SQL分析的速度比很多解决方案都要快。 GPDB完全支持ANSI SQL 2008标准和SQL OLAP 2003 扩展； 从应用编程接口上讲，它支持ODBC和JDBC。 完善的标准支持使得系统开发、维护和管理都大为方便。 支持分布式事务，支持ACID。 保证数据的强一致性。 做为分布式数据库，拥有良好的线性扩展能力。 GPDB有完善的生态系统，可以与很多企业级产品集成， 譬如SAS，Cognos，Informatic，Tableau等； 也可以很多种开源软件集成，譬如Pentaho,Talend 等。 Greenplum基于Postgresql 
-  基于预计算的 和 MOLAP 
   - kylin Kylin自身就是一个MOLAP系统， 多维立方体（MOLAP Cube）的设计， 使得用户能够在Kylin里为百亿以上数据集定义数据模型， 并构建立方体进行数据的预聚合。 并提供ANSI-SQL接口交互式查询能力
   - Druid Druid 是一种能对历史和实时数据提供亚秒级别的查询的数据存储。 Druid 支持低延时的数据摄取，灵活的数据探索分析， 高性能的数据聚合，简便的水平扩展。 适用于数据量大，可扩展能力要求高的分析型查询系统。 Druid解决的问题包括：数据的快速摄入和数据的快速查询。 Druid保证数据实时写入，但查询上对SQL支持的不够完善 
-  MPP 和 预计算的 方式差异： MPP非常灵活， 其数据是基于数据表的分析， 支持数据实时导入实时分析， 并且可以查询任意想要查询的数据。 但是其缺点也很明显， 内存资源需求大， MPP的OLAP一般都是基于内存的， 所以对于机器内存要求很大， 对于过大的数据量，会极大的影响性能. 基于预计算的方式， 则略微显得不太灵活， 无法查询预计算外的数据， 但是其优点是相对稳定， 数据量的增大不会对查询速度造成很大的影响， 其需要的存储空间也不会随着数据量增大而膨胀。

![img](https://ask.qcloudimg.com/http-save/yehe-4501479/5a8kaehuj8.png?imageView2/2/w/1620)

image.png

# OLAP测评报告

前两份主要是针对基于MPP方式的OLAP框架的测评，

1. [HAWQ、Presto、ClickHouse](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.jiqizhixin.com%2Farticles%2F2020-01-20-3) HAWQ 性能大部分情况下是低于 Presto和 ClickHouse， 而Presto的速度比较依赖网络，因为其本身并不具备存储数据的功能， ClickHouse目前是MPP速度最快的引擎，不过其在多表查询上性能也并不好。
2. [Hive Hawq、Presto、Impala、Sparksql、Clickhouse、Greenplum](https://links.jianshu.com/go?to=https%3A%2F%2Fmp.weixin.qq.com%2Fs%3F__biz%3DMjM5OTExMjkwMA%3D%3D%26mid%3D2651896181%26idx%3D2%26sn%3D6047773711f7e88494f074f3740ca594%26chksm%3Dbd2460de8a53e9c8e46d491efe6d3e6311aabfb9c1dca3ab1f260c5cff3b74ce203e7a828eb3%26mpshare%3D1%26scene%3D1%26srcid%3D0228qP2jV2zqrCnebZ2YShbR%26sharer_sharetime%3D1582852934670%26sharer_shareid%3D48897b67a0d66ecd765c7429fcb0e970%26key%3D1dacc203a44a05e9c68ab8131fee8868f69fdde3c3daf82522ad8957a27a25c1db8ac49df8c480fc588ebb938d9a0404b80c63ea28db101eaa394c985a3e97bb96b64ec99d8aacaad9edd880bee582f0%26ascene%3D1%26uin%3DMTQwMTQ2MTkyNA%3D%3D%26devicetype%3DWindows%2B10%26version%3D62080079%26lang%3Dzh_CN%26exportkey%3DATnuPtjzvM7vjdi%2Bj%2FPZkic%3D%26pass_ticket%3DxPKD17dSD3%2BBUGQHgtFNmD6DffmiY5Y%2F1ee3aSvxtFHSsZ47LARQkHgiH6Ur%2FHS4)     

![img](https://ask.qcloudimg.com/http-save/yehe-4501479/4xm6ucv5mh.png?imageView2/2/w/1620)

  image.png   

1.  [kylin presto druid](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.infoq.cn%2Farticle%2Fkylin-apache-in-meituan-olap-scenarios-practice) 这是美团16年初的报告， 时间比较久远， 不具备太大的参考意义， 不过大致也表明 kylin和druid 在速度响应上是要更快的。 而Kylin提供了更加完善的功能和SQL支持， Druid则提供了数据实时摄入， 二者在查询性能上基本是一个量级     

![img](https://ask.qcloudimg.com/http-save/yehe-4501479/r5ryqv4bb6.png?imageView2/2/w/1620)

  image.png  



# 总结

MPP虽然看起来是更好的选择， 但是因为其是基于内存计算的， 会相对的比较不太稳定， 比如遇到`数据倾斜导致内存崩溃`， 又比如数据量的大小改变， 和查询语句的不同， 都可能导致查询时间的起伏， 也许很快，但也可能会出现半天出不来数据的情况

预计算则相对的放弃了灵活的查询， 但是却节省了大量的内存计算带来的开销， 而且因为是属于预计算范畴， 对于不支持的数据那就是不支持， 但是对于支持的查询则是可以达到一个比较稳定的查询速度，

对于稳定的天级任务， 我们完全可以使用预计算的方式， 而对于一些类似偶尔的临时任务， 那么可以通过MPP的方式进行导出， 没有必要为了一些特殊的需求而加大机器资源的开销。

而在基于预计算的框架， 我更趋向于kylin， 因为他可以更好的管理数据， 具有更好的SQL支持， 并且其社区在国内比较活跃， 然后有中文文档~~~~~

还有一点就是，现在很多培训机构已经把kylin拉上课程安排了...







SQL

1. create db 

```mysql
CREATE DATABASE IF NOT EXISTS dbname ON CLUSTER CLUSTERNAME;
```



2. create replicated table 

```mysql
CREATE TABLE jason.table_test_local on cluster KC0_CK_TS_01
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ***ReplicatedMergeTree('/clickhouse/KC0_CK_TS_01/jdob_ha/jason/table_test_local/{shard}', '{replica}')
PARTITION BY toYYYYMMDD(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha';
```

- 注意
  - 模型的选择
  - 路径的设置 /clickhouse/CLUSTERNAME/jdob_ha/DATABAE/TABLE/{shard},{replica} 这个是表在zk的存储，信息，唯一性需要，已经存在是会报错
  - Storage_policy ='job_ha'; 这个是我们对数据设置的存储厕率



3. create distributed table 

```
CREATE TABLE jason.table_test on cluster KC0_CK_TS_01
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = Distributed(KC0_CK_TS_01, jason, table_test_local, ***;
```

- Distributed 参数
  - KC0_CK_TS_01 ， clustername
  - jason , dbname
  - table_test_local, 执行本地表replicatena me

