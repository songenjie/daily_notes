

## Virtual Columns[ ](https://clickhouse.tech/docs/en/engines/table-engines/#table_engines-virtual_columns)

Virtual column is an integral table engine attribute that is defined in the engine source code.

You shouldn’t specify virtual columns in the `CREATE TABLE` query and you can’t see them in `SHOW CREATE TABLE` and `DESCRIBE TABLE` query results. Virtual columns are also read-only, so you can’t insert data into virtual columns.

To select data from a virtual column, you must specify its name in the `SELECT` query. `SELECT *` doesn’t return values from virtual columns.

If you create a table with a column that has the same name as one of the table virtual columns, the virtual column becomes inaccessible. We don’t recommend doing this. To help avoid conflicts, virtual column names are usually prefixed with an underscore.

sr/Storages/StorageDistributed.cpp

```c++

NamesAndTypesList StorageDistributed::getVirtuals() const
{
    /// NOTE This is weird. Most of these virtual columns are part of MergeTree
    /// tables info. But Distributed is general-purpose engine.
    return NamesAndTypesList{
            NameAndTypePair("_table", std::make_shared<DataTypeString>()),
            NameAndTypePair("_part", std::make_shared<DataTypeString>()),
            NameAndTypePair("_part_index", std::make_shared<DataTypeUInt64>()),
            NameAndTypePair("_partition_id", std::make_shared<DataTypeString>()),
            NameAndTypePair("_sample_factor", std::make_shared<DataTypeFloat64>()),
            NameAndTypePair("_shard_num", std::make_shared<DataTypeUInt32>()),
    };
}
```





```mysql
helloword :) select _part,_shard_num  from ****  where _shard_num=1 limit 1\G

SELECT
    _part,
    _shard_num
FROM ****
WHERE _shard_num = 1
LIMIT 1

word] 2020.11.12 16:40:55.164512 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Debug> executeQuery: (from [::ffff:172.18.160.19]:43652) select _part,_shard_num from app_d14_traffic_plat_item_di_new_aggr_all where _shard_num=1 limit 1
word] 2020.11.12 16:40:55.165140 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Trace> ContextAccess (default): Access granted: SELECT(_shard_num, _part) ON default.app_d14_traffic_plat_item_di_new_aggr_all
word] 2020.11.12 16:40:55.165593 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Trace> ContextAccess (default): Access granted: SELECT(_shard_num, _part) ON default.app_d14_traffic_plat_item_di_new_aggr_all
word] 2020.11.12 16:40:55.167594 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.167977 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.167996 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.168025 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.168104 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.168637 [ 26553 ] {4e07e8a7-149e-4827-9258-ee4290df2d68} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
word] 2020.11.12 16:40:55.169853 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Debug> executeQuery: (from [::ffff:10.203.26.167]:62470, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(9) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170345 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Debug> executeQuery: (from [::ffff:10.203.26.167]:32396, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(5) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170047 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Debug> executeQuery: (from [::ffff:10.203.26.167]:4990, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(8) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
5 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Debug> executeQuery: (from [::ffff:10.203.26.167]:16520, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(10) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170078 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Debug> executeQuery: (from [::ffff:10.203.26.167]:41310, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(3) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
3 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Debug> executeQuery: (from [::ffff:10.203.26.167]:27250, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(11) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170137 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Debug> executeQuery: (from [::ffff:10.203.26.167]:52650, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(14) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170428 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Debug> executeQuery: (from [::ffff:10.203.26.167]:24934, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(4) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170125 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Debug> executeQuery: (from [::ffff:10.203.26.167]:45078, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(7) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170140 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Debug> executeQuery: (from [::ffff:10.203.26.167]:52270, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(1) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170366 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Debug> executeQuery: (from [::ffff:10.203.26.167]:63828, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(17) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170174 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Debug> executeQuery: (from [::ffff:10.203.26.167]:56048, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(13) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170046 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Debug> executeQuery: (from [::ffff:10.203.26.167]:5084, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(2) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170326 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Debug> executeQuery: (from [::ffff:10.203.26.167]:46698, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(23) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170216 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Debug> executeQuery: (from [::ffff:10.203.26.167]:14122, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(19) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170270 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Debug> executeQuery: (from [::ffff:10.203.26.167]:40518, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(12) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170373 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Debug> executeQuery: (from [::ffff:10.203.26.167]:41026, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(21) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170404 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Debug> executeQuery: (from [::ffff:10.203.26.167]:14572, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(25) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170477 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Debug> executeQuery: (from [::ffff:10.203.26.167]:27758, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(16) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170269 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Debug> executeQuery: (from [::ffff:10.203.26.167]:63186, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(15) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170481 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Debug> executeQuery: (from [::ffff:10.203.26.167]:26098, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(18) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170356 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Debug> executeQuery: (from [::ffff:10.203.26.167]:65530, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(22) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170371 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Debug> executeQuery: (from [::ffff:10.203.26.167]:9914, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(30) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170289 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Debug> executeQuery: (from [::ffff:10.203.26.167]:55746, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(20) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170515 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Debug> executeQuery: (from [::ffff:10.203.26.167]:61632, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(33) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170474 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Debug> executeQuery: (from [::ffff:10.203.26.167]:4192, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(26) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170247 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Debug> executeQuery: (from [::ffff:10.203.26.167]:49554, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(32) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170473 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Debug> executeQuery: (from [::ffff:10.203.26.167]:18688, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(28) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170400 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Debug> executeQuery: (from [::ffff:10.203.26.167]:14106, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(37) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170008 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Debug> executeQuery: (from [::ffff:10.203.26.167]:1870, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(31) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170188 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Debug> executeQuery: (from [::ffff:10.203.26.167]:36812, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(27) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170522 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Debug> executeQuery: (from [::ffff:10.203.26.167]:42656, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(36) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170285 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Debug> executeQuery: (from [::ffff:10.203.26.167]:42046, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(24) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.169857 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Debug> executeQuery: (from [::ffff:10.203.26.167]:50646, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(6) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170518 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Debug> executeQuery: (from [::ffff:10.203.26.167]:45374, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(34) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170423 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Debug> executeQuery: (from [::ffff:10.203.26.167]:61306, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(38) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170526 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Debug> executeQuery: (from [::ffff:10.203.26.167]:14714, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(35) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.169693 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Debug> executeQuery: (from [::ffff:10.203.26.167]:65032, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(45) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.169708 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Debug> executeQuery: (from [::ffff:10.203.26.167]:14164, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(44) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170510 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Debug> executeQuery: (from [::ffff:10.203.26.167]:38400, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(43) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170609 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Debug> executeQuery: (from [::ffff:10.203.26.167]:22182, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(40) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170457 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Debug> executeQuery: (from [::ffff:10.203.26.167]:29744, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(41) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170558 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Debug> executeQuery: (from [::ffff:10.203.26.167]:15928, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(39) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170474 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Debug> executeQuery: (from [::ffff:10.203.26.167]:51794, initial_query_id: 4e07e8a7-149e-4827-9258-ee4290df2d68) WITH toUInt32(42) AS _shard_num SELECT _part, _shard_num FROM xxx WHERE _shard_num = 1 LIMIT 1
word] 2020.11.12 16:40:55.170662 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.170887 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.170903 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.170914 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.170960 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.170490 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.170773 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.170789 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.170801 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.170852 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171361 [ 150329 ] {1c1f1602-f0be-4145-959f-b4aced3f3e16} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171271 [ 47483 ] {669019c4-e565-4ea6-9562-93b4acc43319} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170744 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171045 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171059 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171070 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171159 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171193 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171436 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171451 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171474 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171537 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.170777 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171189 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171207 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171224 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171275 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171015 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171361 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171388 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171424 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171494 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171195 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171527 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171566 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171579 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171624 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171010 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171331 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171372 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171384 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171434 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.170992 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171354 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171371 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171384 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171432 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.170805 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171040 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171060 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171073 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171379 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
3 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
2 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Debug> xxx (SelectExecutor): Key condition: false
6 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Debug> xxx (SelectExecutor): MinMax index condition: false
5 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
4 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
8 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
4 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Debug> xxx (SelectExecutor): Key condition: false
3 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Debug> xxx (SelectExecutor): MinMax index condition: false
5 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
5 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171084 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171384 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171424 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171435 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171481 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171050 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171537 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171554 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171565 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171617 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171139 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171587 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171612 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171641 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171721 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171318 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171564 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171579 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171595 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171666 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171014 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171383 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171401 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171416 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171478 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171502 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171743 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171762 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171774 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171818 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171953 [ 158105 ] {ad0f5ce6-aec4-4024-a334-7411ab534a88} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171911 [ 56606 ] {4a8feced-a570-4aed-8c92-ee37f4bbe88b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171637 [ 29983 ] {25fab225-cccd-42b3-a135-d4e246174c3b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170939 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171443 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171459 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171478 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171530 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171768 [ 61595 ] {2b178026-94ee-4d29-bccc-f77eb84d5f7c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172039 [ 33032 ] {33f4ee4b-4b8c-49f0-85f2-160dbf399dc8} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171906 [ 62225 ] {d264800f-4ca6-4fae-a353-3e4ef81c7bb9} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171919 [ 49718 ] {4087c408-df0b-478b-8415-ad6a677da3fb} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170991 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171221 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171234 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171251 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171650 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171010 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171376 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171395 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171418 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171498 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171805 [ 198131 ] {5cbc5459-9ec8-4753-99d8-22df909d9432} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171428 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171695 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171716 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171743 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171809 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
2 [ 206583 ] {5b3cef88-a9af-43cf-bcb6-018213b17e8e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172029 [ 27739 ] {25337627-0c9b-46e8-b181-d87bf0c3006c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171855 [ 162639 ] {d4d2df16-9393-4f51-88d4-044861231c6a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
5 [ 60780 ] {4e993337-d42a-480e-a06e-762272d1fffe} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170932 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171221 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171263 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171274 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171321 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171238 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171606 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171627 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171643 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171691 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171328 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171635 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171659 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171681 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171813 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172200 [ 183806 ] {229c75b8-a033-4ea3-a909-47ed23c8fd17} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171932 [ 171867 ] {e346b433-1df8-4217-ac46-61f4430a4319} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172224 [ 90477 ] {8a8a2dc1-8956-4686-b48e-35c7f522125a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172118 [ 170912 ] {75ece9cc-8713-4b94-8bd7-78122fa8b94d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172048 [ 36150 ] {e4ee7324-4723-4977-9260-a593c3994376} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170331 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.170945 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.170961 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.170973 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171020 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171459 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171829 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171874 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171887 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171933 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171998 [ 99871 ] {19a1edde-d800-4535-823b-677c41c3b7d5} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170863 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171719 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171739 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171755 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171802 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171583 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171874 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171893 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171904 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171949 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171324 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171626 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171643 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171677 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171745 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172269 [ 196863 ] {ee73098e-799e-48fb-8044-af8da18a7deb} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171643 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171908 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171926 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171944 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171998 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172034 [ 28543 ] {3163d6c2-fb8b-4770-bf7c-0f55c6bc53e4} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171568 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171823 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171848 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171859 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171910 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172033 [ 9654 ] {0dc8c4c2-2b7f-4d42-a7fa-7261368d7226} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172151 [ 175130 ] {5f35b908-3a37-4609-8ce8-9104ef4ffc1c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172278 [ 171914 ] {eff2bda1-bae5-4230-ac31-1f814979900c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171440 [ 23165 ] {0a2e793b-46b8-4608-8a12-347e39df0dfb} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171147 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171504 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171522 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171537 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171931 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.171158 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171401 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171417 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171429 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171985 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172349 [ 158703 ] {9510e55f-7101-4499-bbec-0a941110b77c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172369 [ 113266 ] {edf1fcfd-d8e1-4e3e-8013-2363b98bf763} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172430 [ 134212 ] {9a86ffc1-4223-4508-9df6-721aeb059de7} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170768 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171659 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171704 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171711 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171884 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172227 [ 105416 ] {9ea9b01f-b260-4349-bfa8-4bee1fbc6d45} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171040 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171901 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171927 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171956 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.172019 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172355 [ 30201 ] {cc479f89-4f42-4490-acd9-2f45ef05c90b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171188 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171479 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171498 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171509 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171554 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172351 [ 50051 ] {00b46012-08fc-494f-9202-77b56263c616} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172420 [ 34446 ] {8d58247e-cded-46b2-b51d-00f7251e19b1} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171870 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.172192 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.172206 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.172218 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.172268 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172317 [ 19335 ] {70c312b1-bf09-4990-b17e-dd2e514d7900} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172635 [ 154394 ] {57610784-ddc7-4ff3-b09b-0a262d795445} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172469 [ 21469 ] {cc44d6da-a9dc-4954-9a57-2fbf626edbab} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170680 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171144 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171167 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171203 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171727 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172697 [ 214496 ] {a457c38a-cfa0-42d6-bd5e-038a76a8ea19} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170862 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.172142 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.172159 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.172175 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.172239 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.170690 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.170986 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171002 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171113 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.171935 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.172627 [ 49116 ] {88d94c03-84ef-4e82-9ae7-caaf73f8eb45} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172244 [ 94380 ] {64a5bf94-386f-4bb8-a2a3-a545623b1883} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172714 [ 145095 ] {21384fcb-0da4-4d0c-920a-e0116669f026} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172415 [ 89771 ] {36f008b8-8016-4105-a894-b096a098d84a} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.171055 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171483 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.171500 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.171513 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.172663 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.173148 [ 207517 ] {d0576e04-17da-4416-a14c-10af00b7065d} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.172948 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.173339 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Debug> xxx (SelectExecutor): Key condition: false
word] 2020.11.12 16:40:55.173357 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Debug> xxx (SelectExecutor): MinMax index condition: false
word] 2020.11.12 16:40:55.173372 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Debug> xxx (SelectExecutor): Selected 0 parts by date, 0 parts by key, 0 marks to read from 0 ranges
word] 2020.11.12 16:40:55.173424 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
word] 2020.11.12 16:40:55.173862 [ 210314 ] {6a93c195-c481-4f11-82d6-344412783b62} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
word] 2020.11.12 16:40:55.170909 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> ContextAccess (default): Access granted: SELECT(_part) ON xxx
word] 2020.11.12 16:40:55.171444 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Debug> xxx (SelectExecutor): Key condition: unknown
word] 2020.11.12 16:40:55.171469 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Debug> xxx (SelectExecutor): MinMax index condition: unknown
word] 2020.11.12 16:40:55.172649 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Debug> xxx (SelectExecutor): Selected 508 parts by date, 508 parts by key, 584503 marks to read from 508 ranges
word] 2020.11.12 16:40:55.172732 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191001_1_28_2, approx. 4115175 rows starting from 0
word] 2020.11.12 16:40:55.172769 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191001_29_34_1, approx. 830047 rows starting from 0
word] 2020.11.12 16:40:55.172803 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191001_35_40_1, approx. 977091 rows starting from 0
word] 2020.11.12 16:40:55.172834 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191001_41_45_1, approx. 674400 rows starting from 0
word] 2020.11.12 16:40:55.172864 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191002_1_34_2, approx. 5509457 rows starting from 0
word] 2020.11.12 16:40:55.172897 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191002_35_68_2, approx. 5461606 rows starting from 0
word] 2020.11.12 16:40:55.172928 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191002_69_72_1, approx. 633743 rows starting from 0
word] 2020.11.12 16:40:55.172959 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191003_1_141_3, approx. 22259794 rows starting from 0
word] 2020.11.12 16:40:55.172992 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191003_142_142_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.173026 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191003_143_143_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.173054 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191003_144_144_0, approx. 12288 rows starting from 0
word] 2020.11.12 16:40:55.173089 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191023_1_143_3, approx. 23110033 rows starting from 0
word] 2020.11.12 16:40:55.173120 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191023_144_144_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.173151 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191023_145_145_0, approx. 81920 rows starting from 0
word] 2020.11.12 16:40:55.173184 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191024_1_142_3, approx. 22935187 rows starting from 0
word] 2020.11.12 16:40:55.173222 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191024_143_143_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.173254 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191024_144_144_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.173288 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191024_145_145_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.173318 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191024_146_146_0, approx. 12288 rows starting from 0
word] 2020.11.12 16:40:55.173356 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191025_1_33_2, approx. 5386500 rows starting from 0
word] 2020.11.12 16:40:55.173390 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191025_34_66_2, approx. 5165939 rows starting from 0
word] 2020.11.12 16:40:55.173418 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191025_67_98_2, approx. 4973098 rows starting from 0
word] 2020.11.12 16:40:55.173450 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191025_99_132_2, approx. 5406164 rows starting from 0
word] 2020.11.12 16:40:55.173487 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191025_133_138_1, approx. 982276 rows starting from 0
word] 2020.11.12 16:40:55.173520 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191025_139_143_1, approx. 667247 rows starting from 0
word] 2020.11.12 16:40:55.173552 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191026_1_141_3, approx. 22694575 rows starting from 0
word] 2020.11.12 16:40:55.173588 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191026_142_142_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.173622 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191026_143_143_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.173660 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191026_144_144_0, approx. 12288 rows starting from 0
word] 2020.11.12 16:40:55.173699 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191027_1_141_3, approx. 22864873 rows starting from 0
word] 2020.11.12 16:40:55.173741 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191027_142_142_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.173773 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191027_143_143_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.173803 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191027_144_144_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.173835 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191027_145_145_0, approx. 12288 rows starting from 0
word] 2020.11.12 16:40:55.173868 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191028_1_153_3, approx. 25804614 rows starting from 0
word] 2020.11.12 16:40:55.173905 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191028_154_177_2, approx. 3990596 rows starting from 0
word] 2020.11.12 16:40:55.173943 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191028_178_178_0, approx. 32768 rows starting from 0
word] 2020.11.12 16:40:55.173976 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191029_1_152_3, approx. 25638209 rows starting from 0
word] 2020.11.12 16:40:55.174008 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191029_153_158_1, approx. 920756 rows starting from 0
word] 2020.11.12 16:40:55.174040 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191029_159_164_1, approx. 1032615 rows starting from 0
word] 2020.11.12 16:40:55.174074 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191029_165_170_1, approx. 1031146 rows starting from 0
word] 2020.11.12 16:40:55.174105 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191029_171_176_1, approx. 919562 rows starting from 0
word] 2020.11.12 16:40:55.174147 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191030_1_34_2, approx. 5709729 rows starting from 0
word] 2020.11.12 16:40:55.174186 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191030_35_68_2, approx. 5391184 rows starting from 0
word] 2020.11.12 16:40:55.174219 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191030_69_74_1, approx. 856705 rows starting from 0
word] 2020.11.12 16:40:55.174251 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191030_75_80_1, approx. 1032577 rows starting from 0
word] 2020.11.12 16:40:55.174284 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191030_81_86_1, approx. 1034073 rows starting from 0
word] 2020.11.12 16:40:55.174315 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191030_87_91_1, approx. 701537 rows starting from 0
word] 2020.11.12 16:40:55.174342 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191031_1_34_2, approx. 5651803 rows starting from 0
word] 2020.11.12 16:40:55.174376 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191031_35_66_2, approx. 5309176 rows starting from 0
word] 2020.11.12 16:40:55.174405 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191031_67_98_2, approx. 5251914 rows starting from 0
word] 2020.11.12 16:40:55.174435 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191031_99_104_1, approx. 1017956 rows starting from 0
word] 2020.11.12 16:40:55.174467 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191031_105_110_1, approx. 904638 rows starting from 0
word] 2020.11.12 16:40:55.174499 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191101_1_140_3, approx. 23572002 rows starting from 0
word] 2020.11.12 16:40:55.174532 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191101_141_145_1, approx. 759801 rows starting from 0
word] 2020.11.12 16:40:55.174561 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191102_1_34_2, approx. 5715111 rows starting from 0
word] 2020.11.12 16:40:55.174594 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191102_35_67_2, approx. 5534549 rows starting from 0
word] 2020.11.12 16:40:55.174624 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191102_68_98_2, approx. 5118616 rows starting from 0
word] 2020.11.12 16:40:55.174657 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191102_99_104_1, approx. 1022583 rows starting from 0
word] 2020.11.12 16:40:55.174694 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191102_105_110_1, approx. 905609 rows starting from 0
word] 2020.11.12 16:40:55.174720 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191103_1_33_2, approx. 5451352 rows starting from 0
word] 2020.11.12 16:40:55.174750 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191103_34_66_2, approx. 5475111 rows starting from 0
word] 2020.11.12 16:40:55.174781 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191103_67_99_2, approx. 5377309 rows starting from 0
word] 2020.11.12 16:40:55.174815 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191103_100_105_1, approx. 1008024 rows starting from 0
word] 2020.11.12 16:40:55.174844 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191103_106_110_1, approx. 728905 rows starting from 0
word] 2020.11.12 16:40:55.174884 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191104_1_150_3, approx. 26325306 rows starting from 0
word] 2020.11.12 16:40:55.174914 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191104_151_156_1, approx. 1075021 rows starting from 0
word] 2020.11.12 16:40:55.174943 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191104_157_162_1, approx. 1074050 rows starting from 0
word] 2020.11.12 16:40:55.174972 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191104_163_163_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.175003 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191104_164_164_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.175031 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191104_165_165_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.175063 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_1_34_2, approx. 5702599 rows starting from 0
word] 2020.11.12 16:40:55.175094 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_35_68_2, approx. 5840848 rows starting from 0
word] 2020.11.12 16:40:55.175126 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_69_101_2, approx. 5303443 rows starting from 0
word] 2020.11.12 16:40:55.175159 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_102_107_1, approx. 1010395 rows starting from 0
word] 2020.11.12 16:40:55.175189 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_108_113_1, approx. 1008151 rows starting from 0
word] 2020.11.12 16:40:55.175221 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_114_119_1, approx. 1010195 rows starting from 0
word] 2020.11.12 16:40:55.175255 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191105_120_120_0, approx. 49152 rows starting from 0
word] 2020.11.12 16:40:55.175289 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191106_1_34_2, approx. 5557394 rows starting from 0
word] 2020.11.12 16:40:55.175323 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191106_35_68_2, approx. 5711533 rows starting from 0
word] 2020.11.12 16:40:55.175354 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191106_69_99_2, approx. 5022987 rows starting from 0
word] 2020.11.12 16:40:55.175393 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191107_1_182_3, approx. 33064035 rows starting from 0
word] 2020.11.12 16:40:55.175424 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191107_183_216_2, approx. 6419703 rows starting from 0
word] 2020.11.12 16:40:55.175459 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191107_217_222_1, approx. 1132107 rows starting from 0
word] 2020.11.12 16:40:55.175491 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191107_223_223_0, approx. 126976 rows starting from 0
word] 2020.11.12 16:40:55.175524 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191108_1_34_2, approx. 5527184 rows starting from 0
word] 2020.11.12 16:40:55.175556 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191108_35_67_2, approx. 5472473 rows starting from 0
word] 2020.11.12 16:40:55.175585 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191108_68_99_2, approx. 5337184 rows starting from 0
word] 2020.11.12 16:40:55.175632 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191108_100_105_1, approx. 995086 rows starting from 0
word] 2020.11.12 16:40:55.175667 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191108_106_111_1, approx. 994884 rows starting from 0
word] 2020.11.12 16:40:55.175696 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191108_112_117_1, approx. 949594 rows starting from 0
word] 2020.11.12 16:40:55.175727 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191109_1_130_3, approx. 22554940 rows starting from 0
word] 2020.11.12 16:40:55.175761 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191109_131_131_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.175792 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191109_132_132_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.175827 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191109_133_133_0, approx. 110592 rows starting from 0
word] 2020.11.12 16:40:55.175862 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191110_1_131_3, approx. 22247300 rows starting from 0
word] 2020.11.12 16:40:55.175893 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191110_132_132_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.175920 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191110_133_133_0, approx. 106496 rows starting from 0
word] 2020.11.12 16:40:55.175948 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191111_1_153_3, approx. 26409066 rows starting from 0
word] 2020.11.12 16:40:55.175984 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191111_154_185_2, approx. 5474583 rows starting from 0
word] 2020.11.12 16:40:55.176008 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191112_1_155_3, approx. 25515942 rows starting from 0
word] 2020.11.12 16:40:55.176043 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191112_156_187_2, approx. 5043433 rows starting from 0
word] 2020.11.12 16:40:55.176076 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191113_1_32_2, approx. 4903941 rows starting from 0
word] 2020.11.12 16:40:55.176107 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191113_33_66_2, approx. 5189928 rows starting from 0
word] 2020.11.12 16:40:55.176144 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191113_67_72_1, approx. 852836 rows starting from 0
word] 2020.11.12 16:40:55.176176 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191113_73_78_1, approx. 1007621 rows starting from 0
word] 2020.11.12 16:40:55.176210 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191113_79_79_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.176249 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191113_80_80_0, approx. 24576 rows starting from 0
word] 2020.11.12 16:40:55.176284 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_1_32_2, approx. 5234243 rows starting from 0
word] 2020.11.12 16:40:55.176317 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_33_66_2, approx. 5491717 rows starting from 0
word] 2020.11.12 16:40:55.176344 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_67_98_2, approx. 5145290 rows starting from 0
word] 2020.11.12 16:40:55.176373 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_99_104_1, approx. 1007008 rows starting from 0
word] 2020.11.12 16:40:55.176402 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_105_110_1, approx. 891844 rows starting from 0
word] 2020.11.12 16:40:55.176433 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_111_116_1, approx. 1026287 rows starting from 0
word] 2020.11.12 16:40:55.176464 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_117_117_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.176497 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_118_118_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.176529 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_119_119_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.176557 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191114_120_120_0, approx. 40960 rows starting from 0
word] 2020.11.12 16:40:55.176584 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191115_1_34_2, approx. 5576411 rows starting from 0
word] 2020.11.12 16:40:55.176614 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191115_35_66_2, approx. 5183501 rows starting from 0
word] 2020.11.12 16:40:55.176639 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191115_67_100_2, approx. 5515362 rows starting from 0
word] 2020.11.12 16:40:55.176669 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191115_101_104_1, approx. 635765 rows starting from 0
word] 2020.11.12 16:40:55.176699 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191116_1_33_2, approx. 5373095 rows starting from 0
word] 2020.11.12 16:40:55.176727 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191116_34_64_2, approx. 5063466 rows starting from 0
word] 2020.11.12 16:40:55.176757 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191117_1_32_2, approx. 5351132 rows starting from 0
word] 2020.11.12 16:40:55.176789 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191117_33_65_2, approx. 5411220 rows starting from 0
word] 2020.11.12 16:40:55.176818 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191117_66_97_2, approx. 5298551 rows starting from 0
word] 2020.11.12 16:40:55.176850 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191117_98_128_2, approx. 5161263 rows starting from 0
word] 2020.11.12 16:40:55.176879 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191118_1_35_2, approx. 5581322 rows starting from 0
word] 2020.11.12 16:40:55.176919 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191118_36_67_2, approx. 5328941 rows starting from 0
word] 2020.11.12 16:40:55.176946 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191118_68_100_2, approx. 5498618 rows starting from 0
word] 2020.11.12 16:40:55.176975 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191118_101_106_1, approx. 986305 rows starting from 0
word] 2020.11.12 16:40:55.177002 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191118_107_107_0, approx. 81920 rows starting from 0
word] 2020.11.12 16:40:55.177030 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191119_1_32_2, approx. 4283900 rows starting from 0
word] 2020.11.12 16:40:55.177062 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191120_1_32_2, approx. 4223119 rows starting from 0
word] 2020.11.12 16:40:55.177094 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191121_1_34_2, approx. 5710597 rows starting from 0
word] 2020.11.12 16:40:55.177124 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191121_35_67_2, approx. 5482038 rows starting from 0
word] 2020.11.12 16:40:55.177155 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191121_68_98_2, approx. 5092341 rows starting from 0
word] 2020.11.12 16:40:55.177185 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191121_99_99_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.177216 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191121_100_100_0, approx. 118784 rows starting from 0
word] 2020.11.12 16:40:55.177241 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191122_1_34_2, approx. 5639445 rows starting from 0
word] 2020.11.12 16:40:55.177271 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191122_35_68_2, approx. 5688785 rows starting from 0
word] 2020.11.12 16:40:55.177301 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191122_69_99_2, approx. 5045245 rows starting from 0
word] 2020.11.12 16:40:55.177331 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_1_34_2, approx. 5906419 rows starting from 0
word] 2020.11.12 16:40:55.177361 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_35_66_2, approx. 5351732 rows starting from 0
word] 2020.11.12 16:40:55.177391 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_67_97_2, approx. 5244671 rows starting from 0
word] 2020.11.12 16:40:55.177420 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_98_103_1, approx. 926968 rows starting from 0
word] 2020.11.12 16:40:55.177447 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_104_109_1, approx. 1055370 rows starting from 0
word] 2020.11.12 16:40:55.177475 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_110_115_1, approx. 1054357 rows starting from 0
word] 2020.11.12 16:40:55.177503 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_116_120_1, approx. 878702 rows starting from 0
word] 2020.11.12 16:40:55.177528 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_121_121_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.177558 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191123_122_122_0, approx. 49152 rows starting from 0
word] 2020.11.12 16:40:55.177587 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191124_1_33_2, approx. 5267868 rows starting from 0
word] 2020.11.12 16:40:55.177614 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191124_34_64_2, approx. 4918532 rows starting from 0
word] 2020.11.12 16:40:55.177642 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191124_65_65_0, approx. 32768 rows starting from 0
word] 2020.11.12 16:40:55.177668 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191125_1_34_2, approx. 5509417 rows starting from 0
word] 2020.11.12 16:40:55.177699 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191125_35_66_2, approx. 5188801 rows starting from 0
word] 2020.11.12 16:40:55.177729 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191125_67_98_2, approx. 5248925 rows starting from 0
word] 2020.11.12 16:40:55.177757 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191126_1_34_2, approx. 5552340 rows starting from 0
word] 2020.11.12 16:40:55.177787 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191126_35_67_2, approx. 5197692 rows starting from 0
word] 2020.11.12 16:40:55.177812 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191126_68_73_1, approx. 828000 rows starting from 0
word] 2020.11.12 16:40:55.177839 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191126_74_79_1, approx. 981126 rows starting from 0
word] 2020.11.12 16:40:55.177868 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191126_80_85_1, approx. 981888 rows starting from 0
word] 2020.11.12 16:40:55.177898 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191126_86_90_1, approx. 663331 rows starting from 0
word] 2020.11.12 16:40:55.177928 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191127_1_150_3, approx. 26820281 rows starting from 0
word] 2020.11.12 16:40:55.177958 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191127_151_156_1, approx. 1052333 rows starting from 0
word] 2020.11.12 16:40:55.177988 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191127_157_160_1, approx. 701624 rows starting from 0
word] 2020.11.12 16:40:55.178022 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191128_1_33_2, approx. 5306655 rows starting from 0
word] 2020.11.12 16:40:55.178051 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191128_34_62_2, approx. 4563099 rows starting from 0
word] 2020.11.12 16:40:55.178079 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_1_34_2, approx. 5584212 rows starting from 0
word] 2020.11.12 16:40:55.178109 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_35_40_1, approx. 893769 rows starting from 0
word] 2020.11.12 16:40:55.178134 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_41_72_2, approx. 5271600 rows starting from 0
word] 2020.11.12 16:40:55.178162 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_73_78_1, approx. 870123 rows starting from 0
word] 2020.11.12 16:40:55.178193 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_79_84_1, approx. 992058 rows starting from 0
word] 2020.11.12 16:40:55.178223 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_85_90_1, approx. 992107 rows starting from 0
word] 2020.11.12 16:40:55.178252 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191129_91_95_1, approx. 707470 rows starting from 0
word] 2020.11.12 16:40:55.178281 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_1_34_2, approx. 5498006 rows starting from 0
word] 2020.11.12 16:40:55.178315 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_35_68_2, approx. 5516015 rows starting from 0
word] 2020.11.12 16:40:55.178349 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_69_102_2, approx. 5665536 rows starting from 0
word] 2020.11.12 16:40:55.178381 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_103_108_1, approx. 1057735 rows starting from 0
word] 2020.11.12 16:40:55.178412 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_109_114_1, approx. 1059599 rows starting from 0
word] 2020.11.12 16:40:55.178436 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_115_115_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.178462 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20191130_116_116_0, approx. 61440 rows starting from 0
word] 2020.11.12 16:40:55.178508 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200601_179_211_2, approx. 5465693 rows starting from 0
word] 2020.11.12 16:40:55.178561 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200601_212_243_2, approx. 5150320 rows starting from 0
word] 2020.11.12 16:40:55.178614 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200601_244_273_2, approx. 4765186 rows starting from 0
word] 2020.11.12 16:40:55.178660 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_187_219_2, approx. 5440955 rows starting from 0
word] 2020.11.12 16:40:55.178713 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_220_251_2, approx. 5181319 rows starting from 0
word] 2020.11.12 16:40:55.178763 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_252_257_1, approx. 1026691 rows starting from 0
word] 2020.11.12 16:40:55.178811 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_258_263_1, approx. 1026504 rows starting from 0
word] 2020.11.12 16:40:55.178858 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_264_264_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.178900 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_265_265_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.178944 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200602_266_266_0, approx. 12288 rows starting from 0
word] 2020.11.12 16:40:55.178992 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_100_133_2, approx. 5726356 rows starting from 0
word] 2020.11.12 16:40:55.179041 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_134_166_2, approx. 5531696 rows starting from 0
word] 2020.11.12 16:40:55.179089 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_167_198_2, approx. 5117596 rows starting from 0
word] 2020.11.12 16:40:55.179133 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_199_204_1, approx. 1007109 rows starting from 0
word] 2020.11.12 16:40:55.179179 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_205_210_1, approx. 1005467 rows starting from 0
word] 2020.11.12 16:40:55.179227 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_211_216_1, approx. 1006496 rows starting from 0
word] 2020.11.12 16:40:55.179276 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_217_217_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.179325 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_218_218_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.179364 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200603_219_219_0, approx. 49152 rows starting from 0
word] 2020.11.12 16:40:55.179411 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200604_128_280_3, approx. 25896895 rows starting from 0
word] 2020.11.12 16:40:55.179457 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200604_281_286_1, approx. 1111337 rows starting from 0
word] 2020.11.12 16:40:55.179503 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200604_287_292_1, approx. 1108073 rows starting from 0
word] 2020.11.12 16:40:55.179555 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200604_293_298_1, approx. 1109403 rows starting from 0
word] 2020.11.12 16:40:55.179600 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200604_299_302_1, approx. 740758 rows starting from 0
word] 2020.11.12 16:40:55.179651 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200605_52_85_2, approx. 5709857 rows starting from 0
word] 2020.11.12 16:40:55.179699 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200605_86_118_2, approx. 5340949 rows starting from 0
word] 2020.11.12 16:40:55.179751 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200605_119_146_2, approx. 4457686 rows starting from 0
word] 2020.11.12 16:40:55.179803 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_132_164_2, approx. 5864723 rows starting from 0
word] 2020.11.12 16:40:55.179843 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_165_198_2, approx. 6086162 rows starting from 0
word] 2020.11.12 16:40:55.179892 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_199_229_2, approx. 5439762 rows starting from 0
word] 2020.11.12 16:40:55.179939 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_230_259_2, approx. 5218295 rows starting from 0
word] 2020.11.12 16:40:55.179991 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_260_265_1, approx. 1093570 rows starting from 0
word] 2020.11.12 16:40:55.180040 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_266_271_1, approx. 1092179 rows starting from 0
word] 2020.11.12 16:40:55.180088 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200606_272_276_1, approx. 809523 rows starting from 0
word] 2020.11.12 16:40:55.180137 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200607_78_250_3, approx. 29362665 rows starting from 0
word] 2020.11.12 16:40:55.180185 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200607_251_284_2, approx. 5680020 rows starting from 0
word] 2020.11.12 16:40:55.180236 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200608_187_220_2, approx. 5708182 rows starting from 0
word] 2020.11.12 16:40:55.180284 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200608_221_252_2, approx. 5246224 rows starting from 0
word] 2020.11.12 16:40:55.180324 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200608_253_284_2, approx. 5323257 rows starting from 0
word] 2020.11.12 16:40:55.180373 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200608_285_290_1, approx. 1011408 rows starting from 0
word] 2020.11.12 16:40:55.180423 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200608_291_295_1, approx. 729186 rows starting from 0
word] 2020.11.12 16:40:55.180471 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200609_106_259_3, approx. 28096298 rows starting from 0
word] 2020.11.12 16:40:55.180517 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200609_260_290_2, approx. 5523872 rows starting from 0
word] 2020.11.12 16:40:55.180563 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_62_94_2, approx. 5403187 rows starting from 0
word] 2020.11.12 16:40:55.180615 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_95_126_2, approx. 5158815 rows starting from 0
word] 2020.11.12 16:40:55.180663 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_127_132_1, approx. 1013321 rows starting from 0
word] 2020.11.12 16:40:55.180712 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_133_133_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.180760 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_134_134_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.180804 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_135_135_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.180849 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200610_136_136_0, approx. 40960 rows starting from 0
word] 2020.11.12 16:40:55.180894 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_85_118_2, approx. 5642657 rows starting from 0
word] 2020.11.12 16:40:55.180946 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_119_152_2, approx. 5540058 rows starting from 0
word] 2020.11.12 16:40:55.180994 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_153_185_2, approx. 5463280 rows starting from 0
word] 2020.11.12 16:40:55.181043 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_186_191_1, approx. 1057843 rows starting from 0
word] 2020.11.12 16:40:55.181093 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_192_197_1, approx. 1056908 rows starting from 0
word] 2020.11.12 16:40:55.181141 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_198_198_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.181192 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_199_199_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.181243 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200611_200_200_0, approx. 61440 rows starting from 0
word] 2020.11.12 16:40:55.181281 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_147_180_2, approx. 5788071 rows starting from 0
word] 2020.11.12 16:40:55.181328 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_181_213_2, approx. 5370297 rows starting from 0
word] 2020.11.12 16:40:55.181376 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_214_246_2, approx. 5404718 rows starting from 0
word] 2020.11.12 16:40:55.181425 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_247_252_1, approx. 1037840 rows starting from 0
word] 2020.11.12 16:40:55.181474 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_253_258_1, approx. 1035697 rows starting from 0
word] 2020.11.12 16:40:55.181518 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_259_259_0, approx. 176128 rows starting from 0
word] 2020.11.12 16:40:55.181567 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200612_260_260_0, approx. 61440 rows starting from 0
word] 2020.11.12 16:40:55.181616 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_135_167_2, approx. 5654678 rows starting from 0
word] 2020.11.12 16:40:55.181664 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_168_201_2, approx. 5893988 rows starting from 0
word] 2020.11.12 16:40:55.181714 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_202_233_2, approx. 5404000 rows starting from 0
word] 2020.11.12 16:40:55.181752 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_234_263_2, approx. 5025060 rows starting from 0
word] 2020.11.12 16:40:55.181800 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_264_269_1, approx. 1029270 rows starting from 0
word] 2020.11.12 16:40:55.181847 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_270_275_1, approx. 1029056 rows starting from 0
word] 2020.11.12 16:40:55.181898 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_276_276_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.181946 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_277_277_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.181992 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_278_278_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.182055 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200613_279_279_0, approx. 77824 rows starting from 0
word] 2020.11.12 16:40:55.182101 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200614_1_153_3, approx. 26455441 rows starting from 0
word] 2020.11.12 16:40:55.182152 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200614_154_185_2, approx. 5502461 rows starting from 0
word] 2020.11.12 16:40:55.182201 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200615_1_33_2, approx. 5376545 rows starting from 0
word] 2020.11.12 16:40:55.182241 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200615_34_65_2, approx. 5259804 rows starting from 0
word] 2020.11.12 16:40:55.182289 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200615_66_66_0, approx. 135168 rows starting from 0
word] 2020.11.12 16:40:55.182339 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200616_1_33_2, approx. 5662873 rows starting from 0
word] 2020.11.12 16:40:55.182386 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200616_34_64_2, approx. 5338775 rows starting from 0
word] 2020.11.12 16:40:55.182432 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200616_65_94_2, approx. 5054796 rows starting from 0
word] 2020.11.12 16:40:55.182477 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200616_95_125_2, approx. 5218519 rows starting from 0
word] 2020.11.12 16:40:55.182525 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200616_126_130_1, approx. 784226 rows starting from 0
word] 2020.11.12 16:40:55.182568 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_390_559_3, approx. 28532811 rows starting from 0
word] 2020.11.12 16:40:55.182616 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_560_593_2, approx. 6043251 rows starting from 0
word] 2020.11.12 16:40:55.182666 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_594_626_2, approx. 6461712 rows starting from 0
word] 2020.11.12 16:40:55.182705 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_627_659_2, approx. 5680737 rows starting from 0
word] 2020.11.12 16:40:55.182751 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_660_690_2, approx. 5080731 rows starting from 0
word] 2020.11.12 16:40:55.182804 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_691_696_1, approx. 983207 rows starting from 0
word] 2020.11.12 16:40:55.182847 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_697_697_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.182893 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200618_698_698_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.182939 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_1_34_2, approx. 5793264 rows starting from 0
word] 2020.11.12 16:40:55.182987 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_35_67_2, approx. 5610520 rows starting from 0
word] 2020.11.12 16:40:55.183035 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_68_98_2, approx. 5223568 rows starting from 0
word] 2020.11.12 16:40:55.183085 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_99_128_2, approx. 5049022 rows starting from 0
word] 2020.11.12 16:40:55.183134 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_129_134_1, approx. 1024767 rows starting from 0
word] 2020.11.12 16:40:55.183171 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_135_140_1, approx. 1025272 rows starting from 0
word] 2020.11.12 16:40:55.183222 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200619_141_145_1, approx. 760842 rows starting from 0
word] 2020.11.12 16:40:55.183272 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200620_1_34_2, approx. 5737352 rows starting from 0
word] 2020.11.12 16:40:55.183320 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200620_35_66_2, approx. 5275197 rows starting from 0
word] 2020.11.12 16:40:55.183354 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200620_67_98_2, approx. 5310944 rows starting from 0
word] 2020.11.12 16:40:55.183397 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200620_99_104_1, approx. 1034665 rows starting from 0
word] 2020.11.12 16:40:55.183448 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200620_105_110_1, approx. 920517 rows starting from 0
word] 2020.11.12 16:40:55.183494 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_1_34_2, approx. 5763105 rows starting from 0
word] 2020.11.12 16:40:55.183543 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_35_68_2, approx. 5771510 rows starting from 0
word] 2020.11.12 16:40:55.183589 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_69_101_2, approx. 5346458 rows starting from 0
word] 2020.11.12 16:40:55.183632 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_102_107_1, approx. 1013534 rows starting from 0
word] 2020.11.12 16:40:55.183679 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_108_113_1, approx. 1014236 rows starting from 0
word] 2020.11.12 16:40:55.183726 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_114_119_1, approx. 1014866 rows starting from 0
word] 2020.11.12 16:40:55.183778 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200621_120_120_0, approx. 49152 rows starting from 0
word] 2020.11.12 16:40:55.183827 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_1_34_2, approx. 5493343 rows starting from 0
word] 2020.11.12 16:40:55.183871 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_35_68_2, approx. 5548352 rows starting from 0
word] 2020.11.12 16:40:55.183919 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_69_100_2, approx. 5035782 rows starting from 0
word] 2020.11.12 16:40:55.183968 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_101_106_1, approx. 994058 rows starting from 0
word] 2020.11.12 16:40:55.184017 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_107_112_1, approx. 993631 rows starting from 0
word] 2020.11.12 16:40:55.184066 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_113_118_1, approx. 993818 rows starting from 0
word] 2020.11.12 16:40:55.184109 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200622_119_119_0, approx. 135168 rows starting from 0
word] 2020.11.12 16:40:55.184154 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200623_1_34_2, approx. 5844443 rows starting from 0
word] 2020.11.12 16:40:55.184201 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200623_35_67_2, approx. 5470979 rows starting from 0
word] 2020.11.12 16:40:55.184252 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200623_68_99_2, approx. 5313263 rows starting from 0
word] 2020.11.12 16:40:55.184300 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200623_100_105_1, approx. 1030518 rows starting from 0
word] 2020.11.12 16:40:55.184347 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200623_106_111_1, approx. 1029201 rows starting from 0
word] 2020.11.12 16:40:55.184400 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200623_112_112_0, approx. 61440 rows starting from 0
word] 2020.11.12 16:40:55.184446 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200624_1_34_2, approx. 5633669 rows starting from 0
word] 2020.11.12 16:40:55.184495 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200624_35_66_2, approx. 5200992 rows starting from 0
word] 2020.11.12 16:40:55.184540 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200624_67_98_2, approx. 5211128 rows starting from 0
word] 2020.11.12 16:40:55.184582 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200624_99_104_1, approx. 990775 rows starting from 0
word] 2020.11.12 16:40:55.184629 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200624_105_110_1, approx. 880891 rows starting from 0
word] 2020.11.12 16:40:55.184676 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_1_33_2, approx. 5316838 rows starting from 0
word] 2020.11.12 16:40:55.184724 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_34_39_1, approx. 992989 rows starting from 0
word] 2020.11.12 16:40:55.184775 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_40_45_1, approx. 935191 rows starting from 0
word] 2020.11.12 16:40:55.184819 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_46_51_1, approx. 1007609 rows starting from 0
word] 2020.11.12 16:40:55.184867 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_52_52_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.184914 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_53_53_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.184965 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_54_54_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.185013 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200625_55_55_0, approx. 61440 rows starting from 0
word] 2020.11.12 16:40:55.185050 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200626_1_34_2, approx. 5550384 rows starting from 0
word] 2020.11.12 16:40:55.185098 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200626_35_66_2, approx. 5195606 rows starting from 0
word] 2020.11.12 16:40:55.185145 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200626_67_72_1, approx. 1023695 rows starting from 0
word] 2020.11.12 16:40:55.185194 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200626_73_78_1, approx. 1024919 rows starting from 0
word] 2020.11.12 16:40:55.185242 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200626_79_79_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.185291 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200626_80_80_0, approx. 12288 rows starting from 0
word] 2020.11.12 16:40:55.185340 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_1_34_2, approx. 5794596 rows starting from 0
word] 2020.11.12 16:40:55.185388 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_35_67_2, approx. 5610047 rows starting from 0
word] 2020.11.12 16:40:55.185435 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_68_98_2, approx. 5274350 rows starting from 0
word] 2020.11.12 16:40:55.185484 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_99_128_2, approx. 5056969 rows starting from 0
word] 2020.11.12 16:40:55.185521 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_129_134_1, approx. 1029966 rows starting from 0
word] 2020.11.12 16:40:55.185565 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_135_140_1, approx. 1030027 rows starting from 0
word] 2020.11.12 16:40:55.185610 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200627_141_145_1, approx. 763295 rows starting from 0
word] 2020.11.12 16:40:55.185661 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_1_33_2, approx. 5261110 rows starting from 0
word] 2020.11.12 16:40:55.185708 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_34_39_1, approx. 1008080 rows starting from 0
word] 2020.11.12 16:40:55.185761 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_40_45_1, approx. 881235 rows starting from 0
word] 2020.11.12 16:40:55.185811 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_46_51_1, approx. 1008336 rows starting from 0
word] 2020.11.12 16:40:55.185855 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_52_52_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.185901 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_53_53_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.185952 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_54_54_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.185999 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200628_55_55_0, approx. 57344 rows starting from 0
word] 2020.11.12 16:40:55.186038 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200629_1_34_2, approx. 5841295 rows starting from 0
word] 2020.11.12 16:40:55.186089 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200629_35_66_2, approx. 5428146 rows starting from 0
word] 2020.11.12 16:40:55.186134 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200629_67_97_2, approx. 5257618 rows starting from 0
word] 2020.11.12 16:40:55.186181 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200629_98_98_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.186228 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200629_99_99_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.186281 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200629_100_100_0, approx. 118784 rows starting from 0
word] 2020.11.12 16:40:55.186327 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200930_62_95_2, approx. 5453773 rows starting from 0
word] 2020.11.12 16:40:55.186372 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20200930_96_121_2, approx. 4034437 rows starting from 0
word] 2020.11.12 16:40:55.186421 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201001_2_33_2, approx. 5026435 rows starting from 0
word] 2020.11.12 16:40:55.186467 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201001_34_66_2, approx. 5280905 rows starting from 0
word] 2020.11.12 16:40:55.186504 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201001_67_72_1, approx. 982305 rows starting from 0
word] 2020.11.12 16:40:55.186551 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201001_73_73_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.186595 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201001_74_74_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.186641 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201001_75_75_0, approx. 36864 rows starting from 0
word] 2020.11.12 16:40:55.186689 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201002_2_34_2, approx. 5503143 rows starting from 0
word] 2020.11.12 16:40:55.186733 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201002_35_67_2, approx. 5278633 rows starting from 0
word] 2020.11.12 16:40:55.186783 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201002_68_73_1, approx. 844987 rows starting from 0
word] 2020.11.12 16:40:55.186832 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201002_74_79_1, approx. 1015142 rows starting from 0
word] 2020.11.12 16:40:55.186877 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201002_80_85_1, approx. 1015309 rows starting from 0
word] 2020.11.12 16:40:55.186922 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201002_86_91_1, approx. 856157 rows starting from 0
word] 2020.11.12 16:40:55.186960 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201003_2_33_2, approx. 4980970 rows starting from 0
word] 2020.11.12 16:40:55.187009 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201003_34_67_2, approx. 5441956 rows starting from 0
word] 2020.11.12 16:40:55.187054 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201003_68_73_1, approx. 978943 rows starting from 0
word] 2020.11.12 16:40:55.187098 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201003_74_74_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.187147 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201003_75_75_0, approx. 36864 rows starting from 0
word] 2020.11.12 16:40:55.187194 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201004_2_35_2, approx. 5595611 rows starting from 0
word] 2020.11.12 16:40:55.187242 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201004_36_68_2, approx. 5297194 rows starting from 0
word] 2020.11.12 16:40:55.187293 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201004_69_74_1, approx. 849175 rows starting from 0
word] 2020.11.12 16:40:55.187337 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201004_75_80_1, approx. 1017337 rows starting from 0
word] 2020.11.12 16:40:55.187382 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201004_81_86_1, approx. 1015616 rows starting from 0
word] 2020.11.12 16:40:55.187422 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201004_87_91_1, approx. 688949 rows starting from 0
word] 2020.11.12 16:40:55.187466 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201005_2_35_2, approx. 5485731 rows starting from 0
word] 2020.11.12 16:40:55.187508 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201005_36_69_2, approx. 5532857 rows starting from 0
word] 2020.11.12 16:40:55.187557 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201005_70_99_2, approx. 4946176 rows starting from 0
word] 2020.11.12 16:40:55.187605 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201005_100_100_0, approx. 16384 rows starting from 0
word] 2020.11.12 16:40:55.187649 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201006_2_142_3, approx. 23173333 rows starting from 0
word] 2020.11.12 16:40:55.187696 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201007_2_34_2, approx. 5115875 rows starting from 0
word] 2020.11.12 16:40:55.187751 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201007_35_40_1, approx. 961639 rows starting from 0
word] 2020.11.12 16:40:55.187793 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201007_41_46_1, approx. 995720 rows starting from 0
word] 2020.11.12 16:40:55.187836 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201007_47_47_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.187877 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201007_48_48_0, approx. 139264 rows starting from 0
word] 2020.11.12 16:40:55.187924 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201008_2_35_2, approx. 5706439 rows starting from 0
word] 2020.11.12 16:40:55.187970 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201008_36_68_2, approx. 5421337 rows starting from 0
word] 2020.11.12 16:40:55.188018 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201008_69_99_2, approx. 5115941 rows starting from 0
word] 2020.11.12 16:40:55.188062 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201008_100_105_1, approx. 1020275 rows starting from 0
word] 2020.11.12 16:40:55.188108 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201008_106_111_1, approx. 907780 rows starting from 0
word] 2020.11.12 16:40:55.188153 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201009_2_149_3, approx. 24425220 rows starting from 0
word] 2020.11.12 16:40:55.188201 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201009_150_155_1, approx. 989763 rows starting from 0
word] 2020.11.12 16:40:55.188248 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201009_156_161_1, approx. 990699 rows starting from 0
word] 2020.11.12 16:40:55.188294 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201010_2_141_3, approx. 22990272 rows starting from 0
word] 2020.11.12 16:40:55.188334 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201010_142_146_1, approx. 735948 rows starting from 0
word] 2020.11.12 16:40:55.188377 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201011_2_35_2, approx. 5711443 rows starting from 0
word] 2020.11.12 16:40:55.188422 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201011_36_69_2, approx. 5674044 rows starting from 0
word] 2020.11.12 16:40:55.188469 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201011_70_101_2, approx. 5236313 rows starting from 0
word] 2020.11.12 16:40:55.188512 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201012_2_35_2, approx. 5623140 rows starting from 0
word] 2020.11.12 16:40:55.188557 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201012_36_68_2, approx. 5396604 rows starting from 0
word] 2020.11.12 16:40:55.188606 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201012_69_99_2, approx. 5077705 rows starting from 0
word] 2020.11.12 16:40:55.188653 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201012_100_100_0, approx. 167936 rows starting from 0
word] 2020.11.12 16:40:55.188700 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201012_101_101_0, approx. 118784 rows starting from 0
word] 2020.11.12 16:40:55.188744 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201013_2_33_2, approx. 4963299 rows starting from 0
word] 2020.11.12 16:40:55.188782 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201013_34_39_1, approx. 997681 rows starting from 0
word] 2020.11.12 16:40:55.188826 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201013_40_45_1, approx. 840576 rows starting from 0
word] 2020.11.12 16:40:55.188873 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201013_46_51_1, approx. 889329 rows starting from 0
word] 2020.11.12 16:40:55.188918 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201014_2_34_2, approx. 5319907 rows starting from 0
word] 2020.11.12 16:40:55.188963 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201014_35_66_2, approx. 5101281 rows starting from 0
word] 2020.11.12 16:40:55.189010 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201014_67_71_1, approx. 740744 rows starting from 0
word] 2020.11.12 16:40:55.189056 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201015_2_35_2, approx. 5899213 rows starting from 0
word] 2020.11.12 16:40:55.189102 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201015_36_69_2, approx. 5894070 rows starting from 0
word] 2020.11.12 16:40:55.189145 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201015_70_103_2, approx. 5668052 rows starting from 0
word] 2020.11.12 16:40:55.189193 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201015_104_109_1, approx. 1048748 rows starting from 0
word] 2020.11.12 16:40:55.189232 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201015_110_115_1, approx. 1049427 rows starting from 0
word] 2020.11.12 16:40:55.189277 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201015_116_121_1, approx. 921646 rows starting from 0
word] 2020.11.12 16:40:55.189322 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201016_2_156_3, approx. 25972178 rows starting from 0
word] 2020.11.12 16:40:55.189369 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201016_157_162_1, approx. 999936 rows starting from 0
word] 2020.11.12 16:40:55.189413 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201016_163_168_1, approx. 977430 rows starting from 0
word] 2020.11.12 16:40:55.189455 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201016_169_174_1, approx. 1002560 rows starting from 0
word] 2020.11.12 16:40:55.189500 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201016_175_180_1, approx. 929821 rows starting from 0
word] 2020.11.12 16:40:55.189547 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201017_1_139_3, approx. 22835830 rows starting from 0
word] 2020.11.12 16:40:55.189590 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201017_140_144_1, approx. 735423 rows starting from 0
word] 2020.11.12 16:40:55.189638 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201018_1_144_3, approx. 23674358 rows starting from 0
word] 2020.11.12 16:40:55.189675 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201018_145_145_0, approx. 73728 rows starting from 0
word] 2020.11.12 16:40:55.189722 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201019_1_142_3, approx. 23217133 rows starting from 0
word] 2020.11.12 16:40:55.189767 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201020_1_140_3, approx. 23800352 rows starting from 0
word] 2020.11.12 16:40:55.189810 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201020_141_145_1, approx. 759844 rows starting from 0
word] 2020.11.12 16:40:55.189857 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201021_1_151_3, approx. 27342173 rows starting from 0
word] 2020.11.12 16:40:55.189901 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201021_152_157_1, approx. 1087219 rows starting from 0
word] 2020.11.12 16:40:55.189948 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201021_158_161_1, approx. 725508 rows starting from 0
word] 2020.11.12 16:40:55.189992 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201022_1_155_3, approx. 26192190 rows starting from 0
word] 2020.11.12 16:40:55.190035 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201022_156_185_2, approx. 5000307 rows starting from 0
word] 2020.11.12 16:40:55.190083 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201023_1_153_3, approx. 25485762 rows starting from 0
word] 2020.11.12 16:40:55.190121 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201023_154_185_2, approx. 5419171 rows starting from 0
word] 2020.11.12 16:40:55.190165 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201024_1_153_3, approx. 26615384 rows starting from 0
word] 2020.11.12 16:40:55.190212 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201024_154_185_2, approx. 5631006 rows starting from 0
word] 2020.11.12 16:40:55.190261 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201025_1_34_2, approx. 5888552 rows starting from 0
word] 2020.11.12 16:40:55.190308 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201025_35_68_2, approx. 5896478 rows starting from 0
word] 2020.11.12 16:40:55.190359 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201025_69_100_2, approx. 5414977 rows starting from 0
word] 2020.11.12 16:40:55.190401 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201025_101_130_2, approx. 5089544 rows starting from 0
word] 2020.11.12 16:40:55.190455 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201026_1_34_2, approx. 5522846 rows starting from 0
word] 2020.11.12 16:40:55.190502 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201026_35_66_2, approx. 5201498 rows starting from 0
word] 2020.11.12 16:40:55.190548 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201026_67_98_2, approx. 5170199 rows starting from 0
word] 2020.11.12 16:40:55.190590 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201026_99_104_1, approx. 991834 rows starting from 0
word] 2020.11.12 16:40:55.190634 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201026_105_110_1, approx. 881262 rows starting from 0
word] 2020.11.12 16:40:55.190680 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201027_1_143_3, approx. 24005225 rows starting from 0
word] 2020.11.12 16:40:55.190724 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201027_144_144_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.190771 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201027_145_145_0, approx. 77824 rows starting from 0
word] 2020.11.12 16:40:55.190820 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201028_1_155_3, approx. 26892691 rows starting from 0
word] 2020.11.12 16:40:55.190862 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201028_156_185_2, approx. 5188434 rows starting from 0
word] 2020.11.12 16:40:55.190909 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201029_63_95_2, approx. 5235243 rows starting from 0
word] 2020.11.12 16:40:55.190955 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201029_96_123_2, approx. 4504015 rows starting from 0
word] 2020.11.12 16:40:55.190999 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201030_1_34_2, approx. 5376352 rows starting from 0
word] 2020.11.12 16:40:55.191035 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201030_35_67_2, approx. 5209261 rows starting from 0
word] 2020.11.12 16:40:55.191082 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201030_68_73_1, approx. 983929 rows starting from 0
word] 2020.11.12 16:40:55.191128 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201030_74_78_1, approx. 665192 rows starting from 0
word] 2020.11.12 16:40:55.191173 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201031_1_149_3, approx. 25685580 rows starting from 0
word] 2020.11.12 16:40:55.191219 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201031_150_155_1, approx. 1032235 rows starting from 0
word] 2020.11.12 16:40:55.191267 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201031_156_160_1, approx. 859465 rows starting from 0
word] 2020.11.12 16:40:55.191309 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201101_1_172_3, approx. 31860630 rows starting from 0
word] 2020.11.12 16:40:55.191354 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201101_173_206_2, approx. 6400101 rows starting from 0
word] 2020.11.12 16:40:55.191401 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201101_207_212_1, approx. 1128515 rows starting from 0
word] 2020.11.12 16:40:55.191444 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201101_213_213_0, approx. 192512 rows starting from 0
word] 2020.11.12 16:40:55.191483 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201101_214_214_0, approx. 192512 rows starting from 0
word] 2020.11.12 16:40:55.191531 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201101_215_215_0, approx. 126976 rows starting from 0
word] 2020.11.12 16:40:55.191581 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201102_1_34_2, approx. 5472978 rows starting from 0
word] 2020.11.12 16:40:55.191626 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201102_35_68_2, approx. 5597397 rows starting from 0
word] 2020.11.12 16:40:55.191672 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201102_69_100_2, approx. 5193889 rows starting from 0
word] 2020.11.12 16:40:55.191717 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201102_101_130_2, approx. 4763884 rows starting from 0
word] 2020.11.12 16:40:55.191762 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_1_29_2, approx. 4905557 rows starting from 0
word] 2020.11.12 16:40:55.191810 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_30_62_2, approx. 5310767 rows starting from 0
word] 2020.11.12 16:40:55.191856 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_63_94_2, approx. 5274403 rows starting from 0
word] 2020.11.12 16:40:55.191902 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_95_100_1, approx. 1028766 rows starting from 0
word] 2020.11.12 16:40:55.191938 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_101_101_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.191987 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_102_102_0, approx. 172032 rows starting from 0
word] 2020.11.12 16:40:55.192030 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201103_103_103_0, approx. 118784 rows starting from 0
word] 2020.11.12 16:40:55.192076 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201104_1_30_2, approx. 4772045 rows starting from 0
word] 2020.11.12 16:40:55.192122 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201105_1_34_2, approx. 5668200 rows starting from 0
word] 2020.11.12 16:40:55.192165 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201105_35_67_2, approx. 5234985 rows starting from 0
word] 2020.11.12 16:40:55.192211 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201105_68_73_1, approx. 856051 rows starting from 0
word] 2020.11.12 16:40:55.192263 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201105_74_79_1, approx. 1029329 rows starting from 0
word] 2020.11.12 16:40:55.192306 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201105_80_85_1, approx. 1030464 rows starting from 0
word] 2020.11.12 16:40:55.192348 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201105_86_91_1, approx. 869091 rows starting from 0
word] 2020.11.12 16:40:55.192391 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201106_1_6_1, approx. 943112 rows starting from 0
word] 2020.11.12 16:40:55.192443 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201106_7_12_1, approx. 928942 rows starting from 0
word] 2020.11.12 16:40:55.192487 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201106_13_13_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.192536 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201106_14_14_0, approx. 163840 rows starting from 0
word] 2020.11.12 16:40:55.192578 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201106_15_15_0, approx. 139264 rows starting from 0
word] 2020.11.12 16:40:55.192622 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201107_1_156_3, approx. 25430701 rows starting from 0
word] 2020.11.12 16:40:55.192664 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201107_157_185_2, approx. 4656460 rows starting from 0
word] 2020.11.12 16:40:55.192711 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201108_1_153_3, approx. 25461596 rows starting from 0
word] 2020.11.12 16:40:55.192755 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201108_154_185_2, approx. 5294272 rows starting from 0
word] 2020.11.12 16:40:55.192799 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_1_150_3, approx. 26246338 rows starting from 0
word] 2020.11.12 16:40:55.192840 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_151_156_1, approx. 1082571 rows starting from 0
word] 2020.11.12 16:40:55.192883 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_157_162_1, approx. 1081289 rows starting from 0
word] 2020.11.12 16:40:55.192926 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_163_163_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.192973 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_164_164_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.193017 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_165_165_0, approx. 184320 rows starting from 0
word] 2020.11.12 16:40:55.193061 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201109_166_166_0, approx. 180224 rows starting from 0
word] 2020.11.12 16:40:55.193106 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201110_97_129_2, approx. 5388157 rows starting from 0
word] 2020.11.12 16:40:55.193153 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201110_130_161_2, approx. 5117950 rows starting from 0
word] 2020.11.12 16:40:55.193196 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201110_162_191_2, approx. 4691966 rows starting from 0
word] 2020.11.12 16:40:55.193242 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_16_186_3, approx. 31265616 rows starting from 0
word] 2020.11.12 16:40:55.193283 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_187_339_3, approx. 27183020 rows starting from 0
word] 2020.11.12 16:40:55.193328 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_340_518_3, approx. 31826904 rows starting from 0
word] 2020.11.12 16:40:55.193372 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_519_552_2, approx. 5954842 rows starting from 0
word] 2020.11.12 16:40:55.193417 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_553_696_3, approx. 25982330 rows starting from 0
word] 2020.11.12 16:40:55.193465 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_697_702_1, approx. 1100504 rows starting from 0
word] 2020.11.12 16:40:55.193512 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> MergeTreeSelectProcessor: Reading 1 ranges from part 20201111_703_703_0, approx. 65536 rows starting from 0
word] 2020.11.12 16:40:55.194354 [ 119074 ] {12acd7cc-5149-453a-97a6-f6772aad20a5} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
Row 1:
──────
_part:      20191001_1_28_2
_shard_num: 1
```

