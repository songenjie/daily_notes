描述：插入表500+字段  50W数据可行！

100W数据报错



![img](https://img-blog.csdnimg.cn/201903141737504.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjYxODkwNw==,size_16,color_FFFFFF,t_70)

 

填坑：修改users.xml配置文件之

```
set max_bytes_before_external_group_by=20000000000; #20G
set max_memory_usage=40000000000; #40G
参数解析：默认情况下，ClickHouse会限制group by使用的内存量（它使用 hash table来处理group by）。
这很容易解决 - 如果你有空闲的内存，增加这个参数：
如果你没有那么多的内存可用，ClickHouse可以通过设置这个“溢出”数据到磁盘：
 
```

 

```
max_memory_usage详解：该设置不考虑可用内存量或机器上的总内存量。该限制适用于单个服务器中的单个查询，限制总users,
```

 

也就是说如果你内存够大，调整SET max_memory_usage这个参数。如果内存不够，

那么就加上这个参数set max_bytes_before_external_group_by

原因是聚合需要分两个阶段进行：1.查询并且建立中间数据 2.合并中间数据。 

数据“溢出”到磁盘一般发生在第一个阶段，如果没有发生数据“溢出”，ClickHouse在阶段1和阶段2可能需要相同数量的内存

```
 
```

 

据官方文档，如果需要使用max_bytes_before_external_group_by，

建议将max_memory_usage设置为max_bytes_before_external_group_by大小的两倍。

 

```
或者min_insert_block_size_rows=8192, min_insert_block_size_bytes （待测）
 
```

配置在users.xml里面的会被当作默认参数。当你的client没有指定这些参数的时候会使用默认参数

 

system库里面的表都不是复制表 直接set只会在当前server生效

问：所以每个若server节点多的话 每个都得set一下

回答：distribution查询的时候会传递的，最终这些set其实全部保存在client端。。随着每个query走的