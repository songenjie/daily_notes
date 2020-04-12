#### group index 
- http://lxw1234.com/archives/2016/04/632.htm#comments
由之前的文章知道，一个ORC文件包含一个或多个stripes(groups of row data)，每个stripe中包含了每个column的min/max值的索引数据，当查询中有<,>,=的操作时，会根据min/max值，跳过扫描不包含的stripes。

而其中为每个stripe建立的包含min/max值的索引，就称为Row Group Index，也叫min-max Index，或者Storage Index。在建立ORC格式表时，指定表参数’orc.create.index’=’true’之后，便会建立Row Group Index，需要注意的是，为了使Row Group Index有效利用，向表中加载数据时，必须对需要使用索引的字段进行排序，否则，min/max会失去意义。另外，这种索引通常用于数值型字段的查询过滤优化上。

#### bloom filter 
- https://blog.csdn.net/jiaomeng/article/details/1495500

Bloom Filter是一种空间效率很高的随机数据结构，它利用位数组很简洁地表示一个集合，并能判断一个元素是否属于这个集合。Bloom Filter的这种高效是有一定代价的：在判断一个元素是否属于某个集合时，有可能会把不属于这个集合的元素误认为属于这个集合（false positive）。因此，Bloom Filter不适合那些“零错误”的应用场合。而在能容忍低错误率的应用场合下，Bloom Filter通过极少的错误换取了存储空间的极大节省。

#### croaring bitmap  
https://cloud.tencent.com/developer/article/1136054

https://github.com/RoaringBitmap/

https://cloud.tencent.com/developer/article/1136054

-[](/source/croaring_bitmap.png)
