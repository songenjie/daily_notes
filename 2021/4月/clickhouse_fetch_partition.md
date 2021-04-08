clickhouse fetach table 



首先 语法 alter table fetch partition from "zkpath"

fetach partition 属于 alter 范畴

字段中带有 partition 属于 alter parition 

带有fetach  alert partiito fetch 



paritinid, multizookeeper, data metadata, source replica path ...



fetach partiiin 

fetch part 





inmemory 

indisk 


transaction 





....





partition 重复，不可导入

```
A01-R26-I141-5-BC4S7C2.JD.LOCAL :) ALTER TABLE app_ge_s13_dim_shop_dept_local FETCH PARTITION '2020-09-16' FROM 'HT0_CK_Pub_01:/clickhouse/tables/pc/app_ge_s13_dim_shop_dept_local/06';

ALTER TABLE app_ge_s13_dim_shop_dept_local
    FETCH PARTITION '2020-09-16' FROM 'HT0_CK_Pub_01:/clickhouse/tables/pc/app_ge_s13_dim_shop_dept_local/06'


Query id: e41217c4-f3ce-4ebe-a64f-095d46ef3802


Received exception from server (version 20.12.3):
Code: 256. DB::Exception: Received from 10.199.141.5:9700. DB::Exception: Detached partition 20200916 already exists..

0 rows in set. Elapsed: 0.001 sec.
```





fetch 存放

```
20200916_2_2_0  detached
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data7/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data6/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data5/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
20200917_1_1_0
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data4/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
20200916_1_1_0
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data4/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
20200916_1_1_0
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data5/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
20200917_1_1_0
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data5/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/detached/
20200917_1_1_0
[root@A01-R26-I141-5-BC4S7C2 log]# ls /data5/jdolap/clickhouse/data/store/535/5352004e-b633-40f1-9b6b-fc064b5034bd/
detached
```

