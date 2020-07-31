```
BJHTYD-Hope-42-2.hadoop.jd.local :) create database if not exists jasons  on cluster system_cluster;

CREATE DATABASE IF NOT EXISTS jasons ON CLUSTER system_cluster

┌─host─────────┬─port─┬─status─┬─error─┬─num_hosts_remaining─┬─num_hosts_active─┐
│ 10.198.42.35 │ 9600 │      0 │       │                  89 │                0 │
│ 10.198.42.2  │ 9600 │      0 │       │                  88 │                0 │
│ 10.198.42.11 │ 9600 │      0 │       │                  87 │                0 │
│ 10.198.42.42 │ 9600 │      0 │       │                  86 │                0 │
│ 10.198.42.71 │ 9600 │      0 │       │                  85 │                0 │
│ 10.198.42.43 │ 9600 │      0 │       │                  84 │                0 │
│ 10.198.42.3  │ 9600 │      0 │       │                  83 │                0 │
│ 10.198.17.37 │ 9600 │      0 │       │                  82 │                0 │
│ 10.198.17.5  │ 9600 │      0 │       │                  81 │                0 │
│ 10.198.17.8  │ 9600 │      0 │       │                  80 │                0 │
│ 10.198.17.39 │ 9600 │      0 │       │                  79 │                0 │
│ 10.198.42.72 │ 9600 │      0 │       │                  78 │                0 │
│ 10.198.17.40 │ 9600 │      0 │       │                  77 │                0 │
│ 10.198.42.34 │ 9600 │      0 │       │                  76 │                0 │
│ 10.198.17.38 │ 9600 │      0 │       │                  75 │                0 │
│ 10.198.17.9  │ 9600 │      0 │       │                  74 │                0 │
│ 10.198.42.66 │ 9600 │      0 │       │                  73 │                0 │
│ 10.198.42.7  │ 9600 │      0 │       │                  72 │                0 │
└──────────────┴──────┴────────┴───────┴─────────────────────┴──────────────────┘
Cancelling query.
Query was cancelled.

18 rows in set. Elapsed: 6.140 sec. 

BJHTYD-Hope-42-2.hadoop.jd.local :) ^C
BJHTYD-Hope-42-2.hadoop.jd.local :) ^C
BJHTYD-Hope-42-2.hadoop.jd.local :) ^C
BJHTYD-Hope-42-2.hadoop.jd.local :) create database if not exists jasons  on cluster system_cluster;^C
BJHTYD-Hope-42-2.hadoop.jd.local :) exit;
Bye.
[prodadmin@A01-R04-I170-143-DV46J92 clickhouse]$ ./clickhouse client -h 10.198.42.2  --port 9700 -udefault -m --password
ClickHouse client version 20.4.3.1.
Password for user (default): 
Connecting to 10.198.42.2:9700 as user default.
Connected to ClickHouse server version 20.5.2 revision 54435.

ClickHouse client version is older than ClickHouse server. It may lack support for new features.

BJHTYD-Hope-42-2.hadoop.jd.local :) create database if not exists jasons  on cluster system_cluster;

CREATE DATABASE IF NOT EXISTS jasons ON CLUSTER system_cluster

┌─host──────────┬─port─┬─status─┬─error─┬─num_hosts_remaining─┬─num_hosts_active─┐
│ 10.198.17.6   │ 9700 │      0 │       │                  89 │                0 │
│ 10.198.42.2   │ 9700 │      0 │       │                  88 │                0 │
│ 10.198.42.5   │ 9700 │      0 │       │                  87 │                0 │
│ 10.198.42.35  │ 9700 │      0 │       │                  86 │                0 │
│ 10.198.17.9   │ 9700 │      0 │       │                  85 │                0 │
│ 10.198.42.11  │ 9700 │      0 │       │                  84 │                0 │
│ 10.198.42.71  │ 9700 │      0 │       │                  83 │                0 │
│ 10.198.17.37  │ 9700 │      0 │       │                  82 │                0 │
│ 10.198.17.5   │ 9700 │      0 │       │                  81 │                0 │
│ 10.198.17.34  │ 9700 │      0 │       │                  80 │                0 │
│ 10.198.17.42  │ 9700 │      0 │       │                  79 │                0 │
│ 10.198.41.135 │ 9700 │      0 │       │                  78 │                0 │
│ 10.198.17.39  │ 9700 │      0 │       │                  77 │                0 │
│ 10.198.17.36  │ 9700 │      0 │       │                  76 │                0 │
│ 10.198.17.40  │ 9700 │      0 │       │                  75 │                0 │
│ 10.198.42.43  │ 9700 │      0 │       │                  74 │                0 │
│ 10.198.42.34  │ 9700 │      0 │       │                  73 │                0 │
│ 10.198.17.7   │ 9700 │      0 │       │                  72 │                0 │
│ 10.198.17.35  │ 9700 │      0 │       │                  71 │                0 │
│ 10.198.17.38  │ 9700 │      0 │       │                  70 │                0 │
└───────────────┴──────┴────────┴───────┴─────────────────────┴──────────────────┘
↓ Progress: 20.00 rows, 1.11 KB (86.49 rows/s., 4.82 KB/s.)  22%
Cancelling query.
Query was cancelled.

20 rows in set. Elapsed: 16.661 sec. 

BJHTYD-Hope-42-2.hadoop.jd.local :) show databases;

SHOW DATABASES

┌─name───────────────────────────┐
│ _temporary_and_external_tables │
│ default                        │
│ jasons                         │
│ system                         │
└────────────────────────────────┘

4 rows in set. Elapsed: 0.006 sec. 

BJHTYD-Hope-42-2.hadoop.jd.local :) exit;
Bye.
[prodadmin@A01-R04-I170-143-DV46J92 clickhouse]$ ./clickhouse client -h 10.198.42.2  --port 9800 -udefault -m --password
ClickHouse client version 20.4.3.1.
Password for user (default): 
Connecting to 10.198.42.2:9800 as user default.
Connected to ClickHouse server version 20.5.2 revision 54435.

ClickHouse client version is older than ClickHouse server. It may lack support for new features.

BJHTYD-Hope-42-2.hadoop.jd.local :) create database if not exists jasons  on cluster system_cluster;

CREATE DATABASE IF NOT EXISTS jasons ON CLUSTER system_cluster

┌─host─────────┬─port─┬─status─┬─error─┬─num_hosts_remaining─┬─num_hosts_active─┐
│ 10.198.42.42 │ 9800 │      0 │       │                  89 │                0 │
│ 10.198.42.35 │ 9800 │      0 │       │                  88 │                0 │
│ 10.198.17.9  │ 9800 │      0 │       │                  87 │                0 │
│ 10.198.42.5  │ 9800 │      0 │       │                  86 │                0 │
│ 10.198.42.3  │ 9800 │      0 │       │                  85 │                0 │
│ 10.198.17.42 │ 9800 │      0 │       │                  84 │                0 │
│ 10.198.17.37 │ 9800 │      0 │       │                  83 │                0 │
│ 10.198.17.8  │ 9800 │      0 │       │                  82 │                0 │
│ 10.198.17.43 │ 9800 │      0 │       │                  81 │                0 │
│ 10.198.42.72 │ 9800 │      0 │       │                  80 │                0 │
│ 10.198.17.36 │ 9800 │      0 │       │                  79 │                0 │
│ 10.198.17.35 │ 9800 │      0 │       │                  78 │                0 │
│ 10.198.42.34 │ 9800 │      0 │       │                  77 │                0 │
│ 10.198.42.43 │ 9800 │      0 │       │                  76 │                0 │
│ 10.198.17.7  │ 9800 │      0 │       │                  75 │                0 │
│ 10.198.17.4  │ 9800 │      0 │       │                  74 │                0 │
│ 10.198.42.7  │ 9800 │      0 │       │                  73 │                0 │
│ 10.198.42.11 │ 9800 │      0 │       │                  72 │                0 │
│ 10.198.17.38 │ 9800 │      0 │       │                  71 │                0 │
│ 10.198.42.2  │ 9800 │      0 │       │                  70 │                0 │
└──────────────┴──────┴────────┴───────┴─────────────────────┴──────────────────┘
Cancelling query.
Query was cancelled.

```

