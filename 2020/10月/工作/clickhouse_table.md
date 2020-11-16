1. 为什么 需要新建表
2. on cluster create table 
3. 探测表是否存在 system.tables 里面是存在这个表，一些节点，这个本地表是没有写入，zk没有同步
4. 线程池的数量 改大
5. 创建表 在所有表探测（是怎么探测的）
6. 今天改的，原来是on cluster drop table,换成了所有的节点执行
7. 下线分区，然后drop 
8. 删除数据是有影响
9. 每天的数据 都是大数据量 量控制下
10. 经济型的方案









1 drop partition 
