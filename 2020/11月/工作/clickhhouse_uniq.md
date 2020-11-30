# CLICKHOUSE AGGREGATEFUNCTIONS AND AGGREGATE STATE

[Yegor Andreenko](https://altinity.com/author/altinityguestya/) 10 Jul 2017 [ClickHouse](https://altinity.com/blog/tag/clickhouse/)[Cross-post](https://altinity.com/blog/tag/cross-post/)[Tutorial](https://altinity.com/blog/tag/tutorial/)

 

*Jul 10, 2017*

*This is a re-post from (https://medium.com/@f1yegor/clickhouse-aggregatefunctions-and-aggregatestate-e3fd46b7be74).
Follow author on Twitter [@f1yegor](https://twitter.com/f1yegor).*

There is probably a unique feature of ClickHouse?—?aggregate states (addition to aggregate functions). You could refer to the documentation of [AggregatingMergeTree](https://clickhouse.yandex/docs/en/table_engines/aggregatingmergetree.html) and [State](https://clickhouse.yandex/docs/en/single/index.html#state-combinator) combinator.

In a couple of words many databases use probabilistic data structures like HyperLogLog or HLL for short. It is used for unique/distinct calculations, you can find how it works in [Spark](https://databricks.com/blog/2016/05/19/approximate-algorithms-in-apache-spark-hyperloglog-and-quantiles.html), [ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-metrics-cardinality-aggregation.html), [Flink](https://github.com/eBay/Flink/blob/master/flink-contrib/flink-operator-stats/src/main/java/org/apache/flink/contrib/operatorstatistics/OperatorStatistics.java), [Postgres](https://github.com/aggregateknowledge/postgresql-hll), [BigQuery](https://cloud.google.com/blog/big-data/2017/07/counting-uniques-faster-in-bigquery-with-hyperloglog) and [Redis](http://antirez.com/news/75) to name a few. But usually you can apply this function only once in aggregate function, for example query the number of unique users per month?—?get a single number and be happy with it. It is not possible to re-use pre-aggregated or partially aggregated data because internal representation of HLL structure is not available. In ClickHouse you can do that because HLL structure is consistent.

ClickHouse is blazingly fast and based on idea of dealing with raw data and not to pre-aggregate data beforehand. But let’s make an experiment. For example we need to calculate some metric for unique users of last month.

**The idea**: pre-aggregate it per day, and then sum up all results. It’s so called bucket approach?—?later you could sum up only last 30 measurements for last month, or last 7 to figure out the statistic for last week.

Create our pre-aggregate table:

```
create table events_unique (
  date Date, 
  group_id String, 
  client_id String, 
  event_type String, 
  product_id String, 
  value AggregateFunction(uniq, String)
) ENGINE = MergeTree(date, (group_id, client_id, event_type, product_id, date), 8192);
```

Here I’m declaring that my aggregate as AggregateFunction(uniq, String). We are interested in some unique metric that is calculated on String column (for further optimization you probably want to use FixedString or binary data).

Let’s insert data to pre-aggregate table:

```
INSERT INTO events_unique 
SELECT date, group_id, client_id, event_type, product_id, uniqState(visitor_id) AS value 
  FROM events 
 GROUP BY date, group_id, client_id, event_type, product_id;
```

Smoke test that it works:

```
SELECT uniqMerge(value) FROM events_unique GROUP BY product_id;
```

Now let’s compare query performance on original table and pre-aggregated table. Original query:

```
SELECT uniq(visitor_id) AS c 
  FROM events 
 WHERE client_id = ‘aaaaaaaa’ 
   AND event_type = ‘click’ 
   AND product_id = ‘product1’ 
   AND date >= ‘2017–01–20’ 
   AND date < ‘2017–02–20’;

┌──────c─┐
│ 457954 │
└────────┘
1 rows in set. Elapsed: 0.948 sec. Processed 13.22 million rows, 1.61 GB (13.93 million rows/s., 1.70 GB/s.)
```

Result on pre-aggregated table:

```
SELECT uniqMerge(value) AS c 
  FROM events_unique 
 WHERE client_id = ‘aaaaaaaa’ 
   AND event_type = ‘click’ 
   AND product_id = ‘product1’ 
   AND date >= ‘2017–01–20’ 
   AND date < ‘2017–02–20’;

┌──────c─┐
│ 457954 │
└────────┘
1 rows in set. Elapsed: 0.050 sec. Processed 39.39 thousand rows, 8.55 MB (781.22 thousand rows/s., 169.65 MB/s.)
```

As a result we’ve got 20x improvement in processing time.

In practice it is more convenient to use materialized view with AggregatingMergeTree engine instead of a separate table.

## To sum up

ClickHouse allows you to store aggregated state inside the database, not only in your application, which could lead to interesting performance optimizations and new use cases. For further details look at extensive documentation of [AggregatingMergeTree](https://clickhouse.yandex/docs/en/table_engines/aggregatingmergetree.html) engine (with more examples of uniqMerge and uniqState)?—?the main force behind Yandex.Metrica.

P.S. It was mentioned by some commenters that aggregate state functionality is not a unique ClickHouse feature, and it exists in some other products, for example in [Snowflake](https://docs.snowflake.net/manuals/sql-reference/functions/hll_accumulate.html).