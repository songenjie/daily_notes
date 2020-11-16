

# 1. 各种方式对比

| 方式              | 优点                                                         | 缺点                                                         |
| :---------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 直接操作PARTITION | 1. 操作简单；                                                | 1. 不能跨集群；2. 操作较繁琐；3. 每次只能操作单个表；        |
| remote函数        | 1. 操作简单；2. 可以跨集群；                                 | 1. 只适用于数据量小、节点数少的场景；2. 执行失败需要手动重试；3. 每次只能操作单个表； |
| clickhouse-copier | 1. 可以跨集群；2. 适合大批量数据的场景；3. 多个库表可以同时迁移；4. 支持多实例执行，加速迁移进度； | 1. 依赖于zookeeper；2. 配置较复杂；                          |

# 2. 迁移方式



如果只有一个表并且数据量小于40G建议直接用PARTITION操作，或者用remote函数。

如果数据量较大，或有多张表，建议用clickhouse-copier迁移。

## 2.1 直接操作PARTITION

```
-- 下线partition``alter` `table` `db.``table` `DETACH PARTITION [partition_expr];``-- 备份partition``alter` `table` `db.``table` `FREEZE PARTITION [partition_expr];``-- 上线partition``alter` `table` `db.``table` `ATTACH PARTITION [partition_expr];``-- 拉取远程partition``ALTER` `TABLE` `db.``table` `FETCH` `PARTITION partition_expr ``FROM` `'path-in-zookeeper'``;``...
```

详细请参考：https://clickhouse.tech/docs/en/sql-reference/statements/alter/partition/

## 2.2 remote函数

```
-- 指定CK的host:port，db, table，以及user, password；``-- 注意这里的port是ck的TCP端口``INSERT` `INTO` `dest_table ``SELECT` `* ``FROM` `remote(``'host:port'``, ``'db'``, ``'table'``, ``'user_name'``, ``'password'``);
```

详细请参考：https://clickhouse.tech/docs/en/sql-reference/table-functions/remote/

## 2.3 clickhouse-copier

```
clickhouse-copier支持跨集群迁移大批量数据，但是它只能迁移*MergeTree系列引擎的表，不支持其余的表（包括Distributed）。
```

具体步骤请仔细阅读如下内容：

### 2.3.1 基础配置

需要准备一个zookeeper集群（不建议跟源或目标集群混用），然后在base.xml里设置好zk和clickhouse-copier的日志参数。

**base.xml**

```
<``yandex``>``  ``<``logger``>``    ``<``level``>information</``level``>``    ``<``size``>200M</``size``>``    ``<``count``>20</``count``>``  ``</``logger``>` `  ``<``zookeeper``>``    ``<``node` `index``=``"1"``>``     ``<``host``>192.168.3.2</``host``>``     ``<``port``>2181</``port``>``    ``</``node``>``    ``<``node` `index``=``"2"``>``     ``<``host``>192.168.3.3</``host``>``     ``<``port``>2181</``port``>``    ``</``node``>``    ``<``node` `index``=``"3"``>``     ``<``host``>192.168.3.4</``host``>``     ``<``port``>2181</``port``>``    ``</``node``>``  ``</``zookeeper``>``</``yandex``>
```

### 2.3.2 task的配置（重要）

这个是需要迁移任务的描述信息，需要仔细配置好，再启动。

**task_batch01.xml**

```
<``yandex``>``  ``<``remote_servers``>``    ``<``perftest_3shards_2replicas``>``      ``<!-- 源集群定义，建议把所有的节点都加上，这样可以分散压力 -->``      ``<``shard``>``        ``<``internal_replication``>true</``internal_replication``>``        ``<``replica``>``          ``<``host``>192.168.1.3</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>``        ``<``replica``>``          ``<``host``>192.168.1.4</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>``      ``</``shard``>``      ``<``shard``>``        ``.....        ``      ``</``shard``>``      ``.....``    ``</``perftest_3shards_2replicas``>``    ``<``ZYX_CK_Pub_01``>``      ``<!-- 目标集群定义，建议把所有的节点都加上。因为每个shard指定所有的replicas时clickhouse-copier会确保replica的数据同步完成，而且对速度基本没有影响 -->``      ``<``shard``>``        ``<``internal_replication``>true</``internal_replication``>``        ``<``replica``>``          ``<``host``>192.168.2.3</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>``        ``<``replica``>``          ``<``host``>192.168.2.4</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>` `      ``</``shard``>``      ``<``shard``>``        ``.....        ``      ``</``shard``>` `      ``.....``    ``</``ZYX_CK_Pub_01``>``  ``</``remote_servers``>`` ` `  ``<!-- 多个clickhouse-copier可以同时为一个task并行工作，以加快迁移速度，这里是最大的clickhouse-copier个数 -->``  ``<``max_workers``>50</``max_workers``>``  ``<``settings``>``    ``<``readonly``>0</``readonly``>``    ``<``connect_timeout``>30</``connect_timeout``>``    ``<!-- receive_timeout和send_timeout默认是300s，如果单个partition太大可以考虑增大到600或1200s -->``    ``<``receive_timeout``>300</``receive_timeout``>``    ``<``send_timeout``>300</``send_timeout``>``    ``<``insert_distributed_sync``>1</``insert_distributed_sync``>``  ``</``settings``>``  ``<``settings_pull``>``    ``<!-- 源集群只读 -->``    ``<``readonly``>1</``readonly``>``  ``</``settings_pull``>``  ``<``settings_push``>``    ``<!-- 目标集群可写 -->``    ``<``readonly``>0</``readonly``>``  ``</``settings_push``>`` ` `  ``<``tables``>``    ``<``my_table01``>``      ``<!-- 源库、表信息，只能是*MegeTree系列引擎的表 -->``      ``<``cluster_pull``>perftest_3shards_2replicas</``cluster_pull``>``      ``<``database_pull``>origin_database</``database_pull``>``      ``<``table_pull``>origin_table</``table_pull``>`` ` `      ``<!-- 目标库、表信息 -->``      ``<``cluster_push``>ZYX_CK_Pub_01</``cluster_push``>``      ``<``database_push``>dest_database</``database_push``>``      ``<``table_push``>dest_table</``table_push``>`` ` `      ``<!-- 目标表的引擎设置，非常重要！！``        ``1. 一定记得添加存储策略： SETTINGS storage_policy = 'jdob_ha';``        ``2. 其余配置可以参考源表设置；``      ``-->``      ``<``engine``>ENGINE = ReplicatedMergeTree('/tables/dest_db/dest_table/{shard}', '{replica}') PARTITION BY dateTime ORDER BY (dateTime, shopType) SETTINGS storage_policy = 'jdob_ha', index_granularity = 8192</``engine``>`` ` `      ``<!-- clickhouse-copier迁移数据时的sharding策略，重要！``        ``1. 这个参数与Distributed表无关，clickhouse-copier不操作Distributed表，Distributed表需自己手动创建；``        ``2. 建议设置为日期和表名相关，这样可以最大化集群的效率，同时避免同一天都落到一个shard，从而出现618这种单日数据量暴涨压垮某个shard；``      ``-->``      ``<``sharding_key``>toRelativeDayNum(toDate(dateTime)) + cityHash64('dest_table')</``sharding_key``>`` ` `      ``<!-- 非常重要！！ clickhouse-copier会把partition切分为number_of_splits个piece，然后以piece为最小单位进行迁移。``        ``默认值为10，多数情况下不太合理，经测试建议把一个piece的原始数据量（data_uncompressed_bytes）控制在40GB以内，单partition小于40G时这个参数建议设置为1``      ``-->``      ``<``number_of_splits``>1</``number_of_splits``>`` ` `      ``<!-- 强烈建议设置，只迁移所需要的partition，不设置的话默认所有的partition，partition越多clickhouse-copier启动检查partition时就越慢 -->``      ``<``enabled_partitions``>``        ``<``partition``>'2020-03-21'</``partition``>``        ``<``partition``>'2020-03-22'</``partition``>``      ``</``enabled_partitions``>``    ``</``my_table01``>``    ``<``my_table02``>``      ``....``    ``</``my_table02``>``  ``</``tables``>``</``yandex``>
```

### 2.3.3 上传task配置到zookeeper

 这一步，用任何可以操作zookeeper的工具把上面这个task_batch01.xml到某个目录下名为description的node里，注意description的父目录即后面copier启动时指定的**--task-path**，

```
.``/upload_to_zk``.sh task_batch01
```

下面是`upload_to_zk``.sh的`一个example：

**upload_to_zk.sh** Expand source

### 2.3.4 启动clickhouse-copier

```
nohup` `clickhouse copier --config base.xml --task-path ``/transfer/task_batch01` `&
```

注意：

\1. 建议clickhouse-copier在后台执行；

\2. 数据量较大时建议多个机器上同时并行跑，每个机器跑多实例；

### 2.3.5 观察迁移进度

迁移进度建议连上目标集群查看partition情况，同时要关注[ck监控](http://baizegra.jd.com/d/HyAPFhiGj/clickhouse-core-baize?orgId=6)；

### 2.3.6 清理zk数据

迁移结束后记得清理zookeeper的数据，clickhouse-copier不会自动清理。