1 数据要放好

2 缓存

3 预计算











\1. 数据放好，就是我们的分区分片策略

\2. 依赖于根据之前查询的结果 快速回答查询的能力





\1. 为了使的缓存有效，-





1 query cache

2 partition cache 

3 tablet(bucket) cache





result_cache_hits

result_cache_misses

result_cache_entries

result_cache_size_in_bytes

result_cache_evictions

result_cache_timeouts

result_cache_errors



| result_cache_ttl 变量设置在用户Session中，用户可自定义是否开启,通过ttl时间来确定用户的sql是否使用缓存，`这里数据变更时不保证数据的正确性` |      |                                                              |
| ------------------------------------------------------------ | ---- | ------------------------------------------------------------ |
|                                                              |      |                                                              |
|                                                              |      | 按照 用户 connectid,和查询的sql 来存储和获取缓存，超过缓存失效时间则命中不了缓存，该缓存也会被清理 |



| **` result_cache_version`** |      |                                                              |
| --------------------------- | ---- | ------------------------------------------------------------ |
|                             |      |                                                              |
|                             |      | result_cache_version 按SQL的签名、查询的表的分区ID、分区最新版本来存储和获取缓存。三者组合确定一个缓存数据集，任何一个变化了，如SQL有变化，如查询字段或条件不一样，或数据更新后版本变化了，会导致命中不了缓存。 |
|                             |      |                                                              |
|                             |      | 如果多张表Join，使用最近更新的分区ID和最新的版本号，如果其中一张表更新了，会导致分区ID或版本号不一样，也一样命中不了缓存。 |





| **分区缓存 `partition_cache`** |      |                                                              |
| ------------------------------ | ---- | ------------------------------------------------------------ |
|                                |      |                                                              |
|                                |      | 1. SQL可以并行拆分，Q = Q1 ∪ Q2 ... ∪ Qn，R= R1 ∪ R2 ... ∪ Rn，Q为查询语句，R为结果集 |
|                                |      |                                                              |
|                                |      | 2. 拆分为只读分区和可更新分区，只读分区缓存，更新分区不缓存  |



| - BE最大分区数量cache_max_partition_count，指每个SQL对应的最大分区数，如果是按日期分区，能缓存2年多的数据，假如想保留更长时间的缓存，请把这个参数设置得更大，同时修改cache_result_max_row_count的参数。 |      |                                                              |
| ------------------------------------------------------------ | ---- | ------------------------------------------------------------ |
|                                                              |      |                                                              |
|                                                              |      | ```                                                          |
|                                                              |      | cache_max_partition_count                                    |
|                                                              |      | ```                                                          |
|                                                              |      |                                                              |
|                                                              |      |                                                              |
|                                                              |      |                                                              |
|                                                              |      | - BE中缓存内存设置，有两个参数cache_max_size_in_mb和cache_elasticity_size_in_mb），内存超过cache_max_size_in_mb+cache_elasticity_size_in_mb会开始清理，并把内存控制到cache_max_size_in_mb以下。可以根据BE节点数量，节点内存大小，和缓存命中率来设置这两个参数。 |
|                                                              |      |                                                              |
|                                                              |      | ```                                                          |
|                                                              |      | cache_max_size_in_mb=256                                     |
|                                                              |      |                                                              |
|                                                              |      | cache_elasticity_size_in_mb=128                              |





1. 数据只是存起来是没有用的
2. 数据存好的情况下 可能会有用
3. 数据分析是有用的
4. 基于数据分析做数据存储才是我们的目的



### 查询缓存相关参数

```ruby
query_cache_limit :  MySQL能够缓存的最大查询结果；如果某查询的结果大小大于此值，则不会被缓存；
query_cache_min_res_unit : 查询缓存中分配内存的最小单位；(注意：此值通常是需要调整的，此值被调整为接近所有查询结果的平均值是最好的)
                           计算单个查询的平均缓存大小：（query_cache_size-Qcache_free_memory）/Qcache_queries_in_cache
query_cache_size : 查询缓存的总体可用空间，单位为字节；其必须为1024的倍数；
query_cache_type: 查询缓存类型；是否开启缓存功能，开启方式有三种{ON|OFF|DEMAND}；
query_cache_wlock_invalidate : 当其它会话锁定此次查询用到的资源时，是否不能再从缓存中返回数据；（OFF表示可以从缓存中返回数据）
```



### 查询缓存相关参数

与缓存功能相关的服务器变量：



```ruby
mysql> SHOW GLOBAL VARIABLES LIKE 'query_cache%';
+------------------------------+----------+
| Variable_name                | Value    |
+------------------------------+----------+
| query_cache_limit            | 1048576  |
| query_cache_min_res_unit     | 4096     |
| query_cache_size             | 16777216 |
| query_cache_strip_comments   | OFF      |
| query_cache_type             | ON       |
| query_cache_wlock_invalidate | OFF      |
+------------------------------+----------+
```

变量说明：



```ruby
query_cache_limit :  MySQL能够缓存的最大查询结果；如果某查询的结果大小大于此值，则不会被缓存；
query_cache_min_res_unit : 查询缓存中分配内存的最小单位；(注意：此值通常是需要调整的，此值被调整为接近所有查询结果的平均值是最好的)
                           计算单个查询的平均缓存大小：（query_cache_size-Qcache_free_memory）/Qcache_queries_in_cache
query_cache_size : 查询缓存的总体可用空间，单位为字节；其必须为1024的倍数；
query_cache_type: 查询缓存类型；是否开启缓存功能，开启方式有三种{ON|OFF|DEMAND}；
query_cache_wlock_invalidate : 当其它会话锁定此次查询用到的资源时，是否不能再从缓存中返回数据；（OFF表示可以从缓存中返回数据）
```

## 关闭查询缓存

关闭查询缓存，需要以下两步：

> 1. 将query_cache_type设置为OFF。

1. 将查询缓存的大小设置为0，这样才会真正不缓存数据。

<font color=red >**注意:**</font> 即便query_cache_size = 0，但 query_cache_type 非 0 的话，在实际环境中，可能会频繁发生报错：Waiting for query cache lock 。

## 查询缓存状态

### 1、与缓存相关的状态变量

不能也无需修改这些状态数据。



```ruby
mysql> SHOW  GLOBAL STATUS  LIKE  'Qcache%';
+-------------------------+----------+
| Variable_name            | Value   |
+-------------------------+----------+
| Qcache_free_blocks       | 1       | #查询缓存中的空闲块
| Qcache_free_memory       | 16759656| #查询缓存中尚未使用的空闲内存空间
| Qcache_hits              | 16      | #缓存命中次数
| Qcache_inserts           | 71      | #向查询缓存中添加缓存记录的条数
| Qcache_lowmem_prunes     | 0       | #表示因缓存满了而不得不清理部分缓存以存储新的缓存，这样操作的次数。若此数值过大，则表示缓存空间太小了。
| Qcache_not_cached        | 57      | #没能被缓存的次数
| Qcache_queries_in_cache  | 0       | #此时仍留在查询缓存的缓存个数
| Qcache_total_blocks      | 1       | #共分配出去的块数
+-------------------------+----------+
```

### 2、衡量缓存是否有效

#### 缓存命中率的计算（次数）



```ruby
mysql> SHOW GLOBAL STATUS WHERE Variable_name='Qcache_hits' OR Variable_name='Com_select';
+---------------+-----------+
| Variable_name | Value |
+---------------+-----------+
| Com_select    | 279292490 | #非缓存查询次数
| Qcache_hits   | 307366973 | # 缓存命中次数
+---------------+-----------
```

> 缓存命中率：Qcache_hits/(Qcache_hits+Com_select)

#### “命中和写入”的比率

这是另外一种衡量缓存是否有效的指标。



```ruby
mysql> SHOW GLOBAL STATUS WHERE Variable_name='Qcache_hits' OR Variable_name='Qcache_inserts';
+----------------+-----------+
| Variable_name  | Value     |
+----------------+-----------+
| Qcache_hits | 307416113    | #缓存命中次数
| Qcache_inserts | 108873957 | #向查询缓存中添加缓存记录的条数
+----------------+-----------+
```

> “命中和写入”的比率: Qcache_hits/Qcache_inserts # 如果此比值大于3:1, 说明缓存也是有效的；如果高于10:1，相当理想；



作者：hjqjk
链接：https://www.jianshu.com/p/5c3ddf9a454c
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。





`query_cache_size`：设置Query Cache所使用的内存大小，默认值为0，大小必须是1024的整数倍，如果不是整数倍，MySQL会自动调整降低最小量以达到1024的倍数。

`query_cache_type`：控制Query Cache功能的开关，可以设置为0(OFF)，1(ON)和2(DEMAND)三种：0表示关闭Query Cache功能，任何情况下都不会使用Query Cache；1表示开启Query Cache功能，但是当SELECT语句中使用的SQL_NO_CACHE提示后，将不使用Query Cache；2(DEMAND)表示开启Query Cache功能，但是只有当SELECT语句中使用了SQL_CACHE提示后，才使用Query Cache。

`query_cache_limit`：允许Cache的单条Query结果集的最大容量，默认是1MB，超过此参数设置的Query结果集将不会被Cache。

`query_cache_min_res_unit`：设置Query Cache中每次分配内存的最小空间大小，也就是每个Query的Cache最小占用的内存空间大小。

`query_alloc_block_size`：缓存的块大小，默认为8192字节。

`query_cache_wlock_invalidate`：控制当有写锁加在表上的时候，是否先让该表相关的Query Cache失效，1(TRUE)，在写锁定的同时将使该表相关的所有Query Cache 失效。0(FALSE)，在锁定时刻仍然允许读取该表相关的Query Cache。

`Qcache_lowmem_prunes`：这是一个状态变量(show status)，当缓存空间不够需要释放旧的缓存时，该值会自增。

`Qcache_free_blocks`：目前还处于空闲状态的Query Cache中内存Block数目。

`Qcache_free_memory`：目前还处于空闲状态的Query Cache内存总量。

`Qcache_hits`：Query Cache命中次数。

`Qcache_inserts`：向Query Cache中插入新的Query Cache的次数，也就是没有命中的次数。

`Qcache_lowmem_prunes`：当Query Cache内存容量不够，需要从中删除老的Query Cache以给新的Cache对象使用的次数。

`Qcache_not_cached`：没有被Cache的SQL数，包括无法被Cache的SQL以及由于query_cache_type设置的不会被Cache 的 SQL。

`Qcache_queries_in_cache`：目前在Query Cache中的SQL数量。

`Qcache_total_blocks`：Query Cache中总的Block数量。





