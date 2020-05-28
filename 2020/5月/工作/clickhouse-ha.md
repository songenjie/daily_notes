方案三：
多集群：验证不可行，做不到HA，节点故障，集群不可用



优缺点
方案一与方案二互为优缺点

1. 优点
- 多进程管理

- 单进程down数据 只需要恢复一个副本，click-ha by database 需要恢复一个node ,三个副本

- 相对 click-ha by database 可以建立多个database， 从database 层隔离,clickhouse by database,database 在单个集群已经固定



2. 缺点
- 缺点，进程数目太多，占用机器端口太多，管理元数据增多

- 部署相对复杂, 每个进程配置都不相同

- Distributed 表也需要建 总的副本数据,也即是进程数,是 click-ha by database 的三倍
