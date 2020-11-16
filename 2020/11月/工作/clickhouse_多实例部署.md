# ClickHouse多实例部署

本人刚接触ClickHouse两周, 难免有错误之处, 感谢指正. 另外一些参数我也不甚理解, 大家也可以先不必纠结参数, 先部署起来再说, 我的感触是部署后就会对整体结构有了一遍认识. 如果多实例都可以部署完毕, 那么生产单实例部署当然就不成问题了.

生产环境并不建议多实例部署, ClickHouse一个查询可以用到多个CPU, 本例只适用于测试环境



## 部署规划

[![WX20200503-000148](https://raw.githubusercontent.com/Fanduzi/Fandb.github.io/master/images/clickhouse/multi_instance_deploy/WX20200503-000148.png)](https://raw.githubusercontent.com/Fanduzi/Fandb.github.io/master/images/clickhouse/multi_instance_deploy/WX20200503-000148.png)WX20200503-000148

集群部署关系如下:

[![image-20200502202000580](https://raw.githubusercontent.com/Fanduzi/Fandb.github.io/master/images/clickhouse/multi_instance_deploy/image-20200502202000580.png)](https://raw.githubusercontent.com/Fanduzi/Fandb.github.io/master/images/clickhouse/multi_instance_deploy/image-20200502202000580.png)image-20200502202000580

逻辑结构图如下:

[![image-20200502204517718](https://raw.githubusercontent.com/Fanduzi/Fandb.github.io/master/images/clickhouse/multi_instance_deploy/image-20200502204517718.png)](https://raw.githubusercontent.com/Fanduzi/Fandb.github.io/master/images/clickhouse/multi_instance_deploy/image-20200502204517718.png)image-20200502204517718

编辑三台主机`/etc/hosts`添加如下内容:

```
172.16.120.10 centos-1
172.16.120.11 centos-2
172.16.120.12 centos-3
```

## 依赖组件安装

### JDK

#### 下载openjdk

```
wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz
tar -zxvf OpenJDK8U-jdk_x64_linux_hotspot_8u242b08.tar.gz -C /usr/local/
```

#### 做软链

```
ln -s /usr/local/jdk8u242-b08 /usr/local/java
```

#### 配置环境变量

```
#vi ~/.bashrc
 
export JAVA_HOME=/usr/local/java
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```

### ZooKeeper

3.6.0有bug

所以改用稳定版本3.4.14

#### 下载安装包

```
wget https://downloads.apache.org/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz
tar -zxvf zookeeper-3.4.14.tar.gz -C /usr/local/
```

#### 做软链

```
ln -s /usr/local/zookeeper-3.4.14 /usr/local/zookeeper
```

#### 配置环境变量

```
#vi ~/.bashrc
 
export ZOOKEEPER_HOME=/usr/local/zookeeper
export PATH=$PATH:$ZOOKEEPER_HOME/bin
```

#### 修改配置文件

```
cd /usr/local/zookeeper/conf
 
 
#参考官方
#https://clickhouse.tech/docs/en/operations/tips/#zookeeper
#vim zoo.cfg
 
 
tickTime=2000
initLimit=30000
syncLimit=10
maxClientCnxns=2000
maxSessionTimeout=60000000
dataDir=/data/zookeeper/data
dataLogDir=/data/zookeeper/logs
autopurge.snapRetainCount=10
autopurge.purgeInterval=1
preAllocSize=131072
snapCount=3000000
leaderServes=yes
clientPort=2181
 
 
 
集群配置部分三个节点分别为:
# centos-1
server.1=0.0.0.0:2888:3888
server.2=172.16.120.11:2888:3888
server.3=172.16.120.12:2888:3888
  
  
# centos-2
server.1=172.16.120.10:2888:3888
server.2=0.0.0.0:2888:3888
server.3=172.16.120.12:2888:3888
  
  
# centos-3
server.1=172.16.120.10:2888:3888
server.2=172.16.120.11:2888:3888
server.3=0.0.0.0:2888:3888
```

#### 创建目录

```
mkdir -p /data/zookeeper/{data,logs}
mkdir -p /usr/local/zookeeper/logs
```

#### myid

```
# centos-1
echo "1">/data/zookeeper/data/myid
  
# centos-2
echo "2">/data/zookeeper/data/myid
  
# centos-3
echo "3">/data/zookeeper/data/myid
```

#### 配置zk日志

默认zk日志输出到一个文件,且不会自动清理,所以,一段时间后zk日志会非常大

##### `1.zookeeper-env.sh` `./conf`目录下新建`zookeeper-env.sh`文件,修改到`sudo chmod 755 zookeeper-env.sh`权限

```
#cat conf/zookeeper-env.sh
 
#!/usr/bin/env bash
#tip:custom configurationfile，do not amend the zkEnv.sh file
#chang the log dir and output of rolling file
 
ZOO_LOG_DIR="/usr/local/zookeeper/logs"
ZOO_LOG4J_PROP="INFO,ROLLINGFILE"
```

##### 2.log4j.properties 修改日志的输入形式

```
zookeeper.root.logger=INFO, ROLLINGFILE
#zookeeper.root.logger=INFO, CONSOLE
 
 
# Max log file size of 10MB
log4j.appender.ROLLINGFILE.MaxFileSize=128MB
# uncomment the next line to limit number of backup files
log4j.appender.ROLLINGFILE.MaxBackupIndex=10
```

#### 配置运行zk的JVM

`./conf`目录下新建`java.env`文件,修改到`sudo chmod 755 java.env`权限,主要用于`GC log`,`RAM`等的配置.

```
#!/usr/bin/env bash
#config the jvm parameter in a reasonable
#note that the shell is source in so that do not need to use export
#set java  classpath
#CLASSPATH=""
#set jvm start parameter , also can set JVMFLAGS variable
SERVER_JVMFLAGS="-Xms1024m -Xmx2048m $JVMFLAGS"
```

#### 启动zookeeper服务(所有节点)

```
# zkServer.sh start
ZooKeeper JMX enabled by default
Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED
```

#### 验证zk

```
# zkServer.sh status
 
#bin/zkCli.sh -server 127.0.0.1:2181
Connecting to 127.0.0.1:2181
 
 
[zk: 127.0.0.1:2181(CONNECTED) 0]
[zk: 127.0.0.1:2181(CONNECTED) 0] ls /
[zookeeper]
 
[zk: 127.0.0.1:2181(CONNECTED) 1] create /zk_test mydata
Created /zk_test
 
[zk: 127.0.0.1:2181(CONNECTED) 2] ls /
[zk_test, zookeeper]
 
[zk: 127.0.0.1:2181(CONNECTED) 3] get /zk_test
mydata
 
[zk: 127.0.0.1:2181(CONNECTED) 4] set /zk_test junk
[zk: 127.0.0.1:2181(CONNECTED) 5] get /zk_test
junk
 
[zk: 127.0.0.1:2181(CONNECTED) 6] delete /zk_test
[zk: 127.0.0.1:2181(CONNECTED) 7] ls /
[zookeeper]
 
[zk: 127.0.0.1:2181(CONNECTED) 8]
```

# ClickHouse安装

## yum安装

```
yum install yum-utils
rpm --import https://repo.clickhouse.tech/CLICKHOUSE-KEY.GPG
yum-config-manager --add-repo https://repo.clickhouse.tech/rpm/stable/x86_64
 
 
yum install clickhouse-server clickhouse-client
```

## 创建目录

```
centos-1 创建目录：
mkdir -p /data/clickhouse/{node1,node4}/{data,tmp,logs}
  
centos-2 创建目录：
mkdir -p /data/clickhouse/{node2,node5}/{data,tmp,logs}
  
centos-3 创建目录：
mkdir -p /data/clickhouse/{node3,node6}/{data,tmp,logs}
```

## 创建配置文件

配置clickhouse参数文件，账户文件，分片配置文件

这部分会`啰嗦`一些, 节点间有一些重复的配置为了方便也没有省略, 都贴出来了, 照着配置就可以了

### node1配置文件如下

#### config.xml

```
<?xml version="1.0"?>
<yandex>
    <!--日志-->
    <logger>
        <level>warning</level>
        <log>/data/clickhouse/node1/logs/clickhouse.log</log>
        <errorlog>/data/clickhouse/node1/logs/error.log</errorlog>
        <size>500M</size>
        <count>5</count>
    </logger>
    <!--本地节点信息-->
    <http_port>8123</http_port>
    <tcp_port>9000</tcp_port>
    <interserver_http_port>9009</interserver_http_port>
    <interserver_http_host>centos-1</interserver_http_host>
    <!--本机域名或IP-->
    <!--本地配置-->
    <listen_host>0.0.0.0</listen_host>
    <max_connections>2048</max_connections>
    <receive_timeout>800</receive_timeout>
    <send_timeout>800</send_timeout>
    <keep_alive_timeout>3</keep_alive_timeout>
    <max_concurrent_queries>64</max_concurrent_queries>
    <uncompressed_cache_size>4294967296</uncompressed_cache_size>
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data/clickhouse/node1/</path>
    <tmp_path>/data/clickhouse/node1/tmp/</tmp_path>
    <users_config>/data/clickhouse/node1/users.xml</users_config>
    <default_profile>default</default_profile>
    <query_log>
        <database>system</database>
        <table>query_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>8001</port>
        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>
    <default_database>default</default_database>
    <timezone>Asia/Shanghai</timezone>
    <!--集群相关配置-->
    <remote_servers incl="clickhouse_remote_servers" />
    <zookeeper incl="zookeeper-servers" optional="true" />
    <macros incl="macros" optional="true" />
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
    <max_session_timeout>3600</max_session_timeout>
    <default_session_timeout>300</default_session_timeout>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <merge_tree>
        <parts_to_delay_insert>300</parts_to_delay_insert>
        <parts_to_throw_insert>600</parts_to_throw_insert>
        <max_delay_to_insert>2</max_delay_to_insert>
    </merge_tree>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <max_partition_size_to_drop>0</max_partition_size_to_drop>
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/clickhouse/task_queue/ddl</path>
    </distributed_ddl>
    <include_from>/data/clickhouse/node1/metrika.xml</include_from>
</yandex>
```

#### users.xml

```
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <!-- 请根据自己机器实际内存配置 -->
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>8</max_threads>
            <log_queries>1</log_queries>
        </default>
        <readonly>
            <max_threads>8</max_threads>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <log_queries>1</log_queries>
        </readonly>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    </users>
</yandex>
```

#### metrika.xml

```
<?xml version="1.0"?>
<yandex>
    <!--ck集群节点-->
    <clickhouse_remote_servers>
        <ch_cluster_all>
            <!--分片1-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集1-->
                <replica>
                    <host>centos-3</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片2-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集2-->
                <replica>
                    <host>centos-1</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片3-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集3-->
                <replica>
                    <host>centos-2</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
        </ch_cluster_all>
    </clickhouse_remote_servers>
    <!--zookeeper相关配置-->
    <zookeeper-servers>
        <node index="1">
            <host>centos-1</host>
            <port>2181</port>
        </node>
        <node index="2">
            <host>centos-2</host>
            <port>2181</port>
        </node>
        <node index="3">
            <host>centos-3</host>
            <port>2181</port>
        </node>
    </zookeeper-servers>
    <macros>
        <layer>01</layer>
        <shard>01</shard>
        <!--分片号-->
        <replica>node1</replica>
        <!--当前节点IP-->
    </macros>
    <networks>
        <ip>::/0</ip>
    </networks>
    <!--压缩相关配置-->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
            <!--压缩算法lz4压缩比zstd快, 更占磁盘-->
        </case>
    </clickhouse_compression>
</yandex>
```

### node2配置文件如下:

#### config.xml

```
<?xml version="1.0"?>
<yandex>
    <!--日志-->
    <logger>
        <level>warning</level>
        <log>/data/clickhouse/node2/logs/clickhouse.log</log>
        <errorlog>/data/clickhouse/node2/logs/error.log</errorlog>
        <size>500M</size>
        <count>5</count>
    </logger>
    <!--本地节点信息-->
    <http_port>8123</http_port>
    <tcp_port>9000</tcp_port>
    <interserver_http_port>9009</interserver_http_port>
    <interserver_http_host>centos-2</interserver_http_host>
    <!--本机域名或IP-->
    <!--本地配置-->
    <listen_host>0.0.0.0</listen_host>
    <max_connections>2048</max_connections>
    <receive_timeout>800</receive_timeout>
    <send_timeout>800</send_timeout>
    <keep_alive_timeout>3</keep_alive_timeout>
    <max_concurrent_queries>64</max_concurrent_queries>
    <uncompressed_cache_size>4294967296</uncompressed_cache_size>
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data/clickhouse/node2/</path>
    <tmp_path>/data/clickhouse/node2/tmp/</tmp_path>
    <users_config>/data/clickhouse/node2/users.xml</users_config>
    <default_profile>default</default_profile>
    <query_log>
        <database>system</database>
        <table>query_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>8001</port>
        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>
    <default_database>default</default_database>
    <timezone>Asia/Shanghai</timezone>
    <!--集群相关配置-->
    <remote_servers incl="clickhouse_remote_servers" />
    <zookeeper incl="zookeeper-servers" optional="true" />
    <macros incl="macros" optional="true" />
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
    <max_session_timeout>3600</max_session_timeout>
    <default_session_timeout>300</default_session_timeout>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <merge_tree>
        <parts_to_delay_insert>300</parts_to_delay_insert>
        <parts_to_throw_insert>600</parts_to_throw_insert>
        <max_delay_to_insert>2</max_delay_to_insert>
    </merge_tree>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <max_partition_size_to_drop>0</max_partition_size_to_drop>
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/clickhouse/task_queue/ddl</path>
    </distributed_ddl>
    <include_from>/data/clickhouse/node2/metrika.xml</include_from>
</yandex>
```

#### users.xml

```
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <!-- 请根据自己机器实际内存配置 -->
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>8</max_threads>
            <log_queries>1</log_queries>
        </default>
        <readonly>
            <max_threads>8</max_threads>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <log_queries>1</log_queries>
        </readonly>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    </users>
</yandex>
```

#### metrika.xml

```
<?xml version="1.0"?>
<yandex>
    <!--ck集群节点-->
    <clickhouse_remote_servers>
        <ch_cluster_all>
            <!--分片1-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集1-->
                <replica>
                    <host>centos-3</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片2-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集2-->
                <replica>
                    <host>centos-1</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片3-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集3-->
                <replica>
                    <host>centos-2</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
        </ch_cluster_all>
    </clickhouse_remote_servers>
    <!--zookeeper相关配置-->
    <zookeeper-servers>
        <node index="1">
            <host>centos-1</host>
            <port>2181</port>
        </node>
        <node index="2">
            <host>centos-2</host>
            <port>2181</port>
        </node>
        <node index="3">
            <host>centos-3</host>
            <port>2181</port>
        </node>
    </zookeeper-servers>
    <macros>
        <layer>01</layer>
        <shard>02</shard>
        <!--分片号-->
        <replica>node2</replica>
        <!--当前节点IP-->
    </macros>
    <networks>
        <ip>::/0</ip>
    </networks>
    <!--压缩相关配置-->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
            <!--压缩算法lz4压缩比zstd快, 更占磁盘-->
        </case>
    </clickhouse_compression>
</yandex>
```

### node3配置文件如下:

#### config.xml

```
<?xml version="1.0"?>
<yandex>
    <!--日志-->
    <logger>
        <level>warning</level>
        <log>/data/clickhouse/node3/logs/clickhouse.log</log>
        <errorlog>/data/clickhouse/node3/logs/error.log</errorlog>
        <size>500M</size>
        <count>5</count>
    </logger>
    <!--本地节点信息-->
    <http_port>8123</http_port>
    <tcp_port>9000</tcp_port>
    <interserver_http_port>9009</interserver_http_port>
    <interserver_http_host>centos-3</interserver_http_host>
    <!--本机域名或IP-->
    <!--本地配置-->
    <listen_host>0.0.0.0</listen_host>
    <max_connections>2048</max_connections>
    <receive_timeout>800</receive_timeout>
    <send_timeout>800</send_timeout>
    <keep_alive_timeout>3</keep_alive_timeout>
    <max_concurrent_queries>64</max_concurrent_queries>
    <uncompressed_cache_size>4294967296</uncompressed_cache_size>
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data/clickhouse/node3/</path>
    <tmp_path>/data/clickhouse/node3/tmp/</tmp_path>
    <users_config>/data/clickhouse/node3/users.xml</users_config>
    <default_profile>default</default_profile>
    <query_log>
        <database>system</database>
        <table>query_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>8001</port>
        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>
    <default_database>default</default_database>
    <timezone>Asia/Shanghai</timezone>
    <!--集群相关配置-->
    <remote_servers incl="clickhouse_remote_servers" />
    <zookeeper incl="zookeeper-servers" optional="true" />
    <macros incl="macros" optional="true" />
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
    <max_session_timeout>3600</max_session_timeout>
    <default_session_timeout>300</default_session_timeout>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <merge_tree>
        <parts_to_delay_insert>300</parts_to_delay_insert>
        <parts_to_throw_insert>600</parts_to_throw_insert>
        <max_delay_to_insert>2</max_delay_to_insert>
    </merge_tree>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <max_partition_size_to_drop>0</max_partition_size_to_drop>
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/clickhouse/task_queue/ddl</path>
    </distributed_ddl>
    <include_from>/data/clickhouse/node3/metrika.xml</include_from>
</yandex>
```

#### users.xml

```
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <!-- 请根据自己机器实际内存配置 -->
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>8</max_threads>
            <log_queries>1</log_queries>
        </default>
        <readonly>
            <max_threads>8</max_threads>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <log_queries>1</log_queries>
        </readonly>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    </users>
</yandex>
```

#### metrika.xml

```
<?xml version="1.0"?>
<yandex>
    <!--ck集群节点-->
    <clickhouse_remote_servers>
        <ch_cluster_all>
            <!--分片1-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集1-->
                <replica>
                    <host>centos-3</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片2-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集2-->
                <replica>
                    <host>centos-1</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片3-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集3-->
                <replica>
                    <host>centos-2</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
        </ch_cluster_all>
    </clickhouse_remote_servers>
    <!--zookeeper相关配置-->
    <zookeeper-servers>
        <node index="1">
            <host>centos-1</host>
            <port>2181</port>
        </node>
        <node index="2">
            <host>centos-2</host>
            <port>2181</port>
        </node>
        <node index="3">
            <host>centos-3</host>
            <port>2181</port>
        </node>
    </zookeeper-servers>
    <macros>
        <layer>01</layer>
        <shard>03</shard>
        <!--分片号-->
        <replica>node3</replica>
        <!--当前节点IP-->
    </macros>
    <networks>
        <ip>::/0</ip>
    </networks>
    <!--压缩相关配置-->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
            <!--压缩算法lz4压缩比zstd快, 更占磁盘-->
        </case>
    </clickhouse_compression>
</yandex>
```

### node4配置文件如下:

#### config.xml

```
<?xml version="1.0"?>
<yandex>
    <!--日志-->
    <logger>
        <level>warning</level>
        <log>/data/clickhouse/node4/logs/clickhouse.log</log>
        <errorlog>/data/clickhouse/node4/logs/error.log</errorlog>
        <size>500M</size>
        <count>5</count>
    </logger>
    <!--本地节点信息-->
    <http_port>8124</http_port>
    <tcp_port>9002</tcp_port>
    <interserver_http_port>9010</interserver_http_port>
    <interserver_http_host>centos-1</interserver_http_host>
    <!--本机域名或IP-->
    <!--本地配置-->
    <listen_host>0.0.0.0</listen_host>
    <max_connections>2048</max_connections>
    <receive_timeout>800</receive_timeout>
    <send_timeout>800</send_timeout>
    <keep_alive_timeout>3</keep_alive_timeout>
    <max_concurrent_queries>64</max_concurrent_queries>
    <uncompressed_cache_size>4294967296</uncompressed_cache_size>
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data/clickhouse/node4/</path>
    <tmp_path>/data/clickhouse/node4/tmp/</tmp_path>
    <users_config>/data/clickhouse/node4/users.xml</users_config>
    <default_profile>default</default_profile>
    <query_log>
        <database>system</database>
        <table>query_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>8002</port>
        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>
    <default_database>default</default_database>
    <timezone>Asia/Shanghai</timezone>
    <!--集群相关配置-->
    <remote_servers incl="clickhouse_remote_servers" />
    <zookeeper incl="zookeeper-servers" optional="true" />
    <macros incl="macros" optional="true" />
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
    <max_session_timeout>3600</max_session_timeout>
    <default_session_timeout>300</default_session_timeout>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <merge_tree>
        <parts_to_delay_insert>300</parts_to_delay_insert>
        <parts_to_throw_insert>600</parts_to_throw_insert>
        <max_delay_to_insert>2</max_delay_to_insert>
    </merge_tree>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <max_partition_size_to_drop>0</max_partition_size_to_drop>
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/clickhouse/task_queue/ddl</path>
    </distributed_ddl>
    <include_from>/data/clickhouse/node4/metrika.xml</include_from>
</yandex>
```

#### users.xml

```
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <!-- 请根据自己机器实际内存配置 -->
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>8</max_threads>
            <log_queries>1</log_queries>
        </default>
        <readonly>
            <max_threads>8</max_threads>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <log_queries>1</log_queries>
        </readonly>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    </users>
</yandex>
```

#### metrika.xml

```
<?xml version="1.0"?>
<yandex>
    <!--ck集群节点-->
    <clickhouse_remote_servers>
        <ch_cluster_all>
            <!--分片1-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集1-->
                <replica>
                    <host>centos-3</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片2-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集2-->
                <replica>
                    <host>centos-1</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片3-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集3-->
                <replica>
                    <host>centos-2</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
        </ch_cluster_all>
    </clickhouse_remote_servers>
    <!--zookeeper相关配置-->
    <zookeeper-servers>
        <node index="1">
            <host>centos-1</host>
            <port>2181</port>
        </node>
        <node index="2">
            <host>centos-2</host>
            <port>2181</port>
        </node>
        <node index="3">
            <host>centos-3</host>
            <port>2181</port>
        </node>
    </zookeeper-servers>
    <macros>
        <layer>01</layer>
        <shard>02</shard>
        <!--分片号-->
        <replica>node4</replica>
    </macros>
    <networks>
        <ip>::/0</ip>
    </networks>
    <!--压缩相关配置-->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
            <!--压缩算法lz4压缩比zstd快, 更占磁盘-->
        </case>
    </clickhouse_compression>
</yandex>
```

### node5配置文件如下:

#### config.xml

```
<?xml version="1.0"?>
<yandex>
    <!--日志-->
    <logger>
        <level>warning</level>
        <log>/data/clickhouse/node5/logs/clickhouse.log</log>
        <errorlog>/data/clickhouse/node5/logs/error.log</errorlog>
        <size>500M</size>
        <count>5</count>
    </logger>
    <!--本地节点信息-->
    <http_port>8124</http_port>
    <tcp_port>9002</tcp_port>
    <interserver_http_port>9010</interserver_http_port>
    <interserver_http_host>centos-2</interserver_http_host>
    <!--本机域名或IP-->
    <!--本地配置-->
    <listen_host>0.0.0.0</listen_host>
    <max_connections>2048</max_connections>
    <receive_timeout>800</receive_timeout>
    <send_timeout>800</send_timeout>
    <keep_alive_timeout>3</keep_alive_timeout>
    <max_concurrent_queries>64</max_concurrent_queries>
    <uncompressed_cache_size>4294967296</uncompressed_cache_size>
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data/clickhouse/node5/</path>
    <tmp_path>/data/clickhouse/node5/tmp/</tmp_path>
    <users_config>/data/clickhouse/node5/users.xml</users_config>
    <default_profile>default</default_profile>
    <query_log>
        <database>system</database>
        <table>query_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>8002</port>
        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>
    <default_database>default</default_database>
    <timezone>Asia/Shanghai</timezone>
    <!--集群相关配置-->
    <remote_servers incl="clickhouse_remote_servers" />
    <zookeeper incl="zookeeper-servers" optional="true" />
    <macros incl="macros" optional="true" />
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
    <max_session_timeout>3600</max_session_timeout>
    <default_session_timeout>300</default_session_timeout>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <merge_tree>
        <parts_to_delay_insert>300</parts_to_delay_insert>
        <parts_to_throw_insert>600</parts_to_throw_insert>
        <max_delay_to_insert>2</max_delay_to_insert>
    </merge_tree>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <max_partition_size_to_drop>0</max_partition_size_to_drop>
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/clickhouse/task_queue/ddl</path>
    </distributed_ddl>
    <include_from>/data/clickhouse/node5/metrika.xml</include_from>
</yandex>
```

#### users.xml

```
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <!-- 请根据自己机器实际内存配置 -->
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>8</max_threads>
            <log_queries>1</log_queries>
        </default>
        <readonly>
            <max_threads>8</max_threads>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <log_queries>1</log_queries>
        </readonly>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    </users>
</yandex>
```

#### metrika.xml

```
<?xml version="1.0"?>
<yandex>
    <!--ck集群节点-->
    <clickhouse_remote_servers>
        <ch_cluster_all>
            <!--分片1-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集1-->
                <replica>
                    <host>centos-3</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片2-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集2-->
                <replica>
                    <host>centos-1</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片3-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集3-->
                <replica>
                    <host>centos-2</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
        </ch_cluster_all>
    </clickhouse_remote_servers>
    <!--zookeeper相关配置-->
    <zookeeper-servers>
        <node index="1">
            <host>centos-1</host>
            <port>2181</port>
        </node>
        <node index="2">
            <host>centos-2</host>
            <port>2181</port>
        </node>
        <node index="3">
            <host>centos-3</host>
            <port>2181</port>
        </node>
    </zookeeper-servers>
    <macros>
        <layer>01</layer>
        <shard>03</shard>
        <!--分片号-->
        <replica>node5</replica>
        <!--当前节点IP-->
    </macros>
    <networks>
        <ip>::/0</ip>
    </networks>
    <!--压缩相关配置-->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
            <!--压缩算法lz4压缩比zstd快, 更占磁盘-->
        </case>
    </clickhouse_compression>
</yandex>
```

### node6配置文件如下:

#### config.xml

```
<?xml version="1.0"?>
<yandex>
    <!--日志-->
    <logger>
        <level>warning</level>
        <log>/data/clickhouse/node6/logs/clickhouse.log</log>
        <errorlog>/data/clickhouse/node6/logs/error.log</errorlog>
        <size>500M</size>
        <count>5</count>
    </logger>
    <!--本地节点信息-->
    <http_port>8124</http_port>
    <tcp_port>9002</tcp_port>
    <interserver_http_port>9010</interserver_http_port>
    <interserver_http_host>centos-3</interserver_http_host>
    <!--本机域名或IP-->
    <!--本地配置-->
    <listen_host>0.0.0.0</listen_host>
    <max_connections>2048</max_connections>
    <receive_timeout>800</receive_timeout>
    <send_timeout>800</send_timeout>
    <keep_alive_timeout>3</keep_alive_timeout>
    <max_concurrent_queries>64</max_concurrent_queries>
    <uncompressed_cache_size>4294967296</uncompressed_cache_size>
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data/clickhouse/node6/</path>
    <tmp_path>/data/clickhouse/node6/tmp/</tmp_path>
    <users_config>/data/clickhouse/node6/users.xml</users_config>
    <default_profile>default</default_profile>
    <query_log>
        <database>system</database>
        <table>query_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>8002</port>
        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>
    <default_database>default</default_database>
    <timezone>Asia/Shanghai</timezone>
    <!--集群相关配置-->
    <remote_servers incl="clickhouse_remote_servers" />
    <zookeeper incl="zookeeper-servers" optional="true" />
    <macros incl="macros" optional="true" />
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>
    <max_session_timeout>3600</max_session_timeout>
    <default_session_timeout>300</default_session_timeout>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <merge_tree>
        <parts_to_delay_insert>300</parts_to_delay_insert>
        <parts_to_throw_insert>600</parts_to_throw_insert>
        <max_delay_to_insert>2</max_delay_to_insert>
    </merge_tree>
    <max_table_size_to_drop>0</max_table_size_to_drop>
    <max_partition_size_to_drop>0</max_partition_size_to_drop>
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/clickhouse/task_queue/ddl</path>
    </distributed_ddl>
    <include_from>/data/clickhouse/node6/metrika.xml</include_from>
</yandex>
```

#### users.xml

```
<?xml version="1.0"?>
<yandex>
    <profiles>
        <default>
            <!-- 请根据自己机器实际内存配置 -->
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>8</max_threads>
            <log_queries>1</log_queries>
        </default>
        <readonly>
            <max_threads>8</max_threads>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <log_queries>1</log_queries>
        </readonly>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>put_your_passwordsha256hex_here</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    </users>
</yandex>
```

#### metrika.xml

```
<?xml version="1.0"?>
<yandex>
    <!--ck集群节点-->
    <clickhouse_remote_servers>
        <ch_cluster_all>
            <!--分片1-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集1-->
                <replica>
                    <host>centos-3</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片2-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集2-->
                <replica>
                    <host>centos-1</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
            <!--分片3-->
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>centos-3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
                <!--复制集3-->
                <replica>
                    <host>centos-2</host>
                    <port>9002</port>
                    <user>default</user>
                    <password>supersecrect</password>
                </replica>
            </shard>
        </ch_cluster_all>
    </clickhouse_remote_servers>
    <!--zookeeper相关配置-->
    <zookeeper-servers>
        <node index="1">
            <host>centos-1</host>
            <port>2181</port>
        </node>
        <node index="2">
            <host>centos-2</host>
            <port>2181</port>
        </node>
        <node index="3">
            <host>centos-3</host>
            <port>2181</port>
        </node>
    </zookeeper-servers>
    <macros>
        <layer>01</layer>
        <shard>01</shard>
        <!--分片号-->
        <replica>node6</replica>
        <!--当前节点IP-->
    </macros>
    <networks>
        <ip>::/0</ip>
    </networks>
    <!--压缩相关配置-->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
            <!--压缩算法lz4压缩比zstd快, 更占磁盘-->
        </case>
    </clickhouse_compression>
</yandex>
```

## 用户密码生成方式

密码生成方式：

https://clickhouse.tech/docs/en/operations/settings/settings_users/

shell命令行执行：

```
PASSWORD=$(base64 < /dev/urandom | head -c8); echo "$PASSWORD"; echo -n "$PASSWORD" | sha256sum | tr -d '-' 
```

输出结果

```
X1UNizCS（明文密码）
379444c5e109e2f7e5f284831db54cd955011e6ae27d6e7a572cca635fbc7b1d  （加密长密码, 即password_sha256_hex）
```

## 修改属主

```
cd /data && chown -R  clickhouse.clickhouse clickhouse
```

## 进程守护

使用systemd管理

以node1为例

```
# vim /etc/systemd/system/clickhouse_node1.service
 
 
[Unit]
Description=ClickHouse Server (analytic DBMS for big data)
Requires=network-online.target
After=network-online.target
 
[Service]
#Type=simple
Type=forking
User=clickhouse
Group=clickhouse
Restart=always
RestartSec=30
RuntimeDirectory=clickhouse-server
#ExecStart=/usr/bin/clickhouse-server --config=/etc/clickhouse-server/config.xml --pid-file=/run/clickhouse-server/clickhouse-server.pid
ExecStart=/usr/bin/clickhouse-server --daemon --config=/data/clickhouse/ch_9000/config.xml --pid-file=/data/clickhouse/node1/clickhouse-server.pid
#PIDFile=/data/clickhouse/node1/clickhouse-server.pid
LimitCORE=infinity
LimitNOFILE=500000
CapabilityBoundingSet=CAP_NET_ADMIN CAP_IPC_LOCK CAP_SYS_NICE
 
[Install]
WantedBy=multi-user.target
```

以上面的配置作为模板创建 node1~node6 的systemd配置文件

## ClickHouse服务启动

```
centos-1主机进行如下操作：
systemctl start clickhouse_node1.service
systemctl start clickhouse_node4.service
 
 
centos-2主机进行如下操作：
systemctl start clickhouse_node2.service
systemctl start clickhouse_node5.service
 
 
centos-3主机进行如下操作：
systemctl start clickhouse_node3.service
systemctl start clickhouse_node6.service
 
 
验证如下端口是否被监听：
netstat -anlp|grep 9000 （clickhouse tcp端口）
netstat -anlp|grep 9002 （clickhouse tcp端口）
netstat -anlp|grep 8123    (clickhouse http端口)
netstat -anlp|grep 8124    (clickhouse http端口)
netstat -anlp|grep 9009   (clickhouse 数据交互端口)
netstat -anlp|grep 9010    (clickhouse 数据交互端口)

 
 
登陆方式：
clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1 --query="show databases"
```

## 测试集群功能是否正常

### 创建数据库testdb

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1
ClickHouse client version 20.3.4.10 (official build).
Connecting to localhost:9000 as user default.
Connected to ClickHouse server version 20.3.4 revision 54433.

centos-1 :) create database testdb on cluster ch_cluster_all;

CREATE DATABASE testdb ON CLUSTER ck_cluster

┌─host─────┬─port─┬─status─┬─error─┬─num_hosts_remaining─┬─num_hosts_active─┐
│ centos-3 │ 9000 │      0 │       │                   5 │                0 │
│ centos-2 │ 9000 │      0 │       │                   4 │                0 │
│ centos-1 │ 9002 │      0 │       │                   3 │                0 │
│ centos-3 │ 9002 │      0 │       │                   2 │                0 │
│ centos-1 │ 9000 │      0 │       │                   1 │                0 │
│ centos-2 │ 9002 │      0 │       │                   0 │                0 │
└──────────┴──────┴────────┴───────┴─────────────────────┴──────────────────┘

6 rows in set. Elapsed: 0.107 sec. 
```

### 创建本地表

```
clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1 --query="CREATE TABLE testdb.sbtest_local
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/01-01/sbtest','node1')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SETTINGS index_granularity = 8192;"



clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-1 --query="CREATE TABLE testdb.sbtest_local
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/01-02/sbtest','node4')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SETTINGS index_granularity = 8192;"



clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-2 --query="CREATE TABLE testdb.sbtest_local
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/01-02/sbtest','node2')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SETTINGS index_granularity = 8192;"



clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-2 --query="CREATE TABLE testdb.sbtest_local
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/01-03/sbtest','node5')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SETTINGS index_granularity = 8192;"



clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-3 --query="CREATE TABLE testdb.sbtest_local
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/01-03/sbtest','node3')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SETTINGS index_granularity = 8192;"


clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-3 --query="CREATE TABLE testdb.sbtest_local
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/01-01/sbtest','node6')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID))
SETTINGS index_granularity = 8192;"
```

### 创建分布式表

```
clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1 --query="
CREATE TABLE testdb.sbtest (
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = Distributed(ck_cluster,testdb, sbtest_local, rand())"

clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-1 --query="
CREATE TABLE testdb.sbtest (
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = Distributed(ck_cluster,testdb, sbtest_local, rand())"

clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-2 --query="
CREATE TABLE testdb.sbtest (
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = Distributed(ck_cluster,testdb, sbtest_local, rand())"

clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-2 --query="
CREATE TABLE testdb.sbtest (
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = Distributed(ck_cluster,testdb, sbtest_local, rand())"

clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-3 --query="
CREATE TABLE testdb.sbtest (
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = Distributed(ck_cluster,testdb, sbtest_local, rand())"

clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-3 --query="
CREATE TABLE testdb.sbtest (
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = Distributed(ck_cluster,testdb, sbtest_local, rand())"
```

### 验证数据复制状态：

#### 写入分片1组的写入节点的local表

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1 --query="insert into testdb.sbtest_local VALUES (now(), 10000, 10000)"
```

#### 在分片1组local表可见一条记录

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1 --query="select * from testdb.sbtest_local"
2020-05-02 23:02:31     10000   10000
```

#### 在分片1 副本节点local读取可见一条记录

```
# clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-3 --query="select * from testdb.sbtest_local"
2020-05-02 23:02:31     10000   10000
```

#### 写入分片2组的写入节点的local表

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-2 --query="insert into testdb.sbtest_local VALUES (now(), 20000, 20000)"
```

#### 在分片2组local表可见一条记录

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-2 --query="select * from testdb.sbtest_local"
2020-05-02 23:03:31     20000   20000
```

#### 在分片2 副本节点local读取可见一条记录

```
# clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-1 --query="select * from testdb.sbtest_local"
2020-05-02 23:03:31     20000   20000
```

#### 写入分片3组的写入节点的local表

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-3 --query="insert into testdb.sbtest_local VALUES (now(), 30000, 30000)"
```

#### 在分片3组local表可见一条记录

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-3 --query="select * from testdb.sbtest_local"
2020-05-02 23:04:39     30000   30000
```

#### 在分片3 副本节点local读取可见一条记录

```
# clickhouse-client -u default --password xxxxxx --port 9002 -hcentos-2 --query="select * from testdb.sbtest_local"
2020-05-02 23:04:39     30000   30000
```

#### Distributed表验证

```
# clickhouse-client -u default --password xxxxxx --port 9000 -hcentos-1 --query="select * from testdb.sbtest"
2020-05-02 23:02:31     10000   10000
2020-05-02 23:03:31     20000   20000
2020-05-02 23:04:39     30000   30000
```

可以看到结果是之前写入的3条记录

结论，clickhouse基本功能正常

### macros建表

集群后期规模较大，创建分布式表时很复杂，clickhouse提供了在配置文件定义macros，创建表使用`{}`替代具体参数的方式，让表创建更透明方便。

> 可以在config.xml和metrika.xml中搜索一下macros找到相应的配置

使用以下语句连接一个节点即可再集群所有节点创建好对应的表

```
# ReplicatedMergeTree表示例：
CREATE TABLE testdb.sbtest_local on cluster ch_cluster_all
(
EventDate DateTime,
CounterID UInt32,
UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{layer}-{shard}/sbtest_local', '{replica}')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, EventDate, intHash32(UserID));
 
 
# Distributed表示例：
CREATE TABLE testdb.sbtest ON CLUSTER ch_cluster_all AS testdb.sbtest_local engine = Distributed(ch_cluster_all, testdb, sbtest_local, rand());
```

# ClickHouse用户管理

据我了解ClickHouse没有创建用户的语句(现在已经有了), 创建用户的方式是增加配置参数, ClickHouse会自动检测配置文件变化, 所以无需重启服务

在之前的配置中我们制定了如下配置

```
<users_config>/data/clickhouse/node1/users.xml</users_config>
```

这表示用户配置在这个文件下. 其实根据[官方文档](https://clickhouse.tech/docs/en/operations/configuration_files/)介绍, 我们可以在`/data/clickhouse/node1`目录下创建`users.d`目录, 为每个用户创建单独的配置文件, 这样就不必在一个`users.xml`中维护所有用户信息了, ClickHouse会自动合并`/data/clickhouse/node1/users.xml`和`/data/clickhouse/node1/users.d/*.xml`, 生产一个”运行时”配置`/data/clickhouse/node1/preprocessed_configs/users.xml`

例如我在`users.d`创建了两个用户

```
[root@centos-1 node1]# cd users.d/
[root@centos-1 users.d]# ll
total 12
-rwxr-xr-x 1 clickhouse clickhouse 1025 Apr 29 17:46 fanboshi.xml
-rwxr-xr-x 1 clickhouse clickhouse 1035 Apr 30 16:35 monitor_ro.xml
[root@centos-1 users.d]# cat fanboshi.xml 
<?xml version="1.0"?>
<yandex>
    <profiles>
        <fanboshi>
            <max_threads>8</max_threads>
            <load_balancing>random</load_balancing>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <log_queries>1</log_queries>
            <readonly>0</readonly>
            <max_memory_usage>54975581388</max_memory_usage>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <use_uncompressed_cache>0</use_uncompressed_cache>
        </fanboshi>
    </profiles>
    <users>
        <fanboshi>
            <password_sha256_hex>fanboshi_user_password_sha256_hex</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>fanboshi</profile>
            <quota>default</quota>
        </fanboshi>
    </users>
</yandex>
[root@centos-1 users.d]# cat monitor_ro.xml 
<?xml version="1.0"?>
<yandex>
    <profiles>
        <monitor_ro>
            <max_threads>8</max_threads>
            <load_balancing>random</load_balancing>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <log_queries>1</log_queries>
            <readonly>0</readonly>
            <max_memory_usage>54975581388</max_memory_usage>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <use_uncompressed_cache>0</use_uncompressed_cache>
        </monitor_ro>
    </profiles>
    <users>
        <monitor_ro>
            <password_sha256_hex>monitor_ro_user_password_sha256_hex</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>monitor_ro</profile>
            <quota>default</quota>
        </monitor_ro>
    </users>
</yandex>
```

目前我个人建议将一个用户的profile, quota等信息都配置到一个配置文件中, 避免混乱

如此配置之后, `/data/clickhouse/node1/preprocessed_configs/users.xml`就会自动合并我们的所有用户配置, 生成如下配置

```
<!-- This file was generated automatically.
     Do not edit it: it is likely to be discarded and generated again before it's read next time.
     Files used to generate this file:
       /data/clickhouse/node1/users.xml
       /data/clickhouse/node1/users.d/fanboshi.xml      -->

<yandex>
    <profiles>
        <default>
            <max_memory_usage>4294967296</max_memory_usage>
            <!-- 每个 session 的内存限制 -->
            <max_bytes_before_external_group_by>2147483648</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>2147483648</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>1</max_threads>
        </default>
        <readonly>
            <max_threads>1</max_threads>
            <max_memory_usage>4294967296</max_memory_usage>
            <max_bytes_before_external_group_by>2147483648</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>2147483648</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <readonly>1</readonly>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
        </readonly>
    
        <fanboshi>
            <max_threads>8</max_threads>
            <load_balancing>random</load_balancing>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <log_queries>1</log_queries>
            <readonly>0</readonly>
            <max_memory_usage>54975581388</max_memory_usage>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <use_uncompressed_cache>0</use_uncompressed_cache>
        </fanboshi>
    </profiles>
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
    <users>
        <default>
            <password_sha256_hex>default_user_password_sha256_hex</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </default>
        <ch_ro>
            <password_sha256_hex>ch_ro_user_password_sha256_hex</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>readonly</profile>
            <quota>default</quota>
        </ch_ro>
    
        <fanboshi>
            <password_sha256_hex>fanboshi_user_password_sha256_hex</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>fanboshi</profile>
            <quota>default</quota>
        </fanboshi>
    </users>

    
    

    
    
</yandex>
```

注意看这里

```
<!-- This file was generated automatically.
     Do not edit it: it is likely to be discarded and generated again before it's read next time.
     Files used to generate this file:
       /data/clickhouse/node1/users.xml
       /data/clickhouse/node1/users.d/fanboshi.xml      -->
```

创建用户还是比较麻烦的, 要在所有节点增加配置文件, 建议还是使用ansible之类的工具配合, 这里我给出我们现在使用的ansible role的关键部分吧, 关键就是template和var吧

template

```
#jinja2: lstrip_blocks:True
<?xml version="1.0"?>
<yandex>
    <profiles>
        <{{ user.name }}>
          {% for key, value in profile.settings.items() %}
            <{{ key }}>{{ value }}</{{ key }}>
          {% endfor %}
        </{{ user.name }}>
    </profiles>
    <users>
        <{{ user.name }}>
            <password_sha256_hex>{{ password_sha256_hex }}</password_sha256_hex>
            <networks>
            {% for key, values in user.networks.items() %}
              {% for value in values %}
                <{{ key }}>{{ value }}</{{ key }}>
              {% endfor %}
            {% endfor %}
            </networks>
            <profile>{{ user.name|default('default')}}</profile>
            <quota>{{quota|default('default')}}</quota>
          {% if user.allow_databases|default('')|length > 0 %}
            <allow_databases>
            {% for database in user.allow_databases %}
                <database>{{ database }}</database>
            {% endfor %}
            </allow_databases>
          {% endif %}
        </{{ user.name }}>
    </users>
</yandex>
```

var

```
---
# vars file for clickhouse_add_users
profile:
  settings:
    max_memory_usage: 54975581388
#    max_memory_usage_for_all_queries: 61847529062
    max_bytes_before_external_group_by: 21474836480
    max_bytes_before_external_sort: 21474836480
    use_uncompressed_cache: 0
    load_balancing: random
    distributed_aggregation_memory_efficient: 1
    max_threads: 8
    log_queries: 1
    readonly: 0

user:
  name: test
  password: ""
# 不要定义password_sha256_hex, password_sha256_hex应该根据password生成
  networks:
    ip:
      - ::/0
  quota: default
  allow_databases: []
```

# clickhouse-client prompt调整

根据[官方文档](https://clickhouse.tech/docs/en/interfaces/cli/)描述:

`clickhouse-client` uses the first existing file of the following:

- Defined in the `--config-file` parameter.
- `./clickhouse-client.xml`
- `~/.clickhouse-client/config.xml`
- `/etc/clickhouse-client/config.xml`

查看`/etc/clickhouse-client/config.xml`(yum安装会自动创建这个配置), 发现有示例配置

```
<prompt_by_server_display_name>
    <default>{display_name} :) </default>
    <test>{display_name} \x01\e[1;32m\x02:)\x01\e[0m\x02 </test> <!-- if it matched to the substring "test" in the server display name - -->
    <production>{display_name} \x01\e[1;31m\x02:)\x01\e[0m\x02 </production> <!-- if it matched to the substring "production" in the server display name -->
</prompt_by_server_display_name>
```

于是调整一下, 比如default改成

```
<default>{display_name} {user}@{host}:{port} [{database}]\n\x01\e[1;31m\x02:)\x01\e[0m\x02 </default>
#clickhouse-client -ufanboshi --ask-password 
ClickHouse client version 20.3.5.21 (official build).
Password for user (fanboshi): 
Connecting to localhost:9000 as user fanboshi.
Connected to ClickHouse server version 20.3.5 revision 54433.

bj2-clickhouse-all-prod-01 fanboshi@localhost:9000 [default]
:)  --其实笑脸是红色的..
```

其实这个配置还不是很理解, 因为你可以注意到我这里使用的用户是fanboshi, 而非`default`但却也应用到了这个prompt, 我怀疑是因为profile是`default`

```
#cat /data/clickhouse/ch_9000/users.d/fanboshi.xml 
<?xml version="1.0"?>
<yandex>
    <profiles>
        <fanboshi>
            <max_memory_usage>54975581388</max_memory_usage>
            <max_memory_usage_for_all_queries>61847529062</max_memory_usage_for_all_queries>
            <max_bytes_before_external_group_by>21474836480</max_bytes_before_external_group_by>
            <max_bytes_before_external_sort>21474836480</max_bytes_before_external_sort>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>random</load_balancing>
            <distributed_aggregation_memory_efficient>1</distributed_aggregation_memory_efficient>
            <max_threads>10</max_threads>
            <log_queries>1</log_queries>
        </fanboshi>
    </profiles>
    <users>
        <fanboshi>
            <password_sha256_hex>supersecurt</password_sha256_hex>
            <networks>
                <ip>::/0</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
        </fanboshi>
    </users>
</yandex>
```

## 实现类似mysql免输用户密码登录

我们都知道mysql cli可以通过在my.cnf添加如下参数实现快速登录

```
[client]
user=xx
password=xxx
```

clickhouse-client也可以

根据[官方文档](https://clickhouse.tech/docs/en/interfaces/cli/)描述, 在client config文件中添加如下参数即可

```
# vim ~/.clickhouse-client/config.xml 

<config>
    <user>username</user>
    <password>password</password>
    <secure>False</secure>
</config>
```

# 疑问

看了很多大佬的文章, 大家都是建议给应用提供一个负载均衡写本地表读分布式表, 而不直接通过分布式表写数据

我们搞技术的肯定不愿意人云亦云, 别人说什么就信什么, 当然前任经验肯定是有价值的

不过我想来想去还是有些没想明白直接写分布式表有什么致命缺陷, 于是在[ClickHouse中文社区提了一个问题](http://fuxkdb.com/2020/05/02/2020-05-02-ClickHouse多实例部署/(http://www.clickhouse.com.cn/topic/5ea591ffc609fc4935d80526)), 内容如下:

> 不过至今无人答复

看了sina高鹏大佬的分享 看了 https://github.com/ClickHouse/ClickHouse/issues/1854 还看了一些文章都是建议写本地表而不是分布式表 如果我设置`internal_replication=true`, 使用`ReplicatedMergeTree`引擎, 除了写本地表更灵活可控外, 写分布式表到底有什么致命缺陷吗? 因为要给同事解释, 只说一个大家说最佳实践是这样是不行的… 我自己也没理解到底写分布式表有啥大缺陷 如果说造成数据分布不均匀, `sharding key`我设为`rand()`还会有很大不均匀吗? 如果说扩容, 我也可以通过调整`weight`控制数据尽量写入新shared啊?

难道是因为文档中这段:

```
Data is written asynchronously. When inserted in the table, the data block is just written to the local file system. The data is sent to the remote servers in the background as soon as possible. The period for sending data is managed by the distributed_directory_monitor_sleep_time_ms and distributed_directory_monitor_max_sleep_time_ms settings. The Distributed engine sends each file with inserted data separately, but you can enable batch sending of files with the distributed_directory_monitor_batch_inserts setting. This setting improves cluster performance by better utilizing local server and network resources. You should check whether data is sent successfully by checking the list of files (data waiting to be sent) in the table directory: /var/lib/clickhouse/data/database/table/.

If the server ceased to exist or had a rough restart (for example, after a device failure) after an INSERT to a Distributed table, the inserted data might be lost. If a damaged data part is detected in the table directory, it is transferred to the ‘broken’ subdirectory and no longer used.
```

上面文档内容我理解意思是说假如我有S1 S2 S3 三个节点,每个节点都有local表和分布式表. 我向S1的分布式表写数据1, 2, 3 1写入S1, 2,3先写到S1本地文件系统, 然后异步发送到S2 S3 , 比如2发给S2, 3发给S3, 如果此时S3宕机了, 则3发到S3失败, 但是1,2还是成功写到S1,S2了? 所以整个过程不能保证原子性? 出现问题还要人为修数据? https://github.com/ClickHouse/ClickHouse/issues/1343 这个issue说S3 come back后S1会尝试重新发送数据给S3.

Data blocks are written in /var/lib/clickhouse/data/database/table/ folder. Special thread checks directory periodically and tries to send data. If it can’t, it will try next time.

那么只剩文档最后一句意思是如果S1过程中宕机, 会丢数据? 再就是weight是分片级别的, 不是表级别的, 灵活性差?

已经有答案了, 详见[ClickHouse到底改写本地表还是分布式表](http://fuxkdb.com/2020/09/22/2020-09-22-ClickHouse到底改写本地表还是分布式表/)