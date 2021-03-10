A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 0;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 0)

Ok.

0 rows in set. Elapsed: 146.277 sec. Processed 880.19 million rows, 282.59 GB (6.02 million rows/s., 1.93 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 1;^C
A01-R26-I140-140-614X77B.JD.LOCAL :) exit;
^[[ABye.
[songenjie@A02-R12-I160-19 ~]$ ./clickhouse client -m -h 10.199.140.140    --port 9600 --user  default --password  jd_olap;^C
[songenjie@A02-R12-I160-19 ~]$ ./clickhouse client -m -h 10.199.140.140    --port 9600 --user  default --password  jd_olap;
ClickHouse client version 20.6.6.7 (official build).
Connecting to 10.199.140.140:9600 as user default.
Connected to ClickHouse server version 20.5.2 revision 54435.

ClickHouse server version is older than ClickHouse client. It may indicate that the server is out of date and can be upgraded.

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 1;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 1)

Ok.

0 rows in set. Elapsed: 143.307 sec. Processed 880.19 million rows, 282.59 GB (6.14 million rows/s., 1.97 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 2;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 2)

Ok.

0 rows in set. Elapsed: 145.653 sec. Processed 880.19 million rows, 282.59 GB (6.04 million rows/s., 1.94 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 3;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 3)

Ok.

0 rows in set. Elapsed: 144.840 sec. Processed 880.19 million rows, 282.59 GB (6.08 million rows/s., 1.95 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 4;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 4)

Ok.

0 rows in set. Elapsed: 142.701 sec. Processed 880.19 million rows, 282.59 GB (6.17 million rows/s., 1.98 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 5;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 5)

Ok.

0 rows in set. Elapsed: 145.431 sec. Processed 880.19 million rows, 282.59 GB (6.05 million rows/s., 1.94 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 6;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 6)

Ok.

0 rows in set. Elapsed: 145.368 sec. Processed 880.19 million rows, 282.59 GB (6.05 million rows/s., 1.94 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 7;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 7)

Ok.

0 rows in set. Elapsed: 144.288 sec. Processed 880.19 million rows, 282.59 GB (6.10 million rows/s., 1.96 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 8;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 8)

Ok.

0 rows in set. Elapsed: 143.650 sec. Processed 880.19 million rows, 282.59 GB (6.13 million rows/s., 1.97 GB/s.)

A01-R26-I140-140-614X77B.JD.LOCAL :) insert into jason.app_gesc_kylin_sku_flag_fact_d  select *  from gesc.app_gesc_kylin_sku_flag_fact  where dt IN('2021-03-01') and sipHash64(sku_id)%10 = 9;

INSERT INTO jason.app_gesc_kylin_sku_flag_fact_d SELECT *
FROM gesc.app_gesc_kylin_sku_flag_fact
WHERE (dt IN ('2021-03-01')) AND ((sipHash64(sku_id) % 10) = 9)

Ok.

0 rows in set. Elapsed: 143.953 sec. Processed 880.19 million rows, 282.59 GB (6.11 million rows/s., 1.96 GB/s.)
