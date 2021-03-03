```
SELECT count(*)
FROM system.parts AS parts_all
INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name

[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:20.870703 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Debug> executeQuery: (from [::ffff:172.18.160.19]:54952)  select count(*) from system.parts as parts_all join system.tables as tables_all on parts_all.name = tables_all.name;
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:20.871642 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:20.871679 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:20.871796 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.268105 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.269185 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.269386 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.269513 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.270432 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001240396 sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.276519 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.276591 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.276681 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007894445 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.276733 [ 29643 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Trace> Aggregator: Merging aggregated data
┌─count()─┐
│       0 │
└─────────┘
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.277350 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Information> executeQuery: Read 56364 rows, 30.59 MiB in 1.406580782 sec., 40071 rows/sec., 21.75 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:22.277400 [ 83541 ] {d1a1bb2c-897f-40ef-9e39-82249e1de30b} <Debug> MemoryTracker: Peak memory usage (for query): 41.93 MiB.

1 rows in set. Elapsed: 1.412 sec. Processed 56.12 thousand rows, 32.06 MB (39.73 thousand rows/s., 22.70 MB/s.)
```

