```
CREATE TABLE IF NOT EXISTS tables_dis ON CLUSTER default_cluster AS system.tables
ENGINE = Distributed('default_cluster', 'system', 'tables', rand())

┌─host─────────┬─port─┬─status─┬─error─┬─num_hosts_remaining─┬─num_hosts_active─┐
│ 172.16.24.9  │ 9000 │      0 │       │                   5 │                0 │
│ 172.16.24.10 │ 9000 │      0 │       │                   4 │                0 │
│ 172.16.24.17 │ 9000 │      0 │       │                   3 │                0 │
│ 172.16.24.6  │ 9000 │      0 │       │                   2 │                0 │
│ 172.16.24.13 │ 9000 │      0 │       │                   1 │                0 │
│ 172.16.24.11 │ 9000 │      0 │       │                   0 │                0 │
└──────────────┴──────┴────────┴───────┴─────────────────────┴──────────────────┘
```

