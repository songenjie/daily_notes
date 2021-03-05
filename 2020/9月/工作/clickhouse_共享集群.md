# clickhouse 共享集群 管理方案

1. 权限
2. 资源



## 1 权限下发 

1. user

-  create 
-  alter 
-  drop 

2. Role

-  create 
-  alter 
-  drop 

3. Policy

-  grant

-  revoke 



## 2 资源  cpu memory storage

1. clickhouse config

- clickhouse users
- clickhouse global setting 

2. 用户行为

- 读 select show describe exists
- 写 insert optimize
- ddl create alter rename attach detach drop ,truncate
- Set set user

3. Zookeeper





###  一 Clickhouse  config 

#### 1 clickhouse users

1. user`s`   用户
2. Profile`s` 多个profile，每个profile定义不同的配置项，来限制资源的使用
3. Quotas`s` 限制了单位时间内的系统资源使用量，而不是限制单个查询的系统资源使用量

```xml
<yandex>
    <profiles>
        <profile1></profile1>
        <profile2></profile2>
    </profiles>
    <quotas>
        <quotas1></quotas1>
        <quotas2></quotas2>
    </quotas>
    <users>
        <username1>
            <profile>profile1</profile>
            <quotas>quotas2</quotas>
        </username1>
        <username2></username2>
    </users>
</yandex>
```



##### 1.1 profile

1. profile setting  `profile的作用类似于用户角色，可以在user.xml中定义多组profile，并可以为每组profile定义不同的配置项，类限制资源的使用。多个profile的配置可以复用。咋眼一看有点和MySQL的Proxy权限类似`
2. constraints on setting  `在user.xml配置文件的profile选项组下constraints选项组里定义对设置的约束，并禁止用户使用SET查询更改某些设置。constraints标签可以设置一组约束条件，以限制profile内的参数值被随意修改，约束条件有如下三种规则：`
   - min：最小值约束，在设置相应参数的时候，取值不能小于该阈值；
   - max：最大值约束，在设置相应参数的时候，取值不能大于该阈值；
   - readonly：只读约束，该参数值不允许被修改。



`1 profile setting `

```xml
<!-- Settings profiles -->
<profiles>
    <!-- Default settings -->
    <default>
        <!-- The maximum number of threads when running a single query. -->
        <max_threads>8</max_threads>
    </default>

    <!-- Settings for quries from the user interface -->
    <web>
        <max_rows_to_read>1000000000</max_rows_to_read>
        <max_bytes_to_read>100000000000</max_bytes_to_read>

        <max_rows_to_group_by>1000000</max_rows_to_group_by>
        <group_by_overflow_mode>any</group_by_overflow_mode>

        <max_rows_to_sort>1000000</max_rows_to_sort>
        <max_bytes_to_sort>1000000000</max_bytes_to_sort>

        <max_result_rows>100000</max_result_rows>
        <max_result_bytes>100000000</max_result_bytes>
        <result_overflow_mode>break</result_overflow_mode>

        <max_execution_time>600</max_execution_time>
        <min_execution_speed>1000000</min_execution_speed>
        <timeout_before_checking_execution_speed>15</timeout_before_checking_execution_speed>

        <max_columns_to_read>25</max_columns_to_read>
        <max_temporary_columns>100</max_temporary_columns>
        <max_temporary_non_const_columns>50</max_temporary_non_const_columns>

        <max_subquery_depth>2</max_subquery_depth>
        <max_pipeline_depth>25</max_pipeline_depth>
        <max_ast_depth>50</max_ast_depth>
        <max_ast_elements>100</max_ast_elements>

        <readonly>1</readonly>
    </web>
</profiles>
```



`2 constraints on setting`

```xml
<profiles>
    <default>
        <max_memory_usage>10000000000</max_memory_usage>
        <use_uncompressed_cache>0</use_uncompressed_cache>
        <force_index_by_date>0</force_index_by_date>
        <load_balancing>random</load_balancing>
        <constraints>
            <max_memory_usage>
                <min>100000</min>
                <max>20000</max>
            </max_memory_usage>
            <force_index_by_date>
                <readonly/>
            </force_index_by_date>
        </constraints>
    </default>
</profiles>
```



`3 how to use`

```mysql
ALTER SETTINGS PROFILE [IF EXISTS] name [ON CLUSTER cluster_name]
    [RENAME TO new_name]
    [SETTINGS variable [= value] [MIN [=] min_value] [MAX [=] max_value] [READONLY|WRITABLE] | INHERIT 'profile_name'] [,...]
```





##### 1.2 quotas 



`example`

```xml
<!-- Quotas -->
<quotas>
    <!-- Quota name. -->
    <default>
        <statbox>
            <!-- Restrictions for a time period. You can set many intervals with different restrictions. -->
            <interval>
                <!-- Length of the interval. -->
                <duration>3600</duration>
                <queries>1000</queries>
                <errors>100</errors>
                <result_rows>1000000000</result_rows>
                <read_rows>100000000000</read_rows>
                <execution_time>900</execution_time>
            </interval>
            <interval>
                <duration>86400</duration>
                <queries>10000</queries>
                <errors>1000</errors>
                <result_rows>5000000000</result_rows>
                <read_rows>500000000000</read_rows>
                <execution_time>7200</execution_time>
            </interval>
        </statbox>
    </default>
```

`how to use`

```mysql
ALTER QUOTA [IF EXISTS] name [ON CLUSTER cluster_name]
    [RENAME TO new_name]
    [KEYED BY {'none' | 'user name' | 'ip address' | 'client key' | 'client key or user name' | 'client key or ip address'}]
    [FOR [RANDOMIZED] INTERVAL number {SECOND | MINUTE | HOUR | DAY | WEEK | MONTH | QUARTER | YEAR}
        {MAX { {QUERIES | ERRORS | RESULT ROWS | RESULT BYTES | READ ROWS | READ BYTES | EXECUTION TIME} = number } [,...] |
        NO LIMITS | TRACKING ONLY} [,...]]
    [TO {role [,...] | ALL | ALL EXCEPT role [,...]}]

```



##### 1.3 users

```xml
<users>
    <!-- If user name was not specified, 'default' user is used. -->
    <user_name>
        <password></password>
        <!-- Or -->
        <password_sha256_hex></password_sha256_hex>

        <access_management>0|1</access_management>

        <networks incl="networks" replace="replace">
        </networks>

        <profile>profile_name</profile>

        <quota>default</quota>

        <databases>
            <database_name>
                <table_name>
                    <filter>expression</filter>
                <table_name>
            </database_name>
        </databases>
    </user_name>
    <!-- Other users settings -->
</users>
```

`How to use `

```mysql
ALTER USER [IF EXISTS] name [ON CLUSTER cluster_name]
    [RENAME TO new_name]
    [IDENTIFIED [WITH {PLAINTEXT_PASSWORD|SHA256_PASSWORD|DOUBLE_SHA1_PASSWORD}] BY {'password'|'hash'}]
    [[ADD|DROP] HOST {LOCAL | NAME 'name' | REGEXP 'name_regexp' | IP 'address' | LIKE 'pattern'} [,...] | ANY | NONE]
    [DEFAULT ROLE role [,...] | ALL | ALL EXCEPT role [,...] ]
    [SETTINGS variable [= value] [MIN [=] min_value] [MAX [=] max_value] [READONLY|WRITABLE] | PROFILE 'profile_name'] [,...]

```



#### 2 global setting. in config.xml 



| --                          | --                                                           |
| --------------------------- | ------------------------------------------------------------ |
| max_memory_usage            | 限制查询最大使用内存                                         |
| log                         | 存储和表数据量                                               |
| max_concurrent_queries      | 同时处理的最大请求数                                         |
| max_connections             | 最大连接数                                                   |
| max_open_files              | 打开最大的文件数，默认最大值                                 |
| max_suspicious_broken_parts | 最大异常的part数量 merge_tree                                |
| distributed_product_mode    | 更改分布式子查询的行为。当查询包含分布式表的乘积，即当分布式表的查询包含分布式表的非GLOBAL子查询时，ClickHouse将应用此设置 |











###  二 用户行为

1. global set
2. 读：select show describe exists
3. 写：insert optimize
4. Ddl: create alter rename attach detach drop ,truncate

#### 1 global 

| --                 | --                                                      |
| ------------------ | ------------------------------------------------------- |
| mark_cache_size    |                                                         |
| Read_only          | 只读                                                    |
| max_execution_time | The total query execution time, in seconds (wall time). |
| Result_rows        | 允许返回的行数                                          |
| Errors             | 允许的异常总数                                          |

| --                          | --                            |
| --------------------------- | ----------------------------- |
| max_memory_usage            | 限制查询最大使用内存          |
| log                         | 存储和表数据量                |
| max_concurrent_queries      | 同时处理的最大请求数          |
| max_connections             | 最大连接数                    |
| max_open_files              | 打开最大的文件数，默认最大值  |
| max_suspicious_broken_parts | 最大异常的part数量 merge_tree |

| --                                                 | --                                                           |
| -------------------------------------------------- | ------------------------------------------------------------ |
| distributed_product_mode                           |                                                              |
| enable_optimize_predicate_expression               | 谓词下推                                                     |
| fallback_to_stale_replicas_for_distributed_queries | 如果没有新的数据，则强制查询到过期的副本中查询               |
| force_index_by_date                                | 如果无法按日期使用索引，则禁用查询执行                       |
| force_primary_key                                  | 如果无法通过主键建立索引，则禁用查询执行                     |
| fsync_metadata                                     | 写入.sql文件时启用或禁用fsync。 默认1，启用。可选0、1。如果服务器具有数百万个不断创建和销毁的小表，则禁用它是有意义的。 |
| max_block_size                                     | 在ClickHouse中，数据由块（列部分的集合）处理。 处理每个块都有开销。 对于要从表中加载的块大小（以行数为单位），建议使用max_block_size设置。 目的是避免在多个线程中提取大量列时避免占用过多内存，并至少保留一些缓存局部性。默认：65,536（行数）。并非总是从表中加载max_block_size大小的块。 如果很明显需要检索较少的数据，则处理较小的块。 |
| preferred_block_size_bytes                         | 用于与max_block_size相同的目的，但是它通过将其调整为适合块中的行数来设置建议的块大小（以字节为单位），但块大小不能超过max_block_size行。默认值：1,000,000。 仅在从MergeTree引擎读取时有效。 |
| merge_tree_min_rows_for_concurrent_read            | merge_tree_min_rows_for_concurrent_read                      |
| merge_tree_min_bytes_for_concurrent_read           | 从MergeTree引擎表的文件读取的字节数超过了merge_tree_min_bytes_for_concurrent_read，则ClickHouse会尝试在多个线程中同时读取该文件。默认251658240，可选任何正整数 |
| merge_tree_min_rows_for_seek                       | 在一个文件中读取的两个数据块之间的距离小于merge_tree_min_rows_for_seek行，则ClickHouse不会搜索文件，而是顺序读取数据。默认0，可选任何正整数。 |
| merge_tree_min_bytes_for_seek                      | 在一个文件中读取的两个数据块之间的距离小于merge_tree_min_bytes_for_seek字节，则ClickHouse顺序读取包含两个块的文件的范围，从而避免了额外的查找。默认0，可选任何正整数 |
| merge_tree_coarse_index_granularity                | 搜索数据时，ClickHouse检查索引文件中的数据标记。如果ClickHouse发现所需键在某个范围内，则会将该范围划分为merge_tree_coarse_index_granularity子范围，然后在该范围内递归搜索所需键。默认8，可选任何正偶数整数。 |
| merge_tree_max_rows_to_use_cache                   | 在一个查询中读取的行数超过merge_tree_max_rows_to_use_cache行，则它不使用未压缩块的缓存，使用压缩块的高速缓存存储为查询提取的数据。 ClickHouse使用此缓存来加快对重复的小型查询的响应。此设置可保护高速缓存免受读取大量数据的查询的破坏。 uncompressed_cache_size服务器设置定义未压缩块的缓存大小。默认1048576，可选任何正整数。 |
| merge_tree_max_bytes_to_use_cache                  | 在一个查询中读取的数据多于merge_tree_max_bytes_to_use_cache字节，则它不使用未压缩块的缓存，同上。默认2013265920，可选任何正整数。 |
| min_bytes_to_use_direct_io                         | 使用直接I/O访问存储磁盘所需的最小数据量。如果要读取的所有数据的总存储量超过min_bytes_to_use_direct_io字节，则ClickHouse会使用O_DIRECT选项从存储磁盘读取数据。默认0，禁用，可选0、正整数。 |
| log_queries                                        | 设置发送到ClickHouse的查询将根据query_log服务器配置参数中的规则记录。 |
| log_query_threads                                  | 设置运行的查询的线程将根据query_thread_log服务器配置参数中的规则记录。 |



#### 2  读 

| --                                      | --                                                           |
| --------------------------------------- | ------------------------------------------------------------ |
| max_memory_usage_for_users              | 以用户为单位，限制单个用户查询的最大内存使用                 |
| max_memory_usage_for_all_queries        | 对所有查询的限制，最大内存使用量                             |
| max_rows_to_group_by                    | 在执行GROUP BY聚合查询的时候，限制去重后的聚合KEY的最大个数，默认值为0，即不做限制。当超过阈值数量的时候，其处理方式由group_by_overflow_mode参数决定 |
| group_by_overflow_mode                  | 当max_rows_to_group_by熔断规则触发的时候，有三种处理形式:  throw抛出异常，此乃默认值； break立即停止查询，并返回当前部分的数据； any仅以当前已存在的聚合KEY，继续完成聚合查询； |
| max_bytes_before_external_group_by      | 在执行GROUP BY聚合查询的时候，限制使用的最大内存用量，默认值为0，即不做限制。当超过阈值数量的时候，聚合查询将会进一步借用本地磁盘。 |
| Max_rows_to_read                        |                                                              |
| max_bytes_to_read                       |                                                              |
| max_rows_to_group_by                    |                                                              |
| group_by_overflow_mode                  |                                                              |
| group_by_overflow_mode                  |                                                              |
| max_rows_to_sort                        |                                                              |
| max_bytes_to_sort                       |                                                              |
| max_result_rows                         |                                                              |
| max_result_bytes                        |                                                              |
| result_overflow_mode                    |                                                              |
| max_execution_time                      |                                                              |
| min_execution_speed                     |                                                              |
| timeout_before_checking_execution_speed |                                                              |
| max_columns_to_read                     |                                                              |
| max_temporary_columns                   |                                                              |
| max_temporary_non_const_columns         |                                                              |
| max_subquery_depth                      |                                                              |
| max_pipeline_depth                      |                                                              |
| max_ast_depth                           |                                                              |
| max_ast_elements                        |                                                              |
| read_rows                               |                                                              |
| Querys                                  |                                                              |
| distributed_product_mode                | 更改分布式子查询的行为。当查询包含分布式表的乘积，即当分布式表的查询包含分布式表的非GLOBAL子查询时，ClickHouse将应用此设置 |





#### 3 写

| --                              | --                                                           |
| ------------------------------- | ------------------------------------------------------------ |
| max_partitions_per_insert_block | 在单次INSERT写入的时候，限制创建的最大分区个数，默认值为100个。如果超出这个阈值数目，将会得到异常 |
| flush_interval_milliseconds     | 将数据从内存中的缓冲区刷新到表的时间间隔                     |
| uncompressed_cache_size         | 表引擎从MergeTree使用的未压缩数据的缓存大小（以字节为单位，8G）。服务器有一个共享缓存，内存是按需分配的。如果启用，则使用高速缓存。在个别情况下，未压缩的缓存对于非常短的查询是有利的。 |
| max_insert_block_size           | 插入表中要形成的块的大小。此设置仅在服务器构成块的情况下适用。对通过HTTP接口的INSERT，服务器解析数据格式并形成指定大小的块。默认1048576。默认值略大于max_block_size，这样做是因为某些表引擎（* MergeTree）在磁盘上为每个插入的块形成了一个数据部分，这是一个相当大的实体。类似地，* MergeTree表在插入期间对数据进行排序，并且足够大的块大小允许对RAM中的更多数据进行排序。 |



#### 4 ddl

create alter rename attach detach drop ,truncate

| --                     | --                                                           |
| ---------------------- | ------------------------------------------------------------ |
| max_table_size_to_drop | 删除表的限制，默认50G，0表示不限制。如果MergeTree表的大小超过max_table_size_to_drop（以字节为单位），则无法使用DROP查询将其删除。如果仍然需要删除表而不重新启动ClickHouse服务器，请创建<clickhouse-path>/flags/force_drop_table文件并运行DROP查询。 |





### 三 zookeeper

#### 1  Setting

| --                                        | --                                                           |
| ----------------------------------------- | ------------------------------------------------------------ |
| session_timeout_ms                        | 客户端会话的最大超时（以毫秒为单位                           |
| root                                      | 用作ClickHouse服务器使用的znode的根的znode                   |
| use_minimalistic_part_header_in_zookeeper | 位于config.xml文件的merge_tree部分，对服务器上的所有表使用该设置。 可以随时更改设置。 当设置更改时，现有表将更改其行为。 对于每个单独的表，创建表时，请指定相应的引擎设置。 即使全局设置发生更改，具有此设置的现有表的行为也不会更改。 |
|                                           | 如果use_minimalistic_part_header_in_zookeeper = 1，则复制的表使用单个znode紧凑地存储数据部分的头。 如果表包含许多列，则此存储方法将大大减少Zookeeper中存储的数据量。但无法将ClickHouse服务器降级到不支持此设置的版本，在群集中的服务器上升级ClickHouse时要小心。 不要一次升级所有服务器。 在测试环境中或仅在群集中的几台服务器上测试ClickHouse的新版本更为安全。已经使用此设置存储的数据部件标题无法恢复为其以前的（非紧凑）表示形式。 |



#### 2  zoo.cfg

```shell
# http://hadoop.apache.org/zookeeper/docs/current/zookeeperAdmin.html

# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
# This value is not quite motivated
initLimit=300
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=10

maxClientCnxns=2000

# It is the maximum value that client may request and the server will accept.
# It is Ok to have high maxSessionTimeout on server to allow clients to work with high session timeout if they want.
# But we request session timeout of 30 seconds by default (you can change it with session_timeout_ms in ClickHouse config).
maxSessionTimeout=60000000
# the directory where the snapshot is stored.
dataDir=/opt/zookeeper/{{ cluster['name'] }}/data
# Place the dataLogDir to a separate physical disc for better performance
dataLogDir=/opt/zookeeper/{{ cluster['name'] }}/logs

autopurge.snapRetainCount=10
autopurge.purgeInterval=1


# To avoid seeks ZooKeeper allocates space in the transaction log file in
# blocks of preAllocSize kilobytes. The default block size is 64M. One reason
# for changing the size of the blocks is to reduce the block size if snapshots
# are taken more often. (Also, see snapCount).
preAllocSize=131072

# Clients can submit requests faster than ZooKeeper can process them,
# especially if there are a lot of clients. To prevent ZooKeeper from running
# out of memory due to queued requests, ZooKeeper will throttle clients so that
# there is no more than globalOutstandingLimit outstanding requests in the
# system. The default limit is 1,000.ZooKeeper logs transactions to a
# transaction log. After snapCount transactions are written to a log file a
# snapshot is started and a new transaction log file is started. The default
# snapCount is 10,000.
snapCount=3000000

# If this option is defined, requests will be will logged to a trace file named
# traceFile.year.month.day.
#traceFile=

# Leader accepts client connections. Default value is "yes". The leader machine
# coordinates updates. For higher update throughput at thes slight expense of
# read throughput the leader can be configured to not accept clients and focus
# on coordination.
leaderServes=yes

standaloneEnabled=false
dynamicConfigFile=/etc/zookeeper-{{ cluster['name'] }}/conf/zoo.cfg.dynamic
```



#### 3 jvm 

```shell
NAME=zookeeper-{{ cluster['name'] }}
ZOOCFGDIR=/etc/$NAME/conf

# TODO this is really ugly
# How to find out, which jars are needed?
# seems, that log4j requires the log4j.properties file to be in the classpath
CLASSPATH="$ZOOCFGDIR:/usr/build/classes:/usr/build/lib/*.jar:/usr/share/zookeeper/zookeeper-3.5.1-metrika.jar:/usr/share/zookeeper/slf4j-log4j12-1.7.5.jar:/usr/share/zookeeper/slf4j-api-1.7.5.jar:/usr/share/zookeeper/servlet-api-2.5-20081211.jar:/usr/share/zookeeper/netty-3.7.0.Final.jar:/usr/share/zookeeper/log4j-1.2.16.jar:/usr/share/zookeeper/jline-2.11.jar:/usr/share/zookeeper/jetty-util-6.1.26.jar:/usr/share/zookeeper/jetty-6.1.26.jar:/usr/share/zookeeper/javacc.jar:/usr/share/zookeeper/jackson-mapper-asl-1.9.11.jar:/usr/share/zookeeper/jackson-core-asl-1.9.11.jar:/usr/share/zookeeper/commons-cli-1.2.jar:/usr/src/java/lib/*.jar:/usr/etc/zookeeper"

ZOOCFG="$ZOOCFGDIR/zoo.cfg"
ZOO_LOG_DIR=/var/log/$NAME
USER=zookeeper
GROUP=zookeeper
PIDDIR=/var/run/$NAME
PIDFILE=$PIDDIR/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME
JAVA=/usr/bin/java
ZOOMAIN="org.apache.zookeeper.server.quorum.QuorumPeerMain"
ZOO_LOG4J_PROP="INFO,ROLLINGFILE"
JMXLOCALONLY=false
JAVA_OPTS="-Xms{{ cluster.get('xms','128M') }} \
    -Xmx{{ cluster.get('xmx','1G') }} \
    -Xloggc:/var/log/$NAME/zookeeper-gc.log \
    -XX:+UseGCLogFileRotation \
    -XX:NumberOfGCLogFiles=16 \
    -XX:GCLogFileSize=16M \
    -verbose:gc \
    -XX:+PrintGCTimeStamps \
    -XX:+PrintGCDateStamps \
    -XX:+PrintGCDetails
    -XX:+PrintTenuringDistribution \
    -XX:+PrintGCApplicationStoppedTime \
    -XX:+PrintGCApplicationConcurrentTime \
    -XX:+PrintSafepointStatistics \
    -XX:+UseParNewGC \
    -XX:+UseConcMarkSweepGC \
-XX:+CMSParallelRemarkEnabled"
```





## 3 DEMO

```xml
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <max_memory_usage>100000000</max_memory_usage>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
        </default>
        <readonly>
            <readonly>1</readonly>
        </readonly>
        <readwrite>
            <constraints>
                <max_memory_usage>
                    <readonly/>
                </max_memory_usage>
                <force_index_by_date>
                    <readonly/>
                </force_index_by_date>
            </constraints>
        </readwrite>
    </profiles>
    <users>
        <default>
            <password></password>
            <networks incl="networks" replace="replace">
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <!--从任何IP访问的只读账号zhoujy_ro -->
        <zhoujy_ro>
            <password_double_sha1_hex>6bb4837eb74329105ee4568dda7dc67ed2ca2ad9</password_double_sha1_hex>
            <networks incl="networks" replace="replace">
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </zhoujy_ro>
        <!--从指定IP访问的读写账号zhoujy_rw,指定不能set的参数 -->
        <zhoujy_rw>
            <password_double_sha1_hex>6bb4837eb74329105ee4568dda7dc67ed2ca2ad9</password_double_sha1_hex>
            <networks incl="networks" replace="replace">
                <ip>192.168.163.132</ip>
            </networks>
            <profile>readwrite</profile>
            <quota>default</quota>
        </zhoujy_rw>
        <!--从指定IP访问的管理账号 -->
        <zhoujy_admin>
            <password_double_sha1_hex>6bb4837eb74329105ee4568dda7dc67ed2ca2ad9</password_double_sha1_hex>
            <networks incl="networks" replace="replace">
                <ip>192.168.163.132</ip>
                <ip>192.168.163.133</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </zhoujy_admin>
        <!--从指定IP访问指定数据库 -->
        <zhoujy_db>
            <password_double_sha1_hex>6bb4837eb74329105ee4568dda7dc67ed2ca2ad9</password_double_sha1_hex>
            <networks incl="networks" replace="replace">
                <ip>::/0</ip>
                <ip>127.0.0.1</ip>
                <ip>192.168.163.132</ip>
            </networks>
            <profile>readwrite</profile>
            <quota>default</quota>
            <allow_databases>
                <database>test</database>
            </allow_databases>
        </zhoujy_db>
        <!--从指定IP访问指定数据库表的记录 -->
        <zhoujy_tb>
            <password_double_sha1_hex>6bb4837eb74329105ee4568dda7dc67ed2ca2ad9</password_double_sha1_hex>
            <networks incl="networks" replace="replace">
                <ip>::/0</ip>
                <ip>127.0.0.1</ip>
                <ip>192.168.163.132</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
            <allow_databases>
                <database>test</database>
            </allow_databases>
            <databases>
                <test>
                    <xx>
                        <filter>id >= 500 </filter>
                    </xx>
                </test>
            </databases>
        </zhoujy_tb>
    </users>
    <quotas>
        <default>
            <interval>
                <duration>3600</duration>
                <queries>0</queries>
                <errors>0</errors>
                <result_rows>0</result_rows>
                <read_rows>0</read_rows>
                <execution_time>0</execution_time>
            </interval>
        </default>
    </quotas>
</yandex>
```





Help;

* https://www.cnblogs.com/zhoujinyi/p/12613026.html
* https://www.cnblogs.com/zhoujinyi/p/12627780.html
* https://blog.csdn.net/lcl_xiaowugui/article/details/105206594
* https://cf.jd.com/pages/viewpage.action?pageId=350157733
* https://git.jd.com/jdolap/clickhouse/issues/15