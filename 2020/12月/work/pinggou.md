拼拼购流量访客实时模型

源Topic

log-rt-gdm-m14-wxapp-online-log-dual

计算方案

基于源Topic，解析过滤字段后，明细写入CK，Schema如下;整个流程无需依赖外部服务、存储等; 创建物化视图:

| 流量物化视图                                                 |
| ------------------------------------------------------------ |
| `CREATE TABLE IF NOT EXISTS pinpingou.pinpingou_flow_onl_local ON CLUSTER {cluster} (  `std` String,  `request_time` String,  `dt` Date, ` 							`  `hour_idx` UInt8,  `ten_minute_idx` UInt8,  `minute_idx` UInt16,  `region_id` UInt16,  `province_id` UInt16,  `city_id` UInt16,  `union_id` String,  `user_log_acct` String,  `is_leader` Int8,  `is_leaderself` Int8,  `browser_uniq_id` String,  `channel` String,  `sku_id` UInt64,  `main_sku_id` UInt64,  `item_id` UInt64,  `item_first_cate_cd` UInt32,  `item_second_cate_cd` UInt32,  `item_third_cate_cd` UInt32,  `item_last_cate_cd` UInt32,  `hash_key_for_shard` Int32 ` 							`) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/pinpingou/pinpingou_flow_local/{shard}', '{replica}') PARTITION BY dt ORDER BY (region_id, province_id, city_id, hour_idx, ten_minute_idx, minute_idx, user_log_acct, union_id, sku_id) ` 							`SETTINGS index_granularity = 8192; ` 							`CREATE MATERIALIZED VIEW IF NOT EXISTS pinpingou.pinpingou_flow_onl_view ON CLUSTER {cluster} ENGINE = ReplicatedAggregatingMergeTree('/clickhouse/tables/{cluster}/pinpingou/pinpingou_flow_view/{shard}', '{replica}') PARTITION BY dt ORDER BY (region_id, province_id, city_id, hour_idx, ten_minute_idx, minute_idx) AS SELECT region_id, province_id, city_id, hour_idx, ten_minute_idx, minute_idx, uniqState(user_log_acct) AS pinUniq, uniqState(union_id) AS unionIdUniq, sumState(union_id) AS unionIdSum FROM pinpingou.pinpingou_flow_onl_local GROUP BY region_id, province_id, city_id, hour_idx, ten_minute_idx, minute_idx; ` 							`CREATE TABLE IF NOT EXISTS pinpingou.pinpingou_flow_onl_dist ON CLUSTER {cluster} AS pinpingou.pinpingou_flow_onl_view ENGINE = Distributed({cluster}, pinpingou, pinpingou_flow_onl_view, murmurHash2_64(city_id)); ` |

指标计算

登录用户数:SELECT uniqMerge(pinUniq) AS uv from pinpingou.pinpingou_flow_view where dt='2020-12-10'; 团均登录用户数:SELECT sumMerge(unionIdSum)/uniqMerge(unionIdUniq) AS uv from pinpingou.pinpingou_flow_view;

```
团长分享登录用户数:
自主登录用户数:
```

输出实时模型

| 字段名称 字段备注 字段中文名                                 |
| ------------------------------------------------------------ |
| std C端-JA2019_5132026 只取C端 站点id 团长端-JA2019_5132025  |
| std_type 站点类型(0:C端、1:B端) 站点分类(c端,b端)            |
| request_time "rtm":"2020120914152834" 请求时间               |
| dt 日期                                                      |
| hour_idx 小时索引                                            |
| ten_minute_idx 10分钟粒度索引                                |
| minute_idx 分钟粒度索引                                      |
| region_id gdm层补充                                          |
| province_id "prc":"1","prn":"北京"                           |
| city_id "cic":"2800", "cin":"北京" 用户城市编码              |
| shard_id 团长分享活动ID                                      |
| actvy_id 活动ID                                              |
| actvy_name 活动名称                                          |
| gp_id 团ID                                                   |
| union_id ext['union_id'] AS union_id 团长id                  |
| user_log_acct ext['pin_ext'] AS user_log_acct 登录用户名称   |
| is_leader ext['is_leader'] AS is_leader 是否团长 (0=是、1=否) |
| is_leaderself ext['is_leaderself'] AS is_leaderself 进入的是否团长自己的店铺 (0=是、1=否) |
| browser_uniq_id ext['open_id'] AS open_id 用户在小程序中的唯一id |
| channel ext['channel'] AS channel 渠道(商品链接;最近使用;发现页;公众号;B端跳转;C端-团长链接) |
| sku_id ext['sku_ext'] AS sku sku                             |
| main_sku_id gdm层补充 主sku编号                              |
| item_id gdm层补充 商品编号                                   |
| item_first_cate_cd gdm层补充 商品一级分类代码                |
| item_second_cate_cd gdm层补充 商品二级分类代码               |
| item_third_cate_cd gdm层补充 商品三级分类代码                |
| item_last_cate_cd gdm层补充 商品末级分类代码                 |