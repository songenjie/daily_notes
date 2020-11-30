### **一、测试服务器**

- 测试集群：KC0_CK_TS_01
- 服务器：32核，128内存，HDD磁盘
- 数据量：20 亿
- 数据表：

```
case 1: 
CREATE TABLE jason.brand_marketing_distance_base_data_new_test1_local``(``  ```user_id` UInt64,``  ```sku_id` UInt64,``  ```cid3` UInt32,``  ```main_brand_cd` UInt32,``  ```dt` String,``  ```data_type` String``)``ENGINE = ReplicatedMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_test1_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192
```

case 2: 

```
CREATE TABLE jason.brand_marketing_distance_base_data_new_test2_local``(``  ```user_id` UInt64,``  ```sku_id` LowCardinality(UInt64),``  ```cid3` UInt32,``  ```main_brand_cd` UInt32,``  ```dt` String,``  ```data_type` String``)``ENGINE = ReplicatedMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_test2_local/{shard}'``, ``'{replica}'``)``PARTITION BY sku_id``ORDER BY (data_type, cid3, sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192
```

备注：[LowCardinality](https://cf.jd.com/display/kubernetes/LowCardinality) 函数详情

case 3:

```
CREATE TABLE jason.brand_marketing_distance_base_data_new_test3_local on cluster KC0_CK_TS_01``(``  ```user_id` UInt64,``  ```sku_id` UInt64,``  ```cid3` UInt32,``  ```main_brand_cd` UInt32,``  ```dt` String,``  ```data_type` String``)``ENGINE = ReplicatedMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_test3_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192` `CREATE TABLE jason.brand_marketing_distance_base_data_new_test3 on cluster KC0_CK_TS_01``(``  ```user_id` UInt64,``  ```sku_id` UInt64,``  ```cid3` UInt32,``  ```main_brand_cd` UInt32,``  ```dt` String,``  ```data_type` String``)``ENGINE = Distributed(``'KC0_CK_TS_01'``, ``'jason'``, ``'brand_marketing_distance_base_data_new_test3_local'``, rand())
```

case 4:

```
CREATE MATERIALIZED VIEW jason.brand_marketing_distance_base_data_new_uniq_local on cluster KC0_CK_TS_01``ENGINE = ReplicatedAggregatingMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_uniq_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, uniq_sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192` `AS``SELECT``  ``user_id,``  ``uniqState(sku_id) AS uniq_sku_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type``FROM jason.brand_marketing_distance_base_data_new_test3_local``GROUP BY``  ``user_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type` `CREATE TABLE jason.brand_marketing_distance_base_data_new_uniq on cluster KC0_CK_TS_01``AS jason.brand_marketing_distance_base_data_new_test3_local ENGINE = Distributed(``'KC0_CK_TS_01'``, ``'jason'``, ``'brand_marketing_distance_base_data_new_uniq_local'``, rand())
```

case 5:

```
CREATE MATERIALIZED VIEW jason.brand_marketing_distance_base_data_new_uniq_exact_local on cluster KC0_CK_TS_01``ENGINE = ReplicatedAggregatingMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_uniq_exact_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, uniq_exact_sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192` `AS``SELECT``  ``user_id,``  ``uniqState(sku_id) AS uniq_exact_sku_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type``FROM jason.brand_marketing_distance_base_data_new_test3_local``GROUP BY``  ``user_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type`` ` ` ` `CREATE TABLE jason.brand_marketing_distance_base_data_new_uniq_exact on cluster KC0_CK_TS_01``AS jason.brand_marketing_distance_base_data_new_test3_local ENGINE = Distributed(``'KC0_CK_TS_01'``, ``'jason'``, ``'brand_marketing_distance_base_data_new_uniq_exact_local'``, rand())
```

case 6:

```
CREATE MATERIALIZED VIEW jason.brand_marketing_distance_base_data_new_uniq_combined_local on cluster KC0_CK_TS_01``ENGINE = ReplicatedAggregatingMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_uniq_combined_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, uniq_combined_sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192` `AS``SELECT``  ``user_id,``  ``uniqState(sku_id) AS uniq_combined_sku_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type``FROM jason.brand_marketing_distance_base_data_new_test3_local``GROUP BY``  ``user_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type`` ` ` ` `CREATE TABLE jason.brand_marketing_distance_base_data_new_uniq_combined on cluster KC0_CK_TS_01``AS jason.brand_marketing_distance_base_data_new_test3_local ENGINE = Distributed(``'KC0_CK_TS_01'``, ``'jason'``, ``'brand_marketing_distance_base_data_new_uniq_combined_local'``, rand())
```

case 7:

```
CREATE MATERIALIZED VIEW jason.brand_marketing_distance_base_data_new_uniq_combined64_local on cluster KC0_CK_TS_01``ENGINE = ReplicatedAggregatingMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_uniq_combined64_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, uniq_combined64_sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192` `AS``SELECT``  ``user_id,``  ``uniqState(sku_id) AS uniq_combined64_sku_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type``FROM jason.brand_marketing_distance_base_data_new_test3_local``GROUP BY``  ``user_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type`` ` ` ` `CREATE TABLE jason.brand_marketing_distance_base_data_new_uniq_combined64 on cluster KC0_CK_TS_01``AS jason.brand_marketing_distance_base_data_new_test3_local ENGINE = Distributed(``'KC0_CK_TS_01'``, ``'jason'``, ``'brand_marketing_distance_base_data_new_uniq_combined64_local'``, rand())
```



case 8:

```
CREATE MATERIALIZED VIEW jason.brand_marketing_distance_base_data_new_uniq_hll12_local on cluster KC0_CK_TS_01``ENGINE = ReplicatedAggregatingMergeTree(``'/clickhouse/KC0_CK_TS_01/jdob_ha/jason/brand_marketing_distance_base_data_new_uniq_hll12_local/{shard}'``, ``'{replica}'``)``PARTITION BY data_type``ORDER BY (data_type, cid3, uniq_hll12_sku_id, user_id)``SETTINGS storage_policy = ``'jdob_ha'``, index_granularity = ``8192` `AS``SELECT``  ``user_id,``  ``uniqState(sku_id) AS uniq_hll12_sku_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type``FROM jason.brand_marketing_distance_base_data_new_test3_local``GROUP BY``  ``user_id,``  ``cid3,``  ``main_brand_cd,``  ``dt,``  ``data_type`` ` ` ` `CREATE TABLE jason.brand_marketing_distance_base_data_new_uniq_hll12 on cluster KC0_CK_TS_01``AS jason.brand_marketing_distance_base_data_new_test3_local ENGINE = Distributed(``'KC0_CK_TS_01'``, ``'jason'``, ``'brand_marketing_distance_base_data_new_uniq_hll12_local'``, rand())
```



### **二、近似（精确）去重方案**

1、近似（精确）函数

（1）local 表测试

| 近似（精确）函数       | 查询语句                                                     | case 1（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)） | case 2（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)） | 结果      |
| :--------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :-------- |
| 近似（精确）函数       | 查询语句                                                     | case 1（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)） | case 2（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)） | 结果      |
| count(distinct sku_id) | SELECT countDistinct(sku_id) FROM jason.brand_marketing_distance_base_data_new_test1_local | 13.312 sec.13.326 sec.                                       | 15.136 sec.15.166 sec.                                       | 103784874 |
| `uniq`                 | SELECT uniq(sku_id) FROM jason.brand_marketing_distance_base_data_new_test1_local | 1.253 sec.1.252 sec.                                         | 2.689 sec.2.588 sec.                                         | 103762494 |
| uniqExact              | SELECT uniqExact(sku_id) FROM jason.brand_marketing_distance_base_data_new_test1_local | 13.315 sec.13.291 sec.                                       | 14.801 sec.15.102 sec.                                       | 103784874 |
| uniqCombined           | SELECT uniqCombined(sku_id) FROM jason.brand_marketing_distance_base_data_new_test1_local | 2.460 sec.2.330 sec.                                         | 3.964 sec.3.892 sec.                                         | 103909209 |
| uniqCombined64         | SELECT uniqCombined64(sku_id) FROM jason.brand_marketing_distance_base_data_new_test1_local | 2.468 sec.2.419 sec.                                         | 3.837 sec.3.885 sec.                                         | 103922784 |
| uniqHLL12              | SELECT uniqHLL12(sku_id) FROM jason.brand_marketing_distance_base_data_new_test1_local | 2.169 sec.2.008 sec.                                         | 3.330 sec.3.356 sec.                                         | 105124524 |
| count group by         | SELECT count() FROM ( SELECT count(1) FROM jason.brand_marketing_distance_base_data_new_test1_local GROUP BY sku_id ) | 7.235 sec.7.394 sec.                                         | 11.261 sec.11.041 sec.                                       | 103784874 |


结论：a、使用 [LowCardinality](https://cf.jd.com/display/kubernetes/LowCardinality) 这个函数近似（精确）去重查询，查询效率不佳

​      b、近似去重：uniq 查询效率最佳，其次是 uniqHLL12，uniqCombined，uniqCombined64（官方建议使用 uniq 或者 uniqCombined， 其中 uniqCombined 精度更高，消耗更少的内存和分布式查询性能有时候优于 uniq）

​      c、精确去重：count group by 查询效率最佳，其次是 uniqExact，count(distinct sku_id)

（2）分布式表测试（没有做case 2测试）

| 近似（精确）函数       | 查询语句                                                     | case 3（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)） | 结果      |
| :--------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :-------- |
| count(distinct sku_id) | SELECT countDistinct(sku_id) FROM jason.brand_marketing_distance_base_data_new_test3 | 20.400 sec.19.635 sec.                                       | 103784874 |
| `uniq`                 | SELECT uniq(sku_id) FROM jason.brand_marketing_distance_base_data_new_test3 | 0.183 sec.0.191 sec.                                         | 103762494 |
| uniqExact              | SELECT uniqExact(sku_id) FROM jason.brand_marketing_distance_base_data_new_test3 | 19.726 sec.19.912 sec.                                       | 103784874 |
| uniqCombined           | SELECT uniqCombined(sku_id) FROM jason.brand_marketing_distance_base_data_new_test3 | 0.256 sec.0.246 sec.                                         | 103909209 |
| uniqCombined64         | SELECT uniqCombined64(sku_id) FROM jason.brand_marketing_distance_base_data_new_test3 | 0.240 sec.0.220 sec.                                         | 103922784 |
| uniqHLL12              | SELECT uniqHLL12(sku_id) FROM jason.brand_marketing_distance_base_data_new_test3 | 0.188 sec.0.172 sec.                                         | 105124524 |
| count group by         | SELECT count() FROM ( SELECT count(1) FROM jason.brand_marketing_distance_base_data_new_test3 GROUP BY sku_id ) | 6.503 sec.6.546 sec.                                         | 103784874 |

结论：同 local 表测试一样

2、物化视图

（1）uniqState/uniqMerge

（2）uniqExactState/uniqExactMerge

（3）uniqCombinedState/uniqCombinedMerge

（4）uniqCombined64State/uniqCombined64Merge

（5）uniqHLL12State/uniqHLL12Merge

3、Array
