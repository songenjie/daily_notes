## 数据存储

#### system.disks config

```
SELECT     name, path, formatReadableSize(free_space) AS free, formatReadableSize(total_space) AS total,formatReadableSize(keep_free_space) AS reserved FROM system.disks;
+---------+---------------------------------------+----------+----------+----------+
| name    | path                                  | free     | total    | reserved |
+---------+---------------------------------------+----------+----------+----------+
| default | /data0/jdolap/clickhouse/defaultdata/ | 4.96 TiB | 5.46 TiB | 0.00 B   |
| disk0   | /data0/jdolap/clickhouse/data/        | 4.96 TiB | 5.46 TiB | 0.00 B   |
| disk1   | /data1/jdolap/clickhouse/data/        | 4.97 TiB | 5.46 TiB | 0.00 B   |
| disk6   | /data6/jdolap/clickhouse/data1/       | 5.01 TiB | 5.46 TiB | 0.00 B   |
| disk7   | /data7/jdolap/clickhouse/data1/       | 5.02 TiB | 5.46 TiB | 0.00 B   |
+---------+---------------------------------------+----------+----------+----------+
5 rows in set (0.00 sec)
```

### jbod
```
select policy_name,volume_name,volume_priority,disks,formatReadableSize(max_data_part_size) max_data_part_size ,move_factor from system.storage_policies;
+-------------+-------------+-----------------+-------------------+--------------------+-------------+
| policy_name | volume_name | volume_priority | disks             | max_data_part_size | move_factor |
+-------------+-------------+-----------------+-------------------+--------------------+-------------+
| default     | default     |               1 | ['default']       | 0.00 B             |           0 |
| jdob_ha     | hot         |               1 | ['disk0','disk1'] | 3.00 TiB           |        0.25 |
| jdob_ha     | cold        |               2 | ['disk6','disk7'] | 0.00 B             |        0.25 |
+-------------+-------------+-----------------+-------------------+--------------------+-------------+
3 rows in set (0.03 sec)
```

#### 数据存储

```
20200525_0_617_5
20200525_618_1176_4
20200525_1177_1199_2
20200525_1200_1219_2
20200525_1220_1220_0
MySQL [hjy_poc]> select name,partition,disk_name,path from system.parts where table='gdm_m14_online_log_item_d_local';
+----------------------+-----------+-----------+--------------------------------------------------------------------------------------------------+
| name                 | partition | disk_name | path                                                                                             |
+----------------------+-----------+-----------+--------------------------------------------------------------------------------------------------+
| 20200506_0_455_4     | 20200506  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200506_0_455_4/     |
| 20200506_456_1110_4  | 20200506  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200506_456_1110_4/  |
| 20200507_0_921_5     | 20200507  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_0_921_5/     |
| 20200507_922_1053_3  | 20200507  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_922_1053_3/  |
| 20200507_1054_1076_2 | 20200507  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_1054_1076_2/ |
| 20200507_1077_1103_2 | 20200507  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_1077_1103_2/ |
| 20200507_1104_1124_2 | 20200507  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_1104_1124_2/ |
| 20200507_1125_1125_0 | 20200507  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_1125_1125_0/ |
| 20200507_1126_1126_0 | 20200507  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200507_1126_1126_0/ |
| 20200508_0_763_5     | 20200508  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_0_763_5/     |
| 20200508_764_904_3   | 20200508  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_764_904_3/   |
| 20200508_905_996_3   | 20200508  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_905_996_3/   |
| 20200508_997_1085_3  | 20200508  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_997_1085_3/  |
| 20200508_1086_1104_2 | 20200508  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_1086_1104_2/ |
| 20200508_1105_1157_3 | 20200508  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_1105_1157_3/ |
| 20200508_1158_1163_1 | 20200508  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200508_1158_1163_1/ |
| 20200509_0_936_5     | 20200509  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200509_0_936_5/     |
| 20200509_937_1073_3  | 20200509  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200509_937_1073_3/  |
| 20200509_1074_1102_2 | 20200509  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200509_1074_1102_2/ |
| 20200509_1103_1123_2 | 20200509  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200509_1103_1123_2/ |
| 20200510_0_570_5     | 20200510  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_0_570_5/     |
| 20200510_571_699_3   | 20200510  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_571_699_3/   |
| 20200510_700_817_3   | 20200510  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_700_817_3/   |
| 20200510_818_848_2   | 20200510  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_818_848_2/   |
| 20200510_849_923_3   | 20200510  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_849_923_3/   |
| 20200510_924_980_3   | 20200510  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_924_980_3/   |
| 20200510_981_998_2   | 20200510  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_981_998_2/   |
| 20200510_999_1018_2  | 20200510  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_999_1018_2/  |
| 20200510_1019_1034_2 | 20200510  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_1019_1034_2/ |
| 20200510_1035_1048_2 | 20200510  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200510_1035_1048_2/ |
| 20200511_0_623_5     | 20200511  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_0_623_5/     |
| 20200511_624_749_3   | 20200511  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_624_749_3/   |
| 20200511_750_889_3   | 20200511  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_750_889_3/   |
| 20200511_890_942_3   | 20200511  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_890_942_3/   |
| 20200511_943_1042_4  | 20200511  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_943_1042_4/  |
| 20200511_1043_1064_2 | 20200511  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_1043_1064_2/ |
| 20200511_1065_1086_2 | 20200511  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_1065_1086_2/ |
| 20200511_1087_1134_3 | 20200511  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200511_1087_1134_3/ |
| 20200512_0_911_5     | 20200512  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200512_0_911_5/     |
| 20200512_912_1028_3  | 20200512  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200512_912_1028_3/  |
| 20200512_1029_1105_3 | 20200512  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200512_1029_1105_3/ |
| 20200512_1106_1109_1 | 20200512  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200512_1106_1109_1/ |
| 20200513_0_622_4     | 20200513  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200513_0_622_4/     |
| 20200513_623_730_3   | 20200513  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200513_623_730_3/   |
| 20200513_731_860_3   | 20200513  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200513_731_860_3/   |
| 20200513_861_903_3   | 20200513  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200513_861_903_3/   |
| 20200513_904_993_4   | 20200513  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200513_904_993_4/   |
| 20200513_994_996_1   | 20200513  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200513_994_996_1/   |
| 20200514_0_594_4     | 20200514  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200514_0_594_4/     |
| 20200514_595_714_4   | 20200514  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200514_595_714_4/   |
| 20200514_715_828_3   | 20200514  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200514_715_828_3/   |
| 20200514_829_1110_4  | 20200514  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200514_829_1110_4/  |
| 20200514_1111_1111_0 | 20200514  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200514_1111_1111_0/ |
| 20200515_0_768_5     | 20200515  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_0_768_5/     |
| 20200515_769_870_3   | 20200515  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_769_870_3/   |
| 20200515_871_980_3   | 20200515  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_871_980_3/   |
| 20200515_981_1006_2  | 20200515  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_981_1006_2/  |
| 20200515_1007_1060_3 | 20200515  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_1007_1060_3/ |
| 20200515_1061_1153_3 | 20200515  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_1061_1153_3/ |
| 20200515_1154_1158_1 | 20200515  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200515_1154_1158_1/ |
| 20200516_0_946_5     | 20200516  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200516_0_946_5/     |
| 20200516_947_1071_3  | 20200516  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200516_947_1071_3/  |
| 20200516_1072_1094_2 | 20200516  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200516_1072_1094_2/ |
| 20200516_1095_1119_2 | 20200516  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200516_1095_1119_2/ |
| 20200516_1120_1124_1 | 20200516  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200516_1120_1124_1/ |
| 20200516_1125_1130_1 | 20200516  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200516_1125_1130_1/ |
| 20200517_0_840_5     | 20200517  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_0_840_5/     |
| 20200517_841_986_3   | 20200517  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_841_986_3/   |
| 20200517_987_1113_3  | 20200517  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_987_1113_3/  |
| 20200517_1114_1139_2 | 20200517  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_1114_1139_2/ |
| 20200517_1140_1165_2 | 20200517  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_1140_1165_2/ |
| 20200517_1166_1190_2 | 20200517  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_1166_1190_2/ |
| 20200517_1191_1194_1 | 20200517  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200517_1191_1194_1/ |
| 20200518_0_558_4     | 20200518  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_0_558_4/     |
| 20200518_559_826_4   | 20200518  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_559_826_4/   |
| 20200518_827_926_3   | 20200518  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_827_926_3/   |
| 20200518_927_1006_3  | 20200518  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_927_1006_3/  |
| 20200518_1007_1111_3 | 20200518  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_1007_1111_3/ |
| 20200518_1112_1135_2 | 20200518  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_1112_1135_2/ |
| 20200518_1136_1141_1 | 20200518  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_1136_1141_1/ |
| 20200518_1142_1147_1 | 20200518  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200518_1142_1147_1/ |
| 20200519_0_840_5     | 20200519  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200519_0_840_5/     |
| 20200519_841_974_3   | 20200519  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200519_841_974_3/   |
| 20200519_975_1000_2  | 20200519  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200519_975_1000_2/  |
| 20200519_1001_1066_3 | 20200519  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200519_1001_1066_3/ |
| 20200519_1067_1159_3 | 20200519  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200519_1067_1159_3/ |
| 20200519_1160_1162_1 | 20200519  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200519_1160_1162_1/ |
| 20200520_0_794_5     | 20200520  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200520_0_794_5/     |
| 20200520_795_797_1   | 20200520  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200520_795_797_1/   |
| 20200521_0_900_5     | 20200521  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200521_0_900_5/     |
| 20200521_901_1011_3  | 20200521  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200521_901_1011_3/  |
| 20200521_1012_1131_3 | 20200521  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200521_1012_1131_3/ |
| 20200521_1132_1220_3 | 20200521  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200521_1132_1220_3/ |
| 20200522_0_859_5     | 20200522  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200522_0_859_5/     |
| 20200522_860_976_3   | 20200522  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200522_860_976_3/   |
| 20200522_977_1163_4  | 20200522  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200522_977_1163_4/  |
| 20200522_1164_1175_2 | 20200522  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200522_1164_1175_2/ |
| 20200523_0_672_4     | 20200523  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200523_0_672_4/     |
| 20200523_673_785_3   | 20200523  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200523_673_785_3/   |
| 20200523_786_894_3   | 20200523  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200523_786_894_3/   |
| 20200523_895_1150_4  | 20200523  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200523_895_1150_4/  |
| 20200523_1151_1173_2 | 20200523  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200523_1151_1173_2/ |
| 20200523_1174_1189_2 | 20200523  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200523_1174_1189_2/ |
| 20200524_0_836_5     | 20200524  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200524_0_836_5/     |
| 20200524_837_957_3   | 20200524  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200524_837_957_3/   |
| 20200524_958_1090_3  | 20200524  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200524_958_1090_3/  |
| 20200524_1091_1115_2 | 20200524  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200524_1091_1115_2/ |
| 20200524_1116_1136_2 | 20200524  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200524_1116_1136_2/ |
| 20200524_1137_1156_2 | 20200524  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200524_1137_1156_2/ |
| 20200525_0_617_5     | 20200525  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200525_0_617_5/     |
| 20200525_618_1176_4  | 20200525  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200525_618_1176_4/  |
| 20200525_1177_1199_2 | 20200525  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200525_1177_1199_2/ |
| 20200525_1200_1219_2 | 20200525  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200525_1200_1219_2/ |
| 20200525_1220_1220_0 | 20200525  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200525_1220_1220_0/ |
| 20200526_0_642_4     | 20200526  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200526_0_642_4/     |
| 20200526_643_760_3   | 20200526  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200526_643_760_3/   |
| 20200526_761_878_3   | 20200526  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200526_761_878_3/   |
| 20200526_879_1195_4  | 20200526  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200526_879_1195_4/  |
| 20200527_0_786_5     | 20200527  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200527_0_786_5/     |
| 20200527_787_1251_5  | 20200527  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200527_787_1251_5/  |
| 20200527_1252_1252_0 | 20200527  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200527_1252_1252_0/ |
| 20200527_1253_1253_0 | 20200527  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200527_1253_1253_0/ |
| 20200528_0_739_5     | 20200528  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_0_739_5/     |
| 20200528_740_868_3   | 20200528  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_740_868_3/   |
| 20200528_869_983_3   | 20200528  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_869_983_3/   |
| 20200528_984_1014_2  | 20200528  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_984_1014_2/  |
| 20200528_1015_1116_3 | 20200528  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_1015_1116_3/ |
| 20200528_1117_1143_2 | 20200528  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_1117_1143_2/ |
| 20200528_1144_1214_3 | 20200528  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_1144_1214_3/ |
| 20200528_1215_1223_2 | 20200528  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_1215_1223_2/ |
| 20200528_1224_1230_2 | 20200528  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200528_1224_1230_2/ |
| 20200529_0_1033_5    | 20200529  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200529_0_1033_5/    |
| 20200529_1034_1159_3 | 20200529  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200529_1034_1159_3/ |
| 20200529_1160_1253_3 | 20200529  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200529_1160_1253_3/ |
| 20200529_1254_1254_0 | 20200529  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200529_1254_1254_0/ |
| 20200529_1255_1257_1 | 20200529  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200529_1255_1257_1/ |
| 20200530_0_755_6     | 20200530  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200530_0_755_6/     |
| 20200530_756_878_3   | 20200530  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200530_756_878_3/   |
| 20200530_879_884_1   | 20200530  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200530_879_884_1/   |
| 20200530_885_890_1   | 20200530  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200530_885_890_1/   |
| 20200530_891_893_1   | 20200530  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200530_891_893_1/   |
| 20200531_0_928_6     | 20200531  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200531_0_928_6/     |
| 20200531_929_1517_4  | 20200531  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200531_929_1517_4/  |
| 20200531_1518_1522_1 | 20200531  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200531_1518_1522_1/ |
| 20200601_0_784_5     | 20200601  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_0_784_5/     |
| 20200601_785_1360_4  | 20200601  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_785_1360_4/  |
| 20200601_1361_1477_3 | 20200601  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_1361_1477_3/ |
| 20200601_1478_2035_6 | 20200601  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_1478_2035_6/ |
| 20200601_2036_2102_4 | 20200601  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_2036_2102_4/ |
| 20200601_2103_2227_5 | 20200601  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_2103_2227_5/ |
| 20200601_2228_2228_0 | 20200601  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200601_2228_2228_0/ |
| 20200602_0_685_5     | 20200602  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_0_685_5/     |
| 20200602_686_821_3   | 20200602  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_686_821_3/   |
| 20200602_822_961_3   | 20200602  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_822_961_3/   |
| 20200602_962_1076_3  | 20200602  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_962_1076_3/  |
| 20200602_1077_1236_4 | 20200602  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_1077_1236_4/ |
| 20200602_1237_1332_4 | 20200602  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_1237_1332_4/ |
| 20200602_1333_1415_3 | 20200602  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_1333_1415_3/ |
| 20200602_1416_1476_3 | 20200602  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_1416_1476_3/ |
| 20200602_1477_1529_3 | 20200602  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_1477_1529_3/ |
| 20200602_1530_1530_0 | 20200602  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200602_1530_1530_0/ |
| 20200603_0_764_6     | 20200603  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_0_764_6/     |
| 20200603_765_894_3   | 20200603  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_765_894_3/   |
| 20200603_895_1017_3  | 20200603  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_895_1017_3/  |
| 20200603_1018_1060_3 | 20200603  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_1018_1060_3/ |
| 20200603_1061_1121_3 | 20200603  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_1061_1121_3/ |
| 20200603_1122_1190_3 | 20200603  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_1122_1190_3/ |
| 20200603_1191_1206_2 | 20200603  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_1191_1206_2/ |
| 20200603_1207_1214_2 | 20200603  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200603_1207_1214_2/ |
| 20200604_0_734_5     | 20200604  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200604_0_734_5/     |
| 20200604_735_1381_6  | 20200604  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200604_735_1381_6/  |
| 20200604_1382_1386_1 | 20200604  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200604_1382_1386_1/ |
| 20200604_1387_1391_1 | 20200604  | disk0     | /data0/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200604_1387_1391_1/ |
| 20200604_1392_1395_1 | 20200604  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200604_1392_1395_1/ |
| 20200605_1444_2187_5 | 20200605  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200605_1444_2187_5/ |
| 20200605_2188_2859_4 | 20200605  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200605_2188_2859_4/ |
| 20200605_2860_2871_3 | 20200605  | disk1     | /data1/jdolap/clickhouse/data/data/hjy_poc/gdm_m14_online_log_item_d_local/20200605_2860_2871_3/ |
+----------------------+-----------+-----------+--------------------------------------------------------------------------------------------------+
177 rows in set (0.05 sec)

```



#### 数据迁移

```
https://github.com/ClickHouse/ClickHouse/blob/master/docs/en/sql-reference/statements/alter.md
示例：将某个分区移动至当前存储策略中某个volume卷下的其他disk磁盘：

alter table t_hot_cold move part 'all_1_2_1' to DISK 'disk_hot1';

将某个分区移动至当前存储策略中其他的volume卷：
alter table t_hot_cold move part 'all_1_2_1' to DISK 'cold'

ALTER TABLE sample4 MOVE PART 'all_570_570_0' TO VOLUME 'cold_volume'
ALTER TABLE sample4 MOVE PART 'all_570_570_0' TO DISK 'ebs_gp2_1'
ALTER TABLE sample4 MOVE PARTITION tuple() TO VOLUME 'cold_volume'
```
