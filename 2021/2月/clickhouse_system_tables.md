Unlike other system tables, the system log tables [metric_log](https://clickhouse.tech/docs/en/operations/system-tables/metric_log/), [query_log](https://clickhouse.tech/docs/en/operations/system-tables/query_log/), [query_thread_log](https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log/), [trace_log](https://clickhouse.tech/docs/en/operations/system-tables/trace_log/), [part_log](https://clickhouse.tech/docs/en/operations/system-tables/part_log/), crash_log and [text_log](https://clickhouse.tech/docs/en/operations/system-tables/text_log/) are served by [MergeTree](https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/) table engine and store their data in a storage filesystem by default. If you remove a table from a filesystem, the ClickHouse server creates the empty one again at the time of the next data writing. If system table schema changed in a new release, then ClickHouse renames the current table and creates a new one.



```xml
   <!-- Query log. Used only for queries with setting log_queries = 1. -->
    <query_log>
        <!-- What table to insert data. If table is not exist, it will be created.
             When query log structure is changed after system update,
              then old table will be renamed and new table will be created automatically.
        -->
        <database>system</database>
        <table>query_log</table>
        <!--
            PARTITION BY expr: https://clickhouse.yandex/docs/en/table_engines/custom_partitioning_key/
            Example:
                event_date
                toMonday(event_date)
                toYYYYMM(event_date)
                toStartOfHour(event_time)
        -->
        <partition_by>toYYYYMM(event_date)</partition_by>
        <!--
            Table TTL specification: https://clickhouse.tech/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-table-ttl
            Example:
                event_date + INTERVAL 1 WEEK
                event_date + INTERVAL 7 DAY DELETE
                event_date + INTERVAL 2 WEEK TO DISK 'bbb'

        <ttl>event_date + INTERVAL 30 DAY DELETE</ttl>
        -->

        <!-- Instead of partition_by, you can provide full engine expression (starting with ENGINE = ) with parameters,
             Example: <engine>ENGINE = MergeTree PARTITION BY toYYYYMM(event_date) ORDER BY (event_date, event_time) SETTINGS index_granularity = 1024</engine>
          -->

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
         The level of the messages that goes to the table can be limited (<level>), if not specified all messages will go to the table.
    <text_log>
        <database>system</database>
        <table>text_log</table>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
        <level></level>
    </text_log>
    -->

    <!-- Metric log contains rows with current values of ProfileEvents, CurrentMetrics collected with "collect_interval_milliseconds" interval. -->
    <metric_log>
        <database>system</database>
        <table>metric_log</table>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
        <collect_interval_milliseconds>1000</collect_interval_milliseconds>
    </metric_log>

    <!--
        Asynchronous metric log contains values of metrics from
        system.asynchronous_metrics.
    -->
    <asynchronous_metric_log>
        <database>system</database>
        <table>asynchronous_metric_log</table>
        <!--
            Asynchronous metrics are updated once a minute, so there is
            no need to flush more often.
        -->
        <flush_interval_milliseconds>60000</flush_interval_milliseconds>
    </asynchronous_metric_log>

    <!--
        OpenTelemetry log contains OpenTelemetry trace spans.
    -->
    <opentelemetry_span_log>
        <!--
            The default table creation code is insufficient, this <engine> spec
            is a workaround. There is no 'event_time' for this log, but two times,
            start and finish. It is sorted by finish time, to avoid inserting
            data too far away in the past (probably we can sometimes insert a span
            that is seconds earlier than the last span in the table, due to a race
            between several spans inserted in parallel). This gives the spans a
            global order that we can use to e.g. retry insertion into some external
            system.
        -->
        <engine>
            engine MergeTree
            partition by toYYYYMM(finish_date)
            order by (finish_date, finish_time_us, trace_id)
        </engine>
        <database>system</database>
        <table>opentelemetry_span_log</table>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </opentelemetry_span_log>


    <!-- Crash log. Stores stack traces for fatal errors.
         This table is normally empty. -->
    <crash_log>
        <database>system</database>
        <table>crash_log</table>

        <partition_by />
        <flush_interval_milliseconds>1000</flush_interval_milliseconds>
    </crash_log>
```





User

```xml
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
    -->
    <part_log>
        <database>system</database>
        <table>part_log</table>
        <partition_by>toMonday(event_date)</partition_by>
        <flush_interval_milliseconds>7500</flush_interval_milliseconds>
    </part_log>
```

