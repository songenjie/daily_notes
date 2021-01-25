## 引言

阿里云数据库ClickHouse二级索引功能近日已正式发布上线，主要弥补了ClickHouse在海量数据分析场景下，多维度点查能力不足的短板。在以往服务用户的过程中，作者发现绝大部分用户对ClickHouse单表查询性能优化问题感到无从下手，借此机会，本文会先为大家展开介绍ClickHouse在单表分析查询性能优化上的几个方法，基本涵盖了OLAP领域存储层扫描加速的所有常用手段。在解决过各种各样业务场景下的性能优化问题后，作者发现目前ClickHouse在解决多维搜索问题上确实能力不足，一条点查常常浪费巨大的IO、CPU资源，于是云数据库ClickHouse自研了二级索引功能来彻底解决问题，本文会详细介绍二级索引的DDL语法、几个典型适用场景和特色功能。希望可以通过本文让大家对ClickHouse在OLAP场景下的能力有更深的理解，同时阐述清楚二级索引适用的搜索场景。

## 存储扫描性能优化

在介绍各类OLAP存储扫描性能优化技术之前，作者先在这里申明一个简单的代价模型和一些OLAP的背景知识。本文使用最简单的代价模型来计算OLAP存储扫描阶段的开销：磁盘扫描读取的数据量。在类似ClickHouse这样纯列式的存储和计算引擎中，数据的压缩、计算、流转都是以列块为单位按列进行的。在ClickHouse中，只能对数据列以块为单位进行定位读取，虽然用户的查询是按照uid查询确定的某一条记录，但是从磁盘读取的数据量会被放大成块大小 * 列数。本文中不考虑数据缓存(BlockCache / PageCache)这些优化因素，因为Cache可以达到的优化效果不是稳定的。

### 排序键优化-跳跃扫描

排序键是ClickHouse最主要依赖的存储扫描加速技术，它的含义是让存储层每个DataPart里的数据按照排序键进行严格有序存储。正是这种有序存储的模式，构成了ClickHouse "跳跃"扫描的基础和重复数据高压缩比的能力（对于ClickHouse的MergeTree存储结构不熟悉的同学可以参考往期文章《ClickHouse内核分析-MergeTree的存储结构和查询加速》）。

```
CREATE TABLE order_info
(
    `oid`   UInt64,                     --订单ID
    `buyer_nick`    String,     --买家ID
    `seller_nick`   String,     --店铺ID
    `payment`   Decimal64(4), --订单金额
    `order_status`  UInt8,      --订单状态
    ...
    `gmt_order_create`  DateTime, --下单时间
    `gmt_order_pay` DateTime,       --付款时间
    `gmt_update_time` DateTime,     --记录变更时间
    INDEX oid_idx (oid) TYPE minmax GRANULARITY 32
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(gmt_order_create)       --以天为单位分区
ORDER BY (seller_nick, gmt_order_create, oid) --排序键
PRIMARY KEY (seller_nick, gmt_order_create)     --主键
SETTINGS index_granularity = 8192;
```

以一个简单的订单业务场景为例（表结构如上），order by定义了数据文件中的记录会按照店铺ID , 下单时间以及订单号组合排序键进行绝对有序存储，而primary key和index_granularity两者则定义了排序键上的索引结构长什么样子，ClickHouse为每一个有序的数据文件构造了一个"跳跃数组"作为索引，这个"跳跃数组"中的记录是从原数据中按一定间隔抽取出来得到的（简化理解就是每隔index_granularity抽取一行记录），同时只保留primary key定义里的seller_nick, gmt_order_create两个前缀列。如下图所示，有了这个全内存的"跳跃数组"作为索引，优化器可以快速排除掉和查询无关的行号区间，大大减少磁盘扫描的数据量。至于为何不把oid列放到primary key中，读者可以仔细思考一下原因，和index_granularity设定值大小也有关。
![1607334506661-4ed48f2a-5a55-49a1-95cd-fb8a2f10bdd4.jpeg](https://ucc.alicdn.com/pic/developer-ecology/cfcb1497867e4445b650f9e24cda37ce.jpeg)
作者碰到过很多用户在把mysql的binlog数据迁移到ClickHouse上做分析时，照搬照抄mysql上的主键定义，导致ClickHouse的排序键索引基本没有发挥出任何作用，查询性能主要就是靠ClickHouse牛逼的数据并行扫描能力和高效的列式计算引擎在硬抗，这也从侧面反应出ClickHouse在OLAP场景下的绝对性能优势，没有任何索引依旧可以很快。业务系统中的mysql主要侧重单条记录的事务更新，主键是可以简单明了定义成oid，但是在OLAP场景下查询都需要做大数据量的扫描分析，ClickHouse需要用排序键索引来进行"跳跃"扫描，用户建表时应尽量把业务记录生命周期中不变的字段都放入排序键(一般distinct count越小的列放在越前)。

### 分区键优化-MinMax裁剪

继续上一节中的业务场景，当业务需要查询某一段时间内所有店铺的全部订单量时，primary key中定义的"跳跃"数组索引效用就不那么明显了，查询如下：

```
select count(*) 
from order_info where 
gmt_order_create > '2020-0802 00:00:00' 
and gmt_order_create < '2020-0804 15:00:00'
```

ClickHouse中的primary key索引有一个致命问题是，当前缀列的离散度(distinct value count)非常大时，在后续列上的过滤条件起到的"跳跃"加速作用就很微弱了。这个其实很好理解，当"跳跃数组"中相邻的两个元组是('a', 1)和('a', 10086)时，我们可以推断出第二列在对应的行号区间内值域是[1, 10086]；若相邻的元素是('a', 1)和('b', 10086)，则第二列的值域范围就变成(-inf, +inf)了，无法依据第二列的过滤条件进行跳过。
这时候就需要用到partition by优化了，ClickHouse中不同分区的数据是在物理上隔离开的，同时在数据生命管理上也是独立的。partition by就好像是多个DataPart文件集合(数据分区)之间的"有序状态"，而上一节中的order by则是单个DataPart文件内部记录的"有序状态"。每一个DataPart文件只属于一个数据分区，同时在内存里保有partition by列的MinMax值记录。上述查询case中，优化器根据每个DataPart的gmt_order_create最大值最小值可以快速裁剪掉不相关的DataPart，这中裁剪方式对数据的筛选效率比排序键索引更高。
这里教大家一个小技巧，如果业务方既要根据下单时间范围聚合分析，又要根据付款时间范围聚合分析，该如何设计分区键呢？像这类有业务相关性的两个时间列，同时时间差距上又是有业务约束的情况下，我们可以把partition by定义成：
(toYYYYMMDD(gmt_order_create), (gmt_order_pay - gmt_order_create)/3600/240)
这样一来DataPart在gmt_order_create和gmt_order_pay两列上就都有了MinMax裁剪索引。在设计数据分区时，大家需要注意两点：1）partition by会对DataPart起到物理隔离，所以数据分区过细的情况下会导致底层的DataPart数量膨胀，一定程度影响那种大范围的查询性能，要控制partition by的粒度；2）partition by和order by都是让数据存放达到"有序状态"的技术，定义的时候应当尽量错开使用不同的列来定义两者，order by的第一个列一定不要重复放到partition by里，一般来说时间列更适合放在partition by上。

### Skipping index优化-MetaScan

在ClickHouse开源版本里，用户就可以通过自定义index来加速分析查询。但是实际使用中，绝大部分用户都不理解这个文档上写的"skipping index"是个什么原理？为什么创建index之后查询一点都没有变快或者反而变慢了？？？因为"skipping index"并不是真正意义上的索引，正常的索引都是让数据按照索引key进行聚集，或者把行号按照索引key聚集起来。而ClickHouse的"skipping index"并不会做任何聚集的事情，它只是加速筛选Block的一种手段。以 INDEX oid_idx (oid) TYPE minmax GRANULARITY 32 这个索引定义为例，它会对oid列的每32个列存块做一个minmax值统计，统计结果存放在单独的索引文件里。下面的查询在没有oid skipping index的情况下，至少需要扫描5天的数据文件，才能找到对应的oid行。有了索引后，数据扫描的逻辑变成了先扫描oid索引文件，检查oid的minmax区间是否覆盖目标值，后续扫描主表的时候可以跳过不相关的Block，这其实就是在OLAP里常用的Block Meta Scan技术。

```
select *
from order_info where 
gmt_order_create > '2020-0802 00:00:00' 
and gmt_order_create < '2020-0807 00:00:00'
and oid = 726495;
```

当oid列存块的minmax区间都很大时，这个skipping index就无法起到加速作用，甚至会让查询更慢。实际在这个业务场景下oid的skipping idex是有作用的。上一节讲过在同一个DataPart内数据主要是按照店铺ID和下单时间进行排序，所有在同一个DataPart内的oid列存块minmax区间基本都是重叠的。但是ClickHouse的MergeTree还有一个隐含的有序状态：那就是同一个partition下的多个DataPart是处于按写入时间排列的有序状态，而业务系统里的oid是一个自增序列，刚好写入ClickHouse的数据oid基本也是按照时间递增的趋势，不同DataPart之间的oid列存块minmax就基本是错开的。
不难理解，skipping index对查询的加速效果是一个常数级别的，索引扫描的时间是和数据量成正比的。除了minmax类型的skipping index，还有set类型索引，它适用的场景也是要求列值随着写入时间有明显局部性。剩下的bloom_filter、ngrambf_v1、tokenbf_v1则是通过把完整的字符串列或者字符串列分词后的token用bloom_filter生成高压缩比的签名来进行排除Block，在长字符串的场景下有一定加速空间。

### Prewhere优化-两阶段扫描

前面三节讲到的所有性能优化技术基本都是依赖数据的"有序性"来加速扫描满足条件的Block，这也意味着满足查询条件的数据本身就是存在某种"局部性"的。正常的业务场景中只要满足条件的数据本身存在"局部性"就一定能通过上面的三种方法来加速查询。在设计业务系统时，我们甚至应该刻意去创造出更多的"局部性"，例如本文例子中的oid如果是设计成"toYYYYMMDDhh(gmt_order_create)+店铺ID+递增序列"，那就可以在DataPart内部筛选上获得"局部性"，查询会更快，读者们可以深入思考下这个问题。
在OLAP场景下最难搞定的问题就是满足查询条件的数据没有任何"局部性"：查询条件命中的数据可能行数不多，但是分布非常散乱，每一个列存块中都有一两条记录满足条件。这种情况下因为列式存储的关系，只要块中有一条记录命中系统就需要读取完整的块，最后几百上千倍的数据量需要从磁盘中读取。当然这是个极端情况，很多时候情况是一部分列存块中没有满足条件的记录，一部分列存块中包含少量满足条件的记录，整体呈现随机无序。这种场景下当然可以对查询条件列加上类似lucene的倒排索引快速定位到命中记录的行号集合，但索引是有额外存储、构建成本的，更好的方法是采用两阶段扫描来加速。
以下面的查询为例，正常的执行逻辑中存储层扫描会把5天内的全部列数据从磁盘读取出来，然后计算引擎再按照order_status列过滤出满足条件的行。在两阶段扫描的框架下，prewhere表达式会下推到存储扫描过程中执行，优先扫描出order_status列存块，检查是否有记录满足条件，再把满足条件行的其他列读取出来，当没有任何记录满足条件时，其他列的块数据就可以跳过不读了。

```
--常规
select *
from order_info where
where order_status = 2 --订单取消
and gmt_order_create > '2020-0802 00:00:00' 
and gmt_order_create < '2020-0807 00:00:00'；
--两阶段扫描
select *
from order_info where
prewhere order_status = 2 --订单取消
where gmt_order_create > '2020-0802 00:00:00' 
and gmt_order_create < '2020-0807 00:00:00'；
```

这种两阶段扫描的思想就是优先扫描筛选率高的列进行过滤，再按需扫描其他列的块。在OLAP几百列的大宽表分析场景下，这种加速方式减少的IO效果是非常明显的。但是瓶颈也是确定的，至少需要把某个单列的数据全部扫描出来。目前大家在使用prewhere加速的时候最好是根据数据分布情况来挑选最有筛选率同时扫描数据量最少的过滤条件。当遇上那种每个Block中都有一两条记录满足查询条件的极端情况时，尝试使用ClickHouse的物化视图来解决吧。物化视图的作用不光是预聚合计算，也可以让数据换个排序键重新有序存储一份。还有一种zorder的技术也能缓解一部分此类问题，有兴趣的同学可以自己了解一下。

### 小结

前面四节分别介绍了ClickHouse中四种不同的查询加速技术，当满足查询条件的数据有明显的"局部性"时，大家可以通过前三种低成本的手段来加速查询。最后介绍了针对数据分布非常散乱的场景下，prewhere可以缓解多列分析的IO压力。实际上这四种优化手段都是可以结合使用的，本文拆开阐述只是为了方便大家理解它们的本质。延续上一节的问题，当数据分布非常散乱，同时查询命中的记录又只有若干条的场景下，就算使用prewhere进行两阶段扫描，它的IO放大问题也依旧是非常明显的。简单的例子就是查询某个特定买家id(buyer_nick)的购买记录，买家id在数据表中的分布是完全散乱的，同时买家id列全表扫描的代价过大。所以阿里云ClickHouse推出了二级索引功能，专门来解决这种少量结果的搜索问题。这里如何定义结果的少呢？一般列存系统中一个列存块包括接近10000行记录，当满足搜索条件的记录数比列存块小一个数量级时(筛选率超过100000:1)，二级索引才能发挥比较明显的性能优势。

## 二级索引多维搜索

ClickHouse的二级索引在设计的时候对标的就是ElasticSearch的多维搜索能力，支持多索引列条件交并差检索。同时对比ElasticSearch又有更贴近ClickHouse的易用性优化，总体特点概括如下：
• 多列联合索引 & 表达式索引
• 函数下推
• In Set Clause下推
• 多值索引 & 字典索引
• 高压缩比 1:1 vs lucene 8.7
• 向量化构建 4X vs lucene 8.7
常规索引
二级索引在创建表时的定义语句示例如下：

```
CREATE TABLE index_test 
(
  id UInt64, 
  d DateTime, 
  x UInt64,
  y UInt64, 
  tag String,
  KEY tag_idx tag TYPE range, --单列索引
  KEY d_idx toStartOfHour(d) TYPE range, --表达式索引
  KEY combo_idx (toStartOfHour(d)，x, y) TYPE range, --多列联合索引
) ENGINE = MergeTree() ORDER BY id;
```

其他二级索引相关的修改DDL如下：

```
--删除索引定义
Alter table index_test DROP KEY tag_idx;
--增加索引定义
Alter table index_test ADD KEY tag_idx tag TYPE range;
--清除数据分区下的索引文件
Alter table index_test CLEAR KEY tag_idx tag in partition partition_expr;
--重新构建数据分区下的索引文件
Alter table index_test MATERIALIZE KEY tag_idx tag in partition partition_expr;
```

支持多列索引的目的是减少特定查询pattern下的索引结果归并，针对QPS要求特别高的查询用户可以创建针对性的多列索引达到极致的检索性能。而表达式索引主要是方便用户进行自由的检索粒度变换，考虑以下两个典型场景：
1）索引中的时间列在搜索条件中，只会以小时粒度进行过滤，这种情况下用户可以对toStartOfHour(time)表达式创建索引，可以一定程度加速索引构建，同时对time列的时间过滤条件都可以自动转换下推索引。
2）索引中的id列是由UUID构成，UUID几乎是可以保证永久distinct的字符串序列，直接对id构建索引会导致索引文件太大。这时用户可以使用前缀函数截取UUID来构建索引，如prefix8(id)是截取8个byte的前缀，对应的还有prefix4和prefix16，prefixUTF4、prefixUTF8、prefixUTF16则是用来截取UTF编码的。
值得注意的是，用户对表达式构建索引后，原列上的查询条件也可以正常下推索引，不需要特意改写查询。同样用户对原列构建索引，过滤条件上对原列加了表达式的情况下，优化器也都可以正常下推索引。
In Set Clause下推则是一个关联搜索的典型场景，作者经常碰到此类场景：user的属性是一张单独的大宽表，user的行为记录又是另一张单独的表，对user的搜索需要先从user行为记录表中聚合过滤出满足条件的user id，再用user ids从属性表中取出明细记录。这种in subquery的场景下，ClickHouse也可以自动下推索引进行加速。

### 多值索引

多值索引主要针对的是array类型列上has()/hasAll()/hasAny()条件的搜索加速，array列时标签分析里常用的数据类型，每条记录会attach对个标签，存放在一个array列里。对这个标签列的过滤以往只能通过暴力扫描过滤，ClickHouse二级索引专门扩展了多值索引类型解决此类问题，索引定义示例如下：

```
CREATE TABLE index_test 
(
  id UInt64, 
  tags Array(String),
  KEY tag_idx tag TYPE array --多值索引
) ENGINE = MergeTree() ORDER BY id;

--包含单个标签
select * from index_test where has(tags, 'aaa');
--包含所有标签
select * from index_test where hasAll(tags, ['aaa', 'bbb']);
--包含任意标签
select * from index_test where has(tags, ['aaa', 'ccc']);
```

### 字典索引

字典索引主要是针对那种使用两个array类型列模拟Map的场景进行检索加速，key和value是两个单独的array列，通过元素的position一一对应进行kv关联。ClickHouse二级索引专门为这种场景扩展了检索函数和索引类型支持，索引定义示例如下：

```
CREATE TABLE index_test 
(
  id UInt64, 
  keys Array(String),
  vals Array(UInt32),
  KEY kv_idx (keys, vals) TYPE map --字典索引
) ENGINE = MergeTree() ORDER BY id;

--指定key的value等值条件 map['aaa'] = 32
select * from index_test where hasPairEQ(keys, vals, ('aaa', 32));
--指定key的value大于条件 map['aaa'] > 32
select * from index_test where hasPairGT(keys, vals, ('aaa', 32));
--指定key的value大于等于条件 map['aaa'] >= 32
select * from index_test where hasPairGTE(keys, vals, ('aaa', 32));
--指定key的value小于条件 map['aaa'] < 32
select * from index_test where hasPairLT(keys, vals, ('aaa', 32));
--指定key的value小于等于条件 map['aaa'] <= 32
select * from index_test where hasPairLTE(keys, vals, ('aaa', 32));
```

### 索引构建性能

作者对ClickHouse的二级索引构建性能和索引压缩率做了全方位多场景下的测试，主要对比的是lucene 8.7的倒排索引和BKD索引。ElasticSearch底层的索引就是采用的lucene，这里的性能数据读者可以作个参考，但并不代表ElasticSearch和ClickHouse二级索引功能端到端的性能水平。因为ClickHouse的二级索引是在DataPart merge的时候进行构建，了解ClickHouse MergeTree存储引擎的同学应该明白MergeTree存在写放大的情况(一条记录merge多次)，同时merge又完全是异步的行为。

#### 日志trace_id场景

mock数据方法：
substringUTF8(cast (generateUUIDv4() as String), 1, 16)
数据量：1E (ClickHouse数据文件1.5G)
构建耗时：
ClickHouse 65.32s vs Lucene 487.255s
索引文件大小：
ClickHouse 1.4G vs Lucene 1.3G

#### 字符串枚举场景

mock数据方法：
cast((10000000 + rand(number) % 1000) as String)
数据量：1E (ClickHouse数据文件316M)
构建耗时：
ClickHouse 37.19s vs Lucene 46.279s
索引文件大小：
ClickHouse 160M vs Lucene 163M

#### 数值散列场景

mock数据方法：
toFloat64(rand(100000000))
数据量：1E (ClickHouse数据文件564M)
构建耗时：
ClickHouse 32.20s vs Lucene BKD 86.456s
索引文件大小：
ClickHouse 801M vs Lucene BKD 755M

#### 数值枚举场景

mock数据方法：
rand(1000)
数据量：1E (ClickHouse数据文件275M)
构建耗时：
ClickHouse 12.81s vs Lucene BKD 78.0s
索引文件大小：
ClickHouse 160M vs Lucene BKD 184M

## 结语

二级索引功能的主要目的是为了弥补ClickHouse在搜索场景下的不足，在分析场景下ClickHouse目前原有的技术已经比较丰富。希望通过本文大家对OLAP查询优化有更深的理解，欢迎大家尝试使用二级索引来解决多维搜索问题，积极反馈使用体验问题。