https://zhuanlan.zhihu.com/p/41153588





```mysql
ATTACH TABLE IF NOT EXISTS system.tables_dis ON CLUSTER system_cluster AS system.tables
ENGINE = Distributed('system_cluster', 'system', 'tables', rand());


select database, name, storage_policy from system.tables_dis  where engine='ReplicatedMergeTree' and storage_policy!='jdob_ha';
```





1. 导入数据集群压力大 在追数据

2. 机器挂了 下线

3. 节点挂了 重启

4. 建表

5. 告警 业务方提供的 比较慢
6. 副本不一致的问题
7. 存储策略的问题

8. 写入 znode





系统参数

zookeeper 参数调整

clickhouse 参数调整



节点内存挂了 重启了 起不来的问题 ，可以正常启动





