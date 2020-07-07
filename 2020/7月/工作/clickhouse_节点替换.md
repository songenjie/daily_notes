```
# 关键点
1. 节点替换，所有配置下发更新
2. 新建部署，就节点下线
3. 旧的节点清理，
4. 新的节点 需要将表重新构建一遍
  - 1 IF NOT EXISTS 因为只有当前节点需要重现传技感
  - 2 on cluster 这样可以在任意节点创建，新的节点三个进程一次就可以创建完成
  
5. 数据确认

CREATE TABLE IF NOT EXISTS database.table_name on cluster cluster_name 
(
    `doc_id` String, 
    `doc_name` String, 
    `doc_code` String, 
    `domain_type_cd` String, 
    `user_log_acct` String, 
    `created_tm` String, 
)
ENGINE = ReplicatedMergeTree('/clickhouse/jdolap_ck_04/jdob_ha/{shard}/database/tablename', '{replica}')
PRIMARY KEY doc_id
ORDER BY doc_id
SETTINGS storage_policy = 'jdob_ha', index_granularity = 8192；


./zlCli.sh -server zookeeperip:port


rmr /clickhouse/jdolap_ck_04/jdob_ha/ods/08/ods_m04_ord_det_sum_new_local/replicas/03
要将替换节点在zookeeper 中存储的数据删除
```



