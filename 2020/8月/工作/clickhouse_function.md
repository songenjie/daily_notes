```
https://www.cnblogs.com/superdrew/p/11279663.html
```







```mysql
select database , 
table as "表名",
partition,
sum(rows) as "总行数",
formatReadableSize(sum(data_uncompressed_bytes)) as "原始大小",
formatReadableSize(sum(data_compressed_bytes)) as "压缩大小",
round(sum(data_compressed_bytes) / sum(data_uncompressed_bytes) * 100, 0) "压缩率"
from system.parts
where database ='waiter'
group by `database`,`table`,`partition`
order by `database`,`table`,`partition`;
```







```mysql
CREATE TABLE alpha.odm_alpha_adl_rta_impression_message_i_d_local
(
    `etl_dt` Nullable(String),
    `rt_meta` Nullable(String),
    `id` Nullable(String),
    `third_request_id` Nullable(String),
    `third_request_time` String,
    `third_channel` String,
    `source_app` String,
    `device_os` String,
    `device_idfa` Nullable(String),
    `device_imei` Nullable(String),
    `device_android` Nullable(String),
    `device_mac` Nullable(String),
    `device_oaid` Nullable(String),
    `placement_id` Nullable(String),
    `age` Nullable(String),
    `gender` Nullable(String),
    `ad_types` Nullable(String),
    `city` Nullable(String),
    `ip` Nullable(String),
    `rta_score` Nullable(String),
    `rta_threshold` Nullable(String),
    `rta_result` Nullable(String),
    `rank_response_code` Nullable(String),
    `remark` Nullable(String),
    `request_date` Date
)
ENGINE = ReplicatedMergeTree('/clickhouse/alpha/tables/{layer}-{shard}/odm_alpha_adl_rta_impression_message_i_d_local', '{replica}')
PARTITION BY toYYYYMMDD(request_date)
ORDER BY (third_channel, source_app, device_os)
SETTINGS index_granularity = 8192
```

```mysql
CREATE TABLE alpha.odm_alpha_adl_rta_impression_message_i_d
(
    `etl_dt` Nullable(String),
    `rt_meta` Nullable(String),
    `id` Nullable(String),
    `third_request_id` Nullable(String),
    `third_request_time` String,
    `third_channel` String,
    `source_app` String,
    `device_os` String,
    `device_idfa` Nullable(String),
    `device_imei` Nullable(String),
    `device_android` Nullable(String),
    `device_mac` Nullable(String),
    `device_oaid` Nullable(String),
    `placement_id` Nullable(String),
    `age` Nullable(String),
    `gender` Nullable(String),
    `ad_types` Nullable(String),
    `city` Nullable(String),
    `ip` Nullable(String),
    `rta_score` Nullable(String),
    `rta_threshold` Nullable(String),
    `rta_result` Nullable(String),
    `rank_response_code` Nullable(String),
    `remark` Nullable(String),
    `request_date` Date
)
ENGINE = Distributed(alpha_rta_ck_cluster, alpha, odm_alpha_adl_rta_impression_message_i_d_local, rand())

//rand()需要修改 third_channel,ad_types
```





issues



1. 存储 和 计算优化 
   - third_channel  int8 (如果只有 两种 直接可以换成 boolean )
   - Ad_types int16

```
 select    request_date,     third_channel,     ad_types , count(ad_types)  FROM alpha.odm_alpha_adl_rta_impression_message_i_d_local GROUP BY     request_date,     third_channel,     ad_types;

SELECT 
    request_date,
    third_channel,
    ad_types,
    count(ad_types)
FROM alpha.odm_alpha_adl_rta_impression_message_i_d_local
GROUP BY 
    request_date,
    third_channel,
    ad_types

┌─request_date─┬─third_channel─┬─ad_types─┬─count(ad_types)─┐
│   2020-08-12 │ 1             │ 0        │         9266758 │
│   2020-08-04 │ 1             │ 6        │         9574660 │
│   2020-08-05 │ 1             │ 8        │        14382125 │
│   2020-08-08 │ 1             │ 9        │        10318716 │
│   2020-08-09 │ 1             │ 7        │         9654763 │
│   2020-08-01 │ 1             │ 1        │        14220901 │
│   2020-08-11 │ 1             │ 7        │         9168230 │
│   2020-08-10 │ 1             │ 9        │         9727843 │
│   2020-08-03 │ 1             │ 1        │        14170376 │
│   2020-08-06 │ 1             │ 0        │        14841206 │
│   2020-08-14 │ 1             │ 7        │         6545031 │
│   2020-08-06 │ 1             │ 1        │        14852099 │
│   2020-08-14 │ 1             │ 6        │         6542369 │
│   2020-08-10 │ 1             │ 8        │         9723074 │
│   2020-08-11 │ 1             │ 6        │         9171089 │
│   2020-08-03 │ 1             │ 0        │        14158113 │
│   2020-08-09 │ 1             │ 6        │         9658808 │
│   2020-08-08 │ 1             │ 8        │        10313610 │
│   2020-08-01 │ 1             │ 0        │        14217467 │
│   2020-08-12 │ 1             │ 1        │         9270078 │
│   2020-08-05 │ 1             │ 9        │        14390745 │
│   2020-08-04 │ 1             │ 7        │         9572849 │
│   2020-08-01 │ 1             │ 2        │        14220349 │
│   2020-08-09 │ 1             │ 4        │         9658082 │
│   2020-08-04 │ 1             │ 5        │         9570550 │
│   2020-08-12 │ 1             │ 3        │         9269105 │
│   2020-08-06 │ 1             │ 3        │        14843846 │
│   2020-08-14 │ 1             │ 4        │         6546123 │
│   2020-08-03 │ 1             │ 2        │        14161586 │
│   2020-08-11 │ 1             │ 4        │         9172940 │
│   2020-08-03 │ 1             │ 3        │        14160403 │
│   2020-08-11 │ 1             │ 5        │         9171792 │
│   2020-08-06 │ 1             │ 2        │        14841266 │
│   2020-08-14 │ 1             │ 5        │         6541514 │
│   2020-08-04 │ 1             │ 4        │         9577397 │
│   2020-08-12 │ 1             │ 2        │         9263471 │
│   2020-08-01 │ 1             │ 3        │        14215818 │
│   2020-08-09 │ 1             │ 5        │         9658211 │
│   2020-08-06 │ 1             │ 6        │        14838028 │
│   2020-08-14 │ 1             │ 1        │         6546461 │
│   2020-08-07 │ 1             │ 8        │         7992940 │
│   2020-08-11 │ 1             │ 1        │         9174463 │
│   2020-08-02 │ 1             │ 9        │        14297790 │
│   2020-08-02 │ 2             │ 0        │        19192861 │
│   2020-08-03 │ 1             │ 7        │        14157605 │
│   2020-08-09 │ 1             │ 1        │         9660838 │
│   2020-08-01 │ 1             │ 7        │        14217464 │
│   2020-07-31 │ 2             │ 0        │         5972052 │
│   2020-07-31 │ 1             │ 9        │         4522115 │
│   2020-08-13 │ 1             │ 8        │         9294029 │
│   2020-08-12 │ 1             │ 6        │         9261400 │
│   2020-08-04 │ 1             │ 0        │         9575232 │
│   2020-08-12 │ 1             │ 7        │         9264455 │
│   2020-08-13 │ 1             │ 9        │         9300042 │
│   2020-08-04 │ 1             │ 1        │         9580768 │
│   2020-08-09 │ 1             │ 0        │         9654506 │
│   2020-07-31 │ 1             │ 8        │         4520159 │
│   2020-07-31 │ 2             │ 1        │         5391696 │
│   2020-08-01 │ 1             │ 6        │        14214744 │
│   2020-08-11 │ 1             │ 0        │         9170665 │
│   2020-08-03 │ 1             │ 6        │        14152176 │
│   2020-08-02 │ 2             │ 1        │        20793487 │
│   2020-08-02 │ 1             │ 8        │        14295223 │
│   2020-08-07 │ 1             │ 9        │         7994612 │
│   2020-08-06 │ 1             │ 7        │        14836655 │
│   2020-08-14 │ 1             │ 0        │         6544186 │
│   2020-08-03 │ 1             │ 4        │        14160946 │
│   2020-08-11 │ 1             │ 2        │         9174406 │
│   2020-08-06 │ 1             │ 5        │        14844645 │
│   2020-08-14 │ 1             │ 2        │         6545444 │
│   2020-08-04 │ 1             │ 3        │         9575773 │
│   2020-08-12 │ 1             │ 5        │         9260238 │
│   2020-08-01 │ 1             │ 4        │        14218031 │
│   2020-08-09 │ 1             │ 2        │         9659385 │
│   2020-08-01 │ 1             │ 5        │        14207852 │
│   2020-08-09 │ 1             │ 3        │         9655858 │
│   2020-08-04 │ 1             │ 2        │         9576182 │
│   2020-08-12 │ 1             │ 4        │         9265790 │
│   2020-08-06 │ 1             │ 4        │        14842118 │
│   2020-08-14 │ 1             │ 3        │         6551506 │
│   2020-08-03 │ 1             │ 5        │        14152651 │
│   2020-08-11 │ 1             │ 3        │         9176924 │
│   2020-08-08 │ 1             │ 4        │        10315911 │
│   2020-07-31 │ 1             │ 2        │         4518400 │
│   2020-08-13 │ 1             │ 3        │         9294493 │
│   2020-08-05 │ 1             │ 5        │        14393681 │
│   2020-08-07 │ 1             │ 3        │         7996283 │
│   2020-08-10 │ 1             │ 4        │         9729862 │
│   2020-08-02 │ 1             │ 2        │        14298508 │
│   2020-08-10 │ 1             │ 5        │         9731939 │
│   2020-08-02 │ 1             │ 3        │        14294508 │
│   2020-08-07 │ 1             │ 2        │         8001388 │
│   2020-08-13 │ 1             │ 2        │         9298505 │
│   2020-08-05 │ 1             │ 4        │        14388320 │
│   2020-08-08 │ 1             │ 5        │        10321250 │
│   2020-07-31 │ 1             │ 3        │         4515792 │
│   2020-08-04 │ 1             │ 8        │         9569625 │
│   2020-08-04 │ 2             │ ᴺᵁᴸᴸ     │               0 │
│   2020-08-04 │ 2             │ 1        │         7459444 │
│   2020-08-05 │ 1             │ 6        │        14387806 │
│   2020-08-13 │ 1             │ 0        │         9296731 │
│   2020-07-31 │ 1             │ 1        │         4516715 │
│   2020-08-08 │ 1             │ 7        │        10312809 │
│   2020-08-09 │ 1             │ 9        │         9654226 │
│   2020-08-02 │ 1             │ 1        │        14301193 │
│   2020-08-11 │ 1             │ 9        │         9172302 │
│   2020-08-10 │ 1             │ 7        │         9723470 │
│   2020-08-14 │ 1             │ 9        │         6541211 │
│   2020-08-07 │ 1             │ 0        │         7996878 │
│   2020-08-07 │ 1             │ 1        │         7993603 │
│   2020-08-14 │ 1             │ 8        │         6546187 │
│   2020-08-02 │ 1             │ 0        │        14295674 │
│   2020-08-10 │ 1             │ 6        │         9730975 │
│   2020-08-11 │ 1             │ 8        │         9164849 │
│   2020-07-31 │ 1             │ 0        │         4516202 │
│   2020-08-09 │ 1             │ 8        │         9655530 │
│   2020-08-08 │ 1             │ 6        │        10312108 │
│   2020-08-05 │ 1             │ 7        │        14390176 │
│   2020-08-04 │ 2             │ 0        │         6816268 │
│   2020-08-04 │ 1             │ 9        │         9579012 │
│   2020-08-04 │ 1             │ ᴺᵁᴸᴸ     │               0 │
│   2020-08-13 │ 1             │ 1        │         9297617 │
│   2020-08-10 │ 1             │ 2        │         9731730 │
│   2020-08-02 │ 1             │ 4        │        14301219 │
│   2020-08-07 │ 1             │ 5        │         7990920 │
│   2020-08-13 │ 1             │ 5        │         9296172 │
│   2020-08-05 │ 1             │ 3        │        14392028 │
│   2020-08-08 │ 1             │ 2        │        10312174 │
│   2020-07-31 │ 1             │ 4        │         4516844 │
│   2020-08-08 │ 1             │ 3        │        10310278 │
│   2020-07-31 │ 1             │ 5        │         4516809 │
│   2020-08-13 │ 1             │ 4        │         9298675 │
│   2020-08-05 │ 1             │ 2        │        14389025 │
│   2020-08-07 │ 1             │ 4        │         7997322 │
│   2020-08-10 │ 1             │ 3        │         9728272 │
│   2020-08-02 │ 1             │ 5        │        14293411 │
│   2020-08-06 │ 1             │ 8        │        14836174 │
│   2020-08-07 │ 1             │ 6        │         7992053 │
│   2020-08-03 │ 2             │ 0        │        18900614 │
│   2020-08-02 │ 1             │ 7        │        14290799 │
│   2020-08-03 │ 1             │ 9        │        14159595 │
│   2020-08-10 │ 1             │ 1        │         9725703 │
│   2020-08-01 │ 1             │ 9        │        14215531 │
│   2020-07-31 │ 1             │ 7        │         4514819 │
│   2020-08-01 │ 2             │ 0        │        19231842 │
│   2020-08-08 │ 1             │ 1        │        10321234 │
│   2020-08-05 │ 1             │ 0        │        14389375 │
│   2020-08-13 │ 1             │ 6        │         9297244 │
│   2020-08-12 │ 1             │ 8        │         9266194 │
│   2020-08-05 │ 1             │ 1        │        14396262 │
│   2020-08-12 │ 1             │ 9        │         9268725 │
│   2020-08-13 │ 1             │ 7        │         9297250 │
│   2020-08-01 │ 2             │ 1        │        20079915 │
│   2020-07-31 │ 1             │ 6        │         4519684 │
│   2020-08-01 │ 1             │ 8        │        14211010 │
│   2020-08-08 │ 1             │ 0        │        10316804 │
│   2020-08-03 │ 1             │ 8        │        14163366 │
│   2020-08-02 │ 1             │ 6        │        14294112 │
│   2020-08-03 │ 2             │ 1        │        20501740 │
│   2020-08-10 │ 1             │ 0        │         9726968 │
│   2020-08-07 │ 1             │ 7        │         7994002 │
│   2020-08-06 │ 1             │ 9        │        14843783 │
└──────────────┴───────────────┴──────────┴─────────────────┘
```





1. 数据类型

```mysql
select    request_date, count(distinct third_channel), count(distinct ad_types)  FROM alpha.odm_alpha_adl_rta_impression_message_i_d GROUP BY     request_date;

SELECT 
    request_date,
    countDistinct(third_channel),
    countDistinct(ad_types)
FROM alpha.odm_alpha_adl_rta_impression_message_i_d
GROUP BY request_date

┌─request_date─┬─uniqExact(third_channel)─┬─uniqExact(ad_types)─┐
│   2020-07-31 │                        2 │                  10 │
│   2020-08-01 │                        2 │                  10 │
│   2020-08-02 │                        2 │                  10 │
│   2020-08-03 │                        2 │                  10 │
│   2020-08-04 │                        2 │                  10 │
│   2020-08-05 │                        1 │                  10 │
│   2020-08-06 │                        1 │                  10 │
│   2020-08-07 │                        1 │                  10 │
│   2020-08-08 │                        1 │                  10 │
│   2020-08-09 │                        1 │                  10 │
│   2020-08-10 │                        1 │                  10 │
│   2020-08-11 │                        1 │                  10 │
│   2020-08-12 │                        1 │                  10 │
│   2020-08-13 │                        1 │                  10 │
│   2020-08-14 │                        1 │                  10 │
└──────────────┴──────────────────────────┴─────────────────────┘
```





1. 分布式表，hash 分片不对，导致后期 group 数据较慢， 数据后期压缩...

```
ENGINE = Distributed(alpha_rta_ck_cluster, alpha, odm_alpha_adl_rta_impression_message_i_d_local, hash(third_channel,ad_types))
```















- view agg

```mysql
CREATE MATERIALIZED VIEW IF NOT EXISTS alpha.view_rta_impression ON CLUSTER alpha_rta_ck_cluster
ENGINE = ReplicatedAggregatingMergeTree('/clickhouse/tables/{shard}/alpha/view_rta_impression', '{replica}')
PARTITION BY request_date
ORDER BY (request_date, third_channel, ad_types)
SETTINGS index_granularity = 8192, use_minimalistic_part_header_in_zookeeper = 1 AS
SELECT 
    request_date,
    third_channel,
    CAST(ad_types, 'Int8') AS ad_types,
    countState() AS pv,
    uniqState(multiIf((device_os = '1') AND (length(device_idfa) > 0), device_idfa, device_os = '2', coalesce(device_imei, device_android, device_oaid), device_os = '0', device_mac, NULL)) AS uv,
    sumState(remark != 'UserProfile Null') AS rig_pv,
    uniqState(if(remark != 'UserProfile Null', multiIf((device_os = '1') AND (length(device_idfa) > 0), device_idfa, device_os = '2', coalesce(device_imei, device_android, device_oaid), device_os = '0', device_mac, NULL), NULL)) AS rig_uv,
    sumState(rta_result = '1') AS res_count,
    uniqState(if(rta_result = '1', multiIf((device_os = '1') AND (length(device_idfa) > 0), device_idfa, device_os = '2', coalesce(device_imei, device_android, device_oaid), device_os = '0', device_mac, NULL), NULL)) AS res_uv
FROM alpha.odm_alpha_adl_rta_impression_message_i_d_local
GROUP BY 
    request_date,
    third_channel,
    ad_types
```





```mysql
create table alpha.view_rta_impression_message_all as alpha.view_rta_impression_message
ENGINE = Distributed(alpha_rta_ck_cluster, alpha, view_rta_impression_message, rand());
```











- insert

```mysql
CREATE TABLE alpha.result_out_bi_h
(
    `dt` Date,
    `etl_time` UInt8,
    `third_channel` String,
    `pv` UInt64 DEFAULT CAST(0, 'UInt64'),
    `uv` Nullable(UInt64) DEFAULT CAST(CAST(0, 'UInt64'), 'Nullable(UInt64)'),
    `rig_pv` UInt64 DEFAULT CAST(0, 'UInt64'),
    `pv_rig_rate` Float64 DEFAULT CAST(0, 'Float64'),
    `rig_uv` Nullable(UInt64) DEFAULT CAST(CAST(0, 'UInt64'), 'Nullable(UInt64)'),
    `uv_rig_rate` Nullable(Float64) DEFAULT CAST(CAST(0, 'Float64'), 'Nullable(Float64)'),
    `res_count` Nullable(UInt64) DEFAULT CAST(CAST(0, 'UInt64'), 'Nullable(UInt64)'),
    `pv_res_rate` Float64 DEFAULT CAST(0, 'Float64'),
    `res_uv` Nullable(UInt64) DEFAULT CAST(CAST(0, 'UInt64'), 'Nullable(UInt64)'),
    `uv_res_rate` Nullable(Float64),
    `grading` UInt8 DEFAULT 0,
    `create_time` DateTime DEFAULT now(),
    `ad_type` Nullable(UInt8)
)
ENGINE = Distributed(alpha_rta_ck_cluster, alpha, result_out_bi_h_local, rand())
```

