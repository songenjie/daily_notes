```
CREATE TABLE IF NOT EXISTS jason.ods_afs_afs_service_chain_local ON CLUSTER clustername
(
    `afs_service_id` Int64, 
    `afs_apply_id` Int64, 
    `afs_apply_time` DateTime, 
    `afs_category_id` Int64, 
    `afs_service_step` Int32, 
    `afs_service_state` Int32, 
    `platform_src` Int32, 
    `order_id` Int64, 
    `order_type` Int32, 
    `order_remark` String, 
    `is_has_invoice` Int32, 
    `invoice_code` String, 
    `time_type_title` Int32, 
    `invoice_time` String, 
    `time_priority` Int64, 
    `customer_expect` Int32, 
    `refund_type` Int32, 
    `change_sku` Int64, 
    `question_type_cid1` Int32, 
    `question_type_cid2` Int32, 
    `question_desc` String, 
    `is_need_detection_report` Int32, 
    `is_customer_uploade` Int32, 
    `question_pic` String, 
    `is_has_package` Int32, 
    `package_desc` Int32, 
    `customer_pin` String, 
    `customer_name` String, 
    `customer_grade` Int32, 
    `pickware_type` Int32, 
    `pickware_province` Int64, 
    `pickware_city` Int64, 
    `pickware_county` Int64, 
    `pickware_village` Int64, 
    `reserve_date` String, 
    `company_id` Int64, 
    `returnware_type` Int32, 
    `returnware_province` Int64, 
    `returnware_city` Int64, 
    `returnware_county` Int64, 
    `returnware_village` Int64, 
    `approve_pin` String, 
    `approve_name` String, 
    `approve_result` Int32, 
    `approve_reson_cid1` Int32, 
    `approve_reson_cid2` Int32, 
    `approved_date` String, 
    `approve_notes` String, 
    `process_pin` String, 
    `process_name` String, 
    `process_result` Int32, 
    `process_notes` String, 
    `processed_date` String, 
    `create_date` String, 
    `create_name` String, 
    `update_date` String, 
    `update_name` String, 
    `sys_version` Int64, 
    `yn` Int32, 
    `fetch_date` String, 
    `receive_date` String, 
    `neworder_id` Int64, 
    `buid` String, 
    `ware_id` Int64, 
    `crm_case_id` Int64, 
    `ts` String, 
    `parent_service` Int64, 
    `service_count` Int32, 
    `category_source` Int32
)
ENGINE = ReplicatedMergeTree('/clickhouse/clustername/jdob_ha/ods/ods_afs_afs_service_chain_local/{shard}', '{replica}')
PARTITION BY toYYYYMMDD(afs_apply_time)
PRIMARY KEY afs_service_id
ORDER BY (afs_service_id, afs_apply_time, ware_id)
SETTINGS storage_policy = 'jdob_ha', index_granularity = 8192
```





ENGINE = ReplicatedMergeTree('/clickhouse/clustername/jdob_ha/ods/ods_afs_afs_service_chain_local/{shard}', '{replica}') 便于 z k 维护





数据tmp 生效

```
2020.07.21 14:16:53.247519 [ 108883 ] {} <Trace> SystemLog (system.trace_log): Flushing system log
2020.07.21 14:16:53.247824 [ 108883 ] {} <Debug> DiskLocal: Reserving 1.00 MiB on disk `default`, having unreserved 5.18 TiB.
2020.07.21 14:16:53.248308 [ 108883 ] {} <Trace> system.trace_log: Renaming temporary part tmp_insert_202007_1081_1081_0 to 202007_1081_1081_0.
2020.07.21 14:16:53.248448 [ 109602 ] {} <Trace> system.trace_log: Found 4 old parts to remove.
2020.07.21 14:16:53.248464 [ 109602 ] {} <Debug> system.trace_log: Removing part from filesystem 202007_1_1011_540
2020.07.21 14:16:53.248735 [ 109602 ] {} <Debug> system.trace_log: Removing part from filesystem 202007_1_1012_541
2020.07.21 14:16:53.248930 [ 109602 ] {} <Debug> system.trace_log: Removing part from filesystem 202007_1012_1012_0
2020.07.21 14:16:53.249093 [ 109602 ] {} <Debug> system.trace_log: Removing part from filesystem 202007_1013_1013_0
2020.07.21 14:16:53.249445 [ 109602 ] {} <Debug> system.trace_log (MergerMutator): Selected 2 parts from 202007_1_1076_605 to 202007_1077_1077_0
2020.07.21 14:16:53.249470 [ 109602 ] {} <Debug> DiskLocal: Reserving 1.00 MiB on disk `default`, having unreserved 5.18 TiB.
2020.07.21 14:16:53.249487 [ 109602 ] {} <Debug> system.trace_log (MergerMutator): Merging 2 parts: from 202007_1_1076_605 to 202007_1077_1077_0 into tmp_merge_202007_1_1077_606 with type Compact
2020.07.21 14:16:53.249508 [ 109602 ] {} <Debug> system.trace_log (MergerMutator): Selected MergeAlgorithm: Horizontal
2020.07.21 14:16:53.249537 [ 109602 ] {} <Trace> MergeTreeSequentialSource: Reading 2 marks from part 202007_1_1076_605, total 8070 rows starting from the beginning of the part
2020.07.21 14:16:53.249633 [ 109602 ] {} <Trace> MergeTreeSequentialSource: Reading 2 marks from part 202007_1077_1077_0, total 7 rows starting from the beginning of the part
2020.07.21 14:16:53.250965 [ 109602 ] {} <Debug> system.trace_log (MergerMutator): Merge sorted 8077 rows, containing 9 columns (9 merged, 0 gathered) in 0.00 sec., 5487248.96 rows/sec., 834.07 MB/sec.
2020.07.21 14:16:53.251896 [ 109602 ] {} <Trace> system.trace_log: Renaming temporary part tmp_merge_202007_1_1077_606 to 202007_1_1077_606.
2020.07.21 14:16:53.251946 [ 109602 ] {} <Trace> system.trace_log (MergerMutator): Merged 2 parts: from 202007_1_1076_605 to 202007_1077_1077_0
2020.07.21 14:16:54.896629 [ 108931 ] {} <Trace> MySQLHandlerFactory: MySQL connection. Id: 33877. Address: [::ffff:10.188.0.143]:9221

```

