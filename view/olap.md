## 1. 什么是OLAP

![img](https://pic1.zhimg.com/80/v2-b1ee7e53f2515a2e32afb36e433a97e4_1440w.jpg)

**OLAP（On-line Analytical Processing，联机分析处理）**是在基于数据仓库多维模型的基础上实现的面向分析的各类操作的集合。可以比较下其与传统的OLTP（On-line Transaction Processing，联机事务处理）的区别来看一下它的特点：

![img](https://pic2.zhimg.com/80/v2-8e3be54f77bda1a1bf8561dab1127f35_1440w.jpg)

OLAP的优势是基于数据仓库面向主题、集成的、保留历史及不可变更的数据存储，以及多维模型多视角多层次的数据组织形式，如果脱离的这两点，OLAP将不复存在，也就没有优势可言。

参考：[http://webdataanalysis.net/web-data-warehouse/data-cube-and-olap/](https://link.zhihu.com/?target=http%3A//webdataanalysis.net/web-data-warehouse/data-cube-and-olap/)



伸缩性 balance

稳定性 raft service





## 2. OLAP引擎的常见操作

![img](https://pic3.zhimg.com/80/v2-a2f230439e14cff33fa744f4e07c0646_1440w.jpg)

下面所述几种OLAP操作，是针对Kimball的星型模型（Star Schema）和雪花模型（Snowflake Schema）来说的。在Kimball模型中，定义了事实和维度。可以参考：[http://webdataanalysis.net/web-data-warehouse/multidimensional-data-model/](https://link.zhihu.com/?target=http%3A//webdataanalysis.net/web-data-warehouse/multidimensional-data-model/)

- 上卷（Roll Up）/聚合：选定某些维度，根据这些维度来聚合事实，如果用SQL来表达就是select dim_a, aggs_func(fact_b) from fact_table group by dim_a.
- 下钻（Drill Down）：上卷和下钻是相反的操作。它是选定某些维度，将这些维度拆解出小的维度（如年拆解为月，省份拆解为城市），之后聚合事实。
- 切片（Slicing、Dicing）：选定某些维度，并根据特定值过滤这些维度的值，将原来的大Cube切成小cube。如dim_a in ('CN', 'USA')
- 旋转（Pivot/Rotate）：维度位置的互换。

下图举了一个具体的例子：

![img](https://pic3.zhimg.com/80/v2-8e425f14e379a909fc37c8c81fa1949e_1440w.jpg)

图片来自：[http://webdataanalysis.net/web-data-warehouse/data-cube-and-olap/](https://link.zhihu.com/?target=http%3A//webdataanalysis.net/web-data-warehouse/data-cube-and-olap/)



## 3. OLAP分类

![img](https://pic1.zhimg.com/80/v2-ed01a4d8a44b049052fe94b9b54d08c8_1440w.jpg)

OLAP 是一种让用户可以用从不同视角方便快捷的分析数据的计算方法。主流的 OLAP 可以分为3类：多维 OLAP ( Multi-dimensional OLAP )、关系型 OLAP ( Relational OLAP ) 和混合 OLAP ( Hybrid OLAP ) 三大类。

- **MOLAP 的优点和缺点**

MOLAP的典型代表是：Druid，Kylin，Doris，MOLAP一般会根据用户定义的数据维度、度量（也可以叫指标）在数据写入时生成预聚合数据；Query查询到来时，实际上查询的是预聚合的数据而不是原始明细数据，在查询模式相对固定的场景中，这种优化提速很明显。

MOLAP 的优点和缺点都来自于其数据预处理 ( pre-processing ) 环节。数据预处理，将原始数据按照指定的计算规则预先做聚合计算，这样避免了查询过程中出现大量的即使计算，提升了查询性能。

但是这样的预聚合处理，需要预先定义维度，会限制后期数据查询的灵活性；如果查询工作涉及新的指标，需要重新增加预处理流程，损失了灵活度，存储成本也很高；同时，这种方式不支持明细数据的查询，仅适用于聚合型查询（如：sum，avg，count）。

因此，MOLAP 适用于查询场景相对固定并且对查询性能要求非常高的场景。如广告主经常使用的广告投放报表分析。

- **ROLAP 的优点和缺点**

ROLAP的典型代表是：Presto，Impala，GreenPlum，Clickhouse，Elasticsearch，Hive，Spark SQL，Flink SQL

数据写入时，ROLAP并未使用像MOLAP那样的预聚合技术；ROLAP收到Query请求时，会先解析Query，生成执行计划，扫描数据，执行关系型算子，在原始数据上做过滤(Where)、聚合(Sum, Avg, Count)、关联(Join)，分组（Group By)、排序（Order By）等，最后将结算结果返回给用户，整个过程都是即时计算，没有预先聚合好的数据可供优化查询速度，拼的都是资源和算力的大小。

ROLAP 不需要进行数据预处理 ( pre-processing )，因此查询灵活，可扩展性好。这类引擎使用 MPP 架构 ( 与Hadoop相似的大型并行处理架构，可以通过扩大并发来增加计算资源 )，可以高效处理大量数据。

但是当数据量较大或 query 较为复杂时，查询性能也无法像 MOLAP 那样稳定。所有计算都是即时触发 ( 没有预处理 )，因此会耗费更多的计算资源，带来潜在的重复计算。

因此，ROLAP 适用于对查询模式不固定、查询灵活性要求高的场景。如数据分析师常用的数据分析类产品，他们往往会对数据做各种预先不能确定的分析，所以需要更高的查询灵活性。

- **混合 OLAP ( HOLAP )**

混合 OLAP，是 MOLAP 和 ROLAP 的一种融合。当查询聚合性数据的时候，使用MOLAP 技术；当查询明细数据时，使用 ROLAP 技术。在给定使用场景的前提下，以达到查询性能的最优化。

顺便提一下，国内外有一些闭源的商业OLAP引擎，没有在这里归类和介绍，主要是因为使用的公司不多并且源码不可见、资料少，很难分析学习其中的源码和技术点。在一二线的互联网公司中，应用较为广泛的还是上面提到的各种OLAP引擎，如果你希望能够通过掌握一种OLAP技术，学习这些就够了。

## 4. OLAP引擎的对比

我们花一些篇幅来介绍和对比一下目前大数据业内非常流行的几个OLAP引擎，它们是Hive、SparkSQL、FlinkSQL、Clickhouse、Elasticsearch、Druid、Kylin、Presto、Impala、Doris。可以说目前没有一个引擎能在数据量，灵活程度和性能上做到完美，用户需要根据自己的需求进行选型。

**4.1 并发能力与查询延迟对比**

这里可能有朋友有疑问：Hive，SparkSQL，FlinkSQL这些它们要么查询速度慢，要么QPS上不去，怎么能算是OLAP引擎呢？其实OLAP的定义中并没有关于查询执行速度和QPS的限定。进一步来说，这里引出了衡量OLAP特定业务场景的两个重要的指标：

- 查询速度：Search Latency（常用Search Latency Pct99来衡量）
- 查询并发能力：QPS

如果根据不同的查询场景、再按照查询速度与查询并发能力这两个指标来划分以上所列的OLAP引擎，这些OLAP引擎的能力划分如下：

- 场景一：简单查询

简单查询指的是点查、简单聚合查询或者数据查询能够命中索引或物化视图（物化视图指的是物化的查询中间结果，如预聚合数据）。这样的查询经常出现在【在线数据服务】的企业应用中，如阿里生意参谋、腾讯的广点通、京东的广告业务等，它们共同的特点是对外服务、面向B端商业客户（通常是几十万的级别）；并发查询量(QPS)大；对响应时间要求高，一般是ms级别（可以想象一下，如果广告主查询页面投放数据，如果10s还没有结果，很伤害体验）；查询模式相对固定且简单。从下图可知，这种场景最合适的是Elasticsearch、Doris、Druid、Kylin这些。

![img](https://pic3.zhimg.com/80/v2-d4cae5babf2c6dc82abd31bb5222bdf6_1440w.jpg)

- 场景二：复杂查询

复杂查询指的是复杂聚合查询、大批量数据SCAN、复杂的查询（如JOIN）。在ad-hoc场景中，经常会有这样的查询，往往用户不能预先知道要查询什么，更多的是探索式的。这里也根据QPS和查询耗时分几种情况，如下图所示，根据业务的需求来选择对应的引擎即可。有一点要提的是FlinkSQL和SparkSQL虽然也能完成类似需求，但是它们目前还不是开箱即用，需要做周边生态建设，这两种技术目前更多的应用场景还是在通过操作灵活的编程API来完成流式或离线的计算上。

![img](https://pic1.zhimg.com/80/v2-c242148fd3969c9900b80ccb7c436854_1440w.jpg)



**4.2 执行模型对比**

![img](https://pic2.zhimg.com/80/v2-0b8c06bfaaea592074587695bcfe30d1_1440w.jpg)

![图片](https://mmbiz.qpic.cn/mmbiz_png/VY8SELNGe94AiaMJnXXEZJ20dZUvVA5R5iba3nw7pbhdyXNCFaTju3peyT41pzjKS3XH0Qial0YHZcAYr84IiaPndg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

【原图来自Apache Doris官方介绍PPT】

- Scatter-Gather执行模型：相当于MapReduce中的一趟Map和Reduce，没有多轮的迭代，而且中间计算结果往往存储在内存中，通过网络直接交换。Elasticsearch、Druid、Kylin都是此模型。
- MapReduce：Hive是此模型
- MPP：MPP学名是大规模并行计算，其实很难给它一个准确的定义。如果说的宽泛一点，Presto、Impala、Doris、Clickhouse、Spark SQL、Flink SQL这些都算。有人说Spark SQL和Flink SQL属于DAG模型，我们思考后认为，DAG并不算一种单独的模型，它只是生成执行计划的一种方式。



## 5. OLAP引擎的主要特点

**5.1 Hive**

![img](https://pic2.zhimg.com/80/v2-4b2f29cc9ea9c6ffe7e32b376b5683ed_1440w.jpg)

Hive是一个分布式SQL on Hadoop方案，底层依赖MapReduce计算模型执行分布式计算。Hive擅长执行长时间运行的离线批处理，数据量越大，优势越明显。Hive在数据量大、数据驱动需求强烈的互联网大厂比较流行。近2年，随着clickhouse的逐渐流行，对于一些总数据量不超过百PB级别的互联网数据仓库需求，已经有多家公司改为了clickhouse的方案。clickhouse的优势是单个查询执行速度更快，不依赖hadoop，架构和运维更简单。

**5.2 Spark SQL、Flink SQL**

![img](https://pic4.zhimg.com/80/v2-40a5e4c385c64cfc9180018f7c0c52f7_1440w.jpg)

在大部分场景下，Hive计算还是太慢了，别说不能满足那些要求高QPS、低查询延迟的的对外在线服务的需求，就连企业内部的产品、运营、数据分析师也会经常抱怨Hive执行ad-hoc查询太慢。这些痛点，推动了MPP内存迭代和DAG计算模型的诞生和发展，诸如Spark SQL、Flink SQL、Presto这些技术，目前在企业中也非常流行。Spark SQL、Flink SQL的执行速度更快，编程API丰富，同时支持流式计算与批处理，并且有流批统一的趋势，使大数据应用更简单。

注：上面说的在线服务，指的是如阿里对几百万淘宝店主开放的数据应用生意参谋，腾讯对几十万广告主开发的广点通广告投放分析等。

**5.3 Clickhouse**

![img](https://pic3.zhimg.com/80/v2-673aff4899da71c16817eeeff76f1d36_1440w.jpg)

ClickHouse是近年来备受关注的开源列式数据库，主要用于数据分析（OLAP）领域。目前国内社区火热，各个大厂纷纷跟进大规模使用：

- [今日头条](https://link.zhihu.com/?target=https%3A//yq.aliyun.com/go/articleRenderRedirect%3Furl%3Dhttps%3A//t.cj.sina.com.cn/articles/view/5901272611/15fbe462301900xolh) 内部用ClickHouse来做用户行为分析，内部一共几千个ClickHouse节点，单集群最大1200节点，总数据量几十PB，日增原始数据300TB左右。
- [腾讯](https://link.zhihu.com/?target=https%3A//yq.aliyun.com/go/articleRenderRedirect%3Furl%3Dhttps%3A//www.jiqizhixin.com/articles/2019-10-25-3)内部用ClickHouse做游戏数据分析，并且为之建立了一整套监控运维体系。
- [携程](https://link.zhihu.com/?target=https%3A//yq.aliyun.com/go/articleRenderRedirect%3Furl%3Dhttps%3A//www.infoq.cn/article/WZ7aiC27lLrB7_BcGJoL)内部从18年7月份开始接入试用，目前80%的业务都跑在ClickHouse上。每天数据增量十多亿，近百万次查询请求。
- [快手](https://link.zhihu.com/?target=https%3A//yq.aliyun.com/go/articleRenderRedirect%3Furl%3Dhttps%3A//archsummit.infoq.cn/2019/beijing/presentation/2183)内部也在使用ClickHouse，存储总量大约10PB， 每天新增200TB， 90%查询小于3S。

在国外，Yandex内部有数百节点用于做用户点击行为分析，CloudFlare、Spotify等头部公司也在使用。

ClickHouse从OLAP场景需求出发，定制开发了一套全新的高效列式存储引擎，并且实现了数据有序存储、主键索引、稀疏索引、数据Sharding、数据Partitioning、TTL、主备复制等丰富功能。以上功能共同为ClickHouse极速的分析性能奠定了基础。

注：内容来自https://zhuanlan.zhihu.com/p/98135840

ClickHouse部署架构简单，易用，不依赖Hadoop体系（HDFS+YARN）。它比较擅长的地方是对一个大数据量的单表进行聚合查询。Clickhouse用C++实现，底层实现具备向量化执行（Vectorized Execution）、减枝等优化能力，具备强劲的查询性能。目前在互联网企业均有广泛使用，比较适合内部BI报表型应用，可以提供低延迟（ms级别）的响应速度，也就是说单个查询非常快。但是Clickhouse也有它的局限性，在OLAP技术选型的时候，应该避免把它作为多表关联查询(JOIN)的引擎，也应该避免把它用在期望支撑高并发数据查询的场景，OLAP分析场景中，一般认为QPS达到1000+就算高并发，而不是像电商、抢红包等业务场景中，10W以上才算高并发，毕竟数据分析场景，数据海量，计算复杂，QPS能够达到1000已经非常不容易。例如Clickhouse，如果如数据量是TB级别，聚合计算稍复杂一点，单集群QPS一般达到100已经很困难了，所以它更适合企业内部BI报表应用，而不适合如数十万的广告主报表或者数百万的淘宝店主相关报表应用。Clickhouse的执行模型决定了它会尽全力来执行一个Query，而不是同时执行很多Query。

**5.4 Elasticsearch**

![img](https://pic2.zhimg.com/80/v2-1a4a2b86e4e3fce64078e38724a100b9_1440w.jpg)

提到Elasticsearch，很多人的印象是这是一个开源的分布式搜索引擎，底层依托Lucene倒排索引结构，并且支持文本分词，非常适合作为搜索服务。这些印象都对，并且用Elasticsearch作为搜索引擎，一个三节点的集群，支撑1000+的查询QPS也不是什么难事，这是搜索场景。

但是，我们这里要讲的内容是Elasticsearch的另一个功能，即作为聚合（aggregation）场景的OLAP引擎，它与搜索型场景区别很大。聚合场景，可以等同于select c1, c2, sum(c3), count(c4) from table where c1 in ('china', 'usa') and c2 < 100 这样的SQL，也就是做多维度分组聚合。虽然Elasticsearch DSL是一个复杂的JSON而不是SQL，但是意思相同，可以互相转换。

用Elasticsearch作为OLAP引擎，有几项优势：（1）擅长高QPS（QPS > 1K）、低延迟、过滤条件多、查询模式简单（如点查、简单聚合）的查询场景。（2）集群自动化管理能力（shard allocation，recovery）能力非常强。集群、索引管理和查看的API非常丰富。

ES的执行引擎是最简单的Scatter-Gather模型，相当于MapReduce计算模型的一趟Map和Reduce。Scatter和Gather之间的节点数据交换也是基于内存的不会像MapReduce那样每次Shuffle要先落盘。ES底层依赖的Lucene文件格式，我们可以把Lucene理解为一种行列混存的模式，并且在查询时通过FST，跳表等加快数据查询。这种Scatter-Gather模型的问题是，如果Gather/Reduce的数据量比较大，由于ES时单节点执行，可能会非常慢。整体来讲，ES是通过牺牲灵活性，提高了简单OLAP查询的QPS、降低了延迟。

用Elasticsearch作为OLAP引擎，有几项劣势：多维度分组排序、分页。不支持Join。在做aggregation后，由于返回的数据嵌套层次太多，数据量会过于膨胀。

ElasticSearch和Solar也可以归为宽表模型。但其系统设计架构有较大不同，这两个一般称为搜索引擎，通过倒排索引，应用Scatter-Gather计算模型提高查询性能。对于搜索类的查询效果较好，但当数据量较大或进行扫描聚合类查询时，查询性能会有较大影响。

**5.5 Presto**

![img](https://pic3.zhimg.com/80/v2-960776f2f0db4af9c907796c0220eeca_1440w.jpg)

Presto、Impala、GreenPlum均基于MPP架构，相比Elasticsearch、Druid、Kylin这样的简单Scatter-Gather模型，在支持的SQL计算上更加通用，更适合ad-hoc查询场景，然而这些通用系统往往比专用系统更难做性能优化，所以不太适合做对查询QPS(参考值QPS > 1000)、延迟要求比较高(参考值search latency < 500ms)的在线服务，更适合做公司内部的查询服务和加速Hive查询的服务。Presto还有一个优秀的特性是使用了ANSI标准SQL，并且支持超过30+的数据源Connector。这里我们给读者留下一个思考题：以Presto为代表的MPP模型与Hive为代表的MapReduce模型的性能差异比较大的原因是什么？

**5.6 Impala**

![img](https://pic4.zhimg.com/80/v2-a18dfe5b5745391e0cb3b15e0a31f4cf_1440w.jpg)



Impala 是 Cloudera 在受到 Google 的 Dremel 启发下开发的实时交互SQL大数据查询工具，是CDH 平台首选的 PB 级大数据实时查询分析引擎。它拥有和Hadoop一样的可扩展性、它提供了类SQL（类Hsql）语法，在多用户场景下也能拥有较高的响应速度和吞吐量。它是由Java和C++实现的，Java提供的查询交互的接口和实现，C++实现了查询引擎部分，除此之外，Impala还能够共享Hive Metastore，甚至可以直接使用Hive的JDBC jar和beeline等直接对Impala进行查询、支持丰富的数据存储格式（Parquet、Avro等）。此外，Impala 没有再使用缓慢的 Hive+MapReduce 批处理，而是通过使用与商用并行关系数据库中类似的分布式查询引擎（由 Query Planner、Query Coordinator 和 Query Exec Engine 三部分组成），可以直接从 HDFS 或 HBase 中用 SELECT、JOIN 和统计函数查询数据，从而大大降低了延迟。Impala经常搭配存储引擎Kudu一起提供服务，这么做最大的优势是点查比较快，并且支持数据的Update和Delete。

注：部分内容来自https://zhuanlan.zhihu.com/p/55197560

**5.7 Doris**

![img](https://pic2.zhimg.com/80/v2-c4641090425bb98009df7524cf31fd05_1440w.jpg)

Doris是百度主导的，根据Google Mesa论文和Impala项目改写的一个大数据分析引擎，在百度、美团团、京东的广告分析等业务有广泛的应用。Doris的主要功能特性如下图所示：

![img](https://pic3.zhimg.com/80/v2-c2ab79b0e82fd973872be572745996a6_1440w.jpg)

![img](https://pic1.zhimg.com/80/v2-b0d0baf3e3b7569dac6e81867a85ca6c_1440w.jpg)

【原图来自Apache Doris官方介绍PPT】

**5.8 Druid**

![img](https://pic2.zhimg.com/80/v2-665fd02d454a238d4e7ad3a38fc024e1_1440w.jpg)

Druid 是一种能对历史和实时数据提供亚秒级别的查询的数据存储。Druid 支持低延时的数据摄取，灵活的数据探索分析，高性能的数据聚合，简便的水平扩展。Druid支持更大的数据规模，具备一定的预聚合能力，通过倒排索引和位图索引进一步优化查询性能，在广告分析场景、监控报警等时序类应用均有广泛使用；

Druid的特点包括：

- Druid实时的数据消费，真正做到数据摄入实时、查询结果实时
- Druid支持 PB 级数据、千亿级事件快速处理，支持每秒数千查询并发
- Druid的核心是时间序列，把数据按照时间序列分批存储，十分适合用于对按时间进行统计分析的场景
- Druid把数据列分为三类：时间戳、维度列、指标列
- Druid不支持多表连接
- Druid中的数据一般是使用其他计算框架(Spark等)预计算好的低层次统计数据
- Druid不适合用于处理透视维度复杂多变的查询场景
- Druid擅长的查询类型比较单一，一些常用的SQL(groupby 等)语句在druid里运行速度一般
- Druid支持低延时的数据插入、更新，但是比hbase、传统数据库要慢很多

与其他的时序数据库类似，Druid在查询条件命中大量数据情况下可能会有性能问题，而且排序、聚合等能力普遍不太好，灵活性和扩展性不够，比如缺乏Join、子查询等。

注：以上介绍Druid的内容来自：[https://segmentfault.com/a/1190000020385389](https://link.zhihu.com/?target=https%3A//segmentfault.com/a/1190000020385389)

**5.9 Kylin**

![img](https://pic2.zhimg.com/80/v2-b6789ecb4c5b0829536e8c5aa8703375_1440w.jpg)

Kylin自身就是一个MOLAP系统，多维立方体（MOLAP Cube）的设计使得用户能够在Kylin里为百亿以上数据集定义数据模型并构建立方体进行数据的预聚合。

适合Kylin的场景包括：

- 用户数据存在于Hadoop HDFS中，利用Hive将HDFS文件数据以关系数据方式存取，数据量巨大，在500G以上
- 每天有数G甚至数十G的数据增量导入
- 有10个以内较为固定的分析维度

简单来说，Kylin中数据立方的思想就是以空间换时间，通过定义一系列的纬度，对每个纬度的组合进行预先计算并存储。有N个纬度，就会有2的N次种组合。所以最好控制好纬度的数量，因为存储量会随着纬度的增加爆炸式的增长，产生灾难性后果。

注：以上介绍Kylin的内容来自：[https://segmentfault.com/a/1190000020385389](https://link.zhihu.com/?target=https%3A//segmentfault.com/a/1190000020385389)

## 6. 总结

我以为，我们在这里所做的各个OLAP引擎的介绍和分析，并不一定100%合理准确，只是一种参考。只有真正有OLAP线上经验的人，在特定业务场景、特定数据量的，有过深入优化以上介绍的一种或者几种OLAP引擎经验的专家，才有相应的发言权来给出技术选型的建议。但是由于这些OLAP引擎技术方案太多，不可能有哪个专家全都精通。以我个人为例，过往的工作经验使我在Hive、SparkSQL、FlinkSQL、Presto、Elasticsearch这几个方面更了解，其他的引擎不敢瞎说自己懂，不构成技术选型的建议。所以大概每个专家说的都不准确、不全面，我们在这里鼓励大家多讨论和评论，多提问题，成为各个OLAP引擎方面的专家。

------

## 参考资料：

1. https://zhuanlan.zhihu.com/p/161331941
2. https://zhuanlan.zhihu.com/p/147344996
3. [https://mp.weixin.qq.com/s/oIlntVO9ZXimqphlO5ERrA](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s/oIlntVO9ZXimqphlO5ERrA)
4. [https://www.imaginarycloud.com/blog/oltp-vs-olap/](https://link.zhihu.com/?target=https%3A//www.imaginarycloud.com/blog/oltp-vs-olap/)
5. [https://www.jianshu.com/p/bbfdce4433b1](https://link.zhihu.com/?target=https%3A//www.jianshu.com/p/bbfdce4433b1)
6. [https://segmentfault.com/a/1190000020385389](https://link.zhihu.com/?target=https%3A//segmentfault.com/a/1190000020385389)
7. [https://en.wikipedia.org/wiki/Online_analytical_processing](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Online_analytical_processing)
8. https://zhuanlan.zhihu.com/p/144926830
9. https://zhuanlan.zhihu.com/p/147344996
10. [https://medium.com/@leventov/comparison-of-the-open-source-olap-systems-for-big-data-clickhouse-druid-and-pinot-8e042a5ed1c7](https://link.zhihu.com/?target=https%3A//medium.com/%40leventov/comparison-of-the-open-source-olap-systems-for-big-data-clickhouse-druid-and-pinot-8e042a5ed1c7)
11. https://www.zhihu.com/question/41541395
12. [https://mp.weixin.qq.com/s/ucb9AGQ-Kh1D5c8NgS0WXQ](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s/ucb9AGQ-Kh1D5c8NgS0WXQ)
13. https://zhuanlan.zhihu.com/p/55197560
14. [http://www.clickhouse.com.cn/topic/5c453371389ad55f127768ea](https://link.zhihu.com/?target=http%3A//www.clickhouse.com.cn/topic/5c453371389ad55f127768ea)
15. [https://www.oreilly.com/radar/bringing-interactive-bi-to-big-data](https://link.zhihu.com/?target=https%3A//www.oreilly.com/radar/bringing-interactive-bi-to-big-data)
16. [http://doris.apache.org/master/en/](https://link.zhihu.com/?target=http%3A//doris.apache.org/master/en/)
17. [https://www.geeksforgeeks.org/olap-operations-in-dbms/](https://link.zhihu.com/?target=https%3A//www.geeksforgeeks.org/olap-operations-in-dbms/)
18. [http://webdataanalysis.net/web-data-warehouse/multidimensional-data-model/](https://link.zhihu.com/?target=http%3A//webdataanalysis.net/web-data-warehouse/multidimensional-data-model/)
19. [http://webdataanalysis.net/web-data-warehouse/data-cube-and-olap/](https://link.zhihu.com/?target=http%3A//webdataanalysis.net/web-data-warehouse/data-cube-and-olap/)

------

本文作者在国内某一线互联网大厂做大数据技术。交流大数据技术（Hadoop、Spark、Flink、Presto、Elasticsearch，..）、互联网大厂内推、技术面试求职指导，微信扫码联系本文作者(Wechat ID:**`garyelephant`**)，加好友备注“知乎”：

![img](https://pic4.zhimg.com/v2-bdef8ae181fa44133203588d564093ab_b.jpg)