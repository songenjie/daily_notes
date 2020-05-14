## 数据存储的组织逻辑
* 一个分区和一个分桶对应一个Tablet
* 一个Tablet对应一个或多个rowset
* 一个rowset对应一个或多个segment_group （一个rowset对应一批次导入数据）
* 一个segment_group对应一个segment （主要是兼容问题，在0.12版本segment_group和segment已合并）
* 一个segment对应磁盘上一个.dat文件和一个.idx文件

#### 查询meta的方法：
```sql
SHOW TABLET FROM <db_name>.<table_name>; -- 通过table_name获取其所有的Tablet信息
SHOW TABLET FROM <tablet_id>; -- 通过tablet_id获取其tablet的信息
```
访问BE的http接口，获取对应的Tablet Meta信息：
```shell
http://{host}:{port}/api/meta/header/{tablet_id}/{schema_hash}
```

## Segment文件格式
![segment](/uploads/b392eecf2e811bd63ee99f2be9638d1f/segment.png)

[详情见社区文档](http://doris.apache.org/master/zh-CN/internal/doris_storage_optimization.html#%E6%96%87%E4%BB%B6%E6%A0%BC%E5%BC%8F)

## 存储层的谓词下推
- 意义：减少读取的数据, 降低i/o消耗.
  - 跳过不满足谓词条件的page,以减少扫描的文件数据
  - 过滤掉不满足谓词条件的record，以减少数据的传输
  
- 目前谓词下推条件:
  - 仅支持只有And的复合谓词 （如 支持： a=1 AND b=2 AND c=3，不支持 a=1 AND b=2 OR c=3 ）
  - = / >= / > / < / <= / in / is (not)
  - 不支持带函数的谓词 （如 abs(a) > 1 ）

## 基于索引的谓词下推原理
- 不同于传统的数据库设计，```Doris 不支持在任意列上创建索引```,Doris 这类 MPP 架构的 OLAP 数据库，通常都是通过提高并发，来处理大量数据的
- 本质上，Doris 的数据存储在类似 SSTable（Sorted String Table）的数据结构中。该结构是一种有序的数据结构。在这种数据结构上，```以排序列作为条件进行查找，会非常的高效```
- 在 Aggregate、Uniq 和 Duplicate 三种数据模型中。```底层的数据存储，是按照各自建表语句中，AGGREGATE KEY、UNIQ KEY 和 DUPLICATE KEY 中指定的列进行排序存储的```

#### Short Key Index （前缀索引）
- 索引是构建在Row Block粒度
- 而前缀索引，即在排序的基础上，实现的一种根据给定前缀列，快速查询数据的索引方式。
- 我们将一行数据的前 36 个字节 作为这行数据的前缀索引。当遇到 VARCHAR 类型时，前缀索引会直接截断。

- 谓词下推原理：
按照需要的列，读取short key索引和对应列的数据ordinal索引信息，使用start key和end key，通过short key索引定位到要读取的行号，然后通过ordinal索引确定需要读取的row ranges, 同时需要通过其他索引等过滤需要读取的row ranges，然后按照row ranges通过ordinal索引读取行的数据
![image](/uploads/5810256e4e4141d76db5122434c234e6/image.png)

#### Ordinal Index
- 索引是构建在Page粒度
![image](/uploads/43d203698936d4c066b490588c240e44/image.png)

#### ZoneMap
- 索引是构建在Page粒度
- 支持的谓词： = / != / < / <= / > / >= / in / is (not) null

#### BloomFilter
- 索引是构建在Page粒度
- 支持的谓词： = / in / is (not) null


## 存储引擎代码梳理
![ExecNode](/uploads/336a2e0d382502aa720cea37f16cf731/doris存储-Page-3.png)
![OlapScanNode](/uploads/3be08cd1cce9593f31d77c9d4a888942/doris存储-Page-2.png)





### 参考文档
- [Doris 数据模型、ROLLUP 及前缀索引](https://github.com/apache/incubator-doris/wiki/Data-Model%2C-Rollup-%26-Prefix-Index)
- [Doris存储文件格式优化](http://doris.apache.org/master/zh-CN/internal/doris_storage_optimization.html#%E6%96%87%E4%BB%B6%E6%A0%BC%E5%BC%8F)


