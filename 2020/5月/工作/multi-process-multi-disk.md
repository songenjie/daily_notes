#!/bin/bash

ip="hmm"

mysql --protocol=tcp -h $ip -P 9204 -udefault -e "
CREATE TABLE localtable
(
    EventDate DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/doris_ck_02/default_shard_01/localtable', 'replica_01')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID);"
```
