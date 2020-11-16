| Name                                      | olap value   | liuyan value | Define                                                       | important                                                    |
| ----------------------------------------- | ------------ | ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| background_pool_size                      | 32           | 16           |                                                              |                                                              |
| any_join_distinct_right_table_keys        | 0            | 1            | Enable old ANY JOIN logic with many-to-one left-to-right table keys mapping for all ANY JOINs. It leads to confusing not equal results for 't1 ANY LEFT JOIN t2' and 't2 ANY RIGHT JOIN t1'. ANY RIGHT JOIN needs one-to-many keys maping to be consistent with LEFT one. |                                                              |
| ßconnect_timeout_with_failover_ms         | 50           | 1000         | Connection timeout for selecting first healthy replica.      | 1                                                            |
| empty_result_for_aggregation_by_empty_set | 0            | 1            | Return empty result when aggregating without keys on empty set.  查看看到很多空的情况 | operation absent) on empty set (e.g., **SELECT count(\*) FROM table WHERE 0**). **true**—ClickHouse will return an empty result for such queries. **false** (default)—ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. |
| enable_optimize_predicate_expression      | 1            | 0            | If it is set to true, optimize predicates to subqueries.     | 1                                                            |
| enable_scalar_subquery_optimization       | 1            | 0            | If it is set to true, prevent scalar subqueries from (de)serializing large scalar values and possibly avoid running the same subquery more than once. | 1                                                            |
| experimental_use_processors               | 1            | 0            | Use processors pipeline.                                     |                                                              |
| joined_subquery_requires_alias            | 1            | 0            | Force joined subqueries to have aliases for correct name qualification. | 1                                                            |
| load_balancing                            | Round_robin  | Random       |                                                              |                                                              |
| mark_cache_min_lifetime                   | 0            | 10000        | If the maximum size of mark_cache is exceeded, delete only records older than mark_cache_min_lifetime seconds. | 1                                                            |
| max_alter_threads                         | Auto(48)     | Auto(8)      |                                                              |                                                              |
| max_ast_elements                          | 50000        | 10000000     | Maximum size of query syntax tree in number of nodes. Checked after parsing. | 1                                                            |
| max_bytes_before_external_group_by        | 0            | 10737418240  |                                                              | 提高 uniq 查询如果需要使用max_bytes_before_external_group_by，建议将max_memory_usage设置为max_bytes_before_external_group_by大小的两倍。 |
| max_bytes_before_external_sort            | 0            | 10737418240  | external bytes                                               |                                                              |
| max_concurrent_queries_for_user           | 500          | 0            |                                                              |                                                              |
| max_distributed_connections               | 1024         | 2000         |                                                              |                                                              |
| max_execution_time                        | 0            | 2000         | 查询执行时长                                                 | 1                                                            |
| max_expanded_ast_elements                 | 500000       | 10000000     | Maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. │ | 1                                                            |
| max_memory_usage                          | 82463372083  | 27917287424  |                                                              |                                                              |
| max_memory_usage_for_all_queries          | 164926744166 | 23622320128  |                                                              |                                                              |
| max_partitions_per_insert_block           | 1000         | 100          | 100                                                          |                                                              |
| max_threads                               | Auto(48)     | 16           |                                                              |                                                              |
| min_count_to_compile                      | 0            | 3            |                                                              |                                                              |
| partial_merge_join_optimizations          | 32000000     | 0            | Enable optimizations in partial merge join                   | 1                                                            |
| partial_merge_join_rows_in_left_blocks    | 1            | 10000        | Group left-hand joining data in bigger blocks. Setting it to a bigger value increase JOIN performance and memory usage. | 1                                                            |
| partial_merge_join_rows_in_right_blocks   | 65535        | 10000        | Split right-hand joining data in blocks of specified size. It's a portion of data indexed by min-max values and possibly unloaded on disk. | 1                                                            |
| queue_max_wait_ms                         | 5000         | 5000000      | The wait time in the request queue, if the number of concurrent requests exceeds the maximum. |                                                              |
| send_logs_level                           | Fatal        | Error        |                                                              |                                                              |
| timeout_before_checking_execution_speed   | 10           | 0            | Check that the speed is not too low after the specified time has elapsed. |                                                              |







- max_bytes_before_external_group_by

用于处理分组汇总结果行超大时的情况，通常汇总的结果不会太大时可以不用设置。该值为一个字节数，如果设置了该值，每当聚合计算中间处理结果的字节占用超过该值时，会将数据放到磁盘临时目录(tmp_path)上，以减少计算时的内存占用，避免内存不足导致内存不足或执行失败，但如此查询速度会出现明显下降。鉴于聚合计算的 2步骤的实现机制，如果设置该值，建议将该值设置为可承受的单次最大内存（max_memory_usage）的一半大小，因为聚合计算对中间结果做处理的第二步同样会占用相当的内存。

- max_bytes_before_external_sort

与上一项设置作用类似，用于处理排序占用内存过大的情况。每当读取到排序数据达到指定大小时，数据会被排序并写入磁盘，当读取完成后，再将磁盘排序数据合并输出。由于查询时除排序外还会有其他内存占用（视查询的内容不同不定），如果设置则该值必须要小于单次查询的最大内存（max_memory_usage）。

排序在DataViz中使用较多，建议对该值进行设置。

按照官网文档说明，对于单次查询场景，128G内存可设置max_memory_usage为100G, max_bytes_before_external_sort设置为80G。实际测试显示，单机8G物理内存，单次执行1.6亿行的数据集1个排序字段向后翻页查询8个字段数据，配置max_bytes_before_external_sort 为 3000000000 （3G）时，内存使用峰值为5.2GB，配置为 4000000000（4G）时，内存使用峰值为6.9GB。考虑实际运行时会同时运行多个查询，可选取设置为相对较低的值。

该值也不要设置过低（如数K、数M），否则单次排序数量过少，最终合并内容过多，也会出现内存占用过多导致执行失败。

- enable_optimize_predicate_expression

Turns on predicate pushdown in `SELECT` queries.

Predicate pushdown may significantly reduce network traffic for distributed queries.

Possible values:

- 0 — Disabled.
- 1 — Enabled.

Default value: 1.

Usage

Consider the following queries:

1. `SELECT count() FROM test_table WHERE date = '2018-10-10'`
2. `SELECT count() FROM (SELECT * FROM test_table) WHERE date = '2018-10-10'`

If `enable_optimize_predicate_expression = 1`, then the execution time of these queries is equal because ClickHouse applies `WHERE` to the subquery when processing it.

If `enable_optimize_predicate_expression = 0`, then the execution time of the second query is much longer because the `WHERE` clause applies to all the data after the subquery finishes.



- empty_result_for_aggregation_by_empty_set
  - 
  - operation absent) on empty set (e.g., **SELECT count(\*) FROM table WHERE 0**).
  - **true**—ClickHouse will return an empty result for such queries.
  - **false** (default)—ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard.



- log  empty 

```
2020.11.01 00:03:45.803952 [ 229260 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> AggregatingTransform: Aggregating2020.11.01 00:03:45.803985 [ 229260 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:45.804744 [ 228035 ] {db5278f0-b252-4de4-a4b4-91b1ff38408e} <Trace> AggregatingTransform: Aggregating2020.11.01 00:03:45.804797 [ 228035 ] {db5278f0-b252-4de4-a4b4-91b1ff38408e} <Trace> Aggregator: Aggregation method: key_string2020.11.01 00:03:45.817688 [ 35889 ] {7ab01008-73d8-4a22-8ded-11e65a022bf3} <Trace> ContextAccess (default): Access granted: SELECT(bs, shop_id, sale_mode, item_sku_id, user_log_acct, mins, deal_user_flag, dt) ON default.app_s01_user_ord_det_snapshot_day_new_local
2020.11.01 00:03:45.840647 [ 227265 ] {fcc50030-ff91-4bf0-a58c-8e62e6eac97c} <Trace> AggregatingTransform: Aggregated. 112 to 44 rows (from 3.85 KiB) in 3.714795611 sec. (30.149707205519793 rows/sec., 1.04 KiB/sec.)
2020.11.01 00:03:45.842567 [ 226504 ] {6a354a13-814a-47d4-9767-dba1ea744bb6} <Trace> AggregatingTransform: Aggregated. 6 to 3 rows (from 207.00 B) in 2.136009043 sec. (2.8089768719204806 rows/sec., 96.91 B/sec.)
2020.11.01 00:03:45.846099 [ 91507 ] {29355fd3-eff5-445f-97fa-e8003d3d81eb} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 12.024021092 sec. (0.0 rows/sec., 0.00 B/sec.)2020.11.01 00:03:45.855552 [ 172871 ] {5e465f48-06f3-4515-9fc4-f0a5eb8a7327} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:45.855595 [ 172871 ] {5e465f48-06f3-4515-9fc4-f0a5eb8a7327} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:45.856428 [ 225786 ] {1050138d-7179-4130-bd39-eb310e2bcb47} <Trace> ContextAccess (default): Access granted: dictGet ON dict.dict_sku
2020.11.01 00:03:45.856912 [ 88359 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:45.856933 [ 88359 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> Aggregator: Aggregation method: without_key2020.11.01 00:03:45.927750 [ 225241 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Trace> MergingAggregatedTransform: Read 0 blocks of partially aggregated data, total 0 rows.
2020.11.01 00:03:45.927787 [ 225241 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Trace> Aggregator: Converting aggregated data to blocks2020.11.01 00:03:46.051410 [ 225241 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 12.427226416 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.051459 [ 225241 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Trace> Aggregator: Merging aggregated data
2020.11.01 00:03:46.100186 [ 225786 ] {1050138d-7179-4130-bd39-eb310e2bcb47} <Trace> ContextAccess (default): Access granted: dictGet ON dict.dict_shop2020.11.01 00:03:46.146967 [ 173141 ] {c88f2092-98c2-4c03-ab3e-8e59e0368ecb} <Debug> default.app_s01_user_ord_det_snapshot_day_new_local (SelectExecutor): Selected 9 parts by date, 9 parts by key, 250 marks to read from 9 ranges
2020.11.01 00:03:46.153365 [ 227373 ] {7e61cd85-d194-4463-8aeb-c11c14c7ded6} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 12.934473241 sec. (0.0 rows/sec., 0.00 B/sec.)2020.11.01 00:03:46.178122 [ 227082 ] {697d0886-05fc-486e-88b1-697d6f8b766f} <Trace> AggregatingTransform: Aggregated. 382 to 5 rows (from 14.23 KiB) in 6.646761752 sec. (57.471595079371816 rows/sec., 2.14 KiB/sec.)
2020.11.01 00:03:46.208802 [ 35889 ] {7ab01008-73d8-4a22-8ded-11e65a022bf3} <Debug> default.app_s01_user_ord_det_snapshot_day_new_local (SelectExecutor): Key condition: unknown, unknown, and, (column 31 in [0, +inf)), and, (column 31 in (-inf, 0]), and, (column 0 in 1-element set), (column 24 in 200-element set), and, unknown, and, unknown, and, and, unknown, unknown, and, (column 31 in [0, +inf)), and, (column 31 in (-inf, 0]), and, and
2020.11.01 00:03:46.208867 [ 35889 ] {7ab01008-73d8-4a22-8ded-11e65a022bf3} <Debug> default.app_s01_user_ord_det_snapshot_day_new_local (SelectExecutor): MinMax index condition: (column 0 in [18201, +inf)), (column 0 in (-inf, 18201]), and, unknown, and, unknown, and, unknown, unknown, and, unknown, and, unknown, and, and, (column 0 in [18201, +inf)),(column 0 in (-inf, 18201]), and, unknown, and, unknown, and, and
2020.11.01 00:03:46.214565 [ 173141 ] {c88f2092-98c2-4c03-ab3e-8e59e0368ecb} <Trace> default.app_s01_user_ord_det_snapshot_day_new_local (SelectExecutor): Reading approx. 2010195 rows with 11 streams
2020.11.01 00:03:46.218308 [ 35889 ] {7ab01008-73d8-4a22-8ded-11e65a022bf3} <Debug> default.app_s01_user_ord_det_snapshot_day_new_local (SelectExecutor): Selected 9 parts by date, 9 parts by key, 250 marks to read from 9 ranges
2020.11.01 00:03:46.229365 [ 173141 ] {c88f2092-98c2-4c03-ab3e-8e59e0368ecb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState2020.11.01 00:03:46.234060 [ 88341 ] {6a354a13-814a-47d4-9767-dba1ea744bb6} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 2.527420684 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.239727 [ 226867 ] {9897d079-549e-4061-8737-2b38e407592f} <Trace> AggregatingTransform: Aggregating2020.11.01 00:03:46.239776 [ 226867 ] {9897d079-549e-4061-8737-2b38e407592f} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.242148 [ 157095 ] {7d4088f5-7ac6-488b-b0ae-7fa5a4662820} <Trace> ContextAccess (default): Access granted: dictGet ON dict.dict_sku
2020.11.01 00:03:46.242504 [ 157095 ] {7d4088f5-7ac6-488b-b0ae-7fa5a4662820} <Trace> ContextAccess (default): Access granted: dictGet ON dict.dict_shop
2020.11.01 00:03:46.255995 [ 228497 ] {6a354a13-814a-47d4-9767-dba1ea744bb6} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.257033 [ 224851 ] {43307e32-8504-439e-aeff-ccb89fe28a16} <Debug> CreatingSetsBlockInputStream: Created Join with 1 entries from 1 rows in 12.07168444 sec.
2020.11.01 00:03:46.260567 [ 228497 ] {6a354a13-814a-47d4-9767-dba1ea744bb6} <Trace> Aggregator: Aggregation method: key_string
2020.11.01 00:03:46.261627 [ 229255 ] {} <Debug> MemoryTracker: Peak memory usage (for query): 41.02 MiB.
2020.11.01 00:03:46.263862 [ 228036 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Debug> CreatingSetsBlockInputStream: Subquery has empty result.
2020.11.01 00:03:46.271094 [ 228379 ] {1b9be5da-c72d-44c5-b7aa-671f9fedd133} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.274881 [ 228379 ] {1b9be5da-c72d-44c5-b7aa-671f9fedd133} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 10.098419755 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.267439 [ 35889 ] {7ab01008-73d8-4a22-8ded-11e65a022bf3} <Trace> default.app_s01_user_ord_det_snapshot_day_new_local (SelectExecutor): Reading approx. 2010195 rows with 11 streams
2020.11.01 00:03:46.284265 [ 226703 ] {7e61cd85-d194-4463-8aeb-c11c14c7ded6} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 13.065615663 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.295115 [ 12385 ] {52b4625d-0653-4249-8af4-c9917d5728bf} <Trace> AggregatingTransform: Aggregated. 1663 to 97 rows (from 67.56 KiB) in 11.680708618 sec. (142.37149940007174 rows/sec., 5.78 KiB/sec.)
2020.11.01 00:03:46.296113 [ 229313 ] {5e465f48-06f3-4515-9fc4-f0a5eb8a7327} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.296142 [ 229313 ] {5e465f48-06f3-4515-9fc4-f0a5eb8a7327} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.298939 [ 226601 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.298989 [ 226601 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 7.44471669 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.328375 [ 228203 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Trace> ContextAccess (biz): Access granted: dictGet ON dict.dict_sku
2020.11.01 00:03:46.329854 [ 229352 ] {db5278f0-b252-4de4-a4b4-91b1ff38408e} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.330111 [ 35889 ] {7ab01008-73d8-4a22-8ded-11e65a022bf3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
2020.11.01 00:03:46.334490 [ 229352 ] {db5278f0-b252-4de4-a4b4-91b1ff38408e} <Trace> Aggregator: Aggregation method: key_string
2020.11.01 00:03:46.337693 [ 228203 ] {a260a6a8-f4e2-46db-8bca-59cfc6a8435d} <Trace> ContextAccess (biz): Access granted: dictGet ON dict.dict_shop
2020.11.01 00:03:46.341458 [ 225228 ] {9bf1f62c-5585-460e-a196-99a6f2d96469} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.341523 [ 225228 ] {9bf1f62c-5585-460e-a196-99a6f2d96469} <Trace> Aggregator: Aggregation method: key_string
2020.11.01 00:03:46.341550 [ 225228 ] {9bf1f62c-5585-460e-a196-99a6f2d96469} <Trace> Aggregator: Converting aggregation data to two-level.
2020.11.01 00:03:46.341563 [ 227992 ] {6b13673c-ac9a-412a-9dfb-e3a0d12722db} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 1.008010774 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.341614 [ 227992 ] {6b13673c-ac9a-412a-9dfb-e3a0d12722db} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 1.008058214 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.346748 [ 60303 ] {52b4625d-0653-4249-8af4-c9917d5728bf} <Trace> AggregatingTransform: Aggregated. 701 to 96 rows (from 27.33 KiB) in 11.734084147 sec. (59.74049539939778 rows/sec., 2.33 KiB/sec.)
2020.11.01 00:03:46.347860 [ 225202 ] {43307e32-8504-439e-aeff-ccb89fe28a16} <Trace> ContextAccess (biz): Access granted: dictGet ON dict.dict_sku
2020.11.01 00:03:46.371066 [ 225202 ] {43307e32-8504-439e-aeff-ccb89fe28a16} <Trace> ContextAccess (biz): Access granted: dictGet ON dict.dict_shop
2020.11.01 00:03:46.376710 [ 228632 ] {db5278f0-b252-4de4-a4b4-91b1ff38408e} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.376775 [ 228632 ] {db5278f0-b252-4de4-a4b4-91b1ff38408e} <Trace> Aggregator: Aggregation method: key_string
2020.11.01 00:03:46.391529 [ 173219 ] {29355fd3-eff5-445f-97fa-e8003d3d81eb} <Trace> AggregatingTransform: Aggregated. 252 to 39 rows (from 7.38 KiB) in 12.569527216 sec. (20.048486762431622 rows/sec., 601.30 B/sec.)
2020.11.01 00:03:46.393998 [ 228018 ] {7e61cd85-d194-4463-8aeb-c11c14c7ded6} <Trace> AggregatingTransform: Aggregated. 1601 to 61 rows (from 67.05 KiB) in 13.174836977 sec. (121.51953020708713 rows/sec., 5.09 KiB/sec.)
2020.11.01 00:03:46.399194 [ 228442 ] {1b9be5da-c72d-44c5-b7aa-671f9fedd133} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.399312 [ 228442 ] {1b9be5da-c72d-44c5-b7aa-671f9fedd133} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 10.222660924 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.400386 [ 88359 ] {153975c1-aa8b-43bd-a9fe-1bfe5e073b73} <Trace> AggregatingTransform: Aggregated. 9 to 1 rows (from 203.00 B) in 7.553544325 sec. (1.1914936369953717 rows/sec., 26.87 B/sec.)
2020.11.01 00:03:46.403471 [ 225785 ] {f11f21bb-e55f-4031-a583-b7d5e3fe4e00} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.403536 [ 225785 ] {f11f21bb-e55f-4031-a583-b7d5e3fe4e00} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.405039 [ 228627 ] {1b9be5da-c72d-44c5-b7aa-671f9fedd133} <Trace> Aggregator: Aggregation method: without_key
2020.11.01 00:03:46.405110 [ 228627 ] {1b9be5da-c72d-44c5-b7aa-671f9fedd133} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 10.228620676 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.461535 [ 172739 ] {52b4625d-0653-4249-8af4-c9917d5728bf} <Trace> AggregatingTransform: Aggregated. 0 to 0 rows (from 0.00 B) in 11.846667135 sec. (0.0 rows/sec., 0.00 B/sec.)
2020.11.01 00:03:46.475508 [ 864 ] {5e465f48-06f3-4515-9fc4-f0a5eb8a7327} <Trace> AggregatingTransform: Aggregating
2020.11.01 00:03:46.475553 [ 864 ] {5e465f48-06f3-4515-9fc4-f0a5eb8a7327} <Trace> Aggregator: Aggregation method: without_key
```









```
2020.11.01 00:00:01.913005 [ 81982 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Aggregation method: without_key2020.11.01 00:00:01.913023 [ 81982 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.339812832 sec. (0.0 rows/sec., 0.00 B/sec.)2020.11.01 00:00:01.913028 [ 81982 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Merging aggregated data
2020.11.01 00:00:01.913918 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Information> executeQuery: Read 29574845 rows, 4.32 GiB in 0.352603698 sec., 83875595 rows/sec., 12.25 GiB/sec.2020.11.01 00:00:01.913942 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Debug> MemoryTracker: Peak memory usage (for query): 427.59 MiB.
2020.11.01 00:00:01.914171 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914177 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states2020.11.01 00:00:01.914180 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states2020.11.01 00:00:01.914183 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914186 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914189 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states2020.11.01 00:00:01.914192 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914195 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states2020.11.01 00:00:01.914198 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914201 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914204 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914207 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914210 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914213 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914216 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914219 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914222 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914227 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914230 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914233 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914236 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914239 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914242 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914244 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914254 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914257 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914260 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914264 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914266 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914270 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914273 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914275 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914278 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914281 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914285 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states2020.11.01 00:00:01.914287 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914291 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914294 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914297 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914300 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914303 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914306 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914309 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914312 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914314 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914317 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914320 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
2020.11.01 00:00:01.914324 [ 34845 ] {865d3c3c-6091-4fb1-b691-4d495c573963} <Trace> Aggregator: Destroying aggregate states
```

