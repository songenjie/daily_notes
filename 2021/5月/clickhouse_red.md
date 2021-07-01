page cache 

http 300ms





cache 是一种机制



按照月 按照年 存储





首先cache 只是一种机制



Clickhouse存算分离下一步优化点
1、读取文件建立连接200ms，文件读取10MB/s，是否有优化空间
2、并行读取更多优化点，目标：降低CPU负载，提高查询效率，并且不影响写入）
3、缓存策略优化点，当前只做了简单Disk LRU策略，是否有其他策略
4、其他方向（预读、）







mergetreerangereader对应一个 mergetreeReader ，是否可以对应多个
