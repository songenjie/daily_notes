工作细节

1 ha

2 业务划分

3 实时问题的解决

4 统一的数据接口

5 重复数据的合并或删除

6 历史数据的存储

7 历史数据的展示

8 系统设计

9 线上问题跟进



doris 集群搭建

doris bug fix





clickhouse 集群搭建

clickhouse 管控平台设计

clickhouse 多集群，单机器，多磁盘，高可用、高可靠的部署

clickhouse 数据一致性校验

clickhouse in zookeeper 冷热分离

clickhouse raft server 替换zookeeper 





业务支持

线上问题跟进

文档丰富

社区宣讲

后期规划

各版本控制和开发







2020年度人才盘点

亲爱的宋恩杰，欢迎参加2020年度人才盘点，请回顾您最近一年的业绩贡献与工作表现，按下列要求填写完成盘点自评。

信息参考

核心贡献

- 平台赋能-提升部门核心竞争力

  - jdolap doris 618 大促保障  支撑和保障doris 0级业务稳(优惠券、搜推等业务)
  - jdolap doris 、clickhouse 双十一 大促保障 (保障doris 京东动力业务稳定运行，clickhouse 黄金眼、商智 所有独立集群稳定运行,全链路压测，故障演练）

- 提升部门影响力-推广部门使用案例和落地方案-业界影响力

  - jdolap doris 集团内大规模宣讲
  - jdolap doris 社区内宣讲-得到业界肯定
  - jdolap clickhouse 团队内多次技术分享-团队技术深入交流

- 业务支持-解决业务核心痛点-提升olap性能-得到业务认可

  - 双十一黄金眼流量业务数据模型优化及支持，支撑双十一(深入了解业务模型，解决业务慢查询，数据同步等问题)，
  - 双十一商智-商家 交易数据模型支持，支持双十一

- 团队内赋能-提升部门核心生产力

  - 完成 jdolap clickhouse 集群从零到一搭建 

  - 参与及设计 团队未来规划，学习和创新

  - jdolap 多个模块设计及开发 ,晚上olap体系内工具完善性，提升部门产能，释放人力

  - jdolap clickhouse  服务自动化实践，提升个人部门协作能力，团队交流能力

    

**优势项（可参考[四五表](http://jnews.jd.com/org-new?guid=41c93230e9a9417790b44303488f344e)中能力素质项，来描述您的优势能力和素质）**

基础能力：善续发现创新点不断推进在技术、业务、管理等领域的持续改进和突破，有强烈的好奇心，愿意花额外的时间和精力学习新的知识、有行业的前瞻性；能够透过问题发现问题的本质，清晰的认知自己以及周围环境善于反思

专业力: 善于应用专业技术达成和推动落地技术成果的能力；运用专业技术实现挑战性的目标、推动技术变革，创新业务机会，在公司内外建立技术权威影响力

前言意识：深刻把握行业前沿和发展趋势

业务敏锐度：对市场、行业变化敏感，对商机反应迅速，能够通过分析所搜到的商业领绿的相关资讯，明锐地洞察行业以及市场的新动向、新趋势

落地战绩：敢闯、敢试，迎难而上，想尽一切办法执行战略达成战绩

**待发展项（可参考[四五表](http://jnews.jd.com/org-new?guid=41c93230e9a9417790b44303488f344e)中能力素质项，来描述您的待发展能力和素质）。**

基础能力上：应该依赖当前市场有更多的创建能力、为企业赋能

专业力：从产品角度发现更多的可能性







发展倾向

**职业发展倾向**

我希望未来自己成长为专家，通过掌握出色的专业知识、通用专业技能取得成就







**国内流动意向（仅HR可见）**

0/1800

**海外流动意向，如果公司提供更好的发展机会，您最想去海外哪个国外工作？ （仅HR可见）**

A.泰国

B.印尼

C.美国

D.欧洲

E.澳洲

F.中东

G.其他

H.1年内不考虑海外工作







```
CREATE TABLE if not exists  songenjie.table_test_local_minimalistic on cluster KC0_CK_TS_01 (     EventDate DateTime,     CounterID UInt32,     UserID UInt32 ) ENGINE = ReplicatedMergeTree('/clickhouse/KC0_CK_TS_01/jdob_ha/songenjie/table_test_local_minimalistic/{shard}', '{replica}') PARTITION BY toYYYYMMDD(EventDate) ORDER BY (CounterID, EventDate, intHash32(UserID)) SETTINGS storage_policy = 'jdob_ha',use_minimalistic_part_header_in_zookeeper=1;
```



1. JDOLAP ClickHouse 从零到一搭建 ：ClickHouse 从调研、搭建、业务对接，自动化部署、节点扩缩容、节点替换、全链路压测、双十一大促支持
2. 平台影响力及核心竞争力：JD-OLAP doris 公司内宣讲，社区内宣讲，ClickHouse 部分内分享
3. OLAP 平台业务赋能：对接及解决黄金眼流量业务痛点、优化服务模型、提升查询效率 以支持服务双十一上线及大促支持
4. JD OLAP （doris clickhouse ）大促支持：支持 京东动力平台、黄金眼流量平台、黄金眼交易订单平台等业务；与业务方积极沟通、积极配合平台压测、完成平台双十一赋能
5. 个人专业能力：熟练掌握olap框架，善续发现创新点不断推进在技术、业务、管理等领域的持续改进和突破，有强烈的好奇心，愿意花额外的时间和精力学习新的知识、有行业的前瞻性；能够透过问题发现问题的本质，清晰的认知自己以及周围环境、善于反思









1. 工作业绩及成果 时间轴(618至双十一)

JDOLAP ClickHouse 从零到一搭建(ClickHouse 从调研、搭建、业务对接，自动化部署、节点扩缩容、节点替换、全链路压测、双十一支持)



主要职责

1. ClickHouse 调研 
2. ClickHouse 高可用方法调研及落地
3. ClickHouse 业务对接
4. ClickHouse 自动化部署
5. ClickHouse Quota 调研
6. ClickHouse 管控化组件 AdminServer 设计和开发[节点替换]
7. ClickHouse 全链路压测
8. Clickhouse Doris  双十一大促支持



宋恩杰 个人近期工作总结

一： 工作绩效及成果

1. 核心职责方面最大变化

   服务战略转换-JD-OLAP 个人 doris 向 ClickHouse 转型

   平台落地-JD-OLAP ClickHouse 从调研到落地

   释放人力-节省成本：JD-OLAP ClickHouse 自动化服务

   提升平台服务可用性：JD-OLAP ClickHouse 高可用实验到落地

   平台管控方向：JD-OLAP ClickHouse AdminServer 自动化管控 设计到开发到落地的

   平台赋能：JD-OLAP ClickHouse Doris 双十一大促赋能

   业务赋能：JD-OLAP ClickHouse 黄金眼流量核心问题解决

2. 最具影响力、创新性的工作

   JD-OLAP 高可用方案实验到落地、实现Clickhouse 单机器多进程多磁盘

   JD-OLAP 扩缩容方案实验

   提升平台影响力：JD-OLAP doris 公司内宣讲

   提升平台名誉：JD-OLAp doris 京东实践方案 社区内宣讲

   提升平台核心竞争力：JD-OLAP ClickHouse 黄金眼流量 慢查询问题解决及大促支持

   JD-OLAP 后期发展发现调研

3. 个人技术方向沉淀

   正确的成长方向：JD Olap 平台项目 规划化、模版化管理

   专业行能力：熟练 Doris 架构、存储、查询等设计

   专业能力：熟练 ClickHouse MergeTree 等框架设计原理

   专业前瞻性：善续发现创新点不断推进在技术、业务、管理等领域的持续改进和突破，有强烈的好奇心，愿意花额外的时间和精力学习新的知识、有行业的前瞻性；能够透过问题发现问题的本质，清晰的认知自己以及周围环境善于反思

4. 为组织、业务带来了可量化对的价值

​       项目内 不断编写和完善 使用文档

​       解决业务核心痛点：解决大部分 当前平台在ClickHouse 方向使用遇得的问题

​       业务对接-出差上海 对接和解决 黄金眼流量项目 问题

​       参与和讨论项目规划

二： 失败经历及总结

1. JD OLAP ClickHouse 自动化方案初期时间不足，未完全释放开发人力

三： 未来规划

1. 进行ClickHouse 集团队跨团队宣讲
2. 解决ClickHouse 当前遇到的瓶颈（比如 优化ClickHouse 写入对Zookeeper 压力）
3. 解决ClickHouse 业务使用的一些核心问题



























1. 失败业绩及总计
2. 未来规划