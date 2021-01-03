- [1 引擎研究](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1引擎研究)
  - [1.1 高可用架构](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1.1高可用架构)
  - [1.2 高并发和查询优化](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1.2高并发和查询优化)
    - [1.2.1 SQL引擎（吴建超 ）](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1.2.1SQL引擎（）)
    - [1.2.2 执行引擎 （@阳仔）](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1.2.2执行引擎（@阳仔）)
  - [1.3 数据存储（吴建超 ） ](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1.3数据存储（）)
  - [1.4 多场景低延时写入](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-1.4多场景低延时写入)
- [2 集群部署和业务支持](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-2集群部署和业务支持)
  - [2.1 多租户、权限和配额 ](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-2.1多租户、权限和配额)
  - [2.2 容器化和存储计算分离 @阳仔](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-2.2容器化和存储计算分离@阳仔)
  - [2.3 应用案例和业务支持](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-2.3应用案例和业务支持)
  - [2.4 构建测试集](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-2.4构建测试集)
- [3 管控面产品化（李阳、高明、王倩）](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-3管控面产品化（李阳、高明、王倩）)
  - [3.1 部署和配置下发](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-3.1部署和配置下发)
  - [3.2 管理后台](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-3.2管理后台)
  - [3.3 用户前台](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-3.3用户前台)
  - [3.4 监控报警](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-3.4监控报警)
  - [3.5 导入服务化](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-3.5导入服务化)
- [4. 618之后的规划](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-4.618之后的规划)
- [参考资料](https://cf.jd.com/pages/viewpage.action?pageId=384189857#OLAP研究方向-参考资料)



包含Clickhouse、Doris等OLAP引擎

## 1 引擎研究

### 1.1 高可用架构

目标：节点故障不影响业务使用；可以方便扩缩容；架构上可以支持大共享集群

方向：

1. 元数据同步，暂不具备 P0 @海波、 [王高明](https://cf.jd.com/display/~wanggaoming1)
2. 多副本同步，这块强依赖ZK，ZNode占比高 P1 [宋恩杰](https://cf.jd.com/display/~songenjie)
3. 查询、写入、DDL操作的高可用研究 P1 恩杰      
   1. 查询通过域名，需要配置IP映射，不利于配额限制，不方便节点变更 - 建议通过反向代理，推荐用官方的连接库 （@阳仔 [王高明](https://cf.jd.com/display/~wanggaoming1) ）
   2. 写入是业务方做的容错处理，建议通过CHProxy来转发，分布式表+本地表 （@阳仔 [王高明](https://cf.jd.com/display/~wanggaoming1) [王倩](https://cf.jd.com/display/~wangqian445) ）
   3. 节点故障DDL操作是无法执行的，需要手工下线后，用节点恢复工具 P0
4. 故障节点自动下线，扩容自动上线 P0 @海波、@建超
   1. 支持故障节点下线和上线
5. 集群扩缩容 P1 @海波 @建超 @阳仔
   1. 扩分片、扩副本
   2. 扩容后数据均衡
6. 简化配置操作
   1. set global on cluster default key = value

### 1.2 高并发和查询优化

1. 慢查询诊断和优化
   1. 慢查询统计、简单诊断（未加分区条件、Join太多、字段类型、精确去重或GroupBy...）和反馈 P0
2. 大查询隔离和小查询加速（资源队列）
   1. 慢查询线程数控制（核数）、并发数控制、队列控制，小查询提升优先级 P2
3. 结果集缓存提升并发
   1. 带版本的结果集缓存 P0
   2. 按时间周期缓存 P0
4. 表引擎、字段、字段类型、索引、物化视图对性能的优化影响
5. Explain - ClickHouse下个版本21.0 P1

#### 1.2.1 SQL引擎（[吴建超](https://cf.jd.com/display/~wujianchao5) ）

1. AST生成流程
2. **query optimization P2**
3. 增加、修改sql语法
4. **增加自定义函数 P1**

#### **1.2.2 执行引擎 （@阳仔）**

1. 执行引擎整体架构
2. SIMD在ch中的应用 
3. 哪些算子实现了向量化，哪些算子没有以及是否可以
4. 动态生成算子机制
5. 其它提升性能的设计
6. **distributed join性能低 P2**

### 1.3 数据存储（[吴建超](https://cf.jd.com/display/~wujianchao5) ） 

1. 数据合并策略 P2
   1. 加快合并或减缓合并
   2. 合并对ZK依赖，合并对副本影响
2. 稀疏索引机制 P2
   1. 索引在存储和扫描中的作用
   2. 研究二级稠密索引应对KV查询
3. 物化视图聚合逻辑 P2
   1. 聚合的机制
   2. 研究一下多层聚合，多表聚合
4. 冷热数据分层存储 P2
   1. 热数据本地、冷数据HDFS
   2. 热数据本地自动缓存机制
5. 研究Kudu支持单条更新需求
6. 研究读写分离方案（比如只读副本和只写副本）

### 1.4 多场景低延时写入

1. 实时场景数据低延时写入
2. 离线场景数据大批量写入
3. 混合写入时配额控制和优化
4. 集群迁移（clickhouse-copier迁移、ZK多副本迁移）

## 2 集群部署和业务支持

### 2.1 多租户、权限和配额 

1. 多租户的CPU/内存/磁盘/连接数/查询/插入等配额限制   （ [王倩](https://cf.jd.com/display/~wangqian445) [吴建超](https://cf.jd.com/display/~wujianchao5) ）
2. 多租户的数据分组按节点控制，逻辑集群 P2

### 2.2 容器化和存储计算分离 @阳仔

1. JDOS容器化部署OLAP   ( [王倩](https://cf.jd.com/display/~wangqian445) )
2. 数据存储在ChuBao/Hive中

### 2.3 应用案例和业务支持

1. 数据更新 @海波
2. 近似去重 @阳仔
3. 物化视图加速查询 @阳仔
4. 字典表加速查询
5. JOIN

### 2.4 构建测试集

1. TPC-DS测试集
2. 性能测试工具和用例

## 3 管控面产品化（李阳、高明、王倩）

### 3.1 部署和配置下发

1. 对接CI/CD程序通过鲲鹏发布
2. 配置文件修改通过阿波罗分发（[吴建超](https://cf.jd.com/display/~wujianchao5) ）

### 3.2 管理后台

OLAP团队日常运营和运维操作，前台（权限控制）+后台

1. 集群管理
   1. 整合鲲鹏、Minos（李阳）、阿波罗等，部署、配置下发、分片和副本管理
   2. 扩缩容
2. 用户、权限管理
3. 配额管理，日常配额调整
   1. 账户配额设置，内存、查询、扫描行等
4. 进程管理，Query查杀或Drop操作查杀
5. 节点重启上下线，故障节点重启或手工下线
6. 数据迁移工具
7. 库表的数据均衡

### 3.3 用户前台

1. 业务登记、账号管理
2. 库表管理
3. TTL设置
4. 查询分析器
5. 慢查询日志
6. 监控报警
7. 工单系统

### 3.4 监控报警

1. 监控报警集成到用户前台，用户可以自己配置感兴趣的集群的监控报警

### **3.5 导入服务化**

1. **离线**
2. **实时**

## 4. 618之后的规划

![img](https://cf.jd.com/download/attachments/384189857/image2020-11-23_14-36-21.png?version=1&modificationDate=1606113382000&api=v2)

## 参考资料

- 官方：Concept: "Cloud" MergeTree Tables：https://clickhouse.tech/blog/en/2018/concept-cloud-mergetree-tables/
- 阿里：ClickHouse内核分析-ZooKeeper在分布式集群中的作用以及ReplicatedMergeTree表引擎的实现：https://developer.aliyun.com/article/762917
- 阿里：四两拨千斤：小巧新秀ClickHouse如何完美支撑史上最强双十一？：https://developer.aliyun.com/article/778258?spm=a2c6h.12873581.0.dArticle778258.3c8e2217s7ZmZV
- 阿里：ClickHouse内核分析-MergeTree的存储结构和查询加速：https://developer.aliyun.com/article/761931?spm=a2c6h.12873639.0.0.2ab340111juk3i
- 小结：趣头条&头条ch使用案例：https://git.jd.com/jdolap/clickhouse/issues/152
- 头条：ClickHouse 在头条内部技术演化：[https://static001.geekbang.org/con/38/pdf/3911391966/file/ClickHouse%20%E5%9C%A8%E5%A4%B4%E6%9D%A1%E7%9A%84%E6%8A%80%E6%9C%AF%E6%BC%94%E8%BF%9B-%E9%99%88%E6%98%9F.pdf](https://static001.geekbang.org/con/38/pdf/3911391966/file/ClickHouse 在头条的技术演进-陈星.pdf)
- 趣头条：趣头条基于ClickHouse玩转每天1000亿数据量：https://www.infoq.cn/article/g94gMf26m6ONtNeoe0r5
- 官方：ch Road Map：https://git.jd.com/jdolap/clickhouse/issues/153