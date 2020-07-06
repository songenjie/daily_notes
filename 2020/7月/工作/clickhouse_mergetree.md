## 7.1 TTL

- 列级别

```
CREATE TABLE ttl_table_v1 {
	id String,
	create_time DateTime,
	code String TTL create_time + INTERVAL 10 SECOND
}***
```



- 表级别

```
CREATE TABLE ttl_table_v1 {
	id String,
	create_time DateTime,
	code String TTL create_time + INTERVAL 10 SECOND
}
TTL create_time + INTERVAL 1 DAY
```



- 原理

数据以part为目录做ttl维护，在每个目录内生成一个名为ttl.txt 的文件，为明文，是json格式维护

```
{"columns"[{"name":"code","min":155478860,"max":1557651660}],"table":"min":****,"max":xxxx}
```

1. columns 保存列几杯TTl信息
2. table 用于保存表级别TTL信息
3. Min max 当前分区内 最大最小值



- 处理逻辑

1. Merge tree 以part为单位，通过ttl记录时间
2. 每当数据写入一批，都会给予INTERVAL表达式的计算结果为这个part生成ttl文件
3. 只有mergetree合并是，才会触发删除ttl过期数据的逻辑
4. 删除分区逻辑，使用贪婪算饭
5. 如果一个分区内某一列数据因为ttl到期全部被删除了，那么合并之后生成新的分区的目录内，不会包含这个列字段 文件 bin mrk
6. 合并频率由 merge_with_ttl_timeout 参数控制，默认 86400s,一天
7. 触发一个分区合并 optimize table tblename,触发所有分区合并 optimize table tablename FINAL
8. 启动停止 system stop/start TTL merges



## ReplacingMergeTree

ENGINE=ReplacingMergeTree(ver),ver选填，版本号，决定了去重算法

1. 使用 ORDER BY 排序见作为判断去重数据的唯一键
2. 只有在合并part的时候才会触发删除重复数据的逻辑
3. 以数据part为单位，删除重复数据。统一part内重复数据会被删除，不同分区之间的重复数据不会被删除
4. 去重，按照order by排序，所以能找到相邻的重复数据
5. 去重策略
   - 如果没有设置ver版本，暴力同一组重复数据中的最后一个行
   - 设置了ver，保留同一组重复数据中ver字段最大的那一行





## SummingMergeTree

解决场景：

1. 汇总数据计算，存储额外的开销，终端终于不会查询任何明细数据，只关心汇总数据
2. 实时预聚合性能消耗



- 如果同时声明了ORDER BY与PRIMARY KEY，`MergeTree会强制要求PRIMARY KEY列字段必须是ORDER BY的前缀`



ORDER BY 只能在现有的的基础上减少字段。如 ORDER BY(A,B,C,D) 改为 	ALTER TABLE table_name MODIFY ORDER BY(A,B)



新增：ALTER ADD COLUMN



ALTER 是一种元数据操作，成本很低，相比不能修改的主键，很方便



1. 用ORDER BY 排序键作为聚合数据的条件Key
2. 只有在合并分区的时候才会触发汇总的逻辑
3. 以数据part为单位聚合，当part合并的时候，统一分区内的key会被汇总，不同分区不会
4. 如果在定义引擎制定了columns汇总列（非主键的数据类型字段），则SUM汇总；如果未指定，则聚合所有非主键的数值类型字段
5. 汇总，基于ODRDER BY,所以能找到相邻且拥有相同聚合Key的数据
6. 在汇总数据时候，统一分区内，相同聚合Key的多行数据会合并成一行。汇总会进行sum，非汇总，保留第一行
7. 嵌套结构，必须是Map后缀结尾，默认以第一个字段为聚合Key，除了第一个key外，任何以Key,Id或Type为后缀，将和第一个字段组合为符合Key	





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





## CollapsingMergeTree

以增代删

ENGINE=CollapsingMergeTree(sign)

```\
CREATE TABLE UAct
(
    UserID UInt64,
    PageViews UInt8,
    Duration UInt8,
    Sign Int8
)
ENGINE = CollapsingMergeTree(Sign)
ORDER BY UserID
```



- 规则
  - 如果signe=1比如sign=-1多一行，保留最后一行signe=1的数据
  - sign=-1比sign=1多一行，保留最后一行sign=-1的数据
  - 一样多，并且最后一行时sign=1,保留第一行sign=-1和最后一行sign=1的数据
  - 一样多，并且最后一行是sign=-1,都删除，都不保留
  - 其他情况，报警





1. 折叠不是实时触发的，和所有其他的MergeTree变种表引擎一样，这项特性也只有在分区合并的时候实时触发，合并之前的查询都是旧数据 

   - 解决方法 

     1. 查询的时候， optimize TABLE table_name FINAL (效率很低)
     2. 改变查询方式 eg: 

        ```
     SELECT id,SUM(code),COUNT(code),AVG(code),uniq(code) FROM collpase_table GROURP BY id
     
     改为
     
     SELECT id,SUM(code * sign),COUNT(code * sign),AVG(code * sign),uniq(code * sign) 
     FROM collpase_tabe
     GROUP BY id
     HAVING SUM(sign)>0
        ```

2. 只有相同分区内的数据才有可能被折叠，不过这项限制对于CollapsingMergeTree通常不是问题，因为修改和删除数据的时候，这些数据的分区规则通常是一致的
3. 对写入有限制，先后的问题，就是1 和 -1的顺序



## VersionedCollapsingMergeTree

在 CollapsingMergeTree 基础上加上 ver版本号

ENGINE = VersionedCollapsingMergeTree(sign,ver)

```
CREATE TABLE UAct
(
    UserID UInt64,
    PageViews UInt8,
    Duration UInt8,
    Sign Int8,
    Version UInt8
)
ENGINE = VersionedCollapsingMergeTree(Sign, Version)
ORDER BY UserID
```



version 会作为排序条件并增加到ORDER BY的某端，在每个数据分区内，数据会按照ORDER BY id ,ver DESC 排序, 软化 1和-1的顺序







### StorgeMergeTree



MergingSortedBlockinputStream

ReplacingSortedBlockinputStream

SummingSortedBlockinputStream

AggregatingSortedBlockinputStream

CollapsingSortedBlockinputStream

VersionedCollapsingSortedBlockinputStream

GraphiteRollupSortedBlockinputStream



