1. segment 一批

2. 落盘时间间隔 进程重启的问题

3. 强制写文件 不落盘
4. Lucene sdk
5. 13个连接 最大连接数
6. http->tcp 





1. index table  每天 倒排
2. shard 并
3. lucene segment part



1. segment 不是单独文件

2. 数据更新 文件记录 查询的问题 锁串 top  mr

Top n的问题优化的情况 数据量



Node

1. Leader
2. 分片策略



Field:

1. keyword 

2. 索引
3. Stored field 
4. 字符串  数字kdtree lucene
5. 分布式

6. Stored field 行索引
7. DocValues 列索引





版本：

Raft

Redis 



写入：

1. Bulk  1000
2. Shard 5
3. shard master 
4. 写入 请求发送给各自的 都返回 完全主从 retry
5. 写入要求 



细节：

Segment :

1. indexWriter buffer。jvmbuffer
2. 粒度问题
3. 并行写入
4. Tranlog ES  ,写操作 限制 写入得到segment 
5. Flush 



状态：

jvm

commit

disk



Merge:

1. MergeThreadCount
2. segment 大小 Level ssd hdd
3. 





source segment 

segment max size 

max compaction size 



1T 10亿

写入

