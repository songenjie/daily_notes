```
SELECT count(*)
FROM system.parts_dis AS parts_all
INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name

[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.805731 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Debug> executeQuery: (from [::ffff:172.18.160.19]:9274)  select count(*) from system.parts_dis as parts_all join system.tables as tables_all on parts_all.name = tables_all.name;
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.806661 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.806709 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.808206 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.808262 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.808917 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.808955 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:55.809059 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.247935 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.249469 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.250462 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.250614 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.250758 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:57.259555 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Debug> executeQuery: (from [::ffff:10.198.17.36]:65250, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:57.259107 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Debug> executeQuery: (from [::ffff:10.198.17.36]:25420, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:57.252935 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:11374, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:57.259046 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:14930, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.251236 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Debug> executeQuery: (from [::ffff:10.198.17.36]:55434, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:57.258802 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Debug> executeQuery: (from [::ffff:10.198.17.36]:57930, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:57.257436 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:57.255113 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:57.263946 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:40086, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:57.258766 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:39306, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:57.266289 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Debug> executeQuery: (from [::ffff:10.198.17.36]:34154, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:57.251673 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Debug> executeQuery: (from [::ffff:10.198.17.36]:16288, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:57.258295 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Debug> executeQuery: (from [::ffff:10.198.17.36]:26436, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:57.257686 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:50278, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:57.258629 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64270, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:57.258392 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:23664, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:57.258873 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:39312, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:57.258392 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:62534, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:57.259014 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Debug> executeQuery: (from [::ffff:10.198.17.36]:11156, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.251727 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001256916 sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:57.258471 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:57.258478 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Debug> executeQuery: (from [::ffff:10.198.17.36]:21111, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:57.258570 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Debug> executeQuery: (from [::ffff:10.198.17.36]:44960, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:57.259406 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Debug> executeQuery: (from [::ffff:10.198.17.36]:14406, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:57.258623 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Debug> executeQuery: (from [::ffff:10.198.17.36]:36394, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:57.258545 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:57.258522 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Debug> executeQuery: (from [::ffff:10.198.17.36]:57724, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:57.258497 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Debug> executeQuery: (from [::ffff:10.198.17.36]:26048, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:57.259089 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:59314, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:57.258675 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Debug> executeQuery: (from [::ffff:10.198.17.36]:61160, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:57.258650 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:57.258566 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:65518, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:57.258954 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Debug> executeQuery: (from [::ffff:10.198.17.36]:34662, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:57.258680 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:55672, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:57.259071 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:46712, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:57.258724 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17008, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:57.258741 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Debug> executeQuery: (from [::ffff:10.198.17.36]:63956, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:57.259218 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Debug> executeQuery: (from [::ffff:10.198.17.36]:52119, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:57.258678 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Debug> executeQuery: (from [::ffff:10.198.17.36]:16828, initial_query_id: 62a50b11-9550-4f02-8828-ea0ffa1ddb2e) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.256965 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.256983 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.257027 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008345078 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.257077 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.257179 [ 29665 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> MergingAggregatedTransform: Reading blocks of partially aggregated data.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:57.260384 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:57.260417 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:57.260523 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.311520 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.312548 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.312700 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.312809 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.313603 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001047231 sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.319537 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.319564 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.319589 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007358406 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.319606 [ 126033 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.320159 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Information> executeQuery: Read 57112 rows, 31.00 MiB in 1.06055793 sec., 53850 rows/sec., 29.23 MiB/sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:52:58.320195 [ 104350 ] {f64d1fae-9045-4c35-a205-551b70166bf9} <Debug> MemoryTracker: Peak memory usage (for query): 36.74 MiB.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:57.252526 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:57.252586 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:57.252716 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.321957 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.323032 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.323201 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.323312 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.324109 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.00108717 sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.330200 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.330223 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.330266 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007545834 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.330281 [ 41428 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.330777 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Information> executeQuery: Read 56883 rows, 30.88 MiB in 1.079048212 sec., 52715 rows/sec., 28.62 MiB/sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:52:58.330814 [ 34766 ] {33f2725e-b9df-4dc8-a83f-0cf0b98d1bba} <Debug> MemoryTracker: Peak memory usage (for query): 36.77 MiB.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:57.259552 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:57.259596 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:57.259742 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.338008 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.339484 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.339666 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.339793 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.340576 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Debug> CreatingSetsBlockInputStream: Created Join with 248 entries from 248 rows in 0.001085548 sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.345809 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.345831 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.345866 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00671145 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.345923 [ 99384 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.346386 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Information> executeQuery: Read 56788 rows, 30.80 MiB in 1.087537238 sec., 52217 rows/sec., 28.32 MiB/sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:52:58.346420 [ 87360 ] {b0334e66-3abd-4939-bd3c-d9f8ce91ea9f} <Debug> MemoryTracker: Peak memory usage (for query): 35.79 MiB.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:57.264695 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:57.265189 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:57.265325 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.355047 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.356079 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.356201 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.356332 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.357103 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001017678 sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.362038 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.362056 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.362089 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006326965 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.362113 [ 81363 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.252143 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.252181 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:57.252286 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.341587 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.342691 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.342802 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.342949 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.343806 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001109364 sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.349307 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.349343 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.349391 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007025097 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.349426 [ 82347 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.362614 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Information> executeQuery: Read 56985 rows, 30.90 MiB in 1.098618354 sec., 51869 rows/sec., 28.13 MiB/sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:52:58.362653 [ 88887 ] {49bd29d8-b75d-487c-82f9-c65bc095c7b5} <Debug> MemoryTracker: Peak memory usage (for query): 37.95 MiB.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.349933 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Information> executeQuery: Read 56941 rows, 30.89 MiB in 1.098635881 sec., 51828 rows/sec., 28.12 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:58.349977 [ 50429 ] {eefca771-1299-45d9-b982-14939fefc2cc} <Debug> MemoryTracker: Peak memory usage (for query): 35.74 MiB.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:57.255855 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:57.255895 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:57.256007 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.373794 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.374747 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.374914 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.375065 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.375863 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001088995 sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.381066 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.381109 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.381158 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00673134 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.381191 [ 15598 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.381664 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Information> executeQuery: Read 56783 rows, 30.81 MiB in 1.126501392 sec., 50406 rows/sec., 27.35 MiB/sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:52:58.381703 [ 5078 ] {47ea0634-d618-44df-ac60-1fde4e139fce} <Debug> MemoryTracker: Peak memory usage (for query): 39.76 MiB.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:57.259603 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:57.259644 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:57.259796 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.457232 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.458455 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.458644 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.458865 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.459554 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001091862 sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.464564 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.464596 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.464652 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006611612 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.464676 [ 23095 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.465193 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Information> executeQuery: Read 56999 rows, 30.94 MiB in 1.20651183 sec., 47242 rows/sec., 25.65 MiB/sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:52:58.465241 [ 41242 ] {b14a67c5-6336-48bd-a259-a94143e7d6bf} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:57.259312 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:57.259364 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:57.259553 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.544769 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.546489 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.546645 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.546820 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.547605 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001106027 sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.552873 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.552917 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.552980 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006957448 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.553018 [ 45183 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.553568 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Information> executeQuery: Read 57352 rows, 31.14 MiB in 1.295094889 sec., 44284 rows/sec., 24.05 MiB/sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:52:58.553610 [ 13023 ] {5e7b3a8d-5609-405e-acd7-ffce8a929f3c} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:57.259569 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:57.259612 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:57.259731 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.574162 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.575328 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.575465 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.575587 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.576460 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001126783 sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.582037 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.582097 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.582149 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007187927 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.582235 [ 38355 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.582808 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Information> executeQuery: Read 56601 rows, 30.70 MiB in 1.324053789 sec., 42748 rows/sec., 23.19 MiB/sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:52:58.582851 [ 18535 ] {d379cf18-f22f-413a-93eb-1c03f918276d} <Debug> MemoryTracker: Peak memory usage (for query): 35.75 MiB.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:57.259130 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:57.259164 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:57.259277 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.587533 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.588641 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.588820 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.588950 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.589780 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001132541 sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.595250 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.595282 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.595312 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007056786 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.595332 [ 43361 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.595764 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Information> executeQuery: Read 57226 rows, 31.06 MiB in 1.33740253 sec., 42788 rows/sec., 23.22 MiB/sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:52:58.595796 [ 6379 ] {a52ce48b-4719-4683-80f8-7ab455d6dd45} <Debug> MemoryTracker: Peak memory usage (for query): 36.74 MiB.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:57.259568 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:57.259605 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:57.259746 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.651453 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.652726 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.652949 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.653119 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.654183 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001467084 sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.659484 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.659526 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.659605 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007414444 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.659625 [ 7271 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.660170 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Information> executeQuery: Read 56994 rows, 30.94 MiB in 1.401455687 sec., 40667 rows/sec., 22.07 MiB/sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:52:58.660209 [ 46741 ] {8bf7cb88-c91b-49df-9c55-f3d68ffd4e8f} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:57.260197 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:57.260233 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:57.260515 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.717501 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.718838 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.719142 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.719327 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.720396 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001553268 sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.726443 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.726525 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.726619 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008219309 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.726669 [ 38211 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.727347 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Information> executeQuery: Read 57247 rows, 31.08 MiB in 1.468210162 sec., 38991 rows/sec., 21.17 MiB/sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:52:58.727387 [ 5727 ] {b4bd195c-1eda-4ae9-891c-389acca63b41} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:57.267139 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:57.267182 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:57.267402 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.734213 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.735270 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.735422 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.735540 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.736354 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001076791 sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.741616 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.741639 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.741671 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006714509 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.741687 [ 8477 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.742241 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Information> executeQuery: Read 56428 rows, 30.62 MiB in 1.475900195 sec., 38232 rows/sec., 20.75 MiB/sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:52:58.742290 [ 51732 ] {076f84fd-733c-4cd3-84f0-8863ee5cc618} <Debug> MemoryTracker: Peak memory usage (for query): 39.75 MiB.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:57.260467 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:57.260510 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:57.260648 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.737831 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.738950 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.739081 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.739269 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.740204 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.0012478 sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.745249 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.745284 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.745334 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006786492 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.745361 [ 31938 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.745858 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Information> executeQuery: Read 57086 rows, 30.98 MiB in 1.486331302 sec., 38407 rows/sec., 20.84 MiB/sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:52:58.745895 [ 82303 ] {2ca4f3e8-af38-4696-ac1f-dad3a95ec4e6} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:57.259666 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:57.259700 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:57.259840 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.744617 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.745721 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.745889 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.746065 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.746924 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001193921 sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.752946 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.752970 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.753022 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00764729 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.753039 [ 6908 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.753526 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Information> executeQuery: Read 57863 rows, 31.41 MiB in 1.494700351 sec., 38712 rows/sec., 21.01 MiB/sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:52:58.753566 [ 40804 ] {ff49a698-a6cc-49e2-948d-d31f38e4328d} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:57.259620 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:57.259661 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:57.259833 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.753147 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.754521 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.754692 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.755162 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.756059 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001532355 sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.761457 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.761501 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.761554 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007458771 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.761574 [ 24124 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.762127 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Information> executeQuery: Read 57027 rows, 30.94 MiB in 1.503541043 sec., 37928 rows/sec., 20.57 MiB/sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:52:58.762160 [ 7360 ] {64f5ea79-0188-424c-81d4-36e716551a58} <Debug> MemoryTracker: Peak memory usage (for query): 35.75 MiB.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:57.260045 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:57.260096 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:57.260206 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.761797 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.762943 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.763180 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.763420 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.764352 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001404347 sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.770126 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.770157 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.770233 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00764811 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.770284 [ 90517 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.771033 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Information> executeQuery: Read 56813 rows, 30.84 MiB in 1.511860938 sec., 37578 rows/sec., 20.40 MiB/sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:52:58.771099 [ 19701 ] {de5227d9-920e-46e8-81de-8edbb2e23a92} <Debug> MemoryTracker: Peak memory usage (for query): 39.75 MiB.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:57.258237 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:57.258272 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:57.258402 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.763293 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.764468 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.764602 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.764840 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.765691 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001215131 sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.770983 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.771048 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.771135 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006973562 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.771190 [ 113934 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.771697 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Information> executeQuery: Read 56770 rows, 30.80 MiB in 1.514200066 sec., 37491 rows/sec., 20.34 MiB/sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:52:58.771739 [ 51792 ] {8a9eaa27-03d4-4c41-96ed-cd206292bab7} <Debug> MemoryTracker: Peak memory usage (for query): 35.75 MiB.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:57.253811 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:57.253867 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:57.253973 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.759710 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.760768 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.760891 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.761015 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.761962 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001187399 sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.767468 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.767534 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.767606 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007152816 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.767690 [ 18982 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.768192 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Information> executeQuery: Read 56793 rows, 30.80 MiB in 1.515207533 sec., 37481 rows/sec., 20.33 MiB/sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:52:58.768231 [ 83774 ] {e6420539-bd23-45f0-9bdf-2d41844544d3} <Debug> MemoryTracker: Peak memory usage (for query): 35.76 MiB.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:57.260259 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:57.260299 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:57.260443 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.765907 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.767171 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.767325 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.767505 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.768279 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001100535 sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.773691 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.773726 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.773769 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006950943 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.773797 [ 39110 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.774306 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Information> executeQuery: Read 58098 rows, 31.54 MiB in 1.515158825 sec., 38344 rows/sec., 20.82 MiB/sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:52:58.774356 [ 28218 ] {d6dfce7a-0511-445d-8dfb-2a5a66fcafe5} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:57.259926 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:57.259967 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:57.260188 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.773691 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.774933 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.775148 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.775368 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.776343 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001400452 sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.782004 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.782039 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.782075 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007600893 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.782100 [ 25906 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.782504 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Information> executeQuery: Read 56520 rows, 30.68 MiB in 1.523685289 sec., 37094 rows/sec., 20.13 MiB/sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:52:58.782539 [ 19379 ] {dd03cb6e-1b7e-44b8-8edd-9dac0b287f45} <Debug> MemoryTracker: Peak memory usage (for query): 39.74 MiB.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:57.259596 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:57.259647 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:57.259772 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.782950 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.784322 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.784604 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.784779 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.785884 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.0015581 sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.791201 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.791268 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.791319 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00735659 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.791340 [ 48155 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.791930 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Information> executeQuery: Read 57484 rows, 31.21 MiB in 1.533292748 sec., 37490 rows/sec., 20.35 MiB/sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:52:58.791964 [ 4713 ] {115e52f1-9094-4375-b8ed-f6963c68ee65} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:57.259947 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:57.259987 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:57.260127 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.793464 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.795194 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.795385 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.795651 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.796633 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001435182 sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.803193 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.803283 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.803360 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008488089 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.803412 [ 106716 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.803967 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Information> executeQuery: Read 56556 rows, 30.71 MiB in 1.544855961 sec., 36609 rows/sec., 19.88 MiB/sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:52:58.804007 [ 117109 ] {dffe0b54-7751-4f43-841e-d65554da14a2} <Debug> MemoryTracker: Peak memory usage (for query): 39.75 MiB.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:57.259723 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:57.259765 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:57.259967 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.810462 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.811807 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.812059 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.812308 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.813338 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001528074 sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.818724 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.818791 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.818872 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00754008 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.818948 [ 31719 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.819551 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Information> executeQuery: Read 57676 rows, 31.31 MiB in 1.560903238 sec., 36950 rows/sec., 20.06 MiB/sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:52:58.819604 [ 6844 ] {bff87534-caaa-4dc0-a7f0-8b82090d80ff} <Debug> MemoryTracker: Peak memory usage (for query): 36.74 MiB.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:57.258799 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:57.258851 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:57.259021 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.814368 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.815593 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.815776 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.815916 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.816810 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001211406 sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.822263 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.822309 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.822369 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007118531 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.822408 [ 45435 ] {c7000290-60de-487f-9551-c3997e413a3d} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.822979 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Information> executeQuery: Read 57368 rows, 31.13 MiB in 1.565211059 sec., 36651 rows/sec., 19.89 MiB/sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:52:58.823032 [ 63376 ] {c7000290-60de-487f-9551-c3997e413a3d} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:57.260296 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:57.260335 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:57.260560 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.822952 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.824338 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.824660 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.825036 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.826033 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001672204 sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.831472 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.831544 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.831640 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007746134 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.831699 [ 18710 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.832406 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Information> executeQuery: Read 56730 rows, 30.79 MiB in 1.573332721 sec., 36057 rows/sec., 19.57 MiB/sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:52:58.832439 [ 25867 ] {7860f151-bfb7-49f1-91ab-9d703d0347fb} <Debug> MemoryTracker: Peak memory usage (for query): 39.75 MiB.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:57.259936 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:57.259975 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:57.260233 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.828050 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.829665 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.829973 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.830304 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.831264 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001598013 sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.837208 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.837269 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.837358 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008164725 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.837406 [ 17717 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.837929 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Information> executeQuery: Read 57085 rows, 31.01 MiB in 1.578981668 sec., 36153 rows/sec., 19.64 MiB/sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:52:58.837969 [ 43405 ] {fe32f0c9-0d5e-41aa-8062-393a14ce147c} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:57.259795 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:57.259844 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:57.259978 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.835740 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.837127 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.837306 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.837556 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.838398 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001265171 sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.843928 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.843984 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.844082 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007328064 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.844127 [ 5583 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.844659 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Information> executeQuery: Read 56862 rows, 30.84 MiB in 1.58590977 sec., 35854 rows/sec., 19.45 MiB/sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:52:58.844692 [ 40936 ] {8f3df5ec-36e7-470b-93fc-e34d3ac8a653} <Debug> MemoryTracker: Peak memory usage (for query): 35.74 MiB.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:57.259459 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:57.259523 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:57.260905 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.867080 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.869384 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.869605 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.869762 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.870731 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001336273 sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.876478 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> AggregatingTransform: Aggregating
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.876566 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.876607 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007635661 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.876675 [ 8153 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Trace> Aggregator: Merging aggregated data
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.877160 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Information> executeQuery: Read 57360 rows, 31.12 MiB in 1.618696152 sec., 35435 rows/sec., 19.23 MiB/sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:52:58.877197 [ 37040 ] {fdcc16ca-b683-4ad6-9cf4-f24141ae284b} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:57.260161 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:57.260201 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:57.260396 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.887134 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.888581 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.888746 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.888908 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.889811 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001221861 sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.895009 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.895077 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.895218 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007024857 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.895242 [ 1632 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.895763 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Information> executeQuery: Read 57210 rows, 31.05 MiB in 1.636601607 sec., 34956 rows/sec., 18.97 MiB/sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:52:58.895801 [ 34299 ] {e925364e-718b-4586-8b3a-929f678d16f2} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:57.259620 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:57.259673 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:57.259845 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.897049 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.898410 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.898601 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.898791 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.899617 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001200485 sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.904771 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.904827 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.904883 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.006835941 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.904912 [ 28521 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.905409 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Information> executeQuery: Read 57092 rows, 30.99 MiB in 1.646842216 sec., 34667 rows/sec., 18.82 MiB/sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:52:58.905447 [ 25180 ] {c2b0df13-82ee-4f94-9be1-81f98fb3c0c1} <Debug> MemoryTracker: Peak memory usage (for query): 36.80 MiB.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:57.259735 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:57.259803 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:57.260051 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.922715 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.923784 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.923993 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.924169 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.925005 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001216027 sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.930400 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.930429 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.930477 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00706601 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.930505 [ 12524 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.931027 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Information> executeQuery: Read 56960 rows, 30.91 MiB in 1.672346882 sec., 34059 rows/sec., 18.48 MiB/sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:52:58.931065 [ 31880 ] {4d96130f-5e83-4643-a260-c7b73a26b8c2} <Debug> MemoryTracker: Peak memory usage (for query): 35.75 MiB.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:57.259896 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:57.259934 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:57.260117 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.934605 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.936218 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.936548 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.936751 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.938082 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001857934 sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.943959 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.944026 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.944130 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008369367 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.944191 [ 31625 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.944799 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Information> executeQuery: Read 57032 rows, 30.97 MiB in 1.686067193 sec., 33825 rows/sec., 18.37 MiB/sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:52:58.944836 [ 48597 ] {92073c85-cd47-4fba-924e-30b681a7abf2} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:57.259697 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:57.259737 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:57.259934 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.054299 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.055584 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.055747 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.055892 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.056916 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001326091 sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.062410 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.062519 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.062700 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007536214 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.062782 [ 11474 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.063355 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Information> executeQuery: Read 57537 rows, 31.22 MiB in 1.804771295 sec., 31880 rows/sec., 17.30 MiB/sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:52:59.063393 [ 6314 ] {15ceb49c-e7f3-4ce7-9f53-c4f5220f3d97} <Debug> MemoryTracker: Peak memory usage (for query): 36.74 MiB.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:57.259854 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:57.259890 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:57.260243 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.065818 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.067082 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.067292 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.067445 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.068422 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001330096 sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.073771 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.073842 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.073898 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007248516 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.073931 [ 4496 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.074461 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Information> executeQuery: Read 56930 rows, 30.89 MiB in 1.815810298 sec., 31352 rows/sec., 17.01 MiB/sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:52:59.074498 [ 28110 ] {28d6eb9e-0f22-4f32-8705-dd930cc29c73} <Debug> MemoryTracker: Peak memory usage (for query): 35.75 MiB.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:57.260326 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:57.260361 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:57.260538 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.089937 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.092937 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.093137 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.093307 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.094444 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.00149872 sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.100243 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.100315 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.100418 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007852834 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.100478 [ 42260 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.101040 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Information> executeQuery: Read 56582 rows, 30.70 MiB in 1.841706395 sec., 30722 rows/sec., 16.67 MiB/sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:52:59.101076 [ 24804 ] {aebde845-d040-4044-a72f-b0bf8add1562} <Debug> MemoryTracker: Peak memory usage (for query): 39.75 MiB.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:57.259893 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:57.259933 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:57.260074 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.100619 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.101766 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.102019 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.102241 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.103273 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001500089 sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.108722 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.108774 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.108837 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007423132 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.108861 [ 26764 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.109349 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Information> executeQuery: Read 57379 rows, 31.16 MiB in 1.850517211 sec., 31007 rows/sec., 16.84 MiB/sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:52:59.109383 [ 16007 ] {de24424d-6e8c-4ec7-82f1-d131bf5e96ef} <Debug> MemoryTracker: Peak memory usage (for query): 36.75 MiB.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:57.260132 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:57.260205 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:57.260392 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.112392 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.113674 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.113897 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.114075 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.114953 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001274047 sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.120120 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.120145 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.120213 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.007079699 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.120235 [ 22321 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.120749 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Information> executeQuery: Read 56520 rows, 30.67 MiB in 1.861645334 sec., 30360 rows/sec., 16.47 MiB/sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:52:59.120785 [ 44925 ] {e1f2a61e-9f85-407d-b878-1088d956c783} <Debug> MemoryTracker: Peak memory usage (for query): 39.75 MiB.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.113407 [ 29780 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> MergingAggregatedTransform: Read 39 blocks of partially aggregated data, total 39 rows.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.113461 [ 29780 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> Aggregator: Merging partially aggregated single-level data.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.113630 [ 29780 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> Aggregator: Merged partially aggregated single-level data.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.113654 [ 29780 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> Aggregator: Converting aggregated data to blocks
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.113677 [ 29780 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Trace> Aggregator: Converted aggregated data to blocks. 1 rows, 8.00 B in 9.016e-06 sec. (110913.93078970718 rows/sec., 866.52 KiB/sec.)
┌─count()─┐
│       0 │
└─────────┘
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.114509 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Information> executeQuery: Read 2214695 rows, 1.18 GiB in 3.308711964 sec., 669352 rows/sec., 364.71 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:52:59.114565 [ 38630 ] {62a50b11-9550-4f02-8828-ea0ffa1ddb2e} <Debug> MemoryTracker: Peak memory usage (for query): 40.02 MiB.

1 rows in set. Elapsed: 3.315 sec. Processed 2.21 million rows, 1.27 GB (668.01 thousand rows/s., 381.70 MB/s.) 
```

