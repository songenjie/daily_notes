

STL中的容器可以分为两大类：

1、顺序容器：list，queue，vector

2、关联容器：map，set（当然对应的有multimap，multiset）

其中vector的存储结构是数组，其它的存储结构是链表。



言归正传，现在看一下vector和set的区别：

首先vector属于顺序容器，其元素与存储位置与操作操作有关；set属于关联容器，其元素相当于键值。set能够保证它里面所有的元素都是不重复的（multiset除外）。

其次，由于存储结构不同，vector擅长于解决某个位置是什么值的问题，而set擅长于解决，某个元素在那个位置的问题，知道元素的内容，查找它的位置。因此vector特别好的支持随机访问，而set不支持（不支持下标访问）。





