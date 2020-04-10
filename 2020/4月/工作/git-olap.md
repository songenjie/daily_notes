### mpp 架构
master slive 

master 任务下发 查询计划


### 
slive 
存在 多副本

primary segment 正常工作的节点
mirror  segment 副本segment 

primary segment 所在的slive 节点挂掉
会在其对应的 mirror segment 对应的 slive 节点 将其恢复成为 primary segment 

进而执行操作 

那么集群就会不均衡 

## 查询
是并发的 无论是否设置了并发查询的线程数 最终查询都会落到 segment 层次

无论有多少台机器 线程执行的线程数目是不变的

所以查询取决于跑的最慢的节点

## 加减节点
灵活性差 数据需要重新分配

## hk
所以数据不均衡，会导致查询变慢



