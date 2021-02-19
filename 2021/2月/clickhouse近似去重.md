### **一、测试服务器**** **

- 测试集群：KC0_CK_TS_01 18 shard 3 replica
- 服务器：32核，128内存，5.5T*8HDD
- 数据表：[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)

### **二、近似（精确）去重方案**

#### 1、近似（精确）去重函数性能对比

（1）本地表

case 1 和 case 2区别在于在 sku_id case 2上面加了 [LowCardinality](https://cf.jd.com/display/kubernetes/LowCardinality) 函数

|            | 数据量                 | 近似（精确）函数                                             | 查询语句                                                     | case 1（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456) UInt64）2次查询响应时间 | case 2（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456) UInt64）2次查询响应时间 | 结果      | mem(G) case 1 |
| :--------- | :--------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :-------- | :------------ |
| 精确去重   | 2135284121             | count group by                                               | SELECT count() FROM ( SELECT count(1) FROM liyang830.brand_marketing_distance_base_data_new_test1_local GROUP BY sku_id ) | 7.235 sec.7.394 sec.                                         | 11.261 sec.11.041 sec.                                       | 103784874 | 10.0241       |
| 2135284121 | uniqExact              | SELECT uniqExact(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test1_local | 13.315 sec.13.291 sec.                                       | 14.801 sec.15.102 sec.                                       | 103784874                                                    | 4.2728    |               |
| 2135284121 | count(distinct sku_id) | SELECT countDistinct(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test1_local | 13.312 sec.13.326 sec.                                       | 15.136 sec.15.166 sec.                                       | 103784874                                                    | 4.2692    |               |
| 近似去重   | 2135284121             | `uniq`                                                       | SELECT uniq(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test1_local | 1.253 sec.1.252 sec.                                         | 2.689 sec.2.588 sec.                                         | 103762494 | 0.0079        |
| 2135284121 | uniqCombined           | SELECT uniqCombined(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test1_local | 2.460 sec.2.330 sec.                                         | 3.964 sec.3.892 sec.                                         | 103909209                                                    | 0.0045    |               |
| 2135284121 | uniqCombined64         | SELECT uniqCombined64(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test1_local | 2.468 sec.2.419 sec.                                         | 3.837 sec.3.885 sec.                                         | 103922784                                                    | 0.0042    |               |
| 2135284121 | uniqHLL12              | SELECT uniqHLL12(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test1_local | 2.169 sec.2.008 sec.                                         | 3.330 sec.3.356 sec.                                         | 105124524                                                    | 0.0039    |               |


（2）分布式表（没有做 [LowCardinality](https://cf.jd.com/display/kubernetes/LowCardinality) 测试）

|            | 数据量                 | 近似（精确）函数                                             | 查询语句                                                     | case 3（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456) UInt64）2次查询响应时间 | case12（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456) String）2次查询响应时间 | 结果      | mem(G)case 3 |
| :--------- | :--------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :-------- | :----------- |
| 精确去重   | 2135284121             | count group by                                               | SELECT count() FROM ( SELECT count(1) FROM liyang830.brand_marketing_distance_base_data_new_test3 GROUP BY sku_id ) | 6.503 sec.6.546 sec.                                         | 8.179 sec.8.222 sec.                                         | 103784874 | 13.6211      |
| 2135284121 | count(distinct sku_id) | SELECT countDistinct(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test3 | 20.400 sec.19.635 sec.                                       | 30.783 sec.30.462 sec.                                       | 103784874                                                    | 9.5514    |              |
| 2135284121 | uniqExact              | SELECT uniqExact(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test3 | 19.726 sec.19.912 sec.                                       | 31.230 sec.30.783 sec.                                       | 103784874                                                    | 9.5476    |              |
| 近似去重   | 2135284121             | `uniq`                                                       | SELECT uniq(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test3 | 0.183 sec.0.191 sec.                                         | 0.453 sec.0.468 sec.                                         | 103762494 | 0.0078       |
| 2135284121 | uniqCombined           | SELECT uniqCombined(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test3 | 0.256 sec.0.246 sec.                                         | 0.499 sec.0.504 sec.                                         | 103909209                                                    | 0.0041    |              |
| 2135284121 | uniqCombined64         | SELECT uniqCombined64(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test3 | 0.240 sec.0.220 sec.                                         | 0.518 sec.0.510 sec.                                         | 103922784                                                    | 0.0040    |              |
| 2135284121 | uniqHLL12              | SELECT uniqHLL12(sku_id) FROM liyang830.brand_marketing_distance_base_data_new_test3 | 0.188 sec.0.172 sec.                                         | 0.455 sec.0.456 sec.                                         | 105124524                                                    | 0.0040    |              |

经过上面的本地表和分布式表测试，得出以下结论

结论：a、case 2 使用 [LowCardinality](https://cf.jd.com/display/kubernetes/LowCardinality) 这个函数近似（精确）去重查询，查询性能不佳

​      b、近似去重：

​         查询性能方面：uniq 查询性能最佳，其次是 uniqHLL12、uniqCombined 和 uniqCombined64 

​         内存消耗方面：uniq 内存消耗最多，其次是 uniqCombined，uniqCombined64，uniqHLL12

​         综合查询性能，内存消耗，精度等原因，使用 uniqCombined（uniqCombined64）更好

​      c、精确去重： 

​        查询性能方面：count group by 查询性能最佳，其次是 uniqExact，count(distinct sku_id)

​        内存消耗方面：count group by 内存消耗最多，其次是 uniqExact，count(distinct sku_id)

​        

#### 2、物化视图聚合程度性能对比

聚合程度 = 聚合后数据量 / 原始数据量

##### （1）近似去重

case 10（[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)）:

**String**

| 聚合程度    | uniqCombined64(原始数据量)                    | uniqCombined64State/uniqCombined64Merge          | Array                                            |
| :---------- | :-------------------------------------------- | :----------------------------------------------- | :----------------------------------------------- |
| 1 / 10      | 数据量：1亿结果：63364943响应时间：0.097 sec. | 数据量：1000万结果：63364943响应时间：0.115 sec. | 数据量：1000万结果：63364943响应时间：0.155 sec. |
| 1 / 100     | 同上                                          | 数据量：100万结果：63364943响应时间：0.242 sec.  | 数据量：100万结果：63364943响应时间：0.098 sec.  |
| 1 / 1000    | 同上                                          | 数据量：10万结果：63364943响应时间：0.259 sec.   | 数据量：10万结果：63364943响应时间：0.096 sec.   |
| 1 / 10000   | 同上                                          | 数据量：1万结果：63364943响应时间：0.492 sec.    | 数据量：1万结果：63364943响应时间：0.085 sec.    |
| 1 / 100000  | 同上                                          | 数据量：1000结果：63364943响应时间：0.083 sec.   | 数据量：1000结果：63364943响应时间：0.90 sec.    |
| 1 / 1000000 | 同上                                          | 数据量：100结果：63364943响应时间：0.035 sec.    | 数据量：100结果：63364943响应时间：0.167 sec.    |

**UInt64**

| 聚合程度    | uniqCombined64(原始数据量)                    | uniqCombined64State/uniqCombined64Merge          | Array                                            |
| :---------- | :-------------------------------------------- | :----------------------------------------------- | :----------------------------------------------- |
| 1 / 10      | 数据量：1亿结果：63364943响应时间：0.080 sec. | 数据量：1000万结果：63364943响应时间：0.111 sec. | 数据量：1000万结果：63364943响应时间：0.087 sec. |
| 1 / 100     | 同上                                          | 数据量：100万结果：63364943响应时间：0.232 sec.  | 数据量：100万结果：63364943响应时间：0.083 sec.  |
| 1 / 1000    | 同上                                          | 数据量：10万结果：63364943响应时间：0.251 sec.   | 数据量：10万结果：63364943响应时间：0.089 sec.   |
| 1 / 10000   | 同上                                          | 数据量：1万结果：63364943响应时间：0.501 sec.    | 数据量：1万结果：63364943响应时间：0.075 sec.    |
| 1 / 100000  | 同上                                          | 数据量：1000结果：63364943响应时间：0.074 sec.   | 数据量：1000结果：63364943响应时间：0.100 sec.   |
| 1 / 1000000 | 同上                                          | 数据量：100结果：63364943响应时间：0.034 sec.    | 数据量：100结果：63364943响应时间：0.149 sec.    |

结论：

​    从聚合程度上面来看：    

​     1 > 聚合程度 >= 1 / 1000 ，使用 uniqCombined64 查询性能较好

​     1 / 1000 > 聚合程度 >= 1 / 10000，使用 Array 查询性能较好

​     1 / 10000 > 聚合程度 > 0，使用 uniqCombined64State/uniqCombined64Merge 查询性能较好

   从去重指标类型来看：

​    UInt64类型的查询性能更好一些

​    

##### （2）精确去重

case 11 （[建表语句](https://cf.jd.com/pages/viewpage.action?pageId=386620456)）:

**String**

| 聚合程度    | uniqExact(原始数据量)                          | uniqExactState/uniqExactMerge                    | Array                                            |
| :---------- | :--------------------------------------------- | :----------------------------------------------- | :----------------------------------------------- |
| 1 / 10      | 数据量：1亿结果：63205281响应时间：10.230 sec. | 数据量：1000万结果：63205281响应时间：7.623 sec. | 数据量：1000万结果：63205281响应时间：7.438 sec. |
| 1 / 100     | 同上                                           | 数据量：100万结果：63205281响应时间：7.451 sec.  | 数据量：100万结果：63205281响应时间：7.459 sec.  |
| 1 / 1000    | 同上                                           | 数据量：10万结果：63205281响应时间：7.616 sec.   | 数据量：10万结果：63205281响应时间：7.347 sec.   |
| 1 / 10000   | 同上                                           | 数据量：1万结果：63205281响应时间：7.551 sec.    | 数据量：1万结果：63205281响应时间：7.331 sec.    |
| 1 / 100000  | 同上                                           | 数据量：1000结果：63205281响应时间：7.427 sec.   | 数据量：1000结果：63205281响应时间：7.542 sec.   |
| 1 / 1000000 | 同上                                           | 数据量：100结果：63205281响应时间：7.690 sec.    | 数据量：100结果：63205281响应时间： 7.732 sec.   |

**UInt64**

| 聚合程度    | uniqExact(原始数据量)                          | uniqExactState/uniqExactMerge                     | Array                                            |
| :---------- | :--------------------------------------------- | :------------------------------------------------ | :----------------------------------------------- |
| 1 / 10      | 数据量：1亿结果： 9.929 sec.响应时间：63205281 | 数据量：1000万结果： 63205281响应时间：7.261 sec. | 数据量：1000万结果：63205281响应时间：4.955 sec. |
| 1 / 100     | 同上                                           | 数据量：100万结果：63205281响应时间：7.336 sec.   | 数据量：100万结果：63205281响应时间：4.909 sec.  |
| 1 / 1000    | 同上                                           | 数据量：10万结果：63205281响应时间：7.425 sec.    | 数据量：10万结果：63205281响应时间：4.923 sec.   |
| 1 / 10000   | 同上                                           | 数据量：1万结果：63205281响应时间：7.459 sec.     | 数据量：1万结果：63205281响应时间：4.954 sec.    |
| 1 / 100000  | 同上                                           | 数据量：1000结果：63205281响应时间：7.405 sec.    | 数据量：1000结果：63205281响应时间：5.069 sec.   |
| 1 / 1000000 | 同上                                           | 数据量：100结果：63205281响应时间： 7.538 sec.    | 数据量：100结果：63205281响应时间：4.934 sec.    |

结论：

   从去重指标类型来看：

​    去重指标是String类型：使用 uniqExactState/uniqExactMerge 或者 Array 物化视图查询性能较好，与聚合程度没有太大关系

​    去重指标是UInt64类型：使用 Array 物化视图查询性能更好，与聚合程度没有太大关系

​        

### 三、参考资料

官方近似（精确）去重函数：

https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/uniq/

https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/uniqexact/

https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/uniqcombined/

https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/uniqcombined64/

https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/uniqhll12/

https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/groupbitmap/

https://clickhouse.tech/docs/en/sql-reference/data-types/lowcardinality/

ALTINITY  Array和物化视图：

https://altinity.com/blog/harnessing-the-power-of-clickhouse-arrays-part-1

https://altinity.com/blog/harnessing-the-power-of-clickhouse-arrays-part-2

https://altinity.com/blog/clickhouse-materialized-views-illuminated-part-1

https://altinity.com/blog/clickhouse-materialized-views-illuminated-part-2

其他：

https://ld246.com/article/1516782830993