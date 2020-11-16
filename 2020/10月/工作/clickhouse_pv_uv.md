## AggregatingMergeTree

```
CREATE TABLE agg_table {
 id String,
 city String,
 code AggregateFunction(uniq,String),
 value AggregateFunction(sum,UInt32),
 create_time DateTime,
}***
```



- 写入

```
INSERT INTO TABLE agg_table
SELECT 'A000','wuhan',
uniqState('code'),
sumState(toUInt32(100)),
'2019-08-10 17:00:00'
```



- 常用方法

结合物化试图使用，将它作为物化试图的表引擎



1. 建立明细数据表，也就是俗称的底表

```
CREATE TABLE agg_table_basic (
	id String,
	city String,
	code String,
	value Uint32
)ENGINE = MergeTree()
PARTITION BY city
ORDER BY (id,city)
```



2. 物化视图表，聚合表

```
CREATE MATERIALIZED VIEW agg_view
ENGINE = AggregatingMegeTree()
PARTITION BY city
ORDER BY (id,city)
AS SELECT id,city,uniq(code) AS code,sumSate(value) AS value
FROM agg_table_basic
GROUP BY id,city
```



3. 插入数据

插入数据到底表

```
INSERT INTO TABLE agg_table_basic
VALUES('A000','wuhan','code1',100),('A000','wuhan','code2',200),('A000','zhuhai','code1',200),
```



4. 查询

```
SELECT id,sumMerge(value),uniqMerge(code) FROM agg_view GROUP BY id,city
```



- 处理逻辑

1. ORDER BY 排序作为聚合key
2. 使用AggrgateFunciton 字段类型定义聚合函数的类型以及聚合字段
3. 在合并分区的时候才会触发聚合计算的逻辑
4. 以part为单位聚合，当part合并时，同一数据分区内聚合Key相同数据会被合并计算，而不同part时间的数据不会被计算
5. 在进行数据计算时，因为分区内的数据已经给予ORDER BY排序，能够找到相邻且拥有相同聚合Key的数据
6. 在聚合数据时，同一分区part内，相同聚合Key的多行数据会合并成一行。对于非主键，非AggregateFunction类型字段，则会使用第一行数据的取值
7. AgregateFucntion类型的字段使用二进制存储，在写入数据时候，需要调用 *state函数;而需要调用相应的Merge函数。其中,*表示定义时使用的聚合函数
8. AggregateMergeTree通常为物化视图的表引擎，与普通的MergeTree搭配使用