​				                                                                  个人简历 

- 姓名：宋恩杰

- 邮箱：turbo_json@qq.com
- 电话：15313504109



JD OLAP 

项目简介：OLAP解决PB级数据存储、即席查询、高效准确去重、满足多种数据源接入、兼容多种数据类型、监控Mysql协议、列式存储、高可用高并发的事实数据分析系统 平台目前主要使用 Doris,Clickhouse 两个开源产品,前期工作Doris为主，后期工作Clickhouse为主



个人开发工作

- Doris 

个人COMMIT历史 https://github.com/songenjie/incubator-doris/commits/songenjie-commit

1. fe add result cache https://github.com/songenjie/incubator-doris/commit/95764a54c0711181361cec726cb9b1faacef4f43
2. fix  java.lang.ClassCastException https://github.com/apache/incubator-doris/pull/2667/files (进入社区)
3. fix  be log rotate err https://github.com/apache/incubator-doris/blob/12c59ba889cdde24a6211651c166936a4593f191/thirdparty/patches/glog-0.3.3-for-palo2.patch#L298 （进入社区）
4. improve json data type https://github.com/songenjie/incubator-doris/commit/26c0e6fb55bd3660c02c0c9fc62e5472d894f69c
5. support avro data type https://github.com/songenjie/incubator-doris/commit/3000bdeb1daf9c001235c27578671bca0232c525
6. support hive sql import https://github.com/songenjie/incubator-doris/commit/043d80586963d9a22c3d21517d9c6fcc3c54ed4e
7. 熟练 Doris 存储设计、写入..过程



- ClickHouse 

1. Clickhouse Stuct https://github.com/songenjie/daily_notes/blob/master/source/clickhouse_storage1.jpg
2. Clickhouse Stroage [https://github.com/songenjie/daily_notes/blob/master/2020/7%E6%9C%88/%E5%B7%A5%E4%BD%9C/clickhouse_%E5%88%97%E5%BC%8F%E5%AD%98%E5%82%A8.md](https://github.com/songenjie/daily_notes/blob/master/2020/7月/工作/clickhouse_列式存储.md) Clickhouse HA方案设计 [单台机器，多副本，多集群，多磁盘，多进程](https://www.processon.com/view/link/5eec71e4e401fd1fd2a026b2)

3. 扩缩容/数据迁移方案 [resharding,这里可单集群，多进程多副本策略相关](https://www.processon.com/view/link/5eec8b70e0b34d4dba4879b3)   
4. 集群管理 [admin_server集群管理设计](https://www.processon.com/view/link/5ee6ed2b07912929cb42b776)

5. 熟练ck 数据 存储、写入、索引 流程





# JD Monitor

### 项目简介：

统一监控平台 是基于CNCF组织下prometheus、thanos等组件的优化和自研组件，完成对物理层（4w台机器和其进程层（jvm）、应用层（buffalo、flink、fregata等）数据指标的动态采集、转换、采集、存储和告警系统     



个人开发工作

1. COMMITS https://github.com/songenjie/prometheus/commits/branch-v2.10.0
2. 系统架构图 https://github.com/songenjie/daily_notes/blob/master/source/prometheus_alll_monitor.jpg
3. prometheus support chinese label https://github.com/songenjie/prometheus/commit/c98f89f33c024d10ab2bfedeb7464acb9af04b88
4. prometheus resolved alter values is after value https://github.com/songenjie/prometheus/commit/d55c3575f7d81729375f17dff9d628fa0fa39652
5. support jmx to prometheus metrics https://github.com/songenjie/jmx-to-metrics
6. fix some else bug (fix thanos compact err ,数据传输等问题)
7. 封装 go log https://github.com/songenjie/go



# JD OLAP 

项目简介：OLAP解决PB级数据存储、即席查询、高效准确去重、满足多种数据源接入、兼容多种数据类型、监控Mysql协议、列式存储、高可用高并发的事实数据分析系统 平台目前主要使用 Doris,Clickhouse 两个开源产品,前期工作Doris为主，后期工作Clickhouse为主



- 主要对接以下类型业务
  1. 百亿级别订单实时按天、品类等维度统计下单金额
  2. 每天数亿的点击流数据实时统计PV与UV
  3.  kafka中的监控日志的实时分析



- 主要的性能差距是(以下只是普遍情况)
  1. 多表Join性 Doris 强于 ClickHouse
  2. 更新场景(key,value value频繁更新 ClickHouse 强于 Doris (行为都是以增代删，Clickhouse 单表计算 > Doris))
  3. 运维（Doris 维护成本 ClickHouse 大于 Doris）
  4. HA (整体方案 Doris > ClickHouse)
  5. 写入 (ClickHouse > Doris )
  6.  大查询（性能好，但是ClickHouse



## 一 DORIS

### 1 doris 适不适合你用

- Aggregate 聚合模型 key,value; key 可以是表中的多列,key 相同的数据会聚合为一行(这里最终查询为一行，实际存储可能不止一行）,value 有 sum,avg,min,max,update..几种选择
- Duplicate 数据没有主键，不聚合，适合多维分析场景

### 2 doris 基本框架
fe be 不讲

1. 数据模型 Google Mesa (聚合、版本..)
2. 查询计划 Apache Impala (查询 引擎)
3. 存储 ORC

### 3 be 存储结构
1.  cluster

2.  db

3.  table

4.  tablet(bucket) :

   tablet 是创建表的时候`DISTRIBUTED BY HASH(`user_id`) BUCKETS 16`,`PARTITION BY RANGE(`date`)`

   - table partition 是用户层的最小存储单元，sql操作的最小单元
   - table tablet 数据存储的最小物理单元，在同一个parition下，bucket==tablet 数量，所以tablet也是副本同步的最小单元理论上，因为doris支持多副本，所以同一个tablet的不同副本，不可能在同一台backend上，做 到HA

5.  rowset： rowset 是对 tablet 的拆分，一个批次导入就会生成一个rowset,所以 tablet是由连续的rowset组成，所以rowset 需要有version标记来顺序化管理

6.  version: version 是对rowset的描述和管理，所以version 有 start end 组成，相邻的rowset 会合并，就会合并为一个version,首次导入的时候，会生成一个 start:end 相同的标记，合并后就... (这里和clickhouse基本是一致的)

7.  segment: 就是磁盘上最小文件单元，segment 的出现其实是对 rowset 的进一步和磁盘、内存匹配的一个管理(导入设计合理的情况下通常为256M)，也是磁盘读写的最小单元，如果一个rowset 是由一个或多个segment 组成,所以一批次（一个rowset),就有一个或者多个segment生成；这里使用不当比如（并发大，批次小）最会生成很多零零碎碎的小的rowset,小的segment,也就会导致segment 没有意义了，所以导入要合理设计

8.  segment往下最好最需要画图

   - segment 名字${rowset_id}_${segment_id }.dat
   -  稍微看过 rowsetadd 函数都清楚，主要就是数据一行一行的append，但是为了更好的管理，增加了segment块，每个segment的schema的列也都是分开存的叫 ColumnWriter,为了方便读取每一列就会每一列append的时候，构建每一列的索引，（ordinal index 稀疏索引、ZoneMapIndex:MinMax存储、Bitmap 、BloomFilter快速过滤不匹配的行范围）
   - 还有比较特殊的就是 所以列全局的索引Short Key 36bytes最长(short key 就是aggregate key，所以 Short Key 理论上在物理上存储放的位置是和其他针对每行的索引是分开，其他就是针对整个文件的描述，比如长度，checksum..

9. 在segment 内部其实还有对数据的逻辑管理，就是Page,上面介绍的索引很多也有机遇Page 来管理的逻辑概念，默认就是1024行一个Page



### 4 数据写入 DDL

所有的写入都是Stream Load 实现，这里主要介绍FE,BE都有的处理流程 Routine Load 介绍，Routine Load 也会有Stream Load 的介绍

我画了两张图 ,详细的介绍了整个流程

[FE](https://www.processon.com/view/link/5ea8e80be0b34d05e1b7160b)    [BE](https://www.processon.com/diagraming/5eaab04563768974669ebc8b)

简单语言描述 

- FE 开始的有 QeServer 端口服务启动、到为用户创建 Session, 用户出发DDl 操作、ConnectProcessor 解析处理、StmtExecutor 做词法语法解析这里，Routine Load Manager 管理所有Routine load ,到创建Routineload Job(现在也是也就是Kakfa Routine Load Job), 跟进用户出发的DDL Kafka 字段，查询Topic信息，是否匹配（这里是fe的，到了be还会有一次）,跟进并发一系列参数创建了Routine load Task List,创建Routine Load Task Schedule, Routine load Task 就会执行ScheduleOnTask,下发到be去执行,Submit_task 通过 thirft  [关于 topic parition 并发 一个批次消费行数 超时时间的设置，这里不做赘述]

- BE 启动时候，创建ExecEnv,Backend Server ,接受 thrift过来的submit_routineload Task 请求，创建Routine load Task Executor,这里注意有线程池的概念T hreadPool, routine_load_thread_pool_size,和代码里设置的固定值 data_consumer_pool(10),所以也要合理的设计，Routine_load_task也不是里面这行，这里还有 consumer group 的概念，也是一个简单的取模实现，这里其实有一些可以优化的方案，初始化完后，就会exec_task,start_all 开始消费，这里表关键是就是和表的Tablet Hash管理的问题，到最后commit_txn
- 这里描述 数据和Tablet 匹配问题，多个Tablet会有一个Tablet Channel管理,数据加载的时候会有一个 LoadManager管理，LoadJob，LoadChannel来负责下发到不同的Tablet Channel，这里还有 BrokerScanner 数据校验的的问题，比如你ddl中（Column 字段map,是否允许为空等）



### 5 查询

查询还不是特别熟悉，可以看看官方文档，就是 元数据和索引的利用过程（这里和写入息息相关，因为数据放好了，就不用再找了）



### 个人工作

1.  JD OLAP Doris 版本维护,bug 修复等一系列工作
2. 结构集缓存(解决高QPS问题), 正在做Tablet层级的结构集缓存
3. 多数据类型兼容(json, avrò..)
4. 业务对接（优惠券、订单、物流、点击流、搜索推荐平台）
5. 外围工具融合（1 doris api sever 开发  2 跟平台数据集市融合 3 flink 模版 4 hive导入兼容等问题 5 partition ddl ）
6. 熟练 Doris 架构、存储、写入.. 等流程
7. 平台 618，双十一 支持





## ClickHouse

### 1 Clickhouse 适不适合你用

clickhouse 的入门成本要比doris高很多，兼容性基本差不多，

PV,UV 计算效率>Doris



### 2 Clickhouse 架构

1 Zookeeper 管理

2 ClickHouse 



### 存储设计

1 Cluster 

2 Table 

3 Shard (这里其实就是Doris 层次的 Bucket ,Tablet ) 

4 Replica （副本 这里比Doris 多了一层 weight 的概念，还多了查询的执行规则的概念）

5 Partition (用户层级最小的存储单位)

6 Part （part 就是Doris 层级的 Rowset,每次导入都会生成一个Part目录，名称 为带有 start_end_compactcount 三个记录

7 Column.txt Version.txt  ***.idx   ****.dat 、key Part下文件存储

8 存储

![结构](/source/clickhouse_storage1.jpg)



| .mrk           | .mrk                                                         | .mrk              |            | .binhead   | .binhead   |
| -------------- | ------------------------------------------------------------ | ----------------- | ---------- | ---------- | ---------- |
| 未压缩文件编号 | 压缩块偏移量                                                 | 未/解压缩块偏移量 | 压缩块编号 | 压缩块大小 | 未压缩大小 |
| 0              | 0                                                            | 0                 | 0          |            |            |
| 1              | 0                                                            | 8192              | 0          |            |            |
| 2              | 0                                                            | 16384             | 0          |            |            |
| 3              | 0                                                            | 24576             | 0          |            |            |
| 4              | 0                                                            | 32768             | 0          |            |            |
| 5              | 0                                                            | 40960             | 0          |            |            |
| 6              | 0                                                            | 49152             | 0          |            |            |
| 7              | 0                                                            | 57344             | 0          | 12000      | 65535      |
| 8              | 12016                                                        | 65536/0           | 1          | 14661      | 65535      |
| 9              | 12016=8(前压缩块头)+12000(前压缩块大小)+8(当前压缩块的头大小) | 8192              | 1          |            |            |
|                | 12016                                                        | ...               | 1          |            |            |
|                | ...                                                          |                   |            |            |            |
|                | 1402429                                                      |                   |            |            |            |



比较不一样的就是 Doris 一个Segment 为一个文件，Clickhouse 一列就两个文件，查询Doris会load一个 Segment,Clickhouse 只需要Load对应列即可

数据理性 Clickhouse 不如Doris String 有点...



### 写入流程

![写入流程](/source/clickhouse_table_storage.jpg)



### 个人工作

1. Clickhouse 平台兼容性设计
2.  Clickhouse HA方案设计 [单台机器，多副本，多集群，多磁盘，多进程](https://www.processon.com/view/link/5eec71e4e401fd1fd2a026b2)
3.  扩缩容/数据迁移方案 [resharding,这里可单集群，多进程多副本策略相关](https://www.processon.com/view/link/5eec8b70e0b34d4dba4879b3)
4. 集群管理 [admin_server集群管理设计](https://www.processon.com/view/link/5ee6ed2b07912929cb42b776)
5. 熟练ck 数据 存储、写入、索引 流程
6. 平台 数据实时更新场景优化
7. ...







# JD Monitor

### 项目简介：

统一监控平台 是基于CNCF组织下prometheus、thanos等组件的优化和自研组件，完成对物理层（4w台机器和其进程层（jvm）、应用层（buffalo、flink、fregata等）数据指标的动态采集、转换、采集、存储和告警系统       



### 系统架构

![系统架构](/source/prometheus_alll_monitor.jpg)



### 个人工作：

1. 参与整个系统设计、完成系统设计文档、基本参与所有组件的开发工作。做到系统的安全、高效、稳定、节能等指标
2. 利用平台有限资源完成所有服务的数据采集、存储和告警处理
3.  在数据采集端 
      1>完成被抓取目标源jvm进程暴露的jmx指标和抓取、转换和指标暴露。
      2>完成系统兼容多种目标源的采集
      3>完成对于事实数据目标源通过gateway方式，中转做到HA和数据统一性
      4>完成系统对于复杂数据类型的兼容性、如为代替原始监控系统，兼容中文数据类型，做到能完整替换原系统
4. 系统稳定性
      1>在不影响原始功能情况下，降低重要组件负载 eg(prometheus 利用对于不同抓取目标和实时性、抓取间隔要求和数据量大小等等。合理设计数据存储和抓取情况），解决prometheus down问题
      2>解决历史数据存储和慢查询问题（因原设计系统对新业务数据增多、目标增多，系统有了瓶颈）
      3>解决对历史数据压缩和downsample 处理过程进程down问题  
5. 业务高效赋能
      1>完成，数据指标报警规则的api接口开发，做到报警的动态配置
      2>所有组件基本在机器不扩容情况下做到高可用
      3>618支持

