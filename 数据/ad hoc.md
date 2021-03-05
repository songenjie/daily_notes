## **什么是海量实时计算？**

更常见的叫法是 Ad-Hoc Query，在人可容忍的交互时间内(5秒内)，对于给定查询返回结果，典型应用场景为:

- 产品运营实时洞察
- A/B Testing
- 用户增长领域

查询有以下特点:

- (灵活性) 查询方式不固定，不能被预计算
- (海量) 查询数据规模超出传统数据库可以承受的规模 (100亿+)
- (实时) 可以查询到最近产生的数据, 这一点不同业务形态要求的实时性会有差别

> Ad-Hoc Query 在很多方面和 OLAP 很像，只是要求更高的灵活性

## **难点在哪里**

`灵活性`，`海量`，`实时` 这三个维度像是 CAP 理论里面的三角关系一样，如果同时满足会有一些难度，我们分别讨论一下对应的方案。

- 如果仅考虑 `海量`，`实时` 两个维度，可选方案可以是 Druid, Flink+ES，但是这些预计算类型方案没有灵活性
- 如果仅考虑 `灵活性`, `实时` 两个维度，没有海量的约束，就不用考虑横向扩展/成本问题，解决方案就非常多元化了，例如传统数据库，ElasticSearch, ClickHourse 等
- 如果仅考虑 `灵活性`, `海量` 两个维度，可选方案是 HDFS + ORC + Spark/Presto/Impala

目前没有开源解决方案可以直接比较好的处理好这个三角关系，ElasticSearch 可能是最接近的开源方案，但是成本是非常严重的一个问题，查询能力稍弱，是 SQL 子集。

这里会讨论一些组合方案，以达到海量实时计算目的。

## **查询模型**

- Filter，从海量数据中选择符合条件的一小部分数据集 (通常1万条以下)
- Aggregation, 聚合是数据分析中最常见的任务，简单来说就是 Group By
- Custom Model, 自定义查询模型, 例如生成漏斗模型，桑吉模型 等等，这需要查询框架提供 UDF 支持

## **列式存储**

列式存储在 `Ad-Hoc Query` 中非常重要，因为有实时性要求，需要尽可能减少磁盘/网络 IO

目前场景的列式存储为 Parquet，ORC，这两者经常会被作为比较对象

- [Benchmarking PARQUET vs ORC](https://zhuanlan.zhihu.com/p/131366019/https://medium.com/@dhareshwarganesh/benchmarking-parquet-vs-orc-d52c39849aef)
- [Which Hadoop File Format Should I Use?](https://link.zhihu.com/?target=https%3A//www.jowanza.com/blog/which-hadoop-file-format-should-i-use)

我个人的看法:

- ORC 比 Parquet 晚一点出现，在数据压缩上有一定优势
- Parquet 出现的早，开源社区的支持度会比 ORC 好一点，但已经非常接近了
- Parquet 和 ORC 背后是 Cloudera(Impala) 和 Hortonworks(Hadoop,hive) 两家商业公司之争
- 最近阿里巴巴也加入了 ORC 阵营，并做了成吨的优化
- ORC 前景看好一些

另外除了 Parquet，ORC，也有一些建立在其之上的存储框架，例如Spark社区全力打造的 [DeltaLake](https://link.zhihu.com/?target=https%3A//delta.io/) 以及我们下文会重点介绍的 [Kudu](https://link.zhihu.com/?target=https%3A//kudu.apache.org/), 这两者均构建在 Parquet 格式之上

另外关于列式存储的起源，Google 2010 年发布的一篇论文(Google 内部在 2006年已经投入生产环境使用), 大数据领域的小伙伴想必不陌生: [Dremel: Interactive Analysis of Web-Scale Datasets](https://link.zhihu.com/?target=https%3A//storage.googleapis.com/pub-tools-public-publication-data/pdf/36632.pdf)

Dremel 中提到的存储方案，开源实现便是 Parquet, 在 Google 内部的直系后代是 Capacitor, 之后便作为 `Big Query` 的内置存储格式, 关于 Big Query 的更多介绍可以参考 [A Deep Dive Into Google BigQuery Architecture](https://link.zhihu.com/?target=https%3A//panoply.io/data-warehouse-guide/bigquery-architecture/)

## **实时性**

大数据在实时性方面一直没有太多诉求，但是商业分析越来越讲究时效性，例如要评估一个广告投放的效果并进行调整，就需要尽量快的进行分析和数据反馈。

而实效性与列式存储是有矛盾的。

列式存储如 ORC/Parquet 核心思想都是把相似的数据放在一起，期望查询的时候可以直接忽略不满足Where条件的数据块，而实效性又要求数据需要可以实时刷写并用于查询。这种矛盾就引发我们去实现定时的 ETL 过程去做数据重整，而这部分复杂性最好是应当由某个存储组件去承担。如果要求秒极的实时性，必然是经过数据重整的数据和零散的近期数据结合在一起做查询，进一步增加了复杂性。

大数据计算引擎和存储引擎完全解耦，中间的定期 `Table Compaction` 成了一个空白地带，因为这需要一个常驻的后台服务。可以选择 Spark 去实现 `Table Compaction`，毕竟只需要[几行代码](https://link.zhihu.com/?target=https%3A//docs.delta.io/latest/best-practices.html%23compact-files)，但从工程实践的角度讲，引入一个流程从来都不是几行代码这么简单，需要解决的问题有很多:

- 如何定时跑
- 表结构变更怎么办
- Compaction 和最近的实时数据如何关联查询

如果选择 Spark Compaction，关于加载实时数据的方案可能是，额外写一份数据到 HBase/ElasticSearch，这样可以历史数据从 HDFS ORC 加载，实时数据从 HBase/ElasticSearch 加载。

但是其实还会有一些问题:

- HBase 适合做全量 Scan，但是对谓词下推(PushDown) 支持比较薄弱，这实际上有IO的浪费，看业务场景是否可以容忍这种 IO 浪费
- ElasticSearch 显然对 谓词下推(PushDown) 可以完美支持，但是 ElasticSearch 与 Spark 间的吞吐有非常大的问题，单机大约只能到几万记录每秒的速度

> 业界 Parquet/ORC 与 HBase 结合满足实时性需求的案例比较多。

### **Kudu 值得单独介绍一下**

[Apache Kudu](https://link.zhihu.com/?target=https%3A//kudu.apache.org/) 为了解决海量数据的实时性查询而生，它不像 HBase 那样专注于 OLTP，而是取得了 OLAP/OLTP 的一个平衡点。下面一张图可以形象说明这一点:

![img](https://pic3.zhimg.com/80/v2-26c04f46e5ad46e3bab7d644ac55504e_1440w.jpg)

下面这些特性使 Kudu 极其适合于 Ad-Hoc Query

- 实时性，数据可以实时写入，先内存缓存再落盘，查询时会结合内存和磁盘的结果
- 列式存储(Parquet底层)，支持谓词下推
- 有主键，意味着可以进行非聚合查询 (示例场景: 查询一个用户的所有事件)

但是 Kudu 也有显而易见的缺点:

- 字段大小 64K 字节限制
- 不支持 Map/Struct/Array 等复合数据类型
- 分区体验不友好，需要定时任务维护分区

## **查询引擎**

查询引擎，目前大都是 MPP 架构查询引擎，例如 Impala/Presto/Drill/Vertica/ClickHouse，Spark 是 MapReduce 阵营里唯一可用于 Ad-Hoc Query 的引擎。

在一般的评测里，都会给予 Impala 的性能评分，而 Presto 紧随其后，Drill 目前在国内目前鲜有落地案例，Vertica 是付费产品，一般在传统企业中使用的多，Spark 性能中等，而 ClickHouse 在单表查询中有压倒性优势。

下面是一些简要的对比:

**ImpalaPrestoClickHouseSpark**单表速度4453多表速度5433社区活跃度3415业界应用案例3425灵活性3325UDF 支持3315

> ClickHouse 存储计算是一体的，其他的都是单纯的计算框架

Impala 可参考论文: [Impala: A Modern, Open-Source SQL Engine for Hadoop](https://link.zhihu.com/?target=http%3A//cidrdb.org/cidr2015/Papers/CIDR15_Paper28.pdf)

Presto 可参考论文: [Presto: SQL on Everything](https://link.zhihu.com/?target=https%3A//research.fb.com/wp-content/uploads/2019/03/Presto-SQL-on-Everything.pdf)

ClickHouse 可参考官方文档: [Overview of ClickHouse Architecture](https://link.zhihu.com/?target=https%3A//clickhouse.tech/docs/en/development/architecture/)

Spark 可参考: [The Internals Of Apache Spark](https://link.zhihu.com/?target=https%3A//books.japila.pl/apache-spark-internals/apache-spark-internals/latest/shuffle/SortShuffleManager.html%23)

### **Impala**

Impala + Kudu 组合，在腾讯和神策都被选为实时分析的承载引擎。

Impala 的快速有口皆碑，主要得益于:

- 优化查询计划
- 支持列式存储
- HDFS short-circuit local reads
- Runtime Code Generation
- C++ 本身性能优势

### **Presto**

如果需要多数据源关联查询，使用 Presto 是不错的选择。

但对于 `Ad-Hoc Query` 这种对性能要求严苛的场景，存储实际上没有那么多选择。

### **Spark**

Spark 本身提供的灵活性远超其他的查询引擎，相应的速度方面就不能进行太多的定制性优化。Spark 如果仅用于 SQL 查询时，可以使用 [Spark Thrift JDBC/ODBC server](https://link.zhihu.com/?target=https%3A//spark.apache.org/docs/latest/sql-distributed-sql-engine.html), 但其实 Spark 在纯SQL领域方面相比 Impala/Presto 里面没有太大优势，并且查询时间受数据倾斜影响非常大。

但涉及到复杂计算模型时，Spark 在易用性方面有非常大优势。要发挥 Spark 全部能力，目前比较好的解决方案是 Spark + [Hydrosphere Mist](https://link.zhihu.com/?target=https%3A//github.com/Hydrospheredata/mist), 众所周知，Spark 任务加载需要一段固定的时长，因此绝不能查询到来时候去加载 Spark 应用，而需要预先加载。但是预先加载长期 Hold 住计算资源也会造成一些浪费，Mist 完美的解决了这些问题，可以预先加载 Spark 应用，并在长时间没有新的查询时候关闭 Spark Worker。

### **ClickHouse**

ClickHouse 在头条有比较深度的落地，但是对应的头条团队也进行了成吨的优化。建议小团队谨慎使用，优先选项社区成熟的组件。

## **最终方案分类**

以下方案均以海量为前提，但是在灵活性和实时性方面有取舍。

### **方案 1: ElasticSearch**

适用场景: 低查询耗时，实时，低灵活性，高成本 (土豪的选择)

### **方案 2: Spark + HDFS + ORC/Parquet**

适用场景: 高查询耗时，非实时，高灵活性，低成本 (需要有 Table Compaction 流程)

### **方案 3: Impala + Kudu**

适用场景: 低查询耗时，实时，低灵活性，低成本 (平衡之选)

### **方案 4: Impala + Alluxio + HDFS + ORC/Parquet**

适用场景: 低查询耗时，非实时，低灵活性，高成本 (极致的快速)

### **方案 5: Druid**

适用场景: 低查询耗时，实时，极低灵活性，高成本 (一般用于秒级聚合查询)

### **方案 6: Apache Kylin + Spark**

适用场景: 低查询耗时，非实时，极低灵活性，低成本 (不要求实时的话，低成本方案)

### **方案 7: Spark + Kudu**

适用场景: 高查询耗时，实时，高灵活性，低成本 (实时+灵活性的最佳选择，但性能会稍差)

## **总结**

这里是一些海量实时计算领域的一些概览，后面会有一系列文章，详细说明在工程实践中的落地