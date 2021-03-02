### [一、使用案例](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-一、使用案例)[1、物化视图简单的求和](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-1、物化视图简单的求和)[2、物化视图复杂的聚合](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-2、物化视图复杂的聚合)[3、物化视图JOIN的使用](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-3、物化视图JOIN的使用)[4、手动同步数据步骤](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-4、手动同步数据步骤)[5、单表多物化视图性能](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-5、单表多物化视图性能)[二、源码分析](https://cf.jd.com/pages/viewpage.action?pageId=426061733#id-物化视图实践-二、源码分析)一、使用案例

测试环境

- 测试集群： ZYX_CK_TS_02 6 shard 3 replica
- 服务器：32核，128内存，2T*12HDD

#### 1、物化视图简单的求和

物化视图会自动在表之间转换数据，对插入的原始数据查询并实时将查询结果存储在物化视图的内表中，案例1如下：

```
//创建原始表``CREATE TABLE liyang830_test.test1 (`` ``when DateTime,`` ``userid UInt32,`` ``bytes Float32``) ENGINE=MergeTree``PARTITION BY toYYYYMM(when)``ORDER BY (userid, when)` `//插入原始表数据``INSERT INTO liyang830_test.test1`` ``SELECT``  ``now() + number * ``60` `as when,``  ``25``,``  ``rand() % ``100000000`` ``FROM system.numbers`` ``LIMIT ``500000000` `//创建物化视图``CREATE MATERIALIZED VIEW liyang830_test.daily_mv_test1``ENGINE = SummingMergeTree``PARTITION BY toYYYYMM(day) ORDER BY (userid, day)``POPULATE``AS SELECT`` ``toStartOfDay(when) AS day,`` ``userid,`` ``count() as downloads,`` ``sum(bytes) AS bytes``FROM liyang830_test.test1``GROUP BY userid, day` `//查询原始表``SELECT``  ``toStartOfDay(when) AS day,``  ``userid,``  ``count() AS downloads,``  ``sum(bytes) AS bytes``FROM liyang830_test.test1``GROUP BY``  ``userid,``  ``day``ORDER BY``  ``userid ASC,``  ``day ASC``LIMIT ``5` `┌─────────────────day─┬─userid─┬─downloads─┬────────bytes─┐``│ ``1970``-``01``-``02` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``500137530718` `│``│ ``1970``-``01``-``03` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``505026390907` `│``│ ``1970``-``01``-``04` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``499706824196` `│``│ ``1970``-``01``-``05` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``502469222694` `│``│ ``1970``-``01``-``06` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``506198899427` `│``└─────────────────────┴────────┴───────────┴──────────────┘` `5` `rows in set. Elapsed: ``0.998` `sec. Processed ``500.00` `million rows, ``6.00` `GB (``500.82` `million rows/s., ``6.01` `GB/s.)` `//查询物化视图``SELECT *``FROM liyang830_test.daily_mv_test1``ORDER BY``  ``userid ASC,``  ``day ASC``LIMIT ``5` `┌─────────────────day─┬─userid─┬─downloads─┬────────bytes─┐``│ ``1970``-``01``-``02` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``500137530718` `│``│ ``1970``-``01``-``03` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``505026390907` `│``│ ``1970``-``01``-``04` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``499706824196` `│``│ ``1970``-``01``-``05` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``502469222694` `│``│ ``1970``-``01``-``06` `00``:``00``:``00` `│   ``25` `│   ``10080` `│ ``506198899427` `│``└─────────────────────┴────────┴───────────┴──────────────┘` `5` `rows in set. Elapsed: ``0.072` `sec. Processed ``49.71` `thousand rows, ``1.19` `MB (``686.56` `thousand rows/s., ``16.48` `MB/s.)
```

使用物化视图之后能提升的查询的性能，不过需要注意的三点：

（1）物化视图将创建一个隐藏的内表来保存视图数据

（2）物化视图定义包含关键字POPULATE，它会将原始表的历史数据加载进物化视图

（3）物化视图定义包括一个SELECT语句，该语句是将每批次写入的原始数据按照SELECT语句进行聚合后，在将聚合后结果写入物化视图的内表

物化视图整体流程如下：

![img](https://cf.jd.com/download/attachments/426061733/%E7%89%A9%E5%8C%96%E8%A7%86%E5%9B%BE%E5%88%86%E6%9E%90-Page-2.png?version=1&modificationDate=1614050632000&api=v2)

#### 2、物化视图复杂的聚合

使用AggregateFunction实现物化视图复杂的聚合计算

```
//创建原始表``CREATE TABLE liyang830_test.test2 (`` ``when DateTime DEFAULT now(),`` ``device UInt32,`` ``value Float32``) ENGINE=MergeTree``PARTITION BY toYYYYMM(when)``ORDER BY (device, when)` `//插入原始表数据``INSERT INTO liyang830_test.test2`` ``SELECT``  ``toDateTime(``'2015-01-01 00:00:00'``) + toInt64(number/``10``) AS when,``  ``(number % ``10``) + ``1` `AS device,``  ``(device * ``3``) + (number/``10000``) + (rand() % ``53``) * ``0.1` `AS value`` ``FROM system.numbers LIMIT ``500000000` `//创建物化视图``CREATE MATERIALIZED VIEW liyang830_test.daily_mv_test2``ENGINE = AggregatingMergeTree()``PARTITION BY toYYYYMM(day) ORDER BY (device, day)``POPULATE``AS SELECT``  ``toStartOfDay(when) as day,``  ``device,``  ``count(*) as count,``  ``maxState(value) AS max_value_state,``  ``minState(value) AS min_value_state,``  ``avgState(value) AS avg_value_state``FROM liyang830_test.test2``GROUP BY device, day` `//查询原始表``SELECT``  ``device,``  ``count(*) AS count,``  ``max(value) AS max,``  ``min(value) AS min,``  ``avg(value) AS avg``FROM liyang830_test.test2``GROUP BY device``ORDER BY device ASC``LIMIT ``5` `┌─device─┬────count─┬───────max─┬─────min─┬────────────────avg─┐``│   ``1` `│ ``50000000` `│ ``50008.098` `│  ``3.011` `│ ``25005.599545003046` `│``│   ``2` `│ ``50000000` `│ ``50011.145` `│ ``6.0401` `│ ``25008.599763856368` `│``│   ``3` `│ ``50000000` `│ ``50014.188` `│ ``9.0502` `│ ``25011.599795791513` `│``│   ``4` `│ ``50000000` `│ ``50017.195` `│ ``12.0713` `│ ``25014.59997350632` `│``│   ``5` `│ ``50000000` `│ ``50020.07` `│ ``15.0374` `│ ``25017.600049195822` `│``└────────┴──────────┴───────────┴─────────┴────────────────────┘` `5` `rows in set. Elapsed: ``0.610` `sec. Processed ``500.00` `million rows, ``4.00` `GB (``819.98` `million rows/s., ``6.56` `GB/s.)` `//查询物化视图``SELECT``  ``device,``  ``sum(count) AS count,``  ``maxMerge(max_value_state) AS max,``  ``minMerge(min_value_state) AS min,``  ``avgMerge(avg_value_state) AS avg``FROM liyang830_test.daily_mv_test2``GROUP BY device``ORDER BY device ASC``LIMIT ``5` `┌─device─┬────count─┬───────max─┬─────min─┬────────────────avg─┐``│   ``1` `│ ``50000000` `│ ``50008.098` `│  ``3.011` `│ ``25005.599545003046` `│``│   ``2` `│ ``50000000` `│ ``50011.145` `│ ``6.0401` `│ ``25008.599763856368` `│``│   ``3` `│ ``50000000` `│ ``50014.188` `│ ``9.0502` `│ ``25011.599795791513` `│``│   ``4` `│ ``50000000` `│ ``50017.195` `│ ``12.0713` `│ ``25014.59997350631` `│``│   ``5` `│ ``50000000` `│ ``50020.07` `│ ``15.0374` `│ ``25017.600049195822` `│``└────────┴──────────┴───────────┴─────────┴────────────────────┘` `5` `rows in set. Elapsed: ``0.008` `sec. Processed ``5.79` `thousand rows, ``609.85` `KB (``687.45` `thousand rows/s., ``72.41` `MB/s.)
```

当原始表数据批次写入物化视图时，物化视图使用*State函数将数据转换为部分聚合状态，*State函数可以理解为一个数据结构，可以存储数据。最后在查询物化视图的时候，使用*Merge将部分聚合数据加到结果中返回。

![img](https://cf.jd.com/download/attachments/426061733/%E7%89%A9%E5%8C%96%E8%A7%86%E5%9B%BE%E5%88%86%E6%9E%90-Page-3.png?version=1&modificationDate=1612429721000&api=v2)



#### 3、物化视图JOIN的使用

```
//创建三个原始表``CREATE TABLE liyang830_test.test3 (`` ``when DateTime,`` ``userid UInt32,`` ``bytes UInt64``) ENGINE=MergeTree``PARTITION BY toYYYYMM(when)``ORDER BY (userid, when)` `CREATE TABLE liyang830_test.price_test3 (`` ``userid UInt32,`` ``price_per_gb Float64``) ENGINE=MergeTree``PARTITION BY tuple()``ORDER BY userid` `//创建物化视图``CREATE MATERIALIZED VIEW liyang830_test.daily_mv_test3``ENGINE = SummingMergeTree``PARTITION BY toYYYYMM(day) ORDER BY (userid, day)``POPULATE``AS SELECT`` ``day AS day, userid AS userid, count() AS downloads,`` ``sum(gb) as total_gb, sum(price) as total_price``FROM (`` ``SELECT``  ``toDate(when) AS day,``  ``userid AS userid,``  ``liyang830_test.test3.bytes / (``1024``*``1024``*``1024``) AS gb,``  ``gb * liyang830_test.price_test3.price_per_gb AS price`` ``FROM liyang830_test.test3 JOIN liyang830_test.price_test3 ON liyang830_test.test3.userid = liyang830_test.price_test3.userid``)``GROUP BY userid, day` `//插入右侧表数据``INSERT INTO liyang830_test.price_test3 VALUES (``25``, ``0.10``), (``26``, ``0.05``), (``27``, ``0.01``);``//查询物化视图``SELECT COUNT()``FROM liyang830_test.daily_mv_test3` `┌─COUNT()─┐``│    ``0` `│``└─────────┘` `1` `rows in set. Elapsed: ``0.004` `sec.` `//插入左侧表数据``INSERT INTO liyang830_test.test3`` ``SELECT``  ``now() + number * ``60` `as when,``  ``25``,``  ``rand() % ``100000000`` ``FROM system.numbers`` ``LIMIT ``500000000` `//查询物化视图``SELECT``  ``day,``  ``downloads,``  ``total_gb,``  ``total_price``FROM liyang830_test.daily_mv_test3``WHERE userid = ``25` `limit ``5` `┌────────day─┬─downloads─┬───────────total_gb─┬────────total_price─┐``│ ``2021``-``02``-``09` `│    ``106` `│ ``5.108544290065765` `│ ``0.5108544290065766` `│``│ ``2021``-``02``-``10` `│    ``480` `│ ``23.098006163723767` `│ ``2.3098006163723777` `│``│ ``2021``-``02``-``11` `│    ``480` `│ ``21.479994527064264` `│ ``2.147999452706426` `│``│ ``2021``-``02``-``12` `│    ``480` `│ ``22.966846658848226` `│ ``2.2966846658848254` `│``│ ``2021``-``02``-``13` `│    ``121` `│  ``5.58329145796597` `│ ``0.5583291457965969` `│``└────────────┴───────────┴────────────────────┴────────────────────┘` `5` `rows in set. Elapsed: ``0.005` `sec.
```

从上面的案例可以看出，物化视图在SELECT语句中可以连接多个表，只有左侧表的插入才会触发物化视图的插入，其他表做插入，物化视图不会对这些表的插入做出反应。

![img](https://cf.jd.com/download/attachments/426061733/%E7%89%A9%E5%8C%96%E8%A7%86%E5%9B%BE%E5%88%86%E6%9E%90-Page-4.png?version=1&modificationDate=1614050646000&api=v2)

#### 4、手动同步数据步骤

```
create new_table，insert into new_table select old_table，rename old_table to bak_table，rename new_table to old_table
```



#### 5、单表多物化视图性能

| 原始表                 | 物化视图个数 | 写入速度 | 耗时 |
| :--------------------- | :----------- | :------- | :--- |
| `liyang830_test.test1` | 1            |          |      |
| `liyang830_test.test1` | 2            |          |      |
| `liyang830_test.test1` | 3            |          |      |
| `liyang830_test.test1` | 4            |          |      |
| `liyang830_test.test1` | 5            |          |      |



### 二、源码分析

![img](https://cf.jd.com/download/attachments/426061733/%E7%89%A9%E5%8C%96%E8%A7%86%E5%9B%BE%E5%88%86%E6%9E%90.png?version=1&modificationDate=1611571770000&api=v2)

参考资料：

https://altinity.com/blog/2020-07-14-joins-in-clickhouse-materialized-views

https://altinity.com/blog/clickhouse-materialized-views-illuminated-part-1

https://altinity.com/blog/clickhouse-materialized-views-illuminated-part-2

https://clickhouse.tech/docs/en/sql-reference/statements/create/view/#materialized

https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/