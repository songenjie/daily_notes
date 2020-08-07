roaring bitmap,归并，快速排序 都是 二分法，二分法实际在运行时间上，每次一个逻辑循环就是处以2，所以最终就是开根号





1 doris 多列索引的支持 没有 clickhouse 好，doris 前36bytes

2 导入顺序，是实际的表字段数据 ，clickhouse有 order  by ,重新规划，doris 表的列，必须和primary key 顺序一致

3 doris 有 多列rollup(定制化 kylin cube),空间换时间

4 TTL clickhouse有 行 列 分区级别不同的ttl





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





为什么可以优化，只因为你查询的计算的数据量相对比例来看是少的，所以我们可以针对这个查询做优化



ClickHouse会自动将查询拆解为多个task下发到集群中，然后进行多机并行处理，最后把结果汇聚到一起。

```
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.464890 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Debug> executeQuery: (from [::ffff:172.18.160.19]:54726) select count(distinct alert_id) from liyang.alerts100M_d where tenant_id=11 and toDateTime(timestamp) >= toDate('2020-01-20') ;
↖ Progress: 0.00 rows, 0.00 B (0.00 rows/s., 0.00 B/s.) 
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.465537 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_d
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.465919 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_d
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.466179 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.466725 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.466923 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.467117 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 9 parts by date, 1 parts by key, 6 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.467171 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 49152 rows with 1 streams
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.467252 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.467708 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.468598 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Debug> executeQuery: (from [::ffff:10.196.102.231]:50970, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.465540 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Debug> executeQuery: (from [::ffff:10.196.102.231]:55464, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.478829 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Debug> executeQuery: (from [::ffff:10.196.102.231]:40102, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.467866 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Debug> executeQuery: (from [::ffff:10.196.102.231]:11804, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.465233 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Debug> executeQuery: (from [::ffff:10.196.102.231]:54944, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.470039 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Debug> executeQuery: (from [::ffff:10.196.102.231]:37690, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.474229 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Debug> executeQuery: (from [::ffff:10.196.102.231]:52994, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.468790 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Debug> executeQuery: (from [::ffff:10.196.102.231]:27258, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.468657 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Debug> executeQuery: (from [::ffff:10.196.102.231]:51858, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.469041 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Debug> executeQuery: (from [::ffff:10.196.102.231]:56578, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.476345 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Debug> executeQuery: (from [::ffff:10.196.102.231]:24032, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.471244 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Debug> executeQuery: (from [::ffff:10.196.102.231]:29904, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.460814 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Debug> executeQuery: (from [::ffff:10.196.102.231]:50100, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.464967 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Debug> executeQuery: (from [::ffff:10.196.102.231]:25058, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.472550 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Debug> executeQuery: (from [::ffff:10.196.102.231]:44894, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.469781 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Debug> executeQuery: (from [::ffff:10.196.102.231]:23448, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.468506 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Debug> executeQuery: (from [::ffff:10.196.102.231]:43116, initial_query_id: 250bcc2a-db98-4d81-aef2-bc9149ca0ae3) SELECT uniqExact(alert_id) FROM liyang.alerts100M_l WHERE (tenant_id = 11) AND (toDateTime(timestamp) >= toDate('2020-01-20'))
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.469012 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.469617 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.469757 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.469832 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 8 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.469912 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.470229 [ 113010 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.470261 [ 113010 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.000237744 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.470301 [ 113010 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.471085 [ 16329 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> MergingAggregatedTransform: Reading blocks of partially aggregated data.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.471104 [ 16315 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> AggregatingTransform: Aggregating
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.476778 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.477399 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.477546 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.477604 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 4 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.477691 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.478028 [ 74385 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.478063 [ 74385 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00025547 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.478088 [ 74385 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.469271 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.469950 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.470110 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.470170 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 4 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.470251 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.470554 [ 19192 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.470599 [ 19192 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.000216023 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.470610 [ 19192 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.471144 [ 16315 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.470451 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471060 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471201 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471289 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 8 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471372 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471733 [ 35475 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471819 [ 35475 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.000300861 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.471847 [ 35475 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.479234 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480000 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480188 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480246 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 5 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480357 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480730 [ 102725 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480787 [ 102725 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00030915 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.480822 [ 102725 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 16:33:43.470734 [ 116076 ] {d87c3fb8-a32c-4ff0-a15a-5e6380e4e3c4} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.461217 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.461905 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.462043 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.462112 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 8 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.462188 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.462515 [ 5583 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.462554 [ 5583 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.000224218 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.462638 [ 5583 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 16:33:43.478513 [ 91159 ] {30f339c5-c050-4286-a9e5-4d18fa8c6d5e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.469492 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470127 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470283 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470405 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 10 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470512 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470865 [ 127620 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470921 [ 127620 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.000295805 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.470969 [ 127620 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 16:33:43.471014 [ 28474 ] {1bf87204-b683-4797-9de3-5d00f901a653} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 16:33:43.472287 [ 39944 ] {40438f06-7b48-4799-a7d4-61f6593c1095} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 16:33:43.481231 [ 106043 ] {6cc1eab2-a80b-4f80-8d90-ec265f7b4d0a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 16:33:43.463123 [ 8078 ] {d0320b68-7ff2-4456-92a7-d6e193e54751} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 16:33:43.471445 [ 131014 ] {bd412a65-dd4e-456a-8bd3-d0d43ca4cbc3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.465655 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.466246 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.466387 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.466521 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 8 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.466567 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.466628 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.468424 [ 32367 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.468461 [ 32367 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.001738996 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.468486 [ 32367 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.468302 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.468942 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.469107 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.469234 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 7 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.469280 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.469344 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.471260 [ 110048 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.471297 [ 110048 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.001832969 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.471310 [ 110048 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.469145 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.469808 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.470034 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.470206 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 10 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.470278 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.470359 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.472165 [ 97802 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.472206 [ 97802 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.001729842 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.472214 [ 97802 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.468827 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Information> executeQuery: Read 8192 rows, 131.48 KiB in 0.003556166 sec., 2303604 rows/sec., 36.11 MiB/sec.
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 16:33:43.468871 [ 41655 ] {35bd3c69-056d-46c0-a28d-832f19365136} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.465389 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.466073 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.466221 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.466367 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 9 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.466429 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.466493 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.468269 [ 128155 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.468313 [ 128155 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.001715042 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.468336 [ 128155 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.470151 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.470878 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.471052 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.471243 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 8 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.471321 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.471402 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.473067 [ 27050 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.473103 [ 27050 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.0015389 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.473116 [ 27050 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.473033 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.473658 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.473802 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.473973 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 6 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.474031 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.474113 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.475984 [ 81157 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.476016 [ 81157 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00178443 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.476044 [ 81157 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.471721 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.472630 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.472851 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.473053 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 7 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.473148 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.473311 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.474718 [ 102908 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.474752 [ 102908 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.001253128 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.474760 [ 102908 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.474688 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.475451 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.475664 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.475809 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 7 parts by date, 1 parts by key, 1 marks to read from 1 ranges
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.475903 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 8192 rows with 1 streams
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.475988 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.477820 [ 57047 ] {33826da4-2599-4113-9517-edac68e0749c} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.477863 [ 57047 ] {33826da4-2599-4113-9517-edac68e0749c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.001758151 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.477939 [ 57047 ] {33826da4-2599-4113-9517-edac68e0749c} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.471745 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Information> executeQuery: Read 8192 rows, 176.45 KiB in 0.003825949 sec., 2141168 rows/sec., 45.04 MiB/sec.
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 16:33:43.471786 [ 112656 ] {a2a9b7da-b46e-4556-9527-c99017bc9a58} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.472593 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Information> executeQuery: Read 8192 rows, 171.11 KiB in 0.003883477 sec., 2109449 rows/sec., 43.03 MiB/sec.
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 16:33:43.472628 [ 107855 ] {5809b9ad-be7c-457a-b66f-e3cf260b5c36} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.473585 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Information> executeQuery: Read 8192 rows, 153.52 KiB in 0.003762118 sec., 2177496 rows/sec., 39.85 MiB/sec.
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 16:33:43.473619 [ 29981 ] {288d073e-399f-4a3b-aabb-74c4b72b60d0} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.468781 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Information> executeQuery: Read 8192 rows, 132.31 KiB in 0.003768977 sec., 2173534 rows/sec., 34.28 MiB/sec.
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 16:33:43.468817 [ 128367 ] {60cea4ab-c0d5-45b4-a67e-e8b5d2349ee3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.476468 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Information> executeQuery: Read 8192 rows, 179.98 KiB in 0.003838841 sec., 2133977 rows/sec., 45.79 MiB/sec.
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 16:33:43.476505 [ 88470 ] {2e63d38b-681f-45d9-8284-6e682d364e94} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.478331 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Information> executeQuery: Read 8192 rows, 115.17 KiB in 0.004048794 sec., 2023318 rows/sec., 27.78 MiB/sec.
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 16:33:43.478361 [ 64425 ] {33826da4-2599-4113-9517-edac68e0749c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.475156 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Information> executeQuery: Read 8192 rows, 264.20 KiB in 0.003861234 sec., 2121601 rows/sec., 66.82 MiB/sec.
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 16:33:43.475200 [ 112006 ] {2c52838e-f1c7-4891-b7d6-eb1ffa717c8a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.469179 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.469895 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.470904 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.471127 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 9 parts by date, 0 parts by key, 0 marks to read from 0 ranges
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.471262 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.471824 [ 25883 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.471874 [ 25883 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.000400135 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.471889 [ 25883 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 16:33:43.473296 [ 36644 ] {2b107841-a079-42da-8e5a-f9e85d81a9d6} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.465960 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Debug> InterpreterSelectQuery: MergeTreeWhereOptimizer: condition "toDateTime(timestamp) >= toDate('2020-01-20')" moved to PREWHERE
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.466639 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> ContextAccess (default): Access granted: SELECT(tenant_id, alert_id, timestamp) ON liyang.alerts100M_l
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.466787 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Debug> liyang.alerts100M_l (SelectExecutor): Key condition: (toDateTime(column 1) in [1579449600, +inf)), (column 0 in [11, 11]), and, (toDateTime(column 1) in [1579449600, +inf)), and
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.467027 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Debug> liyang.alerts100M_l (SelectExecutor): Selected 10 parts by date, 4 parts by key, 4 marks to read from 4 ranges
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.467125 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> liyang.alerts100M_l (SelectExecutor): Reading approx. 32768 rows with 4 streams
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.467262 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.469727 [ 126570 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.469761 [ 126570 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.002313457 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470203 [ 126529 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470241 [ 126529 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00278224 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470579 [ 126543 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470601 [ 126543 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.003150642 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470652 [ 126563 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> Aggregator: Aggregation method: without_key
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470688 [ 126563 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.003227384 sec. (0.0 rows/sec., 0.00 B/sec.)
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.470702 [ 126563 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.471430 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Information> executeQuery: Read 32768 rows, 2.00 MiB in 0.005819995 sec., 5630245 rows/sec., 343.02 MiB/sec.
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 16:33:43.471464 [ 129791 ] {2c792ea5-5114-4ab9-b28b-bfd4930ab67c} <Debug> MemoryTracker: Peak memory usage (for query): 4.79 MiB.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.478886 [ 16315 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> AggregatingTransform: Aggregated. 36752 to 1 rows (from 2.56 MiB) in 0.011537493 sec. (3185440.7192273056 rows/sec., 221.76 MiB/sec.)
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.478906 [ 16315 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> Aggregator: Merging aggregated data
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.479025 [ 16305 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> MergingAggregatedTransform: Read 18 blocks of partially aggregated data, total 18 rows.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.479127 [ 16305 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> Aggregator: Merging partially aggregated single-level data.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.481998 [ 16305 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> Aggregator: Merged partially aggregated single-level data.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.482031 [ 16305 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> Aggregator: Converting aggregated data to blocks
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.482078 [ 16305 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Trace> Aggregator: Converted aggregated data to blocks. 1 rows, 8.00 B in 3.3365e-05 sec. (29971.52704930316 rows/sec., 234.15 KiB/sec.)
┌─uniqExact(alert_id)─┐
│               36752 │
└─────────────────────┘
↑ Progress: 0.00 rows, 0.00 B (0.00 rows/s., 0.00 B/s.) 
↗ Progress: 147.46 thousand rows, 6.94 MB (5.65 million rows/s., 265.63 MB/s.)  99%
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.482879 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Information> executeQuery: Read 147456 rows, 6.62 MiB in 0.01792554 sec., 8226028 rows/sec., 369.11 MiB/sec.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 16:33:43.482908 [ 39458 ] {250bcc2a-db98-4d81-aef2-bc9149ca0ae3} <Debug> MemoryTracker: Peak memory usage (for query): 4.16 MiB.

1 rows in set. Elapsed: 0.026 sec. Processed 147.46 thousand rows, 6.94 MB (5.61 million rows/s., 263.97 MB/s.)
```

- 方式一：使用钉钉搜索群号 23300515
- 方式二：使用钉钉扫描下方二维码

![image.png](https://ata2-img.cn-hangzhou.oss-pub.aliyun-inc.com/04414db96aa760d1cc1f44203c375551.png)