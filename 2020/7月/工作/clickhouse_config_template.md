![config_server](/source/clickhouse_configserer_serve.jpg)



# users.xml



```xml
<yandex>
    <profiles>
        <default>
            <max_memory_usage>240518168576</max_memory_usage>
            <use_uncompressed_cache>0</use_uncompressed_cache>
            <load_balancing>in_order</load_balancing>
        </default>
        <readonly>
            <load_balancing>in_order</load_balancing>
            <readonly>1</readonly>
        </readonly>
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



# metric.xml

```xml
<yandex>
<clickhouse_remote_servers>
    <ck_06>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>10.196.102.6</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>10.196.102.67</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>10.196.103.12</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>10.196.102.67</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>10.196.103.12</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>10.196.102.6</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <weight>1</weight>
            <internal_replication>true</internal_replication>
            <replica>
                <host>10.196.103.12</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>10.196.102.6</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>10.196.102.67</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>10.196.103.37</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>10.196.103.39</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>10.196.103.43</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>10.196.103.39</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>10.196.103.43</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>10.196.103.37</host>
                <port>9800</port>
            </replica>
        </shard>
        <shard>
            <internal_replication>true</internal_replication>
            <replica>
                <host>10.196.103.43</host>
                <port>9600</port>
            </replica>
            <replica>
                <host>10.196.103.37</host>
                <port>9700</port>
            </replica>
            <replica>
                <host>10.196.103.39</host>
                <port>9800</port>
            </replica>
        </shard>
    </ck_06>
</clickhouse_remote_servers>

<macros>
	<shard>RSHARD</shard>
	<replica>RREPLICA</replica>
</macros>

<zookeeper-servers>
  <node index="1">
    <host>10.198.16.71</host>
    <port>2281</port>
  </node>
  <node index="2">
    <host>10.198.16.74</host>
    <port>2281</port>
  </node>
  <node index="3">
    <host>10.198.16.75</host>
    <port>2281</port>
  </node>
</zookeeper-servers>

<networks>
   <ip>::/0</ip>
</networks>
 
<clickhouse_compression>
<case>
  <min_part_size>10000000000</min_part_size>            
  <min_part_size_ratio>0.01</min_part_size_ratio>
  <method>lz4</method>
</case>
</clickhouse_compression>
</yandex>

```





# config.xml



```xml
<?xml version="1.0"?>

<yandex>

    <logger>
        <!-- Possible levels: https://github.com/pocoproject/poco/blob/develop/Foundation/include/Poco/Logger.h#L105 -->
        <level>trace</level>
        <log>/data0/jdolap/clickhouse/log/clickhouse-server.log</log>
        <errorlog>/data0/jdolap/clickhouse/log/clickhouse-server.err.log</errorlog>
        <size>200M</size>
        <count>10</count>
        <!-- <console>1</console> --> <!-- Default behavior is autodetection (log to console if not daemon mode and is tty) -->
    </logger>
    <!--display_name>production</display_name--> <!-- It is the name that will be shown in the client -->
    <http_port>8623</http_port>
    <tcp_port>9600</tcp_port>
    <mysql_port>9504</mysql_port>
    <interserver_http_port>9509</interserver_http_port>
    <!-- For HTTPS and SSL over native protocol. -->
    <!--
    <https_port>8443</https_port>
    <tcp_port_secure>9440</tcp_port_secure>
    -->

    <!-- Used with https_port and tcp_port_secure. Full ssl options list: https://github.com/ClickHouse-Extras/poco/blob/master/NetSSL_OpenSSL/include/Poco/Net/SSLManager.h#L71 -->
    <openSSL>
        <server> <!-- Used for https server AND secure tcp port -->
            <!-- openssl req -subj "/CN=localhost" -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout /etc/clickhouse-server/server.key -out /etc/clickhouse-server/server.crt -->
            <certificateFile>/data0/jdolap/clickhouse/ssl/server.crt</certificateFile>
            <privateKeyFile>/data0/jdolap/clickhouse/ssl/server.key</privateKeyFile>
            <!-- openssl dhparam -out /etc/clickhouse-server/dhparam.pem 4096 -->
            <dhParamsFile>/data0/jdolap/clickhouse/ssl/dhparam.pem</dhParamsFile>
            <verificationMode>none</verificationMode>
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <cacheSessions>true</cacheSessions>
            <disableProtocols>sslv2,sslv3</disableProtocols>
            <preferServerCiphers>true</preferServerCiphers>
        </server>

        <client> <!-- Used for connecting to https dictionary source -->
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <cacheSessions>true</cacheSessions>
            <disableProtocols>sslv2,sslv3</disableProtocols>
            <preferServerCiphers>true</preferServerCiphers>
            <!-- Use for self-signed: <verificationMode>none</verificationMode> -->
            <invalidCertificateHandler>
                <!-- Use for self-signed: <name>AcceptCertificateHandler</name> -->
                <name>RejectCertificateHandler</name>
            </invalidCertificateHandler>
        </client>
    </openSSL>

    <!-- Default root page on http[s] server. For example load UI from https://tabix.io/ when opening http://localhost:8123 -->
    <!--
    <http_server_default_response><![CDATA[<html ng-app="SMI2"><head><base href="http://ui.tabix.io/"></head><body><div ui-view="" class="content-ui"></div><script src="http://loader.tabix.io/master.js"></script></body></html>]]></http_server_default_response>
    -->

    <!-- Port for communication between replicas. Used for data exchange. -->

    <!-- Hostname that is used by other replicas to request this server.
         If not specified, than it is determined analoguous to 'hostname -f' command.
         This setting could be used to switch replication to another network interface.
      -->
    <!--
    <interserver_http_host>example.yandex.ru</interserver_http_host>
    -->

    <!-- Listen specified host. use :: (wildcard IPv6 address), if you want to accept connections both with IPv4 and IPv6 from everywhere. -->
    <listen_host>::</listen_host> 
    <!-- Same for hosts with disabled ipv6: -->
    <!-- <listen_host>0.0.0.0</listen_host> -->

    <!-- Default values - try listen localhost on ipv4 and ipv6: -->
    <!--
    <listen_host>::1</listen_host>
    <listen_host>127.0.0.1</listen_host>
    -->
    <!-- Don't exit if ipv6 or ipv4 unavailable, but listen_host with this protocol specified -->
    <!-- <listen_try>0</listen_try> -->

    <!-- Allow listen on same address:port -->
    <!-- <listen_reuse_port>0</listen_reuse_port> -->

    <!-- <listen_backlog>64</listen_backlog> -->

    <max_connections>4096</max_connections>
    <keep_alive_timeout>3</keep_alive_timeout>

    <!-- Maximum number of concurrent queries. -->
    <max_concurrent_queries>300</max_concurrent_queries>

    <!-- Set limit on number of open files (default: maximum). This setting makes sense on Mac OS X because getrlimit() fails to retrieve
         correct maximum value. -->
    <!-- <max_open_files>262144</max_open_files> -->

    <!-- Size of cache of uncompressed blocks of data, used in tables of MergeTree family.
         In bytes. Cache is single for server. Memory is allocated only on demand.
         Cache is used when 'use_uncompressed_cache' user setting turned on (off by default).
         Uncompressed cache is advantageous only for very short queries and in rare cases.
      -->
    <uncompressed_cache_size>8589934592</uncompressed_cache_size>

    <!-- Approximate size of mark cache, used in tables of MergeTree family.
         In bytes. Cache is single for server. Memory is allocated only on demand.
         You should not lower this value.
      -->
    <mark_cache_size>5368709120</mark_cache_size>
    <path>/data0/jdolap/clickhouse/defaultdata/</path>

    <!-- Path to data directory, with trailing slash.
    <storage_policy>/data0/jdolap/clickhouse/conf/storage_policy.xml</storage_policy>
    -->

    <!-- Path to temporary data for processing hard queries. -->
    <tmp_path>/data0/jdolap/clickhouse/tmpdata/</tmp_path>

    <!-- Directory with user provided files that are accessible by 'file' table function. -->
    <user_files_path>/data0/jdolap/clickhouse/user_files/</user_files_path>

    <!-- Path to configuration file with users, access rights, profiles of settings, quotas. -->
    <users_config>/data0/jdolap/clickhouse/conf/users.xml</users_config>

    <!-- Default profile of settings. -->
    <default_profile>default</default_profile>

    <!-- System profile of settings. This settings are used by internal processes (Buffer storage, Distibuted DDL worker and so on). -->
    <system_profile>default</system_profile>

    <!-- Default database. -->
    <default_database>default</default_database>

    <!-- Server time zone could be set here.

         Time zone is used when converting between String and DateTime types,
          when printing DateTime in text formats and parsing DateTime from text,
          it is used in date and time related functions, if specific time zone was not passed as an argument.

         Time zone is specified as identifier from IANA time zone database, like UTC or Africa/Abidjan.
         If not specified, system time zone at server startup is used.

         Please note, that server could display time zone alias instead of specified name.
         Example: W-SU is an alias for Europe/Moscow and Zulu is an alias for UTC.
    -->
    <!-- <timezone>Europe/Moscow</timezone> -->

    <!-- You can specify umask here (see "man umask"). Server will apply it on startup.
         Number is always parsed as octal. Default umask is 027 (other users cannot read logs, data files, etc; group can only read).
    -->
    <!-- <umask>022</umask> -->

    <!-- Perform mlockall after startup to lower first queries latency
          and to prevent clickhouse executable from being paged out under high IO load.
         Enabling this option is recommended but will lead to increased startup time for up to a few seconds.
    -->
    <mlock_executable>false</mlock_executable>

    <!-- Configuration of clusters that could be used in Distributed tables.
         https://clickhouse.yandex/docs/en/table_engines/distributed/
      -->

    <!-- If element has 'incl' attribute, then for it's value will be used corresponding substitution from another file.
         By default, path to file with substitutions is /etc/metrika.xml. It could be changed in config in 'include_from' element.
         Values for substitutions are specified in /yandex/name_of_substitution elements in that file.
      -->

    <!-- ZooKeeper is used to store metadata about replicas, when using Replicated tables.
         Optional. If you don't use replicated tables, you could omit that.

         See https://clickhouse.yandex/docs/en/table_engines/replication/
      -->

   <remote_servers incl="clickhouse_remote_servers" >
   </remote_servers>
   <include_from>/data0/jdolap/clickhouse/conf/metrika.xml</include_from>
   <zookeeper incl="zookeeper-servers" optional="true" />

    <!-- Substitutions for parameters of replicated tables.
          Optional. If you don't use replicated tables, you could omit that.

         See https://clickhouse.yandex/docs/en/table_engines/replication/#creating-replicated-tables
      -->
    <macros incl="macros" optional="true" />


    <!-- Reloading interval for embedded dictionaries, in seconds. Default: 3600. -->
    <builtin_dictionaries_reload_interval>3600</builtin_dictionaries_reload_interval>


    <!-- Maximum session timeout, in seconds. Default: 3600. -->
    <max_session_timeout>3600</max_session_timeout>

    <!-- Default session timeout, in seconds. Default: 60. -->
    <default_session_timeout>60</default_session_timeout>

    <!-- Sending data to Graphite for monitoring. Several sections can be defined. -->
    <!--
        interval - send every X second
        root_path - prefix for keys
        hostname_in_path - append hostname to root_path (default = true)
        metrics - send data from table system.metrics
        events - send data from table system.events
        asynchronous_metrics - send data from table system.asynchronous_metrics
    -->
    <!--
    <graphite>
        <host>localhost</host>
        <port>42000</port>
        <timeout>0.1</timeout>
        <interval>60</interval>
        <root_path>one_min</root_path>
        <hostname_in_path>true</hostname_in_path>

        <metrics>true</metrics>
        <events>true</events>
        <events_cumulative>false</events_cumulative>
        <asynchronous_metrics>true</asynchronous_metrics>
    </graphite>
    <graphite>
        <host>localhost</host>
        <port>42000</port>
        <timeout>0.1</timeout>
        <interval>1</interval>
        <root_path>one_sec</root_path>

        <metrics>true</metrics>
        <events>true</events>
        <events_cumulative>false</events_cumulative>
        <asynchronous_metrics>false</asynchronous_metrics>
    </graphite>
    -->

    <!-- Serve endpoint fot Prometheus monitoring. -->
    <!--
        endpoint - mertics path (relative to root, statring with "/")
        port - port to setup server. If not defined or 0 than http_port used
        metrics - send data from table system.metrics
        events - send data from table system.events
        asynchronous_metrics - send data from table system.asynchronous_metrics
    -->
    <prometheus>
        <endpoint>/metrics</endpoint>
        <port>9663</port>

        <metrics>true</metrics>
        <events>true</events>
        <asynchronous_metrics>true</asynchronous_metrics>
    </prometheus>

    <!-- Query log. Used only for queries with setting log_queries = 1. -->
    <query_log>
        <!-- What table to insert data. If table is not exist, it will be created.
             When query log structure is changed after system update,
              then old table will be renamed and new table will be created automatically.
        -->
        <database>system</database>
        <table>query_log</table>
        <!--
            PARTITION BY expr https://clickhouse.yandex/docs/en/table_engines/custom_partitioning_key/
            Example:
                event_date
                toMonday(event_date)
                toYYYYMM(event_date)
                toStartOfHour(event_time)
        -->
        <partition_by>toYYYYMM(event_date)</partition_by>
        <!-- Interval of flushing data. -->
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_log>

    <!-- Trace log. Stores stack traces collected by query profilers.
         See query_profiler_real_time_period_ns and query_profiler_cpu_time_period_ns settings. -->
    <trace_log>
        <database>system</database>
        <table>trace_log</table>

        <partition_by>toYYYYMM(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </trace_log>

    <!-- Query thread log. Has information about all threads participated in query execution.
         Used only for queries with setting log_query_threads = 1. -->
    <query_thread_log>
        <database>system</database>
        <table>query_thread_log</table>
        <partition_by>toYYYYMM(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </query_thread_log>

    <!-- Uncomment if use part log.
         Part log contains information about all actions with parts in MergeTree tables (creation, deletion, merges, downloads).
    <part_log>
        <database>system</database>
        <table>part_log</table>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </part_log>
    -->

    <!-- Uncomment to write text log into table.
         Text log contains all information from usual server log but stores it in structured and efficient way.
    <text_log>
        <database>system</database>
        <table>text_log</table>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </text_log>
    -->

    <!-- Uncomment to write metric log into table.
         Metric log contains rows with current values of ProfileEvents, CurrentMetrics collected with "collect_interval_milliseconds" interval.
    <metric_log>
        <database>system</database>
        <table>metric_log</table>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
        <collect_interval_milliseconds>1000</collect_interval_milliseconds>
    </metric_log>
    -->

    <!-- Parameters for embedded dictionaries, used in Yandex.Metrica.
         See https://clickhouse.yandex/docs/en/dicts/internal_dicts/
    -->

    <!-- Path to file with region hierarchy. -->
    <!-- <path_to_regions_hierarchy_file>/opt/geo/regions_hierarchy.txt</path_to_regions_hierarchy_file> -->

    <!-- Path to directory with files containing names of regions -->
    <!-- <path_to_regions_names_files>/opt/geo/</path_to_regions_names_files> -->


    <!-- Configuration of external dictionaries. See:
         https://clickhouse.yandex/docs/en/dicts/external_dicts/
    -->
    <dictionaries_config>*_dictionary.xml</dictionaries_config>

    <!-- Uncomment if you want data to be compressed 30-100% better.
         Don't do that if you just started using ClickHouse.
      -->
    <compression incl="clickhouse_compression">
    <!--
        <!- - Set of variants. Checked in order. Last matching case wins. If nothing matches, lz4 will be used. - ->
        <case>

            <!- - Conditions. All must be satisfied. Some conditions may be omitted. - ->
            <min_part_size>10000000000</min_part_size>        <!- - Min part size in bytes. - ->
            <min_part_size_ratio>0.01</min_part_size_ratio>   <!- - Min size of part relative to whole table size. - ->

            <!- - What compression method to use. - ->
            <method>zstd</method>
        </case>
    -->
    </compression>

    <!-- Allow to execute distributed DDL queries (CREATE, DROP, ALTER, RENAME) on cluster.
         Works only if ZooKeeper is enabled. Comment it if such functionality isn't required. -->
    <distributed_ddl>
        <!-- Path in ZooKeeper to queue with DDL queries -->
        <path>/data0/jdolap/jdolap_ck_04/ddl</path>

        <!-- Settings from this profile will be used to execute DDL queries -->
        <!-- <profile>default</profile> -->
    </distributed_ddl>

    <!-- Settings to fine tune MergeTree tables. See documentation in source code, in MergeTreeSettings.h -->
    <!--
    <merge_tree>
        <max_suspicious_broken_parts>5</max_suspicious_broken_parts>
    </merge_tree>
    -->

    <!-- Protection from accidental DROP.
         If size of a MergeTree table is greater than max_table_size_to_drop (in bytes) than table could not be dropped with any DROP query.
         If you want do delete one table and don't want to change clickhouse-server config, you could create special file <clickhouse-path>/flags/force_drop_table and make DROP once.
         By default max_table_size_to_drop is 50GB; max_table_size_to_drop=0 allows to DROP any tables.
         The same for max_partition_size_to_drop.
         Uncomment to disable protection.
    -->
    <!-- <max_table_size_to_drop>0</max_table_size_to_drop> -->
    <!-- <max_partition_size_to_drop>0</max_partition_size_to_drop> -->

    <!-- Example of parameters for GraphiteMergeTree table engine -->
    <graphite_rollup_example>
        <pattern>
            <regexp>click_cost</regexp>
            <function>any</function>
            <retention>
                <age>0</age>
                <precision>3600</precision>
            </retention>
            <retention>
                <age>86400</age>
                <precision>60</precision>
            </retention>
        </pattern>
        <default>
            <function>max</function>
            <retention>
                <age>0</age>
                <precision>60</precision>
            </retention>
            <retention>
                <age>3600</age>
                <precision>300</precision>
            </retention>
            <retention>
                <age>86400</age>
                <precision>3600</precision>
            </retention>
        </default>
    </graphite_rollup_example>

    <!-- Directory in <clickhouse-path> containing schema files for various input formats.
         The directory will be created if it doesn't exist.
      -->
    <format_schema_path>/data0/jdolap/clickhouse/format_schemas/</format_schema_path>


    <!-- Uncomment to use query masking rules.
        name - name for the rule (optional)
        regexp - RE2 compatible regular expression (mandatory)
        replace - substitution string for sensitive data (optional, by default - six asterisks)
    <query_masking_rules>
        <rule>
            <name>hide SSN</name>
            <regexp>\b\d{3}-\d{2}-\d{4}\b</regexp>
            <replace>000-00-0000</replace>
        </rule>
    </query_masking_rules>
    -->

    <!-- Uncomment to disable ClickHouse internal DNS caching. -->
    <!-- <disable_internal_dns_cache>1</disable_internal_dns_cache> -->
    <storage_configuration>
        <disks>
            <disk0>
                <path>/data0/jdolap/clickhouse/data/</path>
            </disk0>
            <disk1>
                <path>/data1/jdolap/clickhouse/data/</path>
            </disk1>
            <disk6>
                <path>/data6/jdolap/clickhouse/data1/</path>
            </disk6>
            <disk7>
                <path>/data7/jdolap/clickhouse/data1/</path>
            </disk7>
        </disks>

        <policies>
            <jdob_ha>
                <volumes>
                    <hot>
                        <disk>disk0</disk>
                        <disk>disk1</disk>
			                  <max_data_part_size_bytes>3298534883328</max_data_part_size_bytes>
                    </hot>
                    <cold>
                        <disk>disk6</disk>
                        <disk>disk7</disk>
                    </cold>
                </volumes>
                <move_factor>0.25</move_factor>
            </jdob_ha>
        </policies>
    </storage_configuration>
</yandex>
```



# zookeeper.xml



```xml
<yandex>
    <logger>
        <level>trace</level>
        <size>100M</size>
        <count>3</count>
    </logger>

    <zookeeper>
      <node index="1">
        <host>10.198.16.71</host>
        <port>2281</port>
      </node>
      <node index="2">
        <host>10.198.16.74</host>
        <port>2281</port>
      </node>
      <node index="3">
        <host>10.198.16.75</host>
        <port>2281</port>
      </node>
    </zookeeper>
</yandex>
```





# schema.xml



```xml
<yandex>
    <!-- Configuration of clusters as in an ordinary server config -->
    <remote_servers>
        <ck_06>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>10.196.102.6</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <weight>1</weight>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>10.196.102.67</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <weight>1</weight>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>10.196.103.12</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>10.196.103.37</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>10.196.103.39</host>
                    <port>9600</port>
                </replica>
            </shard>
            <shard>
                <internal_replication>true</internal_replication>
                <replica>
                    <host>10.196.103.43</host>
                    <port>9600</port>
                </replica>
            </shard>
        </ck_06>
    </remote_servers>

        <!-- How many simultaneously active workers are possible. If you run more workers superfluous workers will sleep. -->
        <max_workers>2</max_workers>

        <!-- Setting used to fetch (pull) data from source cluster tables -->
        <settings_pull>
            <readonly>1</readonly>
        </settings_pull>

        <!-- Setting used to insert (push) data to destination cluster tables -->
        <settings_push>
            <readonly>0</readonly>
        </settings_push>

        <!-- Common setting for fetch (pull) and insert (push) operations. Also, copier process context uses it.
             They are overlaid by <settings_pull/> and <settings_push/> respectively. -->
        <settings>
            <connect_timeout>3</connect_timeout>
            <!-- Sync insert is set forcibly, leave it here just in case. -->
            <insert_distributed_sync>1</insert_distributed_sync>
        </settings>

        <!-- Copying tasks description.
             You could specify several table task in the same task description (in the same ZooKeeper node), they will be performed
             sequentially.
        -->
    <tables>
            <!-- A table task, copies one table. -->
        <tabletmp2>
            <!-- Source cluster name (from <remote_servers/> section) and tables in it that should be copied -->
            <cluster_pull>ck_06</cluster_pull>
            <database_pull>jason</database_pull>
            <table_pull>table2</table_pull>

            <!-- Destination cluster name and tables in which the data should be inserted -->
            <cluster_push>ck_06</cluster_push>
            <database_push>jason</database_push>
            <table_push>tabletmp5</table_push>

            <!-- Engine of destination tables.
                 If destination tables have not be created, workers create them using columns definition from source tables and engine
                 definition from here.

                 NOTE: If the first worker starts insert data and detects that destination partition is not empty then the partition will
                 be dropped and refilled, take it into account if you already have some data in destination tables. You could directly
                 specify partitions that should be copied in <enabled_partitions/>, they should be in quoted format like partition column of
                 system.parts table.
            -->
            <engine>
            ENGINE = ReplicatedMergeTree('/clickhouse/ck_06/jdob_ha/jason/{shard}/tabletmp5', '{replica}')
            PARTITION BY toYYYYMMDD(EventDate)
            ORDER BY (CounterID, EventDate, intHash32(UserID))
            SAMPLE BY intHash32(UserID)
            SETTINGS storage_policy = 'jdob_ha';
            </engine>

            <!-- Sharding key used to insert data to destination cluster 
            <sharding_key>jumpConsistentHash(intHash64(UserID), 2)</sharding_key>-->
            <sharding_key>rand()</sharding_key>

            <!-- Optional expression that filter data while pull them from source servers 
            <where_condition>CounterID != 0</where_condition>-->

            <!-- This section specifies partitions that should be copied, other partition will be ignored.
                 Partition names should have the same format as
                 partition column of system.parts table (i.e. a quoted text).
                 Since partition key of source and destination cluster could be different,
                 these partition names specify destination partitions.

                 NOTE: In spite of this section is optional (if it is not specified, all partitions will be copied),
                 it is strictly recommended to specify them explicitly.
                 If you already have some ready partitions on destination cluster they
                 will be removed at the start of the copying since they will be interpeted
                 as unfinished data from the previous copying!!!
            -->
            <enabled_partitions>
                <partition>20200617</partition>
            </enabled_partitions>
        </tabletmp2>

    </tables>

</yandex>
```





```
<networks incl="networks" replace="replace">
 
<networks>
  <incl>networks</incl>
  <replace>replace</replace>
</networks>
```

