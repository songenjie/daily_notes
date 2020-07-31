Quotas 配额限制资源使用，这里不设计用户库表权限的问题

限制使用资源，限制有二种类型：

- 一是在固定周期里的执行次数(quotas)

- 二是限制用户或则查询的使用资源（profiles)

## Quota[ ](https://clickhouse.tech/docs/en/operations/access-rights/#quotas-management)

Quota limits resource usage. See [Quotas](https://clickhouse.tech/docs/en/operations/quotas/).

Quota contains a set of limits for some durations, as well as a list of roles and/or users which should use this quota.

Management queries:

- [CREATE QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/)
- [ALTER QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/alter/quota/#alter-quota-statement)
- [DROP QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/drop/#drop-quota-statement)
- [SHOW CREATE QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/show/#show-create-quota-statement)

## Enabling SQL-driven Access Control and Account Management[ ](https://clickhouse.tech/docs/en/operations/access-rights/#enabling-access-control)

- Setup a directory for configurations storage.

  ClickHouse stores access entity configurations in the folder set in the [access_control_path](https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#access_control_path) server configuration parameter.

- Enable SQL-driven access control and account management for at least one user account.

  By default, SQL-driven access control and account management is disabled for all users. You need to configure at least one user in the `users.xml` configuration file and set the value of the [access_management](https://clickhouse.tech/docs/en/operations/settings/settings-users/#access_management-user-setting) setting to 1.



quotas

在user.xml配置文件的选项组quotas里设置，限制该用户一段时间内的资源使用，即对一段时间内运行的一组查询施加限制，而不是限制单个查询。还具有限制单个查询的复杂性的功能。模板：

```xml
<!-- Quotas. -->
    <quotas>
        <!-- Name of quota. -->
        <default> --指定quotas名
            <!-- Limits for time interval. You could specify many intervals with different limits. -->
            <interval> --时间间隔
                <!-- Length of interval. -->
                <duration>3600</duration> --周期
                <!-- No limits. Just calculate resource usage for time interval. -->
                <queries>0</queries>
                <errors>0</errors>
                <result_rows>0</result_rows>
                <read_rows>0</read_rows>
                <execution_time>0</execution_time>
            </interval>
        </default>
    </quotas>
```

参数介绍：

默认情况下，配额仅跟踪每小时的资源消耗，而没有限制使用情况。在每个请求之后，将为每个时间间隔计算的资源消耗输出到服务器日志。

说明：

```
<default>：配额规则名。
<interval>：配置时间间隔，每个时间内的资源消耗限制。
<duration>：时间周期，单位秒。duration表示累计的时间周期，单位为秒，达到该时间周期后，清除所有收集的值，接下来的周期，将重新开始计算，当服务重启时，也会清除所有的值，重新开始新的周期。
<queries>：时间周期内允许的请求总数，0表示不限制。
<errors>：时间周期内允许的异常总数，0表示不限制
<result_rows>：时间周期内允许返回的行数，0表示不限制。
<read_rows>：时间周期内允许在分布式查询中，远端节点读取的数据行数，0表示不限制。
<execution_time>：时间周期内允许执行的查询时间，单位是秒，0表示不限制。
上面示例中的配置，属性值均为0，所以资源配额不做任何限制。现在继续声明另外一组配额：
```



Eg :statbox user

```xml
<statbox> <!-- 自定义名称-->
    <interval> 
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
```

为 ‘statbox’ 配额，限制设置为每小时和每24小时（86,400秒）。 时间间隔从实现定义的固定时刻开始计数。 换句话说，24小时间隔不一定从午夜开始。



从实施定义的固定时刻开始计算时间间隔。间隔结束时，将清除所有收集的值。 接下来的一个小时，配额计算将重新开始。对于分布式查询处理，累积量存储在请求者服务器上。 因此，如果用户转到另一台服务器，则那里的配额将重新开始。重新启动服务器后，配额将重置。



非时间周期内的限制

```
1：max_memory_usage：在单个ClickHouse服务进程中，运行一次查询限制使用的最大内存用量，默认值为10G；
2：max_memory_usage_for_user：在单个ClickHouse服务进程中，以用户为单位进行统计，单个用户在运行查询时，限制使用的最大内存用量，默认值为0，即不做限制；
3：max_memory_usage_for_all_queries：在单个ClickHouse服务进程中，所有运行的查询累加在一起，限制使用的最大内存用量，默认为0不做限制；
4：max_partitions_per_insert_block：在单次INSERT写入的时候，限制创建的最大分区个数，默认值为100个。如果超出这个阈值数目，将会得到异常；
5:max_rows_to_group_by：在执行GROUP BY聚合查询的时候，限制去重后的聚合KEY的最大个数，默认值为0，即不做限制。当超过阈值数量的时候，其处理方式由group_by_overflow_mode参数决定；
6:group_by_overflow_mode：当max_rows_to_group_by熔断规则触发的时候，有三种处理形式: 
throw抛出异常，此乃默认值；
break立即停止查询，并返回当前部分的数据；
any仅以当前已存在的聚合KEY，继续完成聚合查询；
7:max_bytes_before_external_group_by：在执行GROUP BY聚合查询的时候，限制使用的最大内存用量，默认值为0，即不做限制。当超过阈值数量的时候，聚合查询将会进一步借用本地磁盘。
```







# CREATE QUOTA[ ](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/#create-quota-statement)

Creates a [quota](https://clickhouse.tech/docs/en/operations/access-rights/#quotas-management) that can be assigned to a user or a role.

Syntax:

```mysql
CREATE QUOTA [IF NOT EXISTS | OR REPLACE] name [ON CLUSTER cluster_name]
    [KEYED BY {'none' | 'user name' | 'ip address' | 'client key' | 'client key or user name' | 'client key or ip address'}]
    [FOR [RANDOMIZED] INTERVAL number {SECOND | MINUTE | HOUR | DAY}
        {MAX { {QUERIES | ERRORS | RESULT ROWS | RESULT BYTES | READ ROWS | READ BYTES | EXECUTION TIME} = number } [,...] |
         NO LIMITS | TRACKING ONLY} [,...]]
    [TO {role [,...] | ALL | ALL EXCEPT role [,...]}]
```

`ON CLUSTER` clause allows creating quotas on a cluster, see [Distributed DDL](https://clickhouse.tech/docs/en/sql-reference/distributed-ddl/).

## Example[ ](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/#create-quota-example)

Limit the maximum number of queries for the current user with 123 queries in 15 months constraint:

```mysql
CREATE QUOTA qA FOR INTERVAL 15 MONTH MAX QUERIES 123 TO CURRENT_USER
```



# ALTER QUOTA[ ](https://clickhouse.tech/docs/en/sql-reference/statements/alter/quota/#alter-quota-statement)

Changes quotas.

Syntax:

```mysql
ALTER QUOTA [IF EXISTS] name [ON CLUSTER cluster_name]
    [RENAME TO new_name]
    [KEYED BY {'none' | 'user name' | 'ip address' | 'client key' | 'client key or user name' | 'client key or ip address'}]
    [FOR [RANDOMIZED] INTERVAL number {SECOND | MINUTE | HOUR | DAY}
        {MAX { {QUERIES | ERRORS | RESULT ROWS | RESULT BYTES | READ ROWS | READ BYTES | EXECUTION TIME} = number } [,...] |
        NO LIMITS | TRACKING ONLY} [,...]]
    [TO {role [,...] | ALL | ALL EXCEPT role [,...]}]
```





## DROP QUOTA[ ](https://clickhouse.tech/docs/en/sql-reference/statements/drop/#drop-quota-statement)

```
DROP QUOTA [IF EXISTS] name [,...] [ON CLUSTER cluster_name]
```





## SHOW CREATE QUOTA[ ](https://clickhouse.tech/docs/en/sql-reference/statements/show/#show-create-quota-statement)

Shows parameters that were used at a [quota creation](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/).







# system.quota_limits[ ](https://clickhouse.tech/docs/en/operations/system-tables/quota_limits/#system_tables-quota_limits)

Contains information about maximums for all intervals of all quotas. Any number of rows or zero can correspond to one quota.

Columns:
\- `quota_name` ([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Quota name.
\- `duration` ([UInt32](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/)) — Length of the time interval for calculating resource consumption, in seconds.
\- `is_randomized_interval` ([UInt8](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/#uint-ranges)) — Logical value. It shows whether the interval is randomized. Interval always starts at the same time if it is not randomized. For example, an interval of 1 minute always starts at an integer number of minutes (i.e. it can start at 11:20:00, but it never starts at 11:20:01), an interval of one day always starts at midnight UTC. If interval is randomized, the very first interval starts at random time, and subsequent intervals starts one by one. Values:
\- `0` — Interval is not randomized.
\- `1` — Interval is randomized.
\- `max_queries` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of queries.
\- `max_errors` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of errors.
\- `max_result_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of result rows.
\- `max_result_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of RAM volume in bytes used to store a queries result.
\- `max_read_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of rows read from all tables and table functions participated in queries.
\- `max_read_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of bytes read from all tables and table functions participated in queries.
\- `max_execution_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([Float64](https://clickhouse.tech/docs/en/sql-reference/data-types/float/))) — Maximum of the query execution time, in seconds.





# system.quota_usage[ ](https://clickhouse.tech/docs/en/operations/system-tables/quota_usage/#system_tables-quota_usage)

Quota usage by the current user: how much is used and how much is left.

Columns:
\- `quota_name` ([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Quota name.
\- `quota_key`([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Key value. For example, if keys = [`ip address`], `quota_key` may have a value ‘192.168.1.1’.
\- `start_time`([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([DateTime](https://clickhouse.tech/docs/en/sql-reference/data-types/datetime/))) — Start time for calculating resource consumption.
\- `end_time`([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([DateTime](https://clickhouse.tech/docs/en/sql-reference/data-types/datetime/))) — End time for calculating resource consumption.
\- `duration` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Length of the time interval for calculating resource consumption, in seconds.
\- `queries` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of requests on this interval.
\- `max_queries` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of requests.
\- `errors` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The number of queries that threw an exception.
\- `max_errors` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of errors.
\- `result_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of rows given as a result.
\- `max_result_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of result rows.
\- `result_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — RAM volume in bytes used to store a queries result.
\- `max_result_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum RAM volume used to store a queries result, in bytes.
\- `read_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of source rows read from tables for running the query on all remote servers.
\- `max_read_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of rows read from all tables and table functions participated in queries.
\- `read_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of bytes read from all tables and table functions participated in queries.
\- `max_read_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum of bytes read from all tables and table functions.
\- `execution_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([Float64](https://clickhouse.tech/docs/en/sql-reference/data-types/float/))) — The total query execution time, in seconds (wall time).
\- `max_execution_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([Float64](https://clickhouse.tech/docs/en/sql-reference/data-types/float/))) — Maximum of query execution time.



# system.quotas[ ](https://clickhouse.tech/docs/en/operations/system-tables/quotas/#system_tables-quotas)

Contains information about [quotas](https://clickhouse.tech/docs/en/operations/system-tables/quotas/).

Columns:
\- `name` ([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Quota name.
\- `id` ([UUID](https://clickhouse.tech/docs/en/sql-reference/data-types/uuid/)) — Quota ID.
\- `storage`([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Storage of quotas. Possible value: “users.xml” if a quota configured in the users.xml file, “disk” if a quota configured by an SQL-query.
\- `keys` ([Array](https://clickhouse.tech/docs/en/sql-reference/data-types/array/)([Enum8](https://clickhouse.tech/docs/en/sql-reference/data-types/enum/))) — Key specifies how the quota should be shared. If two connections use the same quota and key, they share the same amounts of resources. Values:
\- `[]` — All users share the same quota.
\- `['user_name']` — Connections with the same user name share the same quota.
\- `['ip_address']` — Connections from the same IP share the same quota.
\- `['client_key']` — Connections with the same key share the same quota. A key must be explicitly provided by a client. When using [clickhouse-client](https://clickhouse.tech/docs/en/interfaces/cli/), pass a key value in the `--quota-key` parameter, or use the `quota_key` parameter in the client configuration file. When using HTTP interface, use the `X-ClickHouse-Quota` header.
\- `['user_name', 'client_key']` — Connections with the same `client_key` share the same quota. If a key isn’t provided by a client, the qouta is tracked for `user_name`.
\- `['client_key', 'ip_address']` — Connections with the same `client_key` share the same quota. If a key isn’t provided by a client, the qouta is tracked for `ip_address`.
\- `durations` ([Array](https://clickhouse.tech/docs/en/sql-reference/data-types/array/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Time interval lengths in seconds.
\- `apply_to_all` ([UInt8](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/#uint-ranges)) — Logical value. It shows which users the quota is applied to. Values:
\- `0` — The quota applies to users specify in the `apply_to_list`.
\- `1` — The quota applies to all users except those listed in `apply_to_except`.
\- `apply_to_list` ([Array](https://clickhouse.tech/docs/en/sql-reference/data-types/array/)([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/))) — List of user names/[roles](https://clickhouse.tech/docs/en/operations/access-rights/#role-management) that the quota should be applied to.
\- `apply_to_except` ([Array](https://clickhouse.tech/docs/en/sql-reference/data-types/array/)([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/))) — List of user names/roles that the quota should not apply to.



# system.quotas_usage[ ](https://clickhouse.tech/docs/en/operations/system-tables/quotas_usage/#system_tables-quotas_usage)

Quota usage by all users.

Columns:
\- `quota_name` ([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Quota name.
\- `quota_key` ([String](https://clickhouse.tech/docs/en/sql-reference/data-types/string/)) — Key value.
\- `is_current` ([UInt8](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/#uint-ranges)) — Quota usage for current user.
\- `start_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([DateTime](https://clickhouse.tech/docs/en/sql-reference/data-types/datetime/)))) — Start time for calculating resource consumption.
\- `end_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([DateTime](https://clickhouse.tech/docs/en/sql-reference/data-types/datetime/)))) — End time for calculating resource consumption.
\- `duration` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt32](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Length of the time interval for calculating resource consumption, in seconds.
\- `queries` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of requests in this interval.
\- `max_queries` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of requests.
\- `errors` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The number of queries that threw an exception.
\- `max_errors` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of errors.
\- `result_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of rows given as a result.
\- `max_result_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum of source rows read from tables.
\- `result_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — RAM volume in bytes used to store a queries result.
\- `max_result_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum RAM volume used to store a queries result, in bytes.
\- `read_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/)))) — The total number of source rows read from tables for running the query on all remote servers.
\- `max_read_rows` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum number of rows read from all tables and table functions participated in queries.
\- `read_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — The total number of bytes read from all tables and table functions participated in queries.
\- `max_read_bytes` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([UInt64](https://clickhouse.tech/docs/en/sql-reference/data-types/int-uint/))) — Maximum of bytes read from all tables and table functions.
\- `execution_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([Float64](https://clickhouse.tech/docs/en/sql-reference/data-types/float/))) — The total query execution time, in seconds (wall time).
\- `max_execution_time` ([Nullable](https://clickhouse.tech/docs/en/sql-reference/data-types/nullable/)([Float64](https://clickhouse.tech/docs/en/sql-reference/data-types/float/))) — Maximum of query execution time.

