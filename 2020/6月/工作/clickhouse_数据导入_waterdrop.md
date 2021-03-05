# hive数据导入

## waterdrop简介

导入hive数据到ck，使用第三方工具：waterdrop。waterdrop 1.x版本可以跑在spark上；waterdrop 2.x版本可以跑在spark和flink上。

参考：

- 文档：https://interestinglab.github.io/waterdrop/#/zh-cn/v1/

- 软件包：https://github.com/InterestingLab/waterdrop/releases

## 环境

1.hive表

```
$ spark-sql -S
spark-sql> use test;
spark-sql> describe table pt;
k	bigint	NULL
p	bigint	NULL
# Partition Information
# col_name	data_type	comment
p	bigint	NULL
```

2.创建ck表

```
$ clickhouse-client -m
A01-R03-I165-20-4CT4352.JD.LOCAL :) CREATE TABLE test.hive_data (`k` Int64, `p` Int64) ENGINE = ReplacingMergeTree PRIMARY KEY k ORDER BY k SETTINGS index_granularity = 8192;

CREATE TABLE test.hive_data
(
    `k` Int64,
    `p` Int64
)
ENGINE = ReplacingMergeTree
PRIMARY KEY k
ORDER BY k
SETTINGS index_granularity = 8192

Ok.
```

## 操作

1.下载waterdrop软件包

这里使用[waterdrop-1.4.3.zip](https://github.com/InterestingLab/waterdrop/releases/download/v1.4.3/waterdrop-1.4.3.zip)

```
$ unzip waterdrop-1.4.3.zip
$ cd waterdrop-1.4.3
```

2.配置文件

```
$ vim config/batch.conf
// batch.conf begin
spark {
  spark.app.name = "Waterdrop"
  spark.executor.instances = 2
  spark.executor.cores = 1
  spark.executor.memory = "1g"
  spark.sql.catalogImplementation = "hive"
}

input {
  hive {
    pre_sql = "select * from test.pt limit 10"
    result_table_name = "hive_output"
  }
}

filter {
}

output {
  clickhouse {
        host = "172.19.165.20:8123"
        database = "test"
        table = "hive_data"
        fields = ["k", "p"]
        #username = "username"
        #password = "password"
  }
}
// batch.conf end
```

3.执行导入任务

```
./bin/start-waterdrop.sh --config config/batch.conf -e client -m 'local[2]'
```

4.查询ck表

```
A01-R03-I165-20-4CT4352.JD.LOCAL :) select * from hive_data;

SELECT *
FROM hive_data

┌──k─┬─p─┐
│  0 │ 0 │
│  1 │ 1 │
│ 10 │ 0 │
│ 11 │ 1 │
│ 12 │ 2 │
│ 22 │ 2 │
│ 50 │ 0 │
│ 51 │ 1 │
│ 60 │ 0 │
│ 61 │ 1 │
└────┴───┘

20 rows in set. Elapsed: 0.008 sec.
```

## 注意

- 连接ck的端口要使用http port，默认8123。
- java用1.8版本，1.7版本报错。
- WaterDrop会把Hive的类型转换为Scala类型，但是转换不是自动的，需要手工定义convert，比如smallint转integer，bigint转long
```
filter {
    convert {
        source_field = "item_sku_id"
        new_type = "long"
    }
    convert {
        source_field = "main_sku_id"
        new_type = "long"
    }
    convert {
        source_field = "sku_valid_flag"
        new_type = "integer"
    }
    convert {
        source_field = "item_valid_flag"
        new_type = "integer"
    }
}
```

