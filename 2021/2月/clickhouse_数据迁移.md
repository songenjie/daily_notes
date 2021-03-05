# 1. 各种方式对比

| 方式              | 优点                                                         | 缺点                                                         |
| :---------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 直接操作PARTITION | 操作简单                                                     | 不能跨集群；每次只能操作单个表；操作多个表较繁琐；           |
| remote函数        | 操作简单；可以跨集群；                                       | 只适用于数据量小、节点数少的场景；执行失败需要手动重试；每次只能操作单个表； |
| clickhouse-copier | 可以跨集群；适合大批量数据的场景；多个库表可以同时迁移；支持多实例执行，加速迁移进度； | 依赖于zookeeper；配置较复杂；OLAP团队做了封装，加强了易用性  |
| 从Hive中重推一遍  | 服用已有的导数方式，比较简单                                 | 如果数据量太大，重推速度稍慢                                 |

# 2. 迁移方式

## 2.1 直接操作PARTITION

```
-- 下线partition``ALTER` `TABLE` `db.``table` `DETACH PARTITION [partition_expr];``-- 备份partition``ALTER` `TABLE` `db.``table` `FREEZE PARTITION [partition_expr];``-- 上线partition``ALTER` `TABLE` `db.``table` `ATTACH PARTITION [partition_expr];``-- 拉取远程partition``ALTER` `TABLE` `db.``table` `FETCH` `PARTITION partition_expr ``FROM` `'path_in_zookeeper'``;``...
```

详细请参考：https://clickhouse.tech/docs/en/sql-reference/statements/alter/partition/

## 2.2 remote函数

```
-- 指定CK的host:port，db, table，以及user, password；``-- 注意这里的port是ck的TCP端口，可以通过这个SQL查到： SELECT host_address, port FROM system.clusters;``INSERT` `INTO` `dest_table ``SELECT` `* ``FROM` `remote(``'host:port'``, ``'db'``, ``'table'``, ``'user_name'``, ``'password'``);
```

详细请参考：https://clickhouse.tech/docs/en/sql-reference/table-functions/remote/





如果只有一个表并且数据量小于40G建议直接用PARTITION操作，或者用remote函数。

如果数据量较大，或有多张表，建议用下面介绍的clickhouse-copier方式。

## 2.3 clickhouse-copier

clickhouse-copier支持跨集群迁移多个库、表的大批量数据，但是需要注意：

**1. 它不创建目标库（需手动提前创建）；**

**2. 只对\*MergeTree系列引擎的表进行表重建和数据同步；**

**3. 不支持其余的表引擎（包括Distributed，需手动重建）。**



我们提供了4台机器专门用于做CK-to-CK的数据迁移。

1. zookeeper集群： 10.199.137.165:2181；
2. 另外3个节点用于运行clickhouse-copier：
   1. 10.199.136.197
   2. 10.199.137.133
   3. 10.199.140.84
3. ssh账号密码分别为clickhouse/clickhouse；

请单独创建目录用于自己的迁移任务。

具体步骤请仔细阅读如下内容：

### 2.3.1 基础配置

需要准备一个zookeeper集群（可以自己搭，也可以用上面提供的，注意不建议跟源或目标集群混用），然后在base.xml里设置好zk和clickhouse-copier的日志参数，下面是个example：

**base.xml**

```
<``yandex``>``  ``<``logger``>``    ``<``level``>information</``level``>``    ``<``size``>200M</``size``>``    ``<``count``>20</``count``>``  ``</``logger``>` `  ``<``zookeeper``>``    ``<``node` `index``=``"1"``>``     ``<``host``>192.168.3.2</``host``>``     ``<``port``>2181</``port``>``    ``</``node``>``    ``<``node` `index``=``"2"``>``     ``<``host``>192.168.3.3</``host``>``     ``<``port``>2181</``port``>``    ``</``node``>``    ``<``node` `index``=``"3"``>``     ``<``host``>192.168.3.4</``host``>``     ``<``port``>2181</``port``>``    ``</``node``>``  ``</``zookeeper``>``</``yandex``>
```

### 2.3.2 task的配置（重要）

这个是需要迁移任务的描述信息，需要仔细配置好，再启动。下面是个example：

**task_batch01.xml**

```
<``yandex``>``  ``<``remote_servers``>``    ``<``perftest_3shards_2replicas``>``      ``<!-- 源集群定义，建议把所有的节点都加上，这样可以分散压力 -->``      ``<``shard``>``        ``<``internal_replication``>true</``internal_replication``>``        ``<``replica``>``          ``<``host``>192.168.1.3</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>``        ``<``replica``>``          ``<``host``>192.168.1.4</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>``      ``</``shard``>``      ``<``shard``>``        ``.....        ``      ``</``shard``>``      ``.....``    ``</``perftest_3shards_2replicas``>``    ``<``ZYX_CK_Pub_01``>``      ``<!-- 目标集群定义，建议把所有的节点都加上。跟每个shard只指定一个replica相比，指定所有的replicas时clickhouse-copier会确保所有replica的数据同步都完成，而且对速度基本没有影响 -->``      ``<``shard``>``        ``<``internal_replication``>true</``internal_replication``>``        ``<``replica``>``          ``<``host``>192.168.2.3</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>``        ``<``replica``>``          ``<``host``>192.168.2.4</``host``>``          ``<``port``>9000</``port``>``          ``<``user``>user1</``user``>``          ``<``password``>xxxx</``password``>``        ``</``replica``>` `      ``</``shard``>``      ``<``shard``>``        ``.....        ``      ``</``shard``>` `      ``.....``    ``</``ZYX_CK_Pub_01``>``  ``</``remote_servers``>`` ` `  ``<!-- 多个clickhouse-copier可以同时为一个task并行工作，以加快迁移速度，这里是clickhouse-copier的最大实例数，超过此配置的copier不work -->``  ``<``max_workers``>50</``max_workers``>``  ``<``settings``>``    ``<``readonly``>0</``readonly``>``    ``<``connect_timeout``>30</``connect_timeout``>``    ``<!-- receive_timeout和send_timeout默认是300s，如果单个partition太大可以考虑增大到600或1200s -->``    ``<``receive_timeout``>300</``receive_timeout``>``    ``<``send_timeout``>300</``send_timeout``>``    ``<``insert_distributed_sync``>1</``insert_distributed_sync``>``  ``</``settings``>``  ``<``settings_pull``>``    ``<!-- 源集群只读 -->``    ``<``readonly``>1</``readonly``>``  ``</``settings_pull``>``  ``<``settings_push``>``    ``<!-- 目标集群可写 -->``    ``<``readonly``>0</``readonly``>``  ``</``settings_push``>`` ` `  ``<``tables``>``    ``<``my_table01``>``      ``<!-- 源库、表信息，只能是*MegeTree系列引擎的表，其余引擎的表会直接报错 -->``      ``<``cluster_pull``>perftest_3shards_2replicas</``cluster_pull``>``      ``<``database_pull``>origin_database</``database_pull``>``      ``<``table_pull``>origin_table</``table_pull``>`` ` `      ``<!-- 目标库、表信息 -->``      ``<``cluster_push``>ZYX_CK_Pub_01</``cluster_push``>``      ``<``database_push``>dest_database</``database_push``>``      ``<``table_push``>dest_table</``table_push``>`` ` `      ``<!-- 目标表的引擎设置，非常重要！！``        ``1. 一定记得添加存储策略： SETTINGS storage_policy = 'jdob_ha';``        ``2. 其余配置可以参考源表设置；``      ``-->``      ``<``engine``>ENGINE = ReplicatedMergeTree('/tables/dest_db/dest_table/{shard}', '{replica}') PARTITION BY dateTime ORDER BY (dateTime, shopType) SETTINGS storage_policy = 'jdob_ha', index_granularity = 8192</``engine``>`` ` `      ``<!-- clickhouse-copier迁移数据时的sharding策略，重要！``        ``1. clickhouse-copier不操作Distributed表，Distributed表需自己手动创建，但是该参数建议配置为跟源集群对应Distributed表的sharding策略一致；``        ``2. 建议设置为日期和表名相关，这样可以最大化集群的效率，避免不同表同一天数据都落到一个shard，从而出现618这种单日数据量暴涨压垮某个shard的情况；``      ``-->``      ``<``sharding_key``>toRelativeDayNum(toDate(dateTime)) + cityHash64('dest_table')</``sharding_key``>`` ` `      ``<!-- 非常重要！！ clickhouse-copier会把partition切分为number_of_splits个piece，然后以piece为最小单位进行迁移。``        ``默认值为10，经测试，多数情况下不合理。此参数大了单piece数据太少会严重拖慢迁移进度，此参数小了单piece数据量太大可能会触发ck的各种限制导致需要返工。推荐：``        ``1. 单partition原始数据量小于40G（system.parts的data_uncompressed_bytes）时这个参数建议设置为1；``        ``2. 单partition原始数据量大于40G时，把一个piece的原始数据量控制在40GB以内；``      ``-->``      ``<``number_of_splits``>1</``number_of_splits``>`` ` `      ``<!-- 强烈建议设置，只迁移所需要的partition，不设置的话默认所有的partition，partition越多clickhouse-copier启动检查partition时就越慢 -->``      ``<``enabled_partitions``>``        ``<``partition``>'2020-03-21'</``partition``>``        ``<``partition``>'2020-03-22'</``partition``>``      ``</``enabled_partitions``>``    ``</``my_table01``>``    ``<``my_table02``>``      ``....``    ``</``my_table02``>``  ``</``tables``>``</``yandex``>
```

其中的集群定义部分可以用下面这个工具生成。

```
.``/gen_cluster_definition``.sh host http_port user password
```

gen_cluster_definition.sh的代码可参考：

**gen_cluster_definition.sh**

```
#!/bin/bash``set` `-e` `if` `[ $``# -lt 4 ]; then``    ``echo` `"usage: $0 host http_port user password"``    ``exit` `1``fi` `host=$1``port=$2``user=$3``password=$4` `get_cluster_query=``"SELECT DISTINCT cluster FROM system.clusters WHERE cluster != 'system_cluster'"``cluster=$(curl -sSL -d ``"${get_cluster_query}"` `"http://${user}:${password}@${host}:${port}/"``)` `get_instance_query=``"SELECT shard_num, host_address, port FROM system.clusters WHERE cluster = '${cluster}'"``rst=$(curl -sSL -d ``"${get_instance_query}"` `"http://${user}:${password}@${host}:${port}/"``)` `old_shard_idx=0``cnt=0``echo` `"    <${cluster}>"` `echo` `"$rst"` `| ``while` `read` `shard_idx ip p``do``    ``#echo "dd $shard_idx $ip $p"``    ``if` `[ ${old_shard_idx} -``ne` `${shard_idx} ]; ``then``        ``if` `[ $cnt -``ne` `0 ]; ``then``            ``echo` `"      </shard>"``        ``fi``        ``echo` `"      <shard>"``        ``echo` `"        <internal_replication>true</internal_replication>"``        ``old_shard_idx=${shard_idx}``    ``fi` `    ``echo` `"        <replica>"``    ``echo` `"          <host>${ip}</host>"``    ``echo` `"          <port>${p}</port>"``    ``echo` `"          <user>${user}</user>"``    ``echo` `"          <password>${password}</password>"``    ``echo` `"        </replica>"` `    ``#((cnt++))``    ``let` `cnt+=1``done` `echo` `"      </shard>"``echo` `"    </${cluster}>"
```



### 2.3.3 上传task配置到zookeeper

 这一步，用任何可以操作zookeeper的工具把上面这个task_batch01.xml上传到某个目录下名为**description**的znode里，注意description的父目录即后面copier启动时指定的**--task-path。**下面是一个upload的example：

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

\1. 建议clickhouse-copier在后台执行，防止连接中断导致任务中断；

\2. 数据量较大时建议多个机器上同时并行跑，每个机器跑多实例，这样可以加快迁移速度；

### 2.3.5 观察迁移进度

迁移时需要关注如下：

1.  迁移进度，可分表连上源集群和目标集群，使用如下SQL进行对比：

   `-- 查询某个库的数据量、磁盘占用空间``SELECT``  ``database``,``  ``sum``(``rows``) ``AS` `sum_rows,``  ``formatReadableSize(``sum``(bytes_on_disk)) ``AS` `on_disk,``  ``formatReadableSize(``sum``(data_uncompressed_bytes)) ``AS` `raw``FROM` `system.parts``WHERE` `database` `= ``'mydb'``GROUP` `BY` `database``ORDER` `BY` `database` `ASC``;``--- 查询表的partition平均大小``SELECT``  ``database``,``  ``table``,``  ``count``(),``  ``formatReadableSize(``sum``(bytes_on_disk)) ``AS` `sum``,``  ``formatReadableSize(``avg``(bytes_on_disk)) ``AS` `avg``FROM` `system.parts``WHERE` `database` `= ``'mydb'``GROUP` `BY``  ``database``,``  ``table``ORDER` `BY``  ``database` `ASC``,``  ``table` `ASC``;`

2.  监控（包括[MDC监控](http://mdc.jd.com/monitor/chart?ip=10.196.102.231)和[ck监控](http://baizegra.jd.com/d/HyAPFhiGj/clickhouse-core-baize?orgId=6)）；

3.  clickhouse-copier日志（针对某些错误可能需要介入处理）；

### 2.3.6 清理zk数据

迁移结束后记得清理zookeeper的数据，clickhouse-copier不会自动清理。



# 3. 自助迁移（copier）

我们提供命令行工具做自助迁移，处于测试阶段，支持往ZYX_CK_TS_02迁移数据，具体步骤如下。

## 3.1 登录堡垒机

ssh clickhouse@10.199.136.197 密码为clickhouse

## 3.2 生成copier配置

```
# 生成机器的配置，需要指定源、目标集群的账号密码和HTTP连接地址，还需要指定输出的文件名，还可以指定数据库``ck-transfer genconf --src user:password@11.49.25.198:8123 --dst user:password@ckts00.olap.jd.com:2000 --out=gen.xml --dbs=fireClickHouse
```

## 3.3 上传copier配置

```
# 上传copier配置到zookeeper集群，下面是TS02的zookeeper，taskPath是zk里的路径（不同任务需不同），file是上一步生成的配置文件``ck-transfer upload --dst user:password@ckts00.olap.jd.com:2000 --``file` `gen.xml --taskPath ``/gen_test
```

## 3.4 启动迁移任务

```
# 启动迁移任务，注意这里的taskPath需与上一步的保持相同，jobs即为启动多少个copier任务（如果数据量较大启动多个会有明显加速效果）``ck-transfer start --src user:password@11.49.25.198:8123 --dst user:password@ckts00.olap.jd.com:2000 --progress=``true` `--taskPath ``/gen_test` `--jobs 2
```