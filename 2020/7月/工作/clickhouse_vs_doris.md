- [clickhouse VS Apache Doris](/source#clickhousevsdoris功能对比-clickhouseVSApacheDoris)
  - [1 系统架构](/source#clickhousevsdoris功能对比-1系统架构)
    - [1.1 What is clickhouse](/source#clickhousevsdoris功能对比-1.1Whatisclickhouse)
    - [真正的列式数据库。 没有任何内容与值一起存储。例如，支持常量长度值，以避免将它们的长度“ number”存储在值的旁边。](/source#clickhousevsdoris功能对比-真正的列式数据库。没有任何内容与值一起存储。例如，支持常量长度值，以避免将它们的长度“number”存储在值的旁边。)
    - [1.2 What is Doris](/source#clickhousevsdoris功能对比-1.2WhatisDoris)
  - [2 数据模型](/source#clickhousevsdoris功能对比-2数据模型)
    - [2.1 Clickhouse聚合模型](/source#clickhousevsdoris功能对比-2.1Clickhouse聚合模型)
    - [2.2 Doris的聚合模型](/source#clickhousevsdoris功能对比-2.2Doris的聚合模型)
    - [2.3 Clickhouse VS Doris RollUp](/source#clickhousevsdoris功能对比-2.3ClickhouseVSDorisRollUp)
    - [2.4 Doris的明细模型](/source#clickhousevsdoris功能对比-2.4Doris的明细模型)
  - [3 存储引擎](/source#clickhousevsdoris功能对比-3存储引擎)
    - [Clickhouse存储引擎：](/source#clickhousevsdoris功能对比-Clickhouse存储引擎：)
    - [Doris存储引擎：](/source#clickhousevsdoris功能对比-Doris存储引擎：)
  - [4 数据导入](/source#clickhousevsdoris功能对比-4数据导入)
    - [Clickhouse数据导入：](/source#clickhousevsdoris功能对比-Clickhouse数据导入：)
    - [Doris数据导入：](/source#clickhousevsdoris功能对比-Doris数据导入：)
  - [5 查询](/source#clickhousevsdoris功能对比-5查询)
    - [Clickhouse查询：](/source#clickhousevsdoris功能对比-Clickhouse查询：)
    - [Doris查询：](/source#clickhousevsdoris功能对比-Doris查询：)
  - [6 精确去重](/source#clickhousevsdoris功能对比-6精确去重)
    - [Clickhouse的精确去重：](/source#clickhousevsdoris功能对比-Clickhouse的精确去重：)
    - [Doris的精确去重：](/source#clickhousevsdoris功能对比-Doris的精确去重：)
  - [7 元数据](/source#clickhousevsdoris功能对比-7元数据)
    - [Clickhouse的元数据 ：](/source#clickhousevsdoris功能对比-Clickhouse的元数据：)
    - [Doris的元数据：](/source#clickhousevsdoris功能对比-Doris的元数据：)
  - [8 高性能](/source#clickhousevsdoris功能对比-8高性能)
    - [Why Clickhouse Query Fast：](/source#clickhousevsdoris功能对比-WhyClickhouseQueryFast：)
    - [Why Doris Query Fast：](/source#clickhousevsdoris功能对比-WhyDorisQueryFast：)
  - [9 高可用](/source#clickhousevsdoris功能对比-9高可用)
    - [Clickhouse高可用：](/source#clickhousevsdoris功能对比-Clickhouse高可用：)
    - [Doris高可用：](/source#clickhousevsdoris功能对比-Doris高可用：)
  - [10 可维护性](/source#clickhousevsdoris功能对比-10可维护性)
    - [10.1 部署](/source#clickhousevsdoris功能对比-10.1部署)
    - [10.2 运维](/source#clickhousevsdoris功能对比-10.2运维)
  - [11 易用性](/source#clickhousevsdoris功能对比-11易用性)
    - [11.1 查询接入](/source#clickhousevsdoris功能对比-11.1查询接入)
    - [11.2 学习成本](/source#clickhousevsdoris功能对比-11.2学习成本)
    - [11.3 Schema Change](/source#clickhousevsdoris功能对比-11.3SchemaChange)
  - [12 功能](/source#clickhousevsdoris功能对比-12功能)
  - [13 社区和生态](/source#clickhousevsdoris功能对比-13社区和生态)
  - [14 总结](/source#clickhousevsdoris功能对比-14总结)



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

![img](/source/1.jpeg?version=1&modificationDate=1585282814000&api=v2)

Doris的系统架构如下，Doris主要分为FE和BE两个组件，FE主要负责查询的编译，分发和元数据管理（基于内存，类似HDFS NN）；BE主要负责查询的执行和存储系统。

![img](/source/2.jpeg?version=1&modificationDate=1585282888000&api=v2)

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