# Clickhouse 总结





- 系统架构
- 数据模型
- 存储引擎
- 数据导入
- 查询
- 精确去重
- 运输局
- 性能
- HA
- 维护
- 部署



# 1 ROLE

![clickhouse big data role](/Users/songenjie/Project/songenjie/daily_notes/source/clickhouse_bitdata_role.png)





# 1 系统架构

数据始终是按列存储的，包括矢量（向量或列块）执行的过程。只要有可能，操作都是基于矢量进行分派的，而不是单个的值，这被称为«矢量化查询执行»，它有利于降低实际的数据处理开销。



列 字段 数据类型 block Table



![系统](/Users/songenjie/Project/songenjie/daily_notes/source/clickhouse_storage1.png)



# 存储

![Storage](/Users/songenjie/Project/songenjie/daily_notes/source/clickhouse_storage2.png)





# Table Storage

![Table](/Users/songenjie/Project/songenjie/daily_notes/source/clickhouse_table_storage.png)



