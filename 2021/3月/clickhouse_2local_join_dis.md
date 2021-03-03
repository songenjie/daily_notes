local join dis

```
SELECT count(*)
FROM system.parts AS parts_all
INNER JOIN system.tables_dis AS tables_all ON parts_all.name = tables_all.name

[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:58.568355 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Debug> executeQuery: (from [::ffff:172.18.160.19]:54952)  select count(*) from system.parts as parts_all join system.tables_dis as tables_all on parts_all.name = tables_all.name;
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:58.569216 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables_dis
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:58.569253 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:58.569386 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.992352 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.993525 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.993959 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables_dis
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.994328 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.994473 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.996250 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.998598 [ 29658 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999144 [ 40509 ] {1d311aee-0fb8-42a5-bb74-6fe594003ba6} <Debug> executeQuery: (from [::ffff:10.198.17.36]:37230, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000036 [ 40935 ] {ac1f1537-de07-44d2-ae25-ff28fdbefa66} <Debug> executeQuery: (from [::ffff:10.198.17.36]:23120, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:29:59.999714 [ 64684 ] {c776d1b7-9204-4ac9-8e08-f5670cbc9e93} <Debug> executeQuery: (from [::ffff:10.198.17.36]:33940, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003236 [ 55655 ] {7ec80b6c-413e-40a2-8a62-a2e2b9c9a3d5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:54482, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.992421 [ 7892 ] {7300144f-62ef-447b-a81d-22388a719e8d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:46136, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999180 [ 70590 ] {0c232280-0c2b-435e-9f59-81cb66640413} <Debug> executeQuery: (from [::ffff:10.198.17.36]:53146, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:29:59.999715 [ 70403 ] {84ee3c7c-b908-4609-8c6c-75a57545fb22} <Debug> executeQuery: (from [::ffff:10.198.17.36]:34020, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.987927 [ 62368 ] {982fa7f4-bd53-46bc-a48b-e055ca1938d3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:27930, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.001638 [ 121301 ] {6b05c184-7b85-4414-b00d-3a6ac352d03e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:41936, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985346 [ 75716 ] {b1086a48-e4b5-4f5a-8c07-7db9fdcedb33} <Debug> executeQuery: (from [::ffff:10.198.17.36]:43576, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985346 [ 119742 ] {b98d5dba-04b6-4423-b80f-6fa16df8ce2e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:58060, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.001638 [ 127978 ] {adb92b48-73ee-4e0e-b142-f67009d2a162} <Debug> executeQuery: (from [::ffff:10.198.17.36]:48208, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.985870 [ 31255 ] {49083704-8f52-49c4-afe5-293695ddc242} <Debug> executeQuery: (from [::ffff:10.198.17.36]:24674, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002027 [ 35924 ] {eecbf97d-9d20-41be-aee7-22d7bec1769d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:19546, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003236 [ 46809 ] {6032b383-b56a-4805-9157-43472e10f783} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000182 [ 84824 ] {affc9249-e250-4248-8cd2-607186386842} <Debug> executeQuery: (from [::ffff:10.198.17.36]:13726, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.981776 [ 121280 ] {6626d51c-b312-412a-8180-bfa6c92e8861} <Debug> executeQuery: (from [::ffff:10.198.17.36]:27740, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.009628 [ 113463 ] {4486d168-4a33-474d-a2b9-fba6f7c91c33} <Debug> executeQuery: (from [::ffff:10.198.17.36]:54686, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.985960 [ 129568 ] {13a9fb3a-5ac6-46da-b0ce-f61b9546ed03} <Debug> executeQuery: (from [::ffff:10.198.17.36]:35390, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990434 [ 19612 ] {9f37dc10-4024-436d-aa32-b52fcb961c2a} <Debug> executeQuery: (from [::ffff:10.198.17.36]:24266, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990483 [ 20428 ] {f582ebf2-5ae1-4f2e-867b-918172ac4022} <Debug> executeQuery: (from [::ffff:10.198.17.36]:45354, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000421 [ 12819 ] {f52cec02-f9fb-4f83-9b7c-6db63107ab58} <Debug> executeQuery: (from [::ffff:10.198.17.36]:28326, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990436 [ 19011 ] {239ba26e-0784-42d8-968b-5551d25486b8} <Debug> executeQuery: (from [::ffff:10.198.17.36]:33314, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986072 [ 31253 ] {49e04670-e259-48a6-8c5b-db3b184f28a2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:25836, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003604 [ 50776 ] {9f254a15-c3e9-40ac-a3d6-3b5a39877d47} <Debug> executeQuery: (from [::ffff:10.198.17.36]:57596, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.992858 [ 37963 ] {55d7aed0-9972-484e-8f01-dab5770c1a1b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:60876, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990062 [ 17053 ] {cdfe5edd-70cc-412a-86d3-20291ec5088a} <Debug> executeQuery: (from [::ffff:10.198.17.36]:16922, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990063 [ 30165 ] {50b7e674-3141-4939-9494-dd751f4b0a12} <Debug> executeQuery: (from [::ffff:10.198.17.36]:48630, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982092 [ 46986 ] {55210278-d8ae-4cae-8808-d43ec6875905} <Debug> executeQuery: (from [::ffff:10.198.17.36]:25830, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990109 [ 42353 ] {b5b204a1-890d-477b-b7d1-f059f7983e9b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:46840, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.009846 [ 106376 ] {3ecc5570-8004-4aed-abca-2c35f6c4aa17} <Debug> executeQuery: (from [::ffff:10.198.17.36]:41824, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.009873 [ 72461 ] {9ecc59a8-90c7-4776-8a37-5b2b1cec97e3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:25238, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988288 [ 15336 ] {83f3d885-1927-47be-9b6a-0f1dcd03964c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:21748, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982128 [ 97587 ] {c312b749-ad4d-4e58-aa5d-db92cef109c6} <Debug> executeQuery: (from [::ffff:10.198.17.36]:29352, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.992939 [ 51007 ] {0efb4cd2-2e6a-450b-9734-29c36c0ddcc8} <Debug> executeQuery: (from [::ffff:10.198.17.36]:52582, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002001 [ 96978 ] {1cb3dd94-ac8c-48a4-a328-4fe5d73f6ad3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:60658, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.990206 [ 5075 ] {6fa6f4eb-6e18-4b4e-af54-61eb1d938c30} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988322 [ 66879 ] {6a4d017d-8598-438e-bcfc-9d239ab3c212} <Debug> executeQuery: (from [::ffff:10.198.17.36]:59846, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002317 [ 117362 ] {591ff8bf-15d5-4af3-bcfd-62fa03df069b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:49571, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.990568 [ 22724 ] {8d64f35b-1f8b-4603-b300-44f66ee945f2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.990455 [ 25355 ] {5dcde045-b232-410c-be46-189763d45a94} <Debug> executeQuery: (from [::ffff:10.198.17.36]:59946, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.990203 [ 9694 ] {a62def8a-03bb-4b19-a8b1-292c67b37ec3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:59784, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.990247 [ 21894 ] {48fea46c-a519-4f70-81ff-4af165626ca3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:16865, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.990486 [ 35935 ] {353b496f-a1fa-45a9-8dc6-f18be8ce3b77} <Debug> executeQuery: (from [::ffff:10.198.17.36]:50110, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.990790 [ 3306 ] {fc50a93f-0308-4976-9eba-bbcc3eeba1fb} <Debug> executeQuery: (from [::ffff:10.198.17.36]:44818, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985797 [ 84330 ] {d4bcd398-d513-4c98-837b-3966a5e897cd} <Debug> executeQuery: (from [::ffff:10.198.17.36]:15552, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990255 [ 36870 ] {4eb9ecb3-986c-42ee-8daa-1d1f9f41d025} <Debug> executeQuery: (from [::ffff:10.198.17.36]:28006, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990347 [ 11343 ] {8816e170-e255-473b-8cbc-81ee2b7f24c2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:61758, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.990276 [ 18651 ] {93729876-ed1e-4805-9ab1-5b6c5fd983ef} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64786, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990354 [ 3896 ] {7e23a3bb-31cf-42c7-98f4-56fdc64311b5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64564, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.990618 [ 23847 ] {d0ea6a5c-6ea0-44c3-b355-6b0820722adb} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64392, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990253 [ 28060 ] {9b84a54e-c187-4aa3-8a33-b9b69f49c315} <Debug> executeQuery: (from [::ffff:10.198.17.36]:65002, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.990804 [ 38208 ] {2bd026ef-7122-4f85-ba3f-33aa606e5e28} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17946, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002448 [ 90686 ] {9f012c47-f0d2-4b13-ad78-6cade6f52c3d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:51515, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.990256 [ 1664 ] {8e095c20-41e8-41d3-af6d-761a2beeebfe} <Debug> executeQuery: (from [::ffff:10.198.17.36]:46872, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990422 [ 15090 ] {a0c49990-ca44-4051-8801-2112e85d8797} <Debug> executeQuery: (from [::ffff:10.198.17.36]:51758, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.990910 [ 6733 ] {824b4a3c-723c-4026-b126-7e17ec202ea6} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17880, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.990743 [ 26011 ] {f8822b0e-7d0b-4227-af5f-ec8e129331b2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:12986, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.991623 [ 44579 ] {e2567fd6-7002-4f19-8693-218f9019439f} <Debug> executeQuery: (from [::ffff:10.198.17.36]:54412, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.990687 [ 21986 ] {d2f05c7b-850e-4c33-aa7a-3d0dda24b188} <Debug> executeQuery: (from [::ffff:10.198.17.36]:45780, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.991627 [ 100682 ] {22408f4f-c732-42d3-9abe-37e5f1f5f8b0} <Debug> executeQuery: (from [::ffff:10.198.17.36]:55030, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.991627 [ 100048 ] {54df3ed5-c994-438b-8b4c-9b9d9a849bc9} <Debug> executeQuery: (from [::ffff:10.198.17.36]:49460, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.990777 [ 29440 ] {cfe7eec1-616c-4c4d-92e5-61ada226e643} <Debug> executeQuery: (from [::ffff:10.198.17.36]:39986, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.990777 [ 41205 ] {fb121b0e-bd26-4f82-9a38-6c6746989de8} <Debug> executeQuery: (from [::ffff:10.198.17.36]:62960, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.990775 [ 19908 ] {e47b362f-c74c-406e-92e4-b6d2f048876b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:35240, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.990545 [ 6823 ] {1cb5e3c0-7608-4d39-8390-8bde9ac498e6} <Debug> executeQuery: (from [::ffff:10.198.17.36]:50066, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.990472 [ 12247 ] {9cdbd74b-03dd-4559-ba76-e249b66b64c4} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17270, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.990964 [ 45445 ] {a3ccd1ca-5116-4191-95e1-c3a63b7e00c7} <Debug> executeQuery: (from [::ffff:10.198.17.36]:56666, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.990506 [ 32855 ] {0535ae6a-a540-42b5-8bd1-3e6cca8f06b8} <Debug> executeQuery: (from [::ffff:10.198.17.36]:47962, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.990622 [ 26633 ] {b3fb5747-7dec-4bfa-9214-c8a1aa7decd1} <Debug> executeQuery: (from [::ffff:10.198.17.36]:21278, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.990582 [ 27129 ] {c12ff298-469c-46b0-ae5d-865f6da59d1e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:24800, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.990598 [ 21565 ] {01fa01b0-8019-4368-9e35-258528d1742b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:12334, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.990582 [ 30742 ] {656ea87c-ed2f-4e1b-b312-c6a96492d966} <Debug> executeQuery: (from [::ffff:10.198.17.36]:36620, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.990581 [ 21404 ] {5356e4ce-0a35-4568-bad4-9b4ad8388562} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64144, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.990543 [ 31609 ] {3ffe1796-f25a-4ee1-a106-b4264077d7c5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:49796, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.990506 [ 720 ] {47b693c8-5f0f-41ee-9ee3-beabfdfeca87} <Debug> executeQuery: (from [::ffff:10.198.17.36]:24210, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.991036 [ 20251 ] {b71c545f-3bf4-447e-b2e8-b5fd15355744} <Debug> executeQuery: (from [::ffff:10.198.17.36]:44404, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.990705 [ 16919 ] {ba785cb0-cbfa-4881-a80a-ec9f6cec05b1} <Debug> executeQuery: (from [::ffff:10.198.17.36]:20268, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000710 [ 76828 ] {85b2302a-e131-400e-a7d2-5ae34e91a548} <Debug> executeQuery: (from [::ffff:10.198.17.36]:48124, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.990754 [ 45480 ] {8646c5ec-c3c1-4a3c-b247-8f8b55227408} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64812, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.990766 [ 33383 ] {c960005e-0eab-4527-b809-c61edc025533} <Debug> executeQuery: (from [::ffff:10.198.17.36]:54272, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.990632 [ 19156 ] {2d85d1fa-40c7-481f-8fa5-5ecdbc36156a} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17238, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.990707 [ 1091 ] {804a48c3-2dab-487c-8144-f7cce124be95} <Debug> executeQuery: (from [::ffff:10.198.17.36]:46791, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.990579 [ 20621 ] {fdd53d94-7231-41db-bc71-8dccd6b21973} <Debug> executeQuery: (from [::ffff:10.198.17.36]:47046, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991103 [ 21446 ] {60db3c31-d6f1-4e6f-87e6-cb8e6e6bf723} <Debug> executeQuery: (from [::ffff:10.198.17.36]:61726, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.990758 [ 20465 ] {0c80a6aa-150b-47f7-9caa-ff5a720f12f5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:35826, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.990743 [ 3344 ] {72d3c8ea-e46d-4998-9095-6c6c87253c46} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17306, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.990777 [ 35843 ] {94bb33a1-100f-4c58-b9d5-249adf731391} <Debug> executeQuery: (from [::ffff:10.198.17.36]:21908, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.990747 [ 16206 ] {c29c9ba1-4ddf-43f9-bcea-f969a5ad7d81} <Debug> executeQuery: (from [::ffff:10.198.17.36]:51104, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.990752 [ 738 ] {2390c805-7f27-4e93-9e5f-795661030307} <Debug> executeQuery: (from [::ffff:10.198.17.36]:45152, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.990825 [ 20937 ] {17f71857-a370-4f9b-abb0-6adabcecfacf} <Debug> executeQuery: (from [::ffff:10.198.17.36]:50164, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991138 [ 26083 ] {9cb6ebb8-38ca-4637-a37b-4cf51b14bffd} <Debug> executeQuery: (from [::ffff:10.198.17.36]:18402, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991144 [ 25965 ] {777de6d3-70e9-4e47-a793-fc87f0d35b1c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:19718, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.990792 [ 34557 ] {653ad6e1-d337-404a-8aa2-c2d75460dc5f} <Debug> executeQuery: (from [::ffff:10.198.17.36]:26910, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.990758 [ 39494 ] {fc7911d9-ca6a-4d7a-9d4b-dadb556b3c37} <Debug> executeQuery: (from [::ffff:10.198.17.36]:50348, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.990994 [ 43443 ] {233f5660-1077-4feb-84a4-94d0be6cbf0e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:53938, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.990942 [ 2190 ] {ed97f85c-85eb-4993-8a2b-9071b7eb9d8a} <Debug> executeQuery: (from [::ffff:10.198.17.36]:14588, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.990979 [ 27301 ] {023fb036-4b21-4a1f-ad9a-e921c0ef8f78} <Debug> executeQuery: (from [::ffff:10.198.17.36]:43144, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000416 [ 40935 ] {ac1f1537-de07-44d2-ae25-ff28fdbefa66} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000500 [ 40935 ] {ac1f1537-de07-44d2-ae25-ff28fdbefa66} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000747 [ 41385 ] {ac1f1537-de07-44d2-ae25-ff28fdbefa66} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991009 [ 12751 ] {cdabfb7f-115a-4e61-9a12-4149004e6e4d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:40476, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990995 [ 8893 ] {bf570782-519b-48dd-a5e4-9bdd15e9a8cc} <Debug> executeQuery: (from [::ffff:10.198.17.36]:54366, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.990936 [ 40722 ] {b7a897f0-5816-4755-85c7-87e69ada27ad} <Debug> executeQuery: (from [::ffff:10.198.17.36]:29584, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991350 [ 23012 ] {63104e9f-ee78-42bc-8d88-01aedfb21b34} <Debug> executeQuery: (from [::ffff:10.198.17.36]:54572, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991083 [ 45340 ] {4975e4da-ebe3-447e-993a-b9ff75694b14} <Debug> executeQuery: (from [::ffff:10.198.17.36]:55666, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.991001 [ 29626 ] {9ec0e127-67e5-4d49-bb79-f52611841180} <Debug> executeQuery: (from [::ffff:10.198.17.36]:33284, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.991024 [ 21893 ] {2de30a8c-ec67-40f3-a126-0a98d07b920d} <Debug> executeQuery: (from [::ffff:10.198.17.36]:62016, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991130 [ 2815 ] {d85c03b9-2e79-42eb-aed4-33adf0a6d42c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32775, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991044 [ 1584 ] {a3767225-a3cb-4c3b-8e0f-6703244b03cd} <Debug> executeQuery: (from [::ffff:10.198.17.36]:65250, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991370 [ 26826 ] {d9e3a6ee-8ca9-4140-9b33-2c1edb8fcf82} <Debug> executeQuery: (from [::ffff:10.198.17.36]:58900, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991370 [ 34872 ] {77bccb56-787e-42ff-85e2-42665b8d077b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:19484, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.991483 [ 9001 ] {12593a00-1261-469c-acb7-0d382ae3b0e1} <Debug> executeQuery: (from [::ffff:10.198.17.36]:60468, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999497 [ 40509 ] {1d311aee-0fb8-42a5-bb74-6fe594003ba6} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999584 [ 40509 ] {1d311aee-0fb8-42a5-bb74-6fe594003ba6} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999839 [ 82195 ] {1d311aee-0fb8-42a5-bb74-6fe594003ba6} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991159 [ 5645 ] {60679743-49fb-487b-bf14-5da1e54fbe79} <Debug> executeQuery: (from [::ffff:10.198.17.36]:45360, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991147 [ 27369 ] {e1bc28c5-c87b-4863-b049-498ba01ad363} <Debug> executeQuery: (from [::ffff:10.198.17.36]:42214, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.990971 [ 36333 ] {570e2b8d-6217-4b50-9b01-83c24899a72e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:11882, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991103 [ 24791 ] {96b3a34c-30d4-47b5-9fcd-0c1f75fbc87b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:62848, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000507 [ 84824 ] {affc9249-e250-4248-8cd2-607186386842} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000610 [ 84824 ] {affc9249-e250-4248-8cd2-607186386842} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000843 [ 22288 ] {affc9249-e250-4248-8cd2-607186386842} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.991152 [ 46291 ] {e3523e95-604f-40e3-b177-9f2849398941} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17120, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999620 [ 70590 ] {0c232280-0c2b-435e-9f59-81cb66640413} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999740 [ 70590 ] {0c232280-0c2b-435e-9f59-81cb66640413} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:29:59.999970 [ 29984 ] {0c232280-0c2b-435e-9f59-81cb66640413} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991253 [ 34316 ] {eb552c66-4c87-4eae-baac-acdfd678131b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:14010, initial_query_id: b12b33b8-4f6a-4a77-a41b-38d057cd3d10) SELECT name FROM system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003659 [ 55655 ] {7ec80b6c-413e-40a2-8a62-a2e2b9c9a3d5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003759 [ 55655 ] {7ec80b6c-413e-40a2-8a62-a2e2b9c9a3d5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.004005 [ 11634 ] {7ec80b6c-413e-40a2-8a62-a2e2b9c9a3d5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002041 [ 121301 ] {6b05c184-7b85-4414-b00d-3a6ac352d03e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002142 [ 121301 ] {6b05c184-7b85-4414-b00d-3a6ac352d03e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002475 [ 103085 ] {6b05c184-7b85-4414-b00d-3a6ac352d03e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002041 [ 127978 ] {adb92b48-73ee-4e0e-b142-f67009d2a162} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002145 [ 127978 ] {adb92b48-73ee-4e0e-b142-f67009d2a162} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002475 [ 18457 ] {adb92b48-73ee-4e0e-b142-f67009d2a162} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.000973 [ 40509 ] {1d311aee-0fb8-42a5-bb74-6fe594003ba6} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001770037 sec., 139545 rows/sec., 5.22 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.001011 [ 40509 ] {1d311aee-0fb8-42a5-bb74-6fe594003ba6} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000142 [ 70403 ] {84ee3c7c-b908-4609-8c6c-75a57545fb22} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000260 [ 70403 ] {84ee3c7c-b908-4609-8c6c-75a57545fb22} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000545 [ 69999 ] {84ee3c7c-b908-4609-8c6c-75a57545fb22} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.992838 [ 7892 ] {7300144f-62ef-447b-a81d-22388a719e8d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.992930 [ 7892 ] {7300144f-62ef-447b-a81d-22388a719e8d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993278 [ 87496 ] {7300144f-62ef-447b-a81d-22388a719e8d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988365 [ 62368 ] {982fa7f4-bd53-46bc-a48b-e055ca1938d3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988498 [ 62368 ] {982fa7f4-bd53-46bc-a48b-e055ca1938d3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988764 [ 87029 ] {982fa7f4-bd53-46bc-a48b-e055ca1938d3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000764 [ 12819 ] {f52cec02-f9fb-4f83-9b7c-6db63107ab58} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.000838 [ 12819 ] {f52cec02-f9fb-4f83-9b7c-6db63107ab58} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.001083 [ 21406 ] {f52cec02-f9fb-4f83-9b7c-6db63107ab58} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010188 [ 72461 ] {9ecc59a8-90c7-4776-8a37-5b2b1cec97e3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010289 [ 72461 ] {9ecc59a8-90c7-4776-8a37-5b2b1cec97e3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010518 [ 55108 ] {9ecc59a8-90c7-4776-8a37-5b2b1cec97e3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.001956 [ 84824 ] {affc9249-e250-4248-8cd2-607186386842} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001728904 sec., 142865 rows/sec., 5.35 MiB/sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.001997 [ 84824 ] {affc9249-e250-4248-8cd2-607186386842} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985782 [ 119742 ] {b98d5dba-04b6-4423-b80f-6fa16df8ce2e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985876 [ 119742 ] {b98d5dba-04b6-4423-b80f-6fa16df8ce2e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.986161 [ 85180 ] {b98d5dba-04b6-4423-b80f-6fa16df8ce2e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982349 [ 121280 ] {6626d51c-b312-412a-8180-bfa6c92e8861} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982461 [ 121280 ] {6626d51c-b312-412a-8180-bfa6c92e8861} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982753 [ 71179 ] {6626d51c-b312-412a-8180-bfa6c92e8861} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982422 [ 46986 ] {55210278-d8ae-4cae-8808-d43ec6875905} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982507 [ 46986 ] {55210278-d8ae-4cae-8808-d43ec6875905} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982750 [ 34097 ] {55210278-d8ae-4cae-8808-d43ec6875905} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986314 [ 129568 ] {13a9fb3a-5ac6-46da-b0ce-f61b9546ed03} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986402 [ 129568 ] {13a9fb3a-5ac6-46da-b0ce-f61b9546ed03} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986679 [ 35280 ] {13a9fb3a-5ac6-46da-b0ce-f61b9546ed03} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010183 [ 106376 ] {3ecc5570-8004-4aed-abca-2c35f6c4aa17} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010255 [ 106376 ] {3ecc5570-8004-4aed-abca-2c35f6c4aa17} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010526 [ 99307 ] {3ecc5570-8004-4aed-abca-2c35f6c4aa17} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985781 [ 75716 ] {b1086a48-e4b5-4f5a-8c07-7db9fdcedb33} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.985876 [ 75716 ] {b1086a48-e4b5-4f5a-8c07-7db9fdcedb33} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.986201 [ 125967 ] {b1086a48-e4b5-4f5a-8c07-7db9fdcedb33} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988659 [ 15336 ] {83f3d885-1927-47be-9b6a-0f1dcd03964c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988752 [ 15336 ] {83f3d885-1927-47be-9b6a-0f1dcd03964c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988986 [ 8492 ] {83f3d885-1927-47be-9b6a-0f1dcd03964c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988664 [ 66879 ] {6a4d017d-8598-438e-bcfc-9d239ab3c212} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988752 [ 66879 ] {6a4d017d-8598-438e-bcfc-9d239ab3c212} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.988978 [ 87732 ] {6a4d017d-8598-438e-bcfc-9d239ab3c212} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003904 [ 50776 ] {9f254a15-c3e9-40ac-a3d6-3b5a39877d47} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003986 [ 50776 ] {9f254a15-c3e9-40ac-a3d6-3b5a39877d47} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.004225 [ 46585 ] {9f254a15-c3e9-40ac-a3d6-3b5a39877d47} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000142 [ 64684 ] {c776d1b7-9204-4ac9-8e08-f5670cbc9e93} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000267 [ 64684 ] {c776d1b7-9204-4ac9-8e08-f5670cbc9e93} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.000545 [ 45612 ] {c776d1b7-9204-4ac9-8e08-f5670cbc9e93} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.001804 [ 40935 ] {ac1f1537-de07-44d2-ae25-ff28fdbefa66} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001709655 sec., 144473 rows/sec., 5.41 MiB/sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.001839 [ 40935 ] {ac1f1537-de07-44d2-ae25-ff28fdbefa66} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010068 [ 113463 ] {4486d168-4a33-474d-a2b9-fba6f7c91c33} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010154 [ 113463 ] {4486d168-4a33-474d-a2b9-fba6f7c91c33} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.010491 [ 44483 ] {4486d168-4a33-474d-a2b9-fba6f7c91c33} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986392 [ 31253 ] {49e04670-e259-48a6-8c5b-db3b184f28a2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986508 [ 31253 ] {49e04670-e259-48a6-8c5b-db3b184f28a2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986827 [ 36315 ] {49e04670-e259-48a6-8c5b-db3b184f28a2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.001184 [ 70590 ] {0c232280-0c2b-435e-9f59-81cb66640413} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001909719 sec., 129338 rows/sec., 4.84 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.001244 [ 70590 ] {0c232280-0c2b-435e-9f59-81cb66640413} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002371 [ 96978 ] {1cb3dd94-ac8c-48a4-a328-4fe5d73f6ad3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002458 [ 96978 ] {1cb3dd94-ac8c-48a4-a328-4fe5d73f6ad3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.002737 [ 104168 ] {1cb3dd94-ac8c-48a4-a328-4fe5d73f6ad3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990490 [ 17053 ] {cdfe5edd-70cc-412a-86d3-20291ec5088a} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990590 [ 17053 ] {cdfe5edd-70cc-412a-86d3-20291ec5088a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990913 [ 9157 ] {cdfe5edd-70cc-412a-86d3-20291ec5088a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.001743 [ 70403 ] {84ee3c7c-b908-4609-8c6c-75a57545fb22} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001970902 sec., 125323 rows/sec., 4.69 MiB/sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.001800 [ 70403 ] {84ee3c7c-b908-4609-8c6c-75a57545fb22} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.003579 [ 121301 ] {6b05c184-7b85-4414-b00d-3a6ac352d03e} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001868898 sec., 132163 rows/sec., 4.95 MiB/sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.003615 [ 121301 ] {6b05c184-7b85-4414-b00d-3a6ac352d03e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.003587 [ 127978 ] {adb92b48-73ee-4e0e-b142-f67009d2a162} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001881257 sec., 131295 rows/sec., 4.91 MiB/sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.003623 [ 127978 ] {adb92b48-73ee-4e0e-b142-f67009d2a162} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.005260 [ 55655 ] {7ec80b6c-413e-40a2-8a62-a2e2b9c9a3d5} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001946815 sec., 126873 rows/sec., 4.75 MiB/sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.005298 [ 55655 ] {7ec80b6c-413e-40a2-8a62-a2e2b9c9a3d5} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990491 [ 30165 ] {50b7e674-3141-4939-9494-dd751f4b0a12} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990612 [ 30165 ] {50b7e674-3141-4939-9494-dd751f4b0a12} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990912 [ 3485 ] {50b7e674-3141-4939-9494-dd751f4b0a12} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.002249 [ 12819 ] {f52cec02-f9fb-4f83-9b7c-6db63107ab58} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001775152 sec., 139143 rows/sec., 5.21 MiB/sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:30:00.002283 [ 12819 ] {f52cec02-f9fb-4f83-9b7c-6db63107ab58} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.989947 [ 62368 ] {982fa7f4-bd53-46bc-a48b-e055ca1938d3} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001947328 sec., 126840 rows/sec., 4.75 MiB/sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.989986 [ 62368 ] {982fa7f4-bd53-46bc-a48b-e055ca1938d3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993361 [ 51007 ] {0efb4cd2-2e6a-450b-9734-29c36c0ddcc8} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993463 [ 51007 ] {0efb4cd2-2e6a-450b-9734-29c36c0ddcc8} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993792 [ 116307 ] {0efb4cd2-2e6a-450b-9734-29c36c0ddcc8} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993297 [ 37963 ] {55d7aed0-9972-484e-8f01-dab5770c1a1b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993401 [ 37963 ] {55d7aed0-9972-484e-8f01-dab5770c1a1b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.993752 [ 41602 ] {55d7aed0-9972-484e-8f01-dab5770c1a1b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.005430 [ 50776 ] {9f254a15-c3e9-40ac-a3d6-3b5a39877d47} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001781774 sec., 138625 rows/sec., 5.19 MiB/sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.005468 [ 50776 ] {9f254a15-c3e9-40ac-a3d6-3b5a39877d47} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990888 [ 20428 ] {f582ebf2-5ae1-4f2e-867b-918172ac4022} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990994 [ 20428 ] {f582ebf2-5ae1-4f2e-867b-918172ac4022} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.991367 [ 3557 ] {f582ebf2-5ae1-4f2e-867b-918172ac4022} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002798 [ 90686 ] {9f012c47-f0d2-4b13-ad78-6cade6f52c3d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002909 [ 90686 ] {9f012c47-f0d2-4b13-ad78-6cade6f52c3d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.003181 [ 67030 ] {9f012c47-f0d2-4b13-ad78-6cade6f52c3d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.003659 [ 46809 ] {6032b383-b56a-4805-9157-43472e10f783} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.004365 [ 46809 ] {6032b383-b56a-4805-9157-43472e10f783} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.004664 [ 54891 ] {6032b383-b56a-4805-9157-43472e10f783} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990887 [ 19612 ] {9f37dc10-4024-436d-aa32-b52fcb961c2a} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990988 [ 19612 ] {9f37dc10-4024-436d-aa32-b52fcb961c2a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.991289 [ 7175 ] {9f37dc10-4024-436d-aa32-b52fcb961c2a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.011629 [ 72461 ] {9ecc59a8-90c7-4776-8a37-5b2b1cec97e3} <Information> executeQuery: Read 248 rows, 9.48 KiB in 0.001692839 sec., 146499 rows/sec., 5.47 MiB/sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.011670 [ 72461 ] {9ecc59a8-90c7-4776-8a37-5b2b1cec97e3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990491 [ 42353 ] {b5b204a1-890d-477b-b7d1-f059f7983e9b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.990612 [ 42353 ] {b5b204a1-890d-477b-b7d1-f059f7983e9b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.991031 [ 94939 ] {b5b204a1-890d-477b-b7d1-f059f7983e9b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.994712 [ 7892 ] {7300144f-62ef-447b-a81d-22388a719e8d} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002228058 sec., 110858 rows/sec., 4.15 MiB/sec.
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.994750 [ 7892 ] {7300144f-62ef-447b-a81d-22388a719e8d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.987443 [ 119742 ] {b98d5dba-04b6-4423-b80f-6fa16df8ce2e} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00203995 sec., 121081 rows/sec., 4.53 MiB/sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.987497 [ 119742 ] {b98d5dba-04b6-4423-b80f-6fa16df8ce2e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.983896 [ 121280 ] {6626d51c-b312-412a-8180-bfa6c92e8861} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001969024 sec., 125442 rows/sec., 4.69 MiB/sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.983938 [ 121280 ] {6626d51c-b312-412a-8180-bfa6c92e8861} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.011661 [ 106376 ] {3ecc5570-8004-4aed-abca-2c35f6c4aa17} <Information> executeQuery: Read 248 rows, 9.48 KiB in 0.001763476 sec., 140631 rows/sec., 5.25 MiB/sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.011697 [ 106376 ] {3ecc5570-8004-4aed-abca-2c35f6c4aa17} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.986167 [ 84330 ] {d4bcd398-d513-4c98-837b-3966a5e897cd} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.986256 [ 84330 ] {d4bcd398-d513-4c98-837b-3966a5e897cd} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.986575 [ 85910 ] {d4bcd398-d513-4c98-837b-3966a5e897cd} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.987960 [ 129568 ] {13a9fb3a-5ac6-46da-b0ce-f61b9546ed03} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001934673 sec., 127670 rows/sec., 4.78 MiB/sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.988001 [ 129568 ] {13a9fb3a-5ac6-46da-b0ce-f61b9546ed03} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.990895 [ 19011 ] {239ba26e-0784-42d8-968b-5551d25486b8} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.991000 [ 19011 ] {239ba26e-0784-42d8-968b-5551d25486b8} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.991285 [ 48701 ] {239ba26e-0784-42d8-968b-5551d25486b8} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.990102 [ 15336 ] {83f3d885-1927-47be-9b6a-0f1dcd03964c} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00176872 sec., 139649 rows/sec., 5.23 MiB/sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.990141 [ 15336 ] {83f3d885-1927-47be-9b6a-0f1dcd03964c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.990998 [ 35935 ] {353b496f-a1fa-45a9-8dc6-f18be8ce3b77} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991114 [ 35935 ] {353b496f-a1fa-45a9-8dc6-f18be8ce3b77} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991460 [ 48364 ] {353b496f-a1fa-45a9-8dc6-f18be8ce3b77} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.990093 [ 66879 ] {6a4d017d-8598-438e-bcfc-9d239ab3c212} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001722881 sec., 143364 rows/sec., 5.36 MiB/sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:29:59.990129 [ 66879 ] {6a4d017d-8598-438e-bcfc-9d239ab3c212} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991104 [ 22724 ] {8d64f35b-1f8b-4603-b300-44f66ee945f2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991228 [ 22724 ] {8d64f35b-1f8b-4603-b300-44f66ee945f2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991520 [ 7883 ] {8d64f35b-1f8b-4603-b300-44f66ee945f2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.983917 [ 46986 ] {55210278-d8ae-4cae-8808-d43ec6875905} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001778642 sec., 138869 rows/sec., 5.20 MiB/sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.983976 [ 46986 ] {55210278-d8ae-4cae-8808-d43ec6875905} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.987490 [ 75716 ] {b1086a48-e4b5-4f5a-8c07-7db9fdcedb33} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002071946 sec., 119211 rows/sec., 4.46 MiB/sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.987529 [ 75716 ] {b1086a48-e4b5-4f5a-8c07-7db9fdcedb33} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.002099 [ 64684 ] {c776d1b7-9204-4ac9-8e08-f5670cbc9e93} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002330342 sec., 105993 rows/sec., 3.97 MiB/sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.002144 [ 64684 ] {c776d1b7-9204-4ac9-8e08-f5670cbc9e93} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.991999 [ 44579 ] {e2567fd6-7002-4f19-8693-218f9019439f} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992100 [ 44579 ] {e2567fd6-7002-4f19-8693-218f9019439f} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992388 [ 119889 ] {e2567fd6-7002-4f19-8693-218f9019439f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.011714 [ 113463 ] {4486d168-4a33-474d-a2b9-fba6f7c91c33} <Information> executeQuery: Read 248 rows, 9.48 KiB in 0.002027142 sec., 122339 rows/sec., 4.57 MiB/sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:30:00.011759 [ 113463 ] {4486d168-4a33-474d-a2b9-fba6f7c91c33} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.003896 [ 96978 ] {1cb3dd94-ac8c-48a4-a328-4fe5d73f6ad3} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001848925 sec., 133591 rows/sec., 5.00 MiB/sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:30:00.003941 [ 96978 ] {1cb3dd94-ac8c-48a4-a328-4fe5d73f6ad3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002647 [ 35924 ] {eecbf97d-9d20-41be-aee7-22d7bec1769d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002733 [ 35924 ] {eecbf97d-9d20-41be-aee7-22d7bec1769d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.003058 [ 15487 ] {eecbf97d-9d20-41be-aee7-22d7bec1769d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992015 [ 100048 ] {54df3ed5-c994-438b-8b4c-9b9d9a849bc9} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992134 [ 100048 ] {54df3ed5-c994-438b-8b4c-9b9d9a849bc9} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992453 [ 61667 ] {54df3ed5-c994-438b-8b4c-9b9d9a849bc9} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.988070 [ 31253 ] {49e04670-e259-48a6-8c5b-db3b184f28a2} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001956908 sec., 126219 rows/sec., 4.72 MiB/sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.988109 [ 31253 ] {49e04670-e259-48a6-8c5b-db3b184f28a2} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.001059 [ 76828 ] {85b2302a-e131-400e-a7d2-5ae34e91a548} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.001160 [ 76828 ] {85b2302a-e131-400e-a7d2-5ae34e91a548} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.001433 [ 81727 ] {85b2302a-e131-400e-a7d2-5ae34e91a548} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992015 [ 100682 ] {22408f4f-c732-42d3-9abe-37e5f1f5f8b0} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992135 [ 100682 ] {22408f4f-c732-42d3-9abe-37e5f1f5f8b0} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.992429 [ 65266 ] {22408f4f-c732-42d3-9abe-37e5f1f5f8b0} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990870 [ 11343 ] {8816e170-e255-473b-8cbc-81ee2b7f24c2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990977 [ 11343 ] {8816e170-e255-473b-8cbc-81ee2b7f24c2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.991390 [ 18989 ] {8816e170-e255-473b-8cbc-81ee2b7f24c2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.992170 [ 30165 ] {50b7e674-3141-4939-9494-dd751f4b0a12} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00202299 sec., 122096 rows/sec., 4.57 MiB/sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.992213 [ 30165 ] {50b7e674-3141-4939-9494-dd751f4b0a12} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991324 [ 2190 ] {ed97f85c-85eb-4993-8a2b-9071b7eb9d8a} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991412 [ 2190 ] {ed97f85c-85eb-4993-8a2b-9071b7eb9d8a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991655 [ 15141 ] {ed97f85c-85eb-4993-8a2b-9071b7eb9d8a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.992795 [ 20428 ] {f582ebf2-5ae1-4f2e-867b-918172ac4022} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002240686 sec., 110234 rows/sec., 4.12 MiB/sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.992830 [ 20428 ] {f582ebf2-5ae1-4f2e-867b-918172ac4022} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.005803 [ 46809 ] {6032b383-b56a-4805-9157-43472e10f783} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002495654 sec., 98972 rows/sec., 3.70 MiB/sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:30:00.005837 [ 46809 ] {6032b383-b56a-4805-9157-43472e10f783} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.004434 [ 90686 ] {9f012c47-f0d2-4b13-ad78-6cade6f52c3d} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001939427 sec., 127357 rows/sec., 4.77 MiB/sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.004467 [ 90686 ] {9f012c47-f0d2-4b13-ad78-6cade6f52c3d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.986290 [ 31255 ] {49083704-8f52-49c4-afe5-293695ddc242} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.987003 [ 31255 ] {49083704-8f52-49c4-afe5-293695ddc242} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.987297 [ 90376 ] {49083704-8f52-49c4-afe5-293695ddc242} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.995083 [ 51007 ] {0efb4cd2-2e6a-450b-9734-29c36c0ddcc8} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002070143 sec., 119315 rows/sec., 4.46 MiB/sec.
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.995124 [ 51007 ] {0efb4cd2-2e6a-450b-9734-29c36c0ddcc8} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.990962 [ 25355 ] {5dcde045-b232-410c-be46-189763d45a94} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991073 [ 25355 ] {5dcde045-b232-410c-be46-189763d45a94} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991424 [ 6024 ] {5dcde045-b232-410c-be46-189763d45a94} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.987812 [ 84330 ] {d4bcd398-d513-4c98-837b-3966a5e897cd} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00196797 sec., 125510 rows/sec., 4.70 MiB/sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:29:59.987851 [ 84330 ] {d4bcd398-d513-4c98-837b-3966a5e897cd} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.995011 [ 37963 ] {55d7aed0-9972-484e-8f01-dab5770c1a1b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002092071 sec., 118064 rows/sec., 4.42 MiB/sec.
[BJHTYD-Hope-17-3.hadoop.jd.local] 2021.03.02 16:29:59.995059 [ 37963 ] {55d7aed0-9972-484e-8f01-dab5770c1a1b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.992806 [ 19612 ] {9f37dc10-4024-436d-aa32-b52fcb961c2a} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002290156 sec., 107852 rows/sec., 4.04 MiB/sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.992840 [ 19612 ] {9f37dc10-4024-436d-aa32-b52fcb961c2a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.992879 [ 19011 ] {239ba26e-0784-42d8-968b-5551d25486b8} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002367219 sec., 104341 rows/sec., 3.90 MiB/sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:29:59.992926 [ 19011 ] {239ba26e-0784-42d8-968b-5551d25486b8} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991356 [ 43443 ] {233f5660-1077-4feb-84a4-94d0be6cbf0e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991451 [ 43443 ] {233f5660-1077-4feb-84a4-94d0be6cbf0e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991692 [ 39780 ] {233f5660-1077-4feb-84a4-94d0be6cbf0e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991102 [ 23847 ] {d0ea6a5c-6ea0-44c3-b355-6b0820722adb} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991233 [ 23847 ] {d0ea6a5c-6ea0-44c3-b355-6b0820722adb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991528 [ 36662 ] {d0ea6a5c-6ea0-44c3-b355-6b0820722adb} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.992682 [ 35935 ] {353b496f-a1fa-45a9-8dc6-f18be8ce3b77} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002090771 sec., 118138 rows/sec., 4.42 MiB/sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.992718 [ 35935 ] {353b496f-a1fa-45a9-8dc6-f18be8ce3b77} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.990630 [ 9694 ] {a62def8a-03bb-4b19-a8b1-292c67b37ec3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.990727 [ 9694 ] {a62def8a-03bb-4b19-a8b1-292c67b37ec3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.991170 [ 18598 ] {a62def8a-03bb-4b19-a8b1-292c67b37ec3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.990792 [ 5075 ] {6fa6f4eb-6e18-4b4e-af54-61eb1d938c30} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.990931 [ 5075 ] {6fa6f4eb-6e18-4b4e-af54-61eb1d938c30} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.991288 [ 15224 ] {6fa6f4eb-6e18-4b4e-af54-61eb1d938c30} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.993596 [ 44579 ] {e2567fd6-7002-4f19-8693-218f9019439f} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001917328 sec., 128825 rows/sec., 4.82 MiB/sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.993634 [ 44579 ] {e2567fd6-7002-4f19-8693-218f9019439f} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.992801 [ 22724 ] {8d64f35b-1f8b-4603-b300-44f66ee945f2} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002157836 sec., 114466 rows/sec., 4.28 MiB/sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.992836 [ 22724 ] {8d64f35b-1f8b-4603-b300-44f66ee945f2} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.993573 [ 100682 ] {22408f4f-c732-42d3-9abe-37e5f1f5f8b0} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001878786 sec., 131467 rows/sec., 4.92 MiB/sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.993619 [ 100682 ] {22408f4f-c732-42d3-9abe-37e5f1f5f8b0} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.004571 [ 35924 ] {eecbf97d-9d20-41be-aee7-22d7bec1769d} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002486398 sec., 99340 rows/sec., 3.72 MiB/sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.004608 [ 35924 ] {eecbf97d-9d20-41be-aee7-22d7bec1769d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.988467 [ 31255 ] {49083704-8f52-49c4-afe5-293695ddc242} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002548255 sec., 96929 rows/sec., 3.63 MiB/sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:29:59.988500 [ 31255 ] {49083704-8f52-49c4-afe5-293695ddc242} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991221 [ 20465 ] {0c80a6aa-150b-47f7-9caa-ff5a720f12f5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991354 [ 20465 ] {0c80a6aa-150b-47f7-9caa-ff5a720f12f5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991699 [ 37906 ] {0c80a6aa-150b-47f7-9caa-ff5a720f12f5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.992396 [ 42353 ] {b5b204a1-890d-477b-b7d1-f059f7983e9b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00224593 sec., 109976 rows/sec., 4.12 MiB/sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.992431 [ 42353 ] {b5b204a1-890d-477b-b7d1-f059f7983e9b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.002541 [ 76828 ] {85b2302a-e131-400e-a7d2-5ae34e91a548} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001779447 sec., 138807 rows/sec., 5.19 MiB/sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:30:00.002588 [ 76828 ] {85b2302a-e131-400e-a7d2-5ae34e91a548} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.992422 [ 9694 ] {a62def8a-03bb-4b19-a8b1-292c67b37ec3} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002140956 sec., 115369 rows/sec., 4.32 MiB/sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.992459 [ 9694 ] {a62def8a-03bb-4b19-a8b1-292c67b37ec3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.993651 [ 100048 ] {54df3ed5-c994-438b-8b4c-9b9d9a849bc9} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001969436 sec., 125416 rows/sec., 4.69 MiB/sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:29:59.993703 [ 100048 ] {54df3ed5-c994-438b-8b4c-9b9d9a849bc9} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.992043 [ 17053 ] {cdfe5edd-70cc-412a-86d3-20291ec5088a} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001894122 sec., 130403 rows/sec., 4.88 MiB/sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:29:59.992148 [ 17053 ] {cdfe5edd-70cc-412a-86d3-20291ec5088a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990870 [ 3896 ] {7e23a3bb-31cf-42c7-98f4-56fdc64311b5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990977 [ 3896 ] {7e23a3bb-31cf-42c7-98f4-56fdc64311b5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.991427 [ 21011 ] {7e23a3bb-31cf-42c7-98f4-56fdc64311b5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.992643 [ 11343 ] {8816e170-e255-473b-8cbc-81ee2b7f24c2} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002179636 sec., 113321 rows/sec., 4.24 MiB/sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.992679 [ 11343 ] {8816e170-e255-473b-8cbc-81ee2b7f24c2} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991246 [ 19908 ] {e47b362f-c74c-406e-92e4-b6d2f048876b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991383 [ 19908 ] {e47b362f-c74c-406e-92e4-b6d2f048876b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991778 [ 43418 ] {e47b362f-c74c-406e-92e4-b6d2f048876b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.992655 [ 2190 ] {ed97f85c-85eb-4993-8a2b-9071b7eb9d8a} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00162168 sec., 152311 rows/sec., 5.70 MiB/sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.992697 [ 2190 ] {ed97f85c-85eb-4993-8a2b-9071b7eb9d8a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991156 [ 26633 ] {b3fb5747-7dec-4bfa-9214-c8a1aa7decd1} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991269 [ 26633 ] {b3fb5747-7dec-4bfa-9214-c8a1aa7decd1} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991621 [ 35032 ] {b3fb5747-7dec-4bfa-9214-c8a1aa7decd1} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.992958 [ 25355 ] {5dcde045-b232-410c-be46-189763d45a94} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002422826 sec., 101947 rows/sec., 3.81 MiB/sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.992993 [ 25355 ] {5dcde045-b232-410c-be46-189763d45a94} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991363 [ 38208 ] {2bd026ef-7122-4f85-ba3f-33aa606e5e28} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991503 [ 38208 ] {2bd026ef-7122-4f85-ba3f-33aa606e5e28} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991970 [ 27552 ] {2bd026ef-7122-4f85-ba3f-33aa606e5e28} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.993129 [ 23847 ] {d0ea6a5c-6ea0-44c3-b355-6b0820722adb} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002426058 sec., 101811 rows/sec., 3.81 MiB/sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.993163 [ 23847 ] {d0ea6a5c-6ea0-44c3-b355-6b0820722adb} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991360 [ 6733 ] {824b4a3c-723c-4026-b126-7e17ec202ea6} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991496 [ 6733 ] {824b4a3c-723c-4026-b126-7e17ec202ea6} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991867 [ 29661 ] {824b4a3c-723c-4026-b126-7e17ec202ea6} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.992866 [ 43443 ] {233f5660-1077-4feb-84a4-94d0be6cbf0e} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.001802253 sec., 137050 rows/sec., 5.13 MiB/sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.992902 [ 43443 ] {233f5660-1077-4feb-84a4-94d0be6cbf0e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990822 [ 36870 ] {4eb9ecb3-986c-42ee-8daa-1d1f9f41d025} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990939 [ 36870 ] {4eb9ecb3-986c-42ee-8daa-1d1f9f41d025} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.991444 [ 18418 ] {4eb9ecb3-986c-42ee-8daa-1d1f9f41d025} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.992861 [ 5075 ] {6fa6f4eb-6e18-4b4e-af54-61eb1d938c30} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002548596 sec., 96916 rows/sec., 3.63 MiB/sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.992906 [ 5075 ] {6fa6f4eb-6e18-4b4e-af54-61eb1d938c30} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991192 [ 16919 ] {ba785cb0-cbfa-4881-a80a-ec9f6cec05b1} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991325 [ 16919 ] {ba785cb0-cbfa-4881-a80a-ec9f6cec05b1} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991657 [ 23234 ] {ba785cb0-cbfa-4881-a80a-ec9f6cec05b1} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.990804 [ 21894 ] {48fea46c-a519-4f70-81ff-4af165626ca3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.990933 [ 21894 ] {48fea46c-a519-4f70-81ff-4af165626ca3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.991365 [ 15888 ] {48fea46c-a519-4f70-81ff-4af165626ca3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.992952 [ 20465 ] {0c80a6aa-150b-47f7-9caa-ff5a720f12f5} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002102728 sec., 117466 rows/sec., 4.40 MiB/sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.992986 [ 20465 ] {0c80a6aa-150b-47f7-9caa-ff5a720f12f5} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.990811 [ 1664 ] {8e095c20-41e8-41d3-af6d-761a2beeebfe} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.990931 [ 1664 ] {8e095c20-41e8-41d3-af6d-761a2beeebfe} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.991457 [ 16539 ] {8e095c20-41e8-41d3-af6d-761a2beeebfe} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.993002 [ 3896 ] {7e23a3bb-31cf-42c7-98f4-56fdc64311b5} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002557225 sec., 96589 rows/sec., 3.61 MiB/sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.993060 [ 3896 ] {7e23a3bb-31cf-42c7-98f4-56fdc64311b5} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991188 [ 21986 ] {d2f05c7b-850e-4c33-aa7a-3d0dda24b188} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991364 [ 21986 ] {d2f05c7b-850e-4c33-aa7a-3d0dda24b188} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.991828 [ 31757 ] {d2f05c7b-850e-4c33-aa7a-3d0dda24b188} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991387 [ 20937 ] {17f71857-a370-4f9b-abb0-6adabcecfacf} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991527 [ 20937 ] {17f71857-a370-4f9b-abb0-6adabcecfacf} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991939 [ 30572 ] {17f71857-a370-4f9b-abb0-6adabcecfacf} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.993301 [ 19908 ] {e47b362f-c74c-406e-92e4-b6d2f048876b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002410372 sec., 102473 rows/sec., 3.83 MiB/sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.993339 [ 19908 ] {e47b362f-c74c-406e-92e4-b6d2f048876b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.993167 [ 26633 ] {b3fb5747-7dec-4bfa-9214-c8a1aa7decd1} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00246641 sec., 100145 rows/sec., 3.75 MiB/sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.993200 [ 26633 ] {b3fb5747-7dec-4bfa-9214-c8a1aa7decd1} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991304 [ 29440 ] {cfe7eec1-616c-4c4d-92e5-61ada226e643} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991424 [ 29440 ] {cfe7eec1-616c-4c4d-92e5-61ada226e643} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991803 [ 6545 ] {cfe7eec1-616c-4c4d-92e5-61ada226e643} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991199 [ 27129 ] {c12ff298-469c-46b0-ae5d-865f6da59d1e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991318 [ 27129 ] {c12ff298-469c-46b0-ae5d-865f6da59d1e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991911 [ 21140 ] {c12ff298-469c-46b0-ae5d-865f6da59d1e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991126 [ 6823 ] {1cb5e3c0-7608-4d39-8390-8bde9ac498e6} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991246 [ 6823 ] {1cb5e3c0-7608-4d39-8390-8bde9ac498e6} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991698 [ 48213 ] {1cb5e3c0-7608-4d39-8390-8bde9ac498e6} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991246 [ 41205 ] {fb121b0e-bd26-4f82-9a38-6c6746989de8} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991402 [ 41205 ] {fb121b0e-bd26-4f82-9a38-6c6746989de8} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.991777 [ 47979 ] {fb121b0e-bd26-4f82-9a38-6c6746989de8} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990820 [ 28060 ] {9b84a54e-c187-4aa3-8a33-b9b69f49c315} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.990935 [ 28060 ] {9b84a54e-c187-4aa3-8a33-b9b69f49c315} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.991338 [ 9164 ] {9b84a54e-c187-4aa3-8a33-b9b69f49c315} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.982477 [ 97587 ] {c312b749-ad4d-4e58-aa5d-db92cef109c6} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.983897 [ 97587 ] {c312b749-ad4d-4e58-aa5d-db92cef109c6} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.984236 [ 32948 ] {c312b749-ad4d-4e58-aa5d-db92cef109c6} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.993673 [ 6733 ] {824b4a3c-723c-4026-b126-7e17ec202ea6} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00268115 sec., 92124 rows/sec., 3.45 MiB/sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.993712 [ 6733 ] {824b4a3c-723c-4026-b126-7e17ec202ea6} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991206 [ 720 ] {47b693c8-5f0f-41ee-9ee3-beabfdfeca87} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991392 [ 720 ] {47b693c8-5f0f-41ee-9ee3-beabfdfeca87} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991786 [ 13623 ] {47b693c8-5f0f-41ee-9ee3-beabfdfeca87} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991358 [ 3306 ] {fc50a93f-0308-4976-9eba-bbcc3eeba1fb} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991509 [ 3306 ] {fc50a93f-0308-4976-9eba-bbcc3eeba1fb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.991901 [ 28878 ] {fc50a93f-0308-4976-9eba-bbcc3eeba1fb} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.990938 [ 15090 ] {a0c49990-ca44-4051-8801-2112e85d8797} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.991110 [ 15090 ] {a0c49990-ca44-4051-8801-2112e85d8797} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.991541 [ 10382 ] {a0c49990-ca44-4051-8801-2112e85d8797} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991497 [ 12751 ] {cdabfb7f-115a-4e61-9a12-4149004e6e4d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991644 [ 12751 ] {cdabfb7f-115a-4e61-9a12-4149004e6e4d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.992017 [ 37284 ] {cdabfb7f-115a-4e61-9a12-4149004e6e4d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.993282 [ 16919 ] {ba785cb0-cbfa-4881-a80a-ec9f6cec05b1} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002477746 sec., 99687 rows/sec., 3.73 MiB/sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.993316 [ 16919 ] {ba785cb0-cbfa-4881-a80a-ec9f6cec05b1} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.993212 [ 36870 ] {4eb9ecb3-986c-42ee-8daa-1d1f9f41d025} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002858191 sec., 86418 rows/sec., 3.23 MiB/sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.993255 [ 36870 ] {4eb9ecb3-986c-42ee-8daa-1d1f9f41d025} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.993704 [ 38208 ] {2bd026ef-7122-4f85-ba3f-33aa606e5e28} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.0028039 sec., 88091 rows/sec., 3.30 MiB/sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.993766 [ 38208 ] {2bd026ef-7122-4f85-ba3f-33aa606e5e28} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991878 [ 26826 ] {d9e3a6ee-8ca9-4140-9b33-2c1edb8fcf82} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991996 [ 26826 ] {d9e3a6ee-8ca9-4140-9b33-2c1edb8fcf82} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.992276 [ 5145 ] {d9e3a6ee-8ca9-4140-9b33-2c1edb8fcf82} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.993175 [ 1664 ] {8e095c20-41e8-41d3-af6d-761a2beeebfe} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002801401 sec., 88170 rows/sec., 3.30 MiB/sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.993243 [ 1664 ] {8e095c20-41e8-41d3-af6d-761a2beeebfe} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991791 [ 25965 ] {777de6d3-70e9-4e47-a793-fc87f0d35b1c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991951 [ 25965 ] {777de6d3-70e9-4e47-a793-fc87f0d35b1c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.992420 [ 12121 ] {777de6d3-70e9-4e47-a793-fc87f0d35b1c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991236 [ 30742 ] {656ea87c-ed2f-4e1b-b312-c6a96492d966} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991372 [ 30742 ] {656ea87c-ed2f-4e1b-b312-c6a96492d966} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991867 [ 44790 ] {656ea87c-ed2f-4e1b-b312-c6a96492d966} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.991978 [ 9001 ] {12593a00-1261-469c-acb7-0d382ae3b0e1} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.992144 [ 9001 ] {12593a00-1261-469c-acb7-0d382ae3b0e1} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.992519 [ 32886 ] {12593a00-1261-469c-acb7-0d382ae3b0e1} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991712 [ 21446 ] {60db3c31-d6f1-4e6f-87e6-cb8e6e6bf723} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991853 [ 21446 ] {60db3c31-d6f1-4e6f-87e6-cb8e6e6bf723} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.992270 [ 44332 ] {60db3c31-d6f1-4e6f-87e6-cb8e6e6bf723} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.993350 [ 21894 ] {48fea46c-a519-4f70-81ff-4af165626ca3} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003024016 sec., 81679 rows/sec., 3.06 MiB/sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.993398 [ 21894 ] {48fea46c-a519-4f70-81ff-4af165626ca3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.991530 [ 8893 ] {bf570782-519b-48dd-a5e4-9bdd15e9a8cc} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.991781 [ 8893 ] {bf570782-519b-48dd-a5e4-9bdd15e9a8cc} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.992151 [ 17834 ] {bf570782-519b-48dd-a5e4-9bdd15e9a8cc} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.993521 [ 20937 ] {17f71857-a370-4f9b-abb0-6adabcecfacf} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002586979 sec., 95478 rows/sec., 3.57 MiB/sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.993556 [ 20937 ] {17f71857-a370-4f9b-abb0-6adabcecfacf} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991330 [ 26011 ] {f8822b0e-7d0b-4227-af5f-ec8e129331b2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991446 [ 26011 ] {f8822b0e-7d0b-4227-af5f-ec8e129331b2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991876 [ 38949 ] {f8822b0e-7d0b-4227-af5f-ec8e129331b2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.993451 [ 27129 ] {c12ff298-469c-46b0-ae5d-865f6da59d1e} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002775502 sec., 88992 rows/sec., 3.33 MiB/sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.993489 [ 27129 ] {c12ff298-469c-46b0-ae5d-865f6da59d1e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.991535 [ 20251 ] {b71c545f-3bf4-447e-b2e8-b5fd15355744} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.991706 [ 20251 ] {b71c545f-3bf4-447e-b2e8-b5fd15355744} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.992113 [ 19958 ] {b71c545f-3bf4-447e-b2e8-b5fd15355744} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.985378 [ 97587 ] {c312b749-ad4d-4e58-aa5d-db92cef109c6} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003188033 sec., 77477 rows/sec., 2.90 MiB/sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:29:59.985419 [ 97587 ] {c312b749-ad4d-4e58-aa5d-db92cef109c6} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991222 [ 32855 ] {0535ae6a-a540-42b5-8bd1-3e6cca8f06b8} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991392 [ 32855 ] {0535ae6a-a540-42b5-8bd1-3e6cca8f06b8} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991816 [ 14285 ] {0535ae6a-a540-42b5-8bd1-3e6cca8f06b8} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.993769 [ 29440 ] {cfe7eec1-616c-4c4d-92e5-61ada226e643} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002872538 sec., 85986 rows/sec., 3.22 MiB/sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.993816 [ 29440 ] {cfe7eec1-616c-4c4d-92e5-61ada226e643} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991630 [ 2815 ] {d85c03b9-2e79-42eb-aed4-33adf0a6d42c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991739 [ 2815 ] {d85c03b9-2e79-42eb-aed4-33adf0a6d42c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.992048 [ 25795 ] {d85c03b9-2e79-42eb-aed4-33adf0a6d42c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.993730 [ 41205 ] {fb121b0e-bd26-4f82-9a38-6c6746989de8} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002851127 sec., 86632 rows/sec., 3.24 MiB/sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:29:59.993764 [ 41205 ] {fb121b0e-bd26-4f82-9a38-6c6746989de8} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.993571 [ 21986 ] {d2f05c7b-850e-4c33-aa7a-3d0dda24b188} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00279639 sec., 88328 rows/sec., 3.30 MiB/sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:29:59.993605 [ 21986 ] {d2f05c7b-850e-4c33-aa7a-3d0dda24b188} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991645 [ 27369 ] {e1bc28c5-c87b-4863-b049-498ba01ad363} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991762 [ 27369 ] {e1bc28c5-c87b-4863-b049-498ba01ad363} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.992093 [ 8956 ] {e1bc28c5-c87b-4863-b049-498ba01ad363} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.993599 [ 6823 ] {1cb5e3c0-7608-4d39-8390-8bde9ac498e6} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002963994 sec., 83333 rows/sec., 3.12 MiB/sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.993637 [ 6823 ] {1cb5e3c0-7608-4d39-8390-8bde9ac498e6} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.991485 [ 40722 ] {b7a897f0-5816-4755-85c7-87e69ada27ad} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.991612 [ 40722 ] {b7a897f0-5816-4755-85c7-87e69ada27ad} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.991974 [ 17259 ] {b7a897f0-5816-4755-85c7-87e69ada27ad} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991352 [ 34557 ] {653ad6e1-d337-404a-8aa2-c2d75460dc5f} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991495 [ 34557 ] {653ad6e1-d337-404a-8aa2-c2d75460dc5f} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991808 [ 3485 ] {653ad6e1-d337-404a-8aa2-c2d75460dc5f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991218 [ 21565 ] {01fa01b0-8019-4368-9e35-258528d1742b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991377 [ 21565 ] {01fa01b0-8019-4368-9e35-258528d1742b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991762 [ 31257 ] {01fa01b0-8019-4368-9e35-258528d1742b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.993622 [ 15090 ] {a0c49990-ca44-4051-8801-2112e85d8797} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003115673 sec., 79276 rows/sec., 2.97 MiB/sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:29:59.993657 [ 15090 ] {a0c49990-ca44-4051-8801-2112e85d8797} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991268 [ 738 ] {2390c805-7f27-4e93-9e5f-795661030307} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991489 [ 738 ] {2390c805-7f27-4e93-9e5f-795661030307} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991845 [ 41165 ] {2390c805-7f27-4e93-9e5f-795661030307} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.994076 [ 3306 ] {fc50a93f-0308-4976-9eba-bbcc3eeba1fb} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003190862 sec., 77408 rows/sec., 2.90 MiB/sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:29:59.994108 [ 3306 ] {fc50a93f-0308-4976-9eba-bbcc3eeba1fb} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.993591 [ 12751 ] {cdabfb7f-115a-4e61-9a12-4149004e6e4d} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002488809 sec., 99244 rows/sec., 3.71 MiB/sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.993629 [ 12751 ] {cdabfb7f-115a-4e61-9a12-4149004e6e4d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991586 [ 45340 ] {4975e4da-ebe3-447e-993a-b9ff75694b14} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991715 [ 45340 ] {4975e4da-ebe3-447e-993a-b9ff75694b14} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.992225 [ 8604 ] {4975e4da-ebe3-447e-993a-b9ff75694b14} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.993955 [ 26826 ] {d9e3a6ee-8ca9-4140-9b33-2c1edb8fcf82} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002500343 sec., 98786 rows/sec., 3.70 MiB/sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.993988 [ 26826 ] {d9e3a6ee-8ca9-4140-9b33-2c1edb8fcf82} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.993532 [ 28060 ] {9b84a54e-c187-4aa3-8a33-b9b69f49c315} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003189898 sec., 77431 rows/sec., 2.90 MiB/sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.993567 [ 28060 ] {9b84a54e-c187-4aa3-8a33-b9b69f49c315} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991528 [ 1584 ] {a3767225-a3cb-4c3b-8e0f-6703244b03cd} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.991646 [ 1584 ] {a3767225-a3cb-4c3b-8e0f-6703244b03cd} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.992060 [ 29699 ] {a3767225-a3cb-4c3b-8e0f-6703244b03cd} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.993515 [ 720 ] {47b693c8-5f0f-41ee-9ee3-beabfdfeca87} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002878268 sec., 85815 rows/sec., 3.21 MiB/sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.993553 [ 720 ] {47b693c8-5f0f-41ee-9ee3-beabfdfeca87} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.994124 [ 21446 ] {60db3c31-d6f1-4e6f-87e6-cb8e6e6bf723} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002915554 sec., 84718 rows/sec., 3.17 MiB/sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.994157 [ 21446 ] {60db3c31-d6f1-4e6f-87e6-cb8e6e6bf723} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991663 [ 24791 ] {96b3a34c-30d4-47b5-9fcd-0c1f75fbc87b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.991807 [ 24791 ] {96b3a34c-30d4-47b5-9fcd-0c1f75fbc87b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.992138 [ 47268 ] {96b3a34c-30d4-47b5-9fcd-0c1f75fbc87b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.991475 [ 3344 ] {72d3c8ea-e46d-4998-9095-6c6c87253c46} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.991655 [ 3344 ] {72d3c8ea-e46d-4998-9095-6c6c87253c46} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.992138 [ 7392 ] {72d3c8ea-e46d-4998-9095-6c6c87253c46} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991254 [ 21404 ] {5356e4ce-0a35-4568-bad4-9b4ad8388562} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991384 [ 21404 ] {5356e4ce-0a35-4568-bad4-9b4ad8388562} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991781 [ 24123 ] {5356e4ce-0a35-4568-bad4-9b4ad8388562} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.994075 [ 9001 ] {12593a00-1261-469c-acb7-0d382ae3b0e1} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002493569 sec., 99054 rows/sec., 3.71 MiB/sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.994114 [ 9001 ] {12593a00-1261-469c-acb7-0d382ae3b0e1} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.993689 [ 30742 ] {656ea87c-ed2f-4e1b-b312-c6a96492d966} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003009584 sec., 82071 rows/sec., 3.07 MiB/sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.993729 [ 30742 ] {656ea87c-ed2f-4e1b-b312-c6a96492d966} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.994121 [ 25965 ] {777de6d3-70e9-4e47-a793-fc87f0d35b1c} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002887363 sec., 85545 rows/sec., 3.20 MiB/sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.994159 [ 25965 ] {777de6d3-70e9-4e47-a793-fc87f0d35b1c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991287 [ 16206 ] {c29c9ba1-4ddf-43f9-bcea-f969a5ad7d81} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991416 [ 16206 ] {c29c9ba1-4ddf-43f9-bcea-f969a5ad7d81} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991866 [ 43358 ] {c29c9ba1-4ddf-43f9-bcea-f969a5ad7d81} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.994078 [ 26011 ] {f8822b0e-7d0b-4227-af5f-ec8e129331b2} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003247755 sec., 76052 rows/sec., 2.85 MiB/sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.994114 [ 26011 ] {f8822b0e-7d0b-4227-af5f-ec8e129331b2} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.993653 [ 8893 ] {bf570782-519b-48dd-a5e4-9bdd15e9a8cc} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.0025714 sec., 96056 rows/sec., 3.59 MiB/sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:29:59.993709 [ 8893 ] {bf570782-519b-48dd-a5e4-9bdd15e9a8cc} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991831 [ 23012 ] {63104e9f-ee78-42bc-8d88-01aedfb21b34} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.991932 [ 23012 ] {63104e9f-ee78-42bc-8d88-01aedfb21b34} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.992315 [ 3638 ] {63104e9f-ee78-42bc-8d88-01aedfb21b34} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991321 [ 33383 ] {c960005e-0eab-4527-b809-c61edc025533} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991466 [ 33383 ] {c960005e-0eab-4527-b809-c61edc025533} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.991942 [ 37142 ] {c960005e-0eab-4527-b809-c61edc025533} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991654 [ 5645 ] {60679743-49fb-487b-bf14-5da1e54fbe79} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.991781 [ 5645 ] {60679743-49fb-487b-bf14-5da1e54fbe79} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.992142 [ 25151 ] {60679743-49fb-487b-bf14-5da1e54fbe79} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991259 [ 31609 ] {3ffe1796-f25a-4ee1-a106-b4264077d7c5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991415 [ 31609 ] {3ffe1796-f25a-4ee1-a106-b4264077d7c5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991827 [ 24221 ] {3ffe1796-f25a-4ee1-a106-b4264077d7c5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.994260 [ 20251 ] {b71c545f-3bf4-447e-b2e8-b5fd15355744} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003145436 sec., 78526 rows/sec., 2.94 MiB/sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.994298 [ 20251 ] {b71c545f-3bf4-447e-b2e8-b5fd15355744} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.991464 [ 1091 ] {804a48c3-2dab-487c-8144-f7cce124be95} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.991654 [ 1091 ] {804a48c3-2dab-487c-8144-f7cce124be95} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.992161 [ 4407 ] {804a48c3-2dab-487c-8144-f7cce124be95} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.993878 [ 27369 ] {e1bc28c5-c87b-4863-b049-498ba01ad363} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00265223 sec., 93129 rows/sec., 3.48 MiB/sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.993929 [ 27369 ] {e1bc28c5-c87b-4863-b049-498ba01ad363} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.993918 [ 34557 ] {653ad6e1-d337-404a-8aa2-c2d75460dc5f} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003016195 sec., 81891 rows/sec., 3.06 MiB/sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.993952 [ 34557 ] {653ad6e1-d337-404a-8aa2-c2d75460dc5f} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.993889 [ 738 ] {2390c805-7f27-4e93-9e5f-795661030307} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003050105 sec., 80980 rows/sec., 3.03 MiB/sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.993924 [ 738 ] {2390c805-7f27-4e93-9e5f-795661030307} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.993829 [ 40722 ] {b7a897f0-5816-4755-85c7-87e69ada27ad} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002786304 sec., 88647 rows/sec., 3.32 MiB/sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.993863 [ 40722 ] {b7a897f0-5816-4755-85c7-87e69ada27ad} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.994004 [ 2815 ] {d85c03b9-2e79-42eb-aed4-33adf0a6d42c} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002791298 sec., 88489 rows/sec., 3.31 MiB/sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.994038 [ 2815 ] {d85c03b9-2e79-42eb-aed4-33adf0a6d42c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991214 [ 12247 ] {9cdbd74b-03dd-4559-ba76-e249b66b64c4} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991356 [ 12247 ] {9cdbd74b-03dd-4559-ba76-e249b66b64c4} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991891 [ 647 ] {9cdbd74b-03dd-4559-ba76-e249b66b64c4} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.993945 [ 21565 ] {01fa01b0-8019-4368-9e35-258528d1742b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003236846 sec., 76308 rows/sec., 2.86 MiB/sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.993983 [ 21565 ] {01fa01b0-8019-4368-9e35-258528d1742b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.993879 [ 32855 ] {0535ae6a-a540-42b5-8bd1-3e6cca8f06b8} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003237948 sec., 76282 rows/sec., 2.85 MiB/sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.993927 [ 32855 ] {0535ae6a-a540-42b5-8bd1-3e6cca8f06b8} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.991910 [ 46291 ] {e3523e95-604f-40e3-b177-9f2849398941} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.992102 [ 46291 ] {e3523e95-604f-40e3-b177-9f2849398941} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.992602 [ 8134 ] {e3523e95-604f-40e3-b177-9f2849398941} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.993983 [ 1584 ] {a3767225-a3cb-4c3b-8e0f-6703244b03cd} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002849905 sec., 86669 rows/sec., 3.24 MiB/sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:29:59.994019 [ 1584 ] {a3767225-a3cb-4c3b-8e0f-6703244b03cd} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.991390 [ 20621 ] {fdd53d94-7231-41db-bc71-8dccd6b21973} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.991645 [ 20621 ] {fdd53d94-7231-41db-bc71-8dccd6b21973} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.992119 [ 4223 ] {fdd53d94-7231-41db-bc71-8dccd6b21973} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.994093 [ 45340 ] {4975e4da-ebe3-447e-993a-b9ff75694b14} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002938216 sec., 84064 rows/sec., 3.15 MiB/sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.994131 [ 45340 ] {4975e4da-ebe3-447e-993a-b9ff75694b14} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991522 [ 27301 ] {023fb036-4b21-4a1f-ad9a-e921c0ef8f78} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991689 [ 27301 ] {023fb036-4b21-4a1f-ad9a-e921c0ef8f78} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.991939 [ 41960 ] {023fb036-4b21-4a1f-ad9a-e921c0ef8f78} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.994124 [ 3344 ] {72d3c8ea-e46d-4998-9095-6c6c87253c46} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003271133 sec., 75509 rows/sec., 2.83 MiB/sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.994165 [ 3344 ] {72d3c8ea-e46d-4998-9095-6c6c87253c46} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.994065 [ 24791 ] {96b3a34c-30d4-47b5-9fcd-0c1f75fbc87b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002840139 sec., 86967 rows/sec., 3.25 MiB/sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:29:59.994099 [ 24791 ] {96b3a34c-30d4-47b5-9fcd-0c1f75fbc87b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.994051 [ 21404 ] {5356e4ce-0a35-4568-bad4-9b4ad8388562} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003367853 sec., 73340 rows/sec., 2.74 MiB/sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.994094 [ 21404 ] {5356e4ce-0a35-4568-bad4-9b4ad8388562} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991764 [ 26083 ] {9cb6ebb8-38ca-4637-a37b-4cf51b14bffd} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.991956 [ 26083 ] {9cb6ebb8-38ca-4637-a37b-4cf51b14bffd} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.992474 [ 1069 ] {9cb6ebb8-38ca-4637-a37b-4cf51b14bffd} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.994135 [ 16206 ] {c29c9ba1-4ddf-43f9-bcea-f969a5ad7d81} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003272566 sec., 75475 rows/sec., 2.82 MiB/sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.994183 [ 16206 ] {c29c9ba1-4ddf-43f9-bcea-f969a5ad7d81} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.994219 [ 5645 ] {60679743-49fb-487b-bf14-5da1e54fbe79} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.002980297 sec., 82877 rows/sec., 3.10 MiB/sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:29:59.994269 [ 5645 ] {60679743-49fb-487b-bf14-5da1e54fbe79} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.991630 [ 29626 ] {9ec0e127-67e5-4d49-bb79-f52611841180} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.991805 [ 29626 ] {9ec0e127-67e5-4d49-bb79-f52611841180} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.992488 [ 44428 ] {9ec0e127-67e5-4d49-bb79-f52611841180} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.994252 [ 1091 ] {804a48c3-2dab-487c-8144-f7cce124be95} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003429483 sec., 72022 rows/sec., 2.69 MiB/sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.994296 [ 1091 ] {804a48c3-2dab-487c-8144-f7cce124be95} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.994314 [ 33383 ] {c960005e-0eab-4527-b809-c61edc025533} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003446835 sec., 71659 rows/sec., 2.68 MiB/sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:29:59.994356 [ 33383 ] {c960005e-0eab-4527-b809-c61edc025533} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.994478 [ 23012 ] {63104e9f-ee78-42bc-8d88-01aedfb21b34} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003033291 sec., 81429 rows/sec., 3.05 MiB/sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:29:59.994514 [ 23012 ] {63104e9f-ee78-42bc-8d88-01aedfb21b34} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.994255 [ 31609 ] {3ffe1796-f25a-4ee1-a106-b4264077d7c5} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003588714 sec., 68826 rows/sec., 2.58 MiB/sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.994292 [ 31609 ] {3ffe1796-f25a-4ee1-a106-b4264077d7c5} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991314 [ 19156 ] {2d85d1fa-40c7-481f-8fa5-5ecdbc36156a} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991463 [ 19156 ] {2d85d1fa-40c7-481f-8fa5-5ecdbc36156a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.991855 [ 45059 ] {2d85d1fa-40c7-481f-8fa5-5ecdbc36156a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991594 [ 39494 ] {fc7911d9-ca6a-4d7a-9d4b-dadb556b3c37} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.991849 [ 39494 ] {fc7911d9-ca6a-4d7a-9d4b-dadb556b3c37} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.992623 [ 8670 ] {fc7911d9-ca6a-4d7a-9d4b-dadb556b3c37} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.991857 [ 34316 ] {eb552c66-4c87-4eae-baac-acdfd678131b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.992101 [ 34316 ] {eb552c66-4c87-4eae-baac-acdfd678131b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.992668 [ 1059 ] {eb552c66-4c87-4eae-baac-acdfd678131b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.994366 [ 12247 ] {9cdbd74b-03dd-4559-ba76-e249b66b64c4} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003789563 sec., 65179 rows/sec., 2.44 MiB/sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.994428 [ 12247 ] {9cdbd74b-03dd-4559-ba76-e249b66b64c4} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.994485 [ 46291 ] {e3523e95-604f-40e3-b177-9f2849398941} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003192286 sec., 77374 rows/sec., 2.90 MiB/sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:29:59.994522 [ 46291 ] {e3523e95-604f-40e3-b177-9f2849398941} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.994421 [ 20621 ] {fdd53d94-7231-41db-bc71-8dccd6b21973} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003732777 sec., 66170 rows/sec., 2.48 MiB/sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.994475 [ 20621 ] {fdd53d94-7231-41db-bc71-8dccd6b21973} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.994516 [ 27301 ] {023fb036-4b21-4a1f-ad9a-e921c0ef8f78} <Information> executeQuery: Read 246 rows, 9.44 KiB in 0.003446021 sec., 71386 rows/sec., 2.67 MiB/sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:29:59.994556 [ 27301 ] {023fb036-4b21-4a1f-ad9a-e921c0ef8f78} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.994974 [ 26083 ] {9cb6ebb8-38ca-4637-a37b-4cf51b14bffd} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00374592 sec., 65938 rows/sec., 2.47 MiB/sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:29:59.995017 [ 26083 ] {9cb6ebb8-38ca-4637-a37b-4cf51b14bffd} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.994520 [ 29626 ] {9ec0e127-67e5-4d49-bb79-f52611841180} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003417723 sec., 72270 rows/sec., 2.70 MiB/sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:29:59.994561 [ 29626 ] {9ec0e127-67e5-4d49-bb79-f52611841180} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.994631 [ 19156 ] {2d85d1fa-40c7-481f-8fa5-5ecdbc36156a} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003899415 sec., 63342 rows/sec., 2.37 MiB/sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:29:59.994673 [ 19156 ] {2d85d1fa-40c7-481f-8fa5-5ecdbc36156a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.994695 [ 34316 ] {eb552c66-4c87-4eae-baac-acdfd678131b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.00333162 sec., 74138 rows/sec., 2.77 MiB/sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:29:59.994732 [ 34316 ] {eb552c66-4c87-4eae-baac-acdfd678131b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.002700 [ 117362 ] {591ff8bf-15d5-4af3-bcfd-62fa03df069b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.005731 [ 117362 ] {591ff8bf-15d5-4af3-bcfd-62fa03df069b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.005982 [ 66322 ] {591ff8bf-15d5-4af3-bcfd-62fa03df069b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.994762 [ 39494 ] {fc7911d9-ca6a-4d7a-9d4b-dadb556b3c37} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.003766329 sec., 65581 rows/sec., 2.45 MiB/sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:29:59.994801 [ 39494 ] {fc7911d9-ca6a-4d7a-9d4b-dadb556b3c37} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.991583 [ 21893 ] {2de30a8c-ec67-40f3-a126-0a98d07b920d} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.991971 [ 21893 ] {2de30a8c-ec67-40f3-a126-0a98d07b920d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.993091 [ 8286 ] {2de30a8c-ec67-40f3-a126-0a98d07b920d} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.007144 [ 117362 ] {591ff8bf-15d5-4af3-bcfd-62fa03df069b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.004774402 sec., 51734 rows/sec., 1.94 MiB/sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:30:00.007180 [ 117362 ] {591ff8bf-15d5-4af3-bcfd-62fa03df069b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.991543 [ 36333 ] {570e2b8d-6217-4b50-9b01-83c24899a72e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.992824 [ 36333 ] {570e2b8d-6217-4b50-9b01-83c24899a72e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.993272 [ 18593 ] {570e2b8d-6217-4b50-9b01-83c24899a72e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.995392 [ 21893 ] {2de30a8c-ec67-40f3-a126-0a98d07b920d} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.004256444 sec., 58029 rows/sec., 2.17 MiB/sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:29:59.995434 [ 21893 ] {2de30a8c-ec67-40f3-a126-0a98d07b920d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.995516 [ 36333 ] {570e2b8d-6217-4b50-9b01-83c24899a72e} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.004428404 sec., 55776 rows/sec., 2.09 MiB/sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:29:59.995553 [ 36333 ] {570e2b8d-6217-4b50-9b01-83c24899a72e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991229 [ 45480 ] {8646c5ec-c3c1-4a3c-b247-8f8b55227408} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991333 [ 45480 ] {8646c5ec-c3c1-4a3c-b247-8f8b55227408} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.991715 [ 39227 ] {8646c5ec-c3c1-4a3c-b247-8f8b55227408} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.997822 [ 45480 ] {8646c5ec-c3c1-4a3c-b247-8f8b55227408} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.006984688 sec., 35363 rows/sec., 1.32 MiB/sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:29:59.997857 [ 45480 ] {8646c5ec-c3c1-4a3c-b247-8f8b55227408} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.991537 [ 45445 ] {a3ccd1ca-5116-4191-95e1-c3a63b7e00c7} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.997258 [ 45445 ] {a3ccd1ca-5116-4191-95e1-c3a63b7e00c7} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.997657 [ 32788 ] {a3ccd1ca-5116-4191-95e1-c3a63b7e00c7} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.999522 [ 45445 ] {a3ccd1ca-5116-4191-95e1-c3a63b7e00c7} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.008466754 sec., 29172 rows/sec., 1.09 MiB/sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:29:59.999555 [ 45445 ] {a3ccd1ca-5116-4191-95e1-c3a63b7e00c7} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.991908 [ 34872 ] {77bccb56-787e-42ff-85e2-42665b8d077b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.992038 [ 34872 ] {77bccb56-787e-42ff-85e2-42665b8d077b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:29:59.992422 [ 4478 ] {77bccb56-787e-42ff-85e2-42665b8d077b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:30:00.002180 [ 34872 ] {77bccb56-787e-42ff-85e2-42665b8d077b} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.010726177 sec., 23027 rows/sec., 882.32 KiB/sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:30:00.002241 [ 34872 ] {77bccb56-787e-42ff-85e2-42665b8d077b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.990842 [ 18651 ] {93729876-ed1e-4805-9ab1-5b6c5fd983ef} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.990965 [ 18651 ] {93729876-ed1e-4805-9ab1-5b6c5fd983ef} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:29:59.991419 [ 24023 ] {93729876-ed1e-4805-9ab1-5b6c5fd983ef} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:29:59.991325 [ 35843 ] {94bb33a1-100f-4c58-b9d5-249adf731391} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:30:00.004816 [ 35843 ] {94bb33a1-100f-4c58-b9d5-249adf731391} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:30:00.005128 [ 9234 ] {94bb33a1-100f-4c58-b9d5-249adf731391} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:30:00.007058 [ 35843 ] {94bb33a1-100f-4c58-b9d5-249adf731391} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.016175395 sec., 15270 rows/sec., 585.08 KiB/sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:30:00.007091 [ 35843 ] {94bb33a1-100f-4c58-b9d5-249adf731391} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:30:00.007028 [ 18651 ] {93729876-ed1e-4805-9ab1-5b6c5fd983ef} <Information> executeQuery: Read 247 rows, 9.46 KiB in 0.016654382 sec., 14830 rows/sec., 568.25 KiB/sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:30:00.007070 [ 18651 ] {93729876-ed1e-4805-9ab1-5b6c5fd983ef} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.017235 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Debug> CreatingSetsBlockInputStream: Created Join with 248 entries from 28901 rows in 0.023421575 sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.022332 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.022353 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.022434 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.029265498 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.022488 [ 29717 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Trace> Aggregator: Merging aggregated data
┌─count()─┐
│       0 │
└─────────┘
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.028856 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Information> executeQuery: Read 113662 rows, 32.73 MiB in 1.460441012 sec., 77827 rows/sec., 22.41 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:30:00.028914 [ 83541 ] {b12b33b8-4f6a-4a77-a41b-38d057cd3d10} <Debug> MemoryTracker: Peak memory usage (for query): 39.28 MiB.

1 rows in set. Elapsed: 1.477 sec. Processed 84.76 thousand rows, 33.18 MB (57.40 thousand rows/s., 22.47 MB/s.)
```











Dis join local

```
SELECT count(*)
FROM system.parts_dis AS parts_all
INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name

[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.173361 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Debug> executeQuery: (from [::ffff:172.18.160.19]:54952)  select count(*) from system.parts_dis as parts_all join system.tables as tables_all on parts_all.name = tables_all.name;
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.174169 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.174202 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.174871 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.174943 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.175607 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.175677 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:01.175844 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.600998 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.602541 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.603651 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.603774 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.603964 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.604397 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Debug> executeQuery: (from [::ffff:10.198.17.36]:55434, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:02.606786 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:11374, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:02.593943 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:02.590071 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:65250, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:02.607002 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:02.590477 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Debug> executeQuery: (from [::ffff:10.198.17.36]:25420, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:02.601452 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Debug> executeQuery: (from [::ffff:10.198.17.36]:57930, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:02.593098 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Debug> executeQuery: (from [::ffff:10.198.17.36]:34154, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:02.604755 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Debug> executeQuery: (from [::ffff:10.198.17.36]:50278, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:02.587771 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Debug> executeQuery: (from [::ffff:10.198.17.36]:14930, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:02.605583 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Debug> executeQuery: (from [::ffff:10.198.17.36]:16288, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:02.594466 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:64270, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:02.594371 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Debug> executeQuery: (from [::ffff:10.198.17.36]:55672, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:02.587428 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Debug> executeQuery: (from [::ffff:10.198.17.36]:40086, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:02.589959 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Debug> executeQuery: (from [::ffff:10.198.17.36]:14406, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:02.594323 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Debug> executeQuery: (from [::ffff:10.198.17.36]:62534, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.604977 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.00130434 sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:02.594458 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Debug> executeQuery: (from [::ffff:10.198.17.36]:36394, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:02.594319 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Debug> executeQuery: (from [::ffff:10.198.17.36]:57724, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:02.594805 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:39312, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:02.594303 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:26436, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:02.594357 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Debug> executeQuery: (from [::ffff:10.198.17.36]:63956, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:02.594749 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Debug> executeQuery: (from [::ffff:10.198.17.36]:52119, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:02.594442 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:02.594925 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Debug> executeQuery: (from [::ffff:10.198.17.36]:59314, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:02.594543 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Debug> executeQuery: (from [::ffff:10.198.17.36]:44960, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:02.594495 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Debug> executeQuery: (from [::ffff:10.198.17.36]:23664, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:02.594792 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Debug> executeQuery: (from [::ffff:10.198.17.36]:34662, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:02.594541 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Debug> executeQuery: (from [::ffff:10.198.17.36]:61160, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:02.594481 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Debug> executeQuery: (from [::ffff:10.198.17.36]:65518, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:02.594520 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:02.594535 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Debug> executeQuery: (from [::ffff:10.198.17.36]:21111, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:02.594976 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Debug> executeQuery: (from [::ffff:10.198.17.36]:39306, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:02.594457 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Debug> executeQuery: (from [::ffff:10.198.17.36]:26048, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:02.595076 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Debug> executeQuery: (from [::ffff:10.198.17.36]:11156, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:02.594901 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Debug> executeQuery: (from [::ffff:10.198.17.36]:46712, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:02.594611 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Debug> executeQuery: (from [::ffff:10.198.17.36]:17008, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:02.594828 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Debug> executeQuery: (from [::ffff:10.198.17.36]:16828, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:02.594779 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Debug> executeQuery: (from [::ffff:10.198.17.36]:32772, initial_query_id: d848f020-2cbe-4759-a8ac-781437f1e2e4) SELECT count() FROM system.parts AS parts_all ALL INNER JOIN system.tables AS tables_all ON parts_all.name = tables_all.name
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.610391 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.610468 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.610549 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008805682 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.610612 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.610737 [ 29684 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> MergingAggregatedTransform: Reading blocks of partially aggregated data.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:02.591118 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:02.591176 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:02.591339 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.649255 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.650522 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.650730 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.672613 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.673509 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.022982541 sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.679306 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.679346 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.679400 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.029281407 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.679440 [ 125832 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.679983 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Information> executeQuery: Read 57101 rows, 31.00 MiB in 1.089840818 sec., 52393 rows/sec., 28.44 MiB/sec.
[BJHTYD-Hope-17-5.hadoop.jd.local] 2021.03.02 16:32:03.680034 [ 104350 ] {f58a3880-1b55-4be6-84f9-7948c3696ac5} <Debug> MemoryTracker: Peak memory usage (for query): 39.21 MiB.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:02.606419 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:02.606462 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:02.606601 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.664881 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.666117 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.666338 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.700460 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.701278 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.035160291 sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.705962 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.705987 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.706018 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.040353498 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.706034 [ 41463 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.706536 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Information> executeQuery: Read 56860 rows, 30.87 MiB in 1.100893155 sec., 51648 rows/sec., 28.04 MiB/sec.
[BJHTYD-Hope-17-37.hadoop.jd.local] 2021.03.02 16:32:03.706616 [ 34766 ] {4e9deb15-ab2d-489a-8413-37cfc6d30a44} <Debug> MemoryTracker: Peak memory usage (for query): 37.28 MiB.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.605296 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.605343 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:02.605477 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.720742 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.721998 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.722241 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.722437 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.723334 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.00133815 sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.729347 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.729385 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.729430 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.00786143 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.729443 [ 81818 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.729989 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Information> executeQuery: Read 56924 rows, 30.88 MiB in 1.125522953 sec., 50575 rows/sec., 27.44 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:03.730034 [ 50429 ] {d3307762-ee11-446d-943e-aa004c7d7ae2} <Debug> MemoryTracker: Peak memory usage (for query): 39.24 MiB.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:02.602334 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:02.602378 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:02.602494 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.731782 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.732813 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.732942 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.756639 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.757437 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Debug> CreatingSetsBlockInputStream: Created Join with 248 entries from 248 rows in 0.024618242 sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.762537 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.762563 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.762596 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.030074384 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.762652 [ 99201 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.763146 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Information> executeQuery: Read 56783 rows, 30.80 MiB in 1.161626192 sec., 48882 rows/sec., 26.52 MiB/sec.
[BJHTYD-Hope-17-10.hadoop.jd.local] 2021.03.02 16:32:03.763185 [ 87360 ] {3eeeb89d-5b35-41aa-bcdc-f4be7327a23f} <Debug> MemoryTracker: Peak memory usage (for query): 38.13 MiB.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:02.607842 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:02.607905 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:02.608050 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.740150 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.741304 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.741450 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.775967 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.776790 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.035481139 sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.782530 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.782588 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.782650 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.04169241 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.782681 [ 15717 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.783210 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Information> executeQuery: Read 56766 rows, 30.80 MiB in 1.176139663 sec., 48264 rows/sec., 26.19 MiB/sec.
[BJHTYD-Hope-17-7.hadoop.jd.local] 2021.03.02 16:32:03.783254 [ 5078 ] {5d31a0ec-c277-4921-878d-036536a3887b} <Debug> MemoryTracker: Peak memory usage (for query): 36.85 MiB.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:02.588388 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:02.588431 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:02.588562 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.747998 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.749087 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.749210 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.775403 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.776367 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.027274771 sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.781611 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.781651 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.781712 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.032982181 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.781743 [ 70786 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.782267 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Information> executeQuery: Read 57042 rows, 30.93 MiB in 1.194785702 sec., 47742 rows/sec., 25.89 MiB/sec.
[BJHTYD-Hope-17-4.hadoop.jd.local] 2021.03.02 16:32:03.782302 [ 88887 ] {84cba8aa-ac3d-4b7c-bfd2-1b41a9d4b495} <Debug> MemoryTracker: Peak memory usage (for query): 39.21 MiB.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:02.595568 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:02.595619 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:02.595758 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.946916 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.948117 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.948315 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.959008 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.959780 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.011664256 sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.964709 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.964730 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.964763 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.017043576 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.964812 [ 23005 ] {3d024189-15aa-4bc4-a203-90694598a315} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.965366 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Information> executeQuery: Read 57004 rows, 30.95 MiB in 1.370812312 sec., 41584 rows/sec., 22.58 MiB/sec.
[A01-R21-I42-71-30002JT.JD.LOCAL] 2021.03.02 16:32:03.965399 [ 41242 ] {3d024189-15aa-4bc4-a203-90694598a315} <Debug> MemoryTracker: Peak memory usage (for query): 37.45 MiB.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:02.595373 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:02.595432 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:02.595581 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.944217 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.945389 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.945572 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.960400 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.961200 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.015804288 sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.967005 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.967042 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.967087 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.022061142 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.967116 [ 38392 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.967643 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Information> executeQuery: Read 56598 rows, 30.70 MiB in 1.373188952 sec., 41216 rows/sec., 22.36 MiB/sec.
[A01-R21-I42-66-30002HJ.JD.LOCAL] 2021.03.02 16:32:03.967681 [ 18535 ] {531438c2-c315-467f-80b4-c1b126f1bce7} <Debug> MemoryTracker: Peak memory usage (for query): 37.42 MiB.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:02.593995 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:02.594042 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:02.594209 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.063542 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.064947 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.065147 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.090585 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.091513 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.026564561 sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.097525 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.097596 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.097683 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.033220657 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.097736 [ 11086 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.098325 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Information> executeQuery: Read 56431 rows, 30.62 MiB in 1.505157824 sec., 37491 rows/sec., 20.34 MiB/sec.
[BJHTYD-Hope-17-39.hadoop.jd.local] 2021.03.02 16:32:04.098363 [ 51732 ] {af783f9c-595c-4fc5-9b62-dd9411db3da8} <Debug> MemoryTracker: Peak memory usage (for query): 36.20 MiB.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:02.607684 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:02.607726 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:02.607869 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.103264 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.104306 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.104504 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.112947 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.113884 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.009575008 sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.119318 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.119365 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.119408 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.015496316 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.119424 [ 33802 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.119965 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Information> executeQuery: Read 56789 rows, 30.80 MiB in 1.513123732 sec., 37530 rows/sec., 20.36 MiB/sec.
[BJHTYD-Hope-17-40.hadoop.jd.local] 2021.03.02 16:32:04.120004 [ 83774 ] {c20865ca-8124-4976-bcb0-5fbf792f280e} <Debug> MemoryTracker: Peak memory usage (for query): 36.32 MiB.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:02.595521 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:02.595571 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:02.595746 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.086751 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.088056 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.088292 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.110878 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.111657 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.023600336 sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.116620 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.116675 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.116728 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.029113025 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.116761 [ 45895 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.117341 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Information> executeQuery: Read 57346 rows, 31.14 MiB in 1.522747233 sec., 37659 rows/sec., 20.45 MiB/sec.
[A01-R21-I41-9-30001HJ.JD.LOCAL] 2021.03.02 16:32:04.117395 [ 13023 ] {08f6560d-03b1-4615-aeca-6a5547651de5} <Debug> MemoryTracker: Peak memory usage (for query): 35.89 MiB.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:02.591436 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:02.591483 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:02.591608 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.103784 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.105925 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.106045 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.133080 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.133936 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.028005938 sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.139614 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.139644 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.139694 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.034128821 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.139723 [ 83612 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.140230 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Information> executeQuery: Read 56818 rows, 30.84 MiB in 1.549688622 sec., 36664 rows/sec., 19.90 MiB/sec.
[BJHTYD-Hope-17-6.hadoop.jd.local] 2021.03.02 16:32:04.140268 [ 19701 ] {48007a1c-7c2a-4159-b6e9-0f28d90ae05a} <Debug> MemoryTracker: Peak memory usage (for query): 37.31 MiB.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:02.590961 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:02.591018 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:02.591140 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.105315 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.106591 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.106716 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.139977 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.140916 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.034320221 sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.146613 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.146635 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.146671 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.040455037 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.146686 [ 119753 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.147154 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Information> executeQuery: Read 57077 rows, 30.98 MiB in 1.557133063 sec., 36655 rows/sec., 19.89 MiB/sec.
[BJHTYD-Hope-17-38.hadoop.jd.local] 2021.03.02 16:32:04.147197 [ 82303 ] {0b8f93d9-95ec-49f0-bf1e-6d81767e1a07} <Debug> MemoryTracker: Peak memory usage (for query): 36.22 MiB.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:02.596055 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:02.596117 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:02.596292 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.129476 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.131202 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.131350 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.149479 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.150232 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.019022769 sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.155786 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.155877 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.155931 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.025064024 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.155952 [ 5968 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.156484 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Information> executeQuery: Read 57865 rows, 31.41 MiB in 1.561398398 sec., 37059 rows/sec., 20.12 MiB/sec.
[A01-R21-I42-9-30002J9.JD.LOCAL] 2021.03.02 16:32:04.156527 [ 40804 ] {05dc13b5-ff90-4f83-942f-30ea5fcdad48} <Debug> MemoryTracker: Peak memory usage (for query): 37.30 MiB.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:02.588731 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:02.588792 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:02.588953 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.120493 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.122300 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.122440 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.145211 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.146035 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.023729926 sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.150795 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.150824 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.150874 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.028968303 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.150899 [ 46837 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.151326 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Information> executeQuery: Read 56586 rows, 30.72 MiB in 1.563471786 sec., 36192 rows/sec., 19.65 MiB/sec.
[BJHTYD-Hope-17-42.hadoop.jd.local] 2021.03.02 16:32:04.151364 [ 117109 ] {02ff087b-9d2d-4a4e-b1ba-60f463886e7b} <Debug> MemoryTracker: Peak memory usage (for query): 39.74 MiB.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:02.595243 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:02.595289 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:02.595428 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.146202 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.147392 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.147639 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.156717 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.157747 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.010336189 sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.162958 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.162991 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.163040 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.01611581 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.163054 [ 18673 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.163681 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Information> executeQuery: Read 57266 rows, 31.08 MiB in 1.569295866 sec., 36491 rows/sec., 19.80 MiB/sec.
[A01-R21-I41-98-3000222.JD.LOCAL] 2021.03.02 16:32:04.163735 [ 6379 ] {2d7fc2f6-df29-4ee4-bc96-6d8505bf7a7c} <Debug> MemoryTracker: Peak memory usage (for query): 39.21 MiB.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:02.594829 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:02.594868 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:02.594988 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.159990 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.161283 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.161456 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.161675 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.163084 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001787459 sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.170870 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.170965 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.171080 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.010179608 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.171183 [ 114073 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:02.595868 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:02.596938 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:02.597271 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.146432 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.147593 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.147789 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.165587 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.166493 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.018893688 sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.171393 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.171436 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.171471 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.024271959 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.171497 [ 25886 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.171763 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Information> executeQuery: Read 56761 rows, 30.80 MiB in 1.57776108 sec., 35975 rows/sec., 19.52 MiB/sec.
[BJHTYD-Hope-17-9.hadoop.jd.local] 2021.03.02 16:32:04.171811 [ 51792 ] {dc5349c4-2b48-4281-8e63-2c2c76b58298} <Debug> MemoryTracker: Peak memory usage (for query): 37.83 MiB.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.172054 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Information> executeQuery: Read 56498 rows, 30.67 MiB in 1.577297527 sec., 35819 rows/sec., 19.44 MiB/sec.
[A01-R21-I42-42-30002HF.JD.LOCAL] 2021.03.02 16:32:04.172088 [ 19379 ] {248a0c5e-1cb6-47e2-ad23-df298bffba50} <Debug> MemoryTracker: Peak memory usage (for query): 36.21 MiB.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:02.605667 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:02.605707 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:02.605833 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.174829 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.176104 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> CreatingSetsBlockInputStream: Creating join.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.176267 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.176427 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.177551 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.001437955 sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.184118 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> AggregatingTransform: Aggregating
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.184171 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> Aggregator: Aggregation method: without_key
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.184255 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.008516734 sec. (0.0 rows/sec., 0.00 B/sec.)
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.184298 [ 45246 ] {40aff614-6bed-4c1f-beac-56108a463953} <Trace> Aggregator: Merging aggregated data
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.184889 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Information> executeQuery: Read 57390 rows, 31.14 MiB in 1.580055325 sec., 36321 rows/sec., 19.71 MiB/sec.
[BJHTYD-Hope-17-2.hadoop.jd.local] 2021.03.02 16:32:04.184941 [ 63376 ] {40aff614-6bed-4c1f-beac-56108a463953} <Debug> MemoryTracker: Peak memory usage (for query): 36.41 MiB.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:02.595875 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:02.595924 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:02.596086 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.155275 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.156759 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.156953 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.187520 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.188503 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.031731972 sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.194005 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.194070 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.194140 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.037767097 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.194167 [ 38963 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.194714 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Information> executeQuery: Read 58117 rows, 31.55 MiB in 1.599727647 sec., 36329 rows/sec., 19.72 MiB/sec.
[A01-R21-I42-3-30002L5.JD.LOCAL] 2021.03.02 16:32:04.194753 [ 28218 ] {171b7d1f-d384-46dd-978e-1eeac28ab478} <Debug> MemoryTracker: Peak memory usage (for query): 37.62 MiB.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:02.595824 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:02.595881 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:02.596084 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.180474 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.181627 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.181925 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.206000 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.206828 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.025199543 sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.212797 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.212868 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.212933 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.031792917 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.212970 [ 47890 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.213692 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Information> executeQuery: Read 57481 rows, 31.21 MiB in 1.61904381 sec., 35503 rows/sec., 19.28 MiB/sec.
[A01-R21-I41-99-30001KY.JD.LOCAL] 2021.03.02 16:32:04.213742 [ 4713 ] {443ac04b-c492-4082-a239-d8c6fd9caa9a} <Debug> MemoryTracker: Peak memory usage (for query): 38.06 MiB.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:02.595906 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:02.595962 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:02.596124 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.194549 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.195931 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.196392 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.210561 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.211590 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.015653861 sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.217028 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.217089 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.217188 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.021738805 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.217237 [ 28334 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.217862 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Information> executeQuery: Read 57064 rows, 30.98 MiB in 1.623301626 sec., 35153 rows/sec., 19.08 MiB/sec.
[A01-R21-I42-35-30002HM.JD.LOCAL] 2021.03.02 16:32:04.217894 [ 25180 ] {19199099-fc3f-40dd-9147-58f7c095024c} <Debug> MemoryTracker: Peak memory usage (for query): 37.75 MiB.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:02.595570 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:02.595624 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:02.595812 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.220823 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.222193 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.222423 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.240972 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.241880 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.01970263 sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.247171 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.247214 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.247271 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.025525256 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.247300 [ 7416 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.247861 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Information> executeQuery: Read 56967 rows, 30.92 MiB in 1.653268562 sec., 34457 rows/sec., 18.71 MiB/sec.
[A01-R21-I41-232-300021H.JD.LOCAL] 2021.03.02 16:32:04.247909 [ 46741 ] {01feb6b8-382e-4642-a492-bbef4fee6b3e} <Debug> MemoryTracker: Peak memory usage (for query): 35.97 MiB.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:02.595879 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:02.595948 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:02.596167 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.234474 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.236194 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.236380 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.246366 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.247273 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.011072217 sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.252615 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.252717 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.252816 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.017035796 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.252868 [ 44303 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.253493 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Information> executeQuery: Read 56831 rows, 30.83 MiB in 1.65885557 sec., 34259 rows/sec., 18.58 MiB/sec.
[A01-R21-I42-72-30002JS.JD.LOCAL] 2021.03.02 16:32:04.253545 [ 40936 ] {bc4bc921-7f46-40a4-a69e-1067bcdba07e} <Debug> MemoryTracker: Peak memory usage (for query): 39.24 MiB.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:02.595603 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:02.595653 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:02.595830 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.276225 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.278631 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.278827 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.291655 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.292635 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.013994326 sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.297741 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.297808 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.297909 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.019637918 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.297973 [ 31527 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.298465 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Information> executeQuery: Read 57020 rows, 30.96 MiB in 1.703841396 sec., 33465 rows/sec., 18.17 MiB/sec.
[A01-R21-I42-43-30002LT.JD.LOCAL] 2021.03.02 16:32:04.298502 [ 48597 ] {cb373191-d8a1-4ddb-9482-b3c74ce17b65} <Debug> MemoryTracker: Peak memory usage (for query): 38.51 MiB.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:02.595627 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:02.595678 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:02.595841 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.296529 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.297776 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.298085 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.331450 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.332700 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.034920041 sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.337748 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.337801 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.337877 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.040558399 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.337923 [ 25018 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.338623 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Information> executeQuery: Read 56963 rows, 30.92 MiB in 1.744003669 sec., 32662 rows/sec., 17.73 MiB/sec.
[A01-R21-I42-2-30002HH.JD.LOCAL] 2021.03.02 16:32:04.338670 [ 31880 ] {4ce7e515-88c7-44e2-a6c7-8eded7c5d797} <Debug> MemoryTracker: Peak memory usage (for query): 37.98 MiB.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:02.595414 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:02.595463 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:02.595667 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.342698 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.344023 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.344254 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.364063 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.365076 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.021046442 sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.370667 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> AggregatingTransform: Aggregating
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.370694 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.370734 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.02711769 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.370763 [ 9062 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Trace> Aggregator: Merging aggregated data
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.371328 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Information> executeQuery: Read 57376 rows, 31.13 MiB in 1.776888552 sec., 32290 rows/sec., 17.52 MiB/sec.
[A01-R21-I17-8-J33TW76.JD.LOCAL] 2021.03.02 16:32:04.371370 [ 37040 ] {c36d7f51-07a2-4ef9-b3bb-b17fb0b6af82} <Debug> MemoryTracker: Peak memory usage (for query): 37.05 MiB.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:02.596005 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:02.596054 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:02.596244 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.333981 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.335942 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.336184 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.365027 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.366243 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.030295738 sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.371094 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.371126 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.371258 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.035803693 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.371351 [ 3532 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.372021 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Information> executeQuery: Read 56595 rows, 30.71 MiB in 1.777151195 sec., 31845 rows/sec., 17.28 MiB/sec.
[A01-R21-I41-8-30002M7.JD.LOCAL] 2021.03.02 16:32:04.372073 [ 24804 ] {b5d9fa70-0261-41ba-b5af-4b8e513b22ce} <Debug> MemoryTracker: Peak memory usage (for query): 36.42 MiB.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:02.596037 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:02.596091 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:02.596244 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.339172 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.340693 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.340922 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.369151 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.370024 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.029324995 sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.375029 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.375051 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.375080 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.034779323 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.375096 [ 43480 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.375617 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Information> executeQuery: Read 57197 rows, 31.05 MiB in 1.780583642 sec., 32122 rows/sec., 17.44 MiB/sec.
[A01-R21-I42-5-30002L2.JD.LOCAL] 2021.03.02 16:32:04.375665 [ 34299 ] {adc87e8b-d0d3-4cc6-8859-2a926b399d66} <Debug> MemoryTracker: Peak memory usage (for query): 37.17 MiB.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:02.596100 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:02.596165 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:02.596348 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.375657 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.377124 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.377380 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.393295 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.394383 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.017257953 sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.400393 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.400425 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.400483 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.023857943 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.400509 [ 19867 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.401183 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Information> executeQuery: Read 57098 rows, 31.01 MiB in 1.806268277 sec., 31611 rows/sec., 17.17 MiB/sec.
[A01-R21-I42-34-30002GQ.JD.LOCAL] 2021.03.02 16:32:04.401219 [ 43405 ] {e8df0521-5437-48c7-8ec8-70d78690dd1c} <Debug> MemoryTracker: Peak memory usage (for query): 37.26 MiB.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:02.596415 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:02.596465 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:02.596706 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.399546 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.400879 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.401203 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.427183 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.428250 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.027363326 sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.433551 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.433725 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.433835 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.033461051 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.433910 [ 27393 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.434617 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Information> executeQuery: Read 56521 rows, 30.67 MiB in 1.839421332 sec., 30727 rows/sec., 16.67 MiB/sec.
[A01-R21-I41-135-300022P.JD.LOCAL] 2021.03.02 16:32:04.434665 [ 44925 ] {65eb2ee1-ed47-485d-aa67-6a4de3be0e19} <Debug> MemoryTracker: Peak memory usage (for query): 39.74 MiB.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:02.596371 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:02.596433 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:02.601127 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.413883 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.415133 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.415432 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.432568 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.434680 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.019541648 sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.440150 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.440240 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.440340 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.025648551 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.440412 [ 37519 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.440942 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Information> executeQuery: Read 57238 rows, 31.08 MiB in 1.845997953 sec., 31006 rows/sec., 16.84 MiB/sec.
[A01-R21-I42-36-30001HF.JD.LOCAL] 2021.03.02 16:32:04.440976 [ 5727 ] {66fed1a7-ccf6-4fd6-8375-2182a218eeb0} <Debug> MemoryTracker: Peak memory usage (for query): 36.31 MiB.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:02.595608 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:02.595812 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:02.596853 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.424595 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.425879 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.426124 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.444467 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.445350 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.019469642 sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.450780 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.450842 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.450949 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.025537183 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.451000 [ 10168 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.451558 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Information> executeQuery: Read 56960 rows, 30.91 MiB in 1.85712127 sec., 30671 rows/sec., 16.64 MiB/sec.
[A01-R21-I42-11-30002K0.JD.LOCAL] 2021.03.02 16:32:04.451593 [ 28110 ] {e39eddc8-eee5-412c-8b70-76e6089016c3} <Debug> MemoryTracker: Peak memory usage (for query): 35.47 MiB.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:02.596233 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:02.596279 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:02.596474 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.462290 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.463633 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.463909 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.474278 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.475175 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.011539182 sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.480829 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.480854 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.480886 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.017672239 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.480904 [ 38707 ] {bf534c50-8286-428a-8453-31315a717551} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.481525 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Information> executeQuery: Read 56716 rows, 30.79 MiB in 1.886617401 sec., 30062 rows/sec., 16.32 MiB/sec.
[A01-R21-I42-10-3000297.JD.LOCAL] 2021.03.02 16:32:04.481580 [ 25867 ] {bf534c50-8286-428a-8453-31315a717551} <Debug> MemoryTracker: Peak memory usage (for query): 39.74 MiB.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:02.595697 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:02.595748 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:02.595929 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.513491 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.514893 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.515164 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.532938 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.533924 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.019025453 sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.539541 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.539619 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.539701 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.025260124 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.539758 [ 10384 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.540334 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Information> executeQuery: Read 57558 rows, 31.24 MiB in 1.945742085 sec., 29581 rows/sec., 16.05 MiB/sec.
[A01-R21-I41-74-3000268.JD.LOCAL] 2021.03.02 16:32:04.540370 [ 6314 ] {02ceb12a-bd4d-4597-a6d6-53cf7abd4d24} <Debug> MemoryTracker: Peak memory usage (for query): 37.06 MiB.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:02.595976 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:02.596059 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:02.596267 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.499344 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.500802 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.501017 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.534690 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.535620 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.034814514 sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.541596 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.541687 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.541807 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.041503064 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.541888 [ 24297 ] {3208898f-c284-4195-9013-424ea0d371eb} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.542565 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Information> executeQuery: Read 57414 rows, 31.18 MiB in 1.948084469 sec., 29472 rows/sec., 16.01 MiB/sec.
[A01-R21-I41-73-30001WY.JD.LOCAL] 2021.03.02 16:32:04.542617 [ 16007 ] {3208898f-c284-4195-9013-424ea0d371eb} <Debug> MemoryTracker: Peak memory usage (for query): 36.58 MiB.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:02.595913 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:02.595963 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:02.596143 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.574887 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.576415 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.576709 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.596659 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.597596 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.021176061 sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.602657 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> AggregatingTransform: Aggregating
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.602693 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.602776 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.026789116 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.602841 [ 8311 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Trace> Aggregator: Merging aggregated data
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.603538 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Information> executeQuery: Read 57012 rows, 30.93 MiB in 2.008900027 sec., 28379 rows/sec., 15.40 MiB/sec.
[A01-R21-I41-75-30001K8.JD.LOCAL] 2021.03.02 16:32:04.603594 [ 7360 ] {ee8d41f1-9f06-42ca-a1d7-44cc9b0ba5da} <Debug> MemoryTracker: Peak memory usage (for query): 35.75 MiB.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:02.596762 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> ContextAccess (default): Access granted: SELECT(name) ON system.tables
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:02.596833 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Debug> HashJoin: Right sample block: tables_all.name String String(size = 0)
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:02.597128 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.582464 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.584009 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> CreatingSetsBlockInputStream: Creating join.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.584211 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.598634 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> ContextAccess (default): Access granted: SHOW TABLES ON *.*
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.599478 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Debug> CreatingSetsBlockInputStream: Created Join with 247 entries from 247 rows in 0.015453348 sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.604142 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> AggregatingTransform: Aggregating
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.604180 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> Aggregator: Aggregation method: without_key
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.604218 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> AggregatingTransform: Aggregated. 0 to 1 rows (from 0.00 B) in 0.020912203 sec. (0.0 rows/sec., 0.00 B/sec.)
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.604236 [ 31892 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Trace> Aggregator: Merging aggregated data
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.604713 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Information> executeQuery: Read 57684 rows, 31.32 MiB in 2.009729854 sec., 28702 rows/sec., 15.58 MiB/sec.
[A01-R21-I42-7-30002H1.JD.LOCAL] 2021.03.02 16:32:04.604745 [ 6844 ] {3dd8aee3-549a-4a69-8106-8527399ea240} <Debug> MemoryTracker: Peak memory usage (for query): 35.58 MiB.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.615293 [ 29677 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> MergingAggregatedTransform: Read 39 blocks of partially aggregated data, total 39 rows.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.615347 [ 29677 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> Aggregator: Merging partially aggregated single-level data.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.615572 [ 29677 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> Aggregator: Merged partially aggregated single-level data.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.615598 [ 29677 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> Aggregator: Converting aggregated data to blocks
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.615621 [ 29677 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Trace> Aggregator: Converted aggregated data to blocks. 1 rows, 8.00 B in 8.691e-06 sec. (115061.55793349442 rows/sec., 898.92 KiB/sec.)
┌─count()─┐
│       0 │
└─────────┘
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.616326 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Information> executeQuery: Read 2214677 rows, 1.18 GiB in 3.442889795 sec., 643261 rows/sec., 350.51 MiB/sec.
[BJHTYD-Hope-17-36.hadoop.jd.local] 2021.03.02 16:32:04.616366 [ 83541 ] {d848f020-2cbe-4759-a8ac-781437f1e2e4} <Debug> MemoryTracker: Peak memory usage (for query): 39.52 MiB.

1 rows in set. Elapsed: 3.449 sec. Processed 2.21 million rows, 1.27 GB (642.11 thousand rows/s., 366.92 MB/s.)
```

