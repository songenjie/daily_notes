- ## 个人信息

  - 姓名： 宋恩杰
  - 英文名：Jason
  - 应聘岗位： 大数据-计算引擎-软件开发工程师
  - 工作经历：2018/07-至今  京东(技术与数据中台-软件开发)-校招
  - 学历： 本科 长安大学(211)-时间(2014/09-2018/07)
  - 工作地：北京
  - 邮箱：turbo_json@qq.com
  - 电话： 153-1350-4109

  

  ## 个人项目经历

  

  ### JD OLAP 

  - 时间：2019/04-至今 

  - 项目简介： OLAP解决PB级数据存储、即席查询、高效准确去重、满足多种数据源接入、兼容多种数据类型、监控Mysql协议、列式存储、高可用高并发的事实数据分析系统 平台目前主要使用 Doris,Clickhouse 两个开源产品,前期工作Doris为主，后期工作Clickhouse为主

  

  ### 1 [Apache Doris :](  https://github.com/apache/incubator-doris)

  - 个人commits [Some Commits]( https://github.com/songenjie/incubator-doris/commits/songenjie-commit)
  - 个人工作：
    1. Fix be log not rotate bug [commit](https://github.com/songenjie/incubator-doris/commit/95764a54c0711181361cec726cb9b1faacef4f43)
    2. Suport json data type import [commit](https://github.com/songenjie/incubator-doris/commit/26c0e6fb55bd3660c02c0c9fc62e5472d894f69c)
    3. Support users with high QPS in the same query through result set cache[commits](https://github.com/apache/incubator-doris/pull/4284/files)
    4. Support importing Doris through hive sql [commits](https://github.com/songenjie/incubator-doris/commit/043d80586963d9a22c3d21517d9c6fcc3c54ed4e)
    5. Fix java.lang.ClassCastException [commit](https://github.com/apache/incubator-doris/pull/2667/files)
    6. Proficient in Doris storage design, writing process

  

  #### 2 [Yandex  ClickHouse: ](https://github.com/ClickHouse/ClickHouse)

  - 个人工作:

  1. Proficient in Doris storage design, writing process
     - Clickhouse Struct : [persion struct jpg](https://github.com/songenjie/daily_notes/blob/master/source/clickhouse_storage1.jpg)         [struct](https://www.processon.com/view/link/5eec71e4e401fd1fd2a026b2)           [源码分析](https://github.com/songenjie/daily_notes/blob/master/2020/7月/工作/读clickhouse原理解析与应用实践有感.md) 
     - Clickhouse [数据段](https://github.com/songenjie/daily_notes/blob/master/2020/7月/工作/clickhouse_数据标记.md)
  2. Clickhouse HA : Clickhouse realizes single machine, multiple copies, multiple clusters, multiple disks, and multiple processes [design](https://www.processon.com/view/link/5f0580e17d9c08442052bfd6) [ppt分享](https://github.com/songenjie/daily_notes/blob/master/2020/8月/工作/clickhouse-扩缩容.pptx)
  3. Realize clickhouse expansion, offline, and replacement plan[design](https://www.processon.com/view/link/5eec8b70e0b34d4dba4879b3)

  

  工作内容：

  1. JD OLAP Doris ClickHouse版本维护,bug 修复等一系列工作 如上个人工作
  2. 业务对接（优惠券、订单、物流、点击流、搜索推荐平台）
  3. 外围工具融合（1 api sever 开发 2 跟平台数据集市融合 3 flink 模版 4 hive导入兼容等问题 5 partition ddl ）
  4. 熟练 Doris  Ciickhouse 架构、存储、写入.. 等流程
  5. 平台 618，双十一 支持

  

  ###  [JD Monitor]( https://github.com/prometheus/prometheus)

  - 时间：2018/07-2019.07

  - 项目简介：JD Monitor是基于CNCF组织下prometheus、thanos等组件的优化和自研组件，完成对物理层（4w台机器和其进程层（jvm）、应用层（buffalo、flink、fregata等）数据指标的动态采集、转换、采集、存储和告警系统 

  

  - 个人工作: [branch](https://github.com/songenjie/prometheus/commits/branch-v2.10.0)


  1. Complete system architecture [Design](https://github.com/songenjie/daily_notes/blob/master/source/prometheus_alll_monitor.jpg)
  2. Prometheus Support Chinese Label [Commits](https://github.com/songenjie/prometheus/commit/c98f89f33c024d10ab2bfedeb7464acb9af04b88)
  3. prometheus resolved alter values is after value [commit](https://github.com/songenjie/prometheus/commit/d55c3575f7d81729375f17dff9d628fa0fa39652)
  4. support  convert jmx metrics to prometheus metrics [project]( https://github.com/songenjie/jmx-to-metrics)
  5. fix some else bug 
  6. package  go log [project](https://github.com/songenjie/go)

  

  - 工作内容：

  1. 参与整个系统设计、完成系统设计文档、基本参与所有组件的开发工作。做到系统的安全、高效、稳定、节能等指标
  2. 利用平台有限资源完成所有服务的数据采集、存储和告警处理
  3. 在数据采集端  
     - 完成被抓取目标源jvm进程暴露的jmx指标和抓取、转换和指标暴露。 
     - 完成系统兼容多种目标源的采集 
     - 完成对于事实数据目标源通过gateway方式，中转做到HA和数据统一性 
     - 完成系统对于复杂数据类型的兼容性、如为代替原始监控系统，兼容中文数据类型，做到能完整替换原系统
  4. 系统稳定性 
     - 在不影响原始功能情况下，降低重要组件负载 eg(prometheus 利用对于不同抓取目标和实时性、抓取间隔要求和数据量大小等等。合理设计数据存储和抓取情况），解决prometheus down问题 
     - 解决历史数据存储和慢查询问题（因原设计系统对新业务数据增多、目标增多，系统有了瓶颈） 
     - 解决对历史数据压缩和downsample 处理过程进程down问题
  5. 业务高效赋能 
     - 完成，数据指标报警规则的api接口开发，做到报警的动态配置 
     - 所有组件基本在机器不扩容情况下做到高可用 3>618支持

  

  ## 个人技能

  - 熟练Linux和Window操作系统和系统内核
  - 熟练C、C++
  - 熟练GO
  - 熟练MPP系统架构（eg: clickhouse doris system structure)
  - 能够使用Java

  

  # THANKS

  - [some more work details:]( https://github.com/songenjie/daily_notes/blob/master/resume.md)

  - 如果贵公司对我工作内容感兴趣，欢迎关注我个人[GITHUB](https://github.com/songenjie) 账号，谢谢