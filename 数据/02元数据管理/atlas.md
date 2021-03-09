## **简介**

Atlas是Hadoop平台元数据框架;

Atlas是一组可扩展的核心基础治理服务，使企业能够有效，高效地满足Hadoop中的合规性要 求，并能与整个企业数据生态系统集成;

Apache Atlas为组织提供了开放的元数据管理和治理功能，以建立数据资产的目录，对这些资产进行分类和治理，并为IT团队、数据分析团队提供围绕这些数据资产的协作功能。

## **架构**

![img](https://bigdata.djbook.top/wp-content/uploads/2020/12/atlas.png)

Atlas由元数据的收集，存储和查询展示三部分核心组件组成。此外，还会有一个管理后台对整体元数据的采集流程以及元数据格式定义和服务的部署等各项内容进行配置管理。

Atlas包括以下组件:

- Core。Atlas功能核心组件，提供元数据的获取与导出(Ingets/Export)、类型系统(Type System)、元数据存储索引查询等核心功能
- Integration。Atlas对外集成模块。外部组件的元数据通过该模块将元数据交给Atlas管理
- Metadata source。Atlas支持的元数据数据源，以插件形式提供。当前支持从以下来源提 取和管理元数据:

hive

hbase

sqoop

kafka

storm

- Applications。Atlas的上层应用，可以用来查询由Atlas管理的元数据类型和对象
- Graph Engine(图计算引擎)。Altas使用图模型管理元数据对象。图数据库提供了极大的灵活性，并能有效处理元数据对象之间的关系。除了管理图对象之外，图计算引擎还为元数据对象创建适当的索引，以便进行高效的访问。在Atlas 1.0 之前采用Titan作为图存储引擎，从1.0开始采用JanusGraph作为图存储引擎。JanusGraph底层又分为两块:
- Metadata Store。采用 HBase 存储 Atlas 管理的元数据;
- Index Store。采用Solr存储元数据的索引，便于高效搜索;

 

**对比**

1）Atlas比datahub血缘分析粒度较细，支持字段级血缘依赖的跟踪。datahub仅支持表级。

2）Atlas与Apache Ranger集成，可根据与Atlas中实体相关的分类对数据访问进行授权/数据屏蔽。而WhereHows缺乏有效的用户、权限管理能力。

3）datahub比Atlas支持的源系统多。

4）DataHub刚立项不久，数据管理方面与WhereHows的特性差不多，侧重于元数据的发现（搜索、查询）。

5）Atlas在同行业中逐渐普及，社区活跃度远高于DataHub。