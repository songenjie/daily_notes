- 40亿

4 * 10 ^9  bit/8/1024/1024=477M



位运算 and、or、xor、andnot 留存分析、漏斗分析、用户画像



- 原理 

将32bit的Int划分为高16为 `(k % 2^16)`和低 16 位`(k mod 2^16)`,称为key,value 关系

通过高16位找到container,低16位存放在Container中



- RBM 的主要思想并不复杂，简单来讲，有如下三条：

1. 我们将 32-bit 的范围 ([0, n)) 划分为 2^16 个桶，每一个桶有一个 Container 来存放一个数值的低16位；
2. 在存储和查询数值的时候，我们将一个数值 k 划分为高 16 位`(k % 2^16)`和低 16 位`(k mod 2^16)`，取高 16 位找到对应的桶，然后在低 16 位存放在相应的 Container 中；
3. 容器的话， RBM 使用两种容器结构： Array Container 和 Bitmap Container。Array Container 存放稀疏的数据，Bitmap Container 存放稠密的数据。即，若一个 Container 里面的 Integer 数量小于 4096，就用 Short 类型的有序数组来存储值。若大于 4096，就用 Bitmap 来存储值。



- 原理

![原理图](/source/roaringbitmap原理介绍.jpg.png)

- eg

看完前面的还不知道在说什么？没关系，举个栗子说明就好了。现在我们要将 821697800 这个 32 bit 的整数插入 RBM 中，整个算法流程是这样的：

1. 821697800 对应的 16 进制数为 30FA1D08， 其中高 16 位为 30FA， 低16位为 1D08。
2. 我们先用二分查找从一级索引（即 Container Array）中找到数值为 30FA 的容器（如果该容器不存在，则新建一个），从图中我们可以看到，该容器是一个 Bitmap 容器。
3. 找到了相应的容器后，看一下低 16 位的数值 1D08，它相当于是 7432，因此在 Bitmap 中找到相应的位置，将其置为 1 即可。

![roaring bimap eg](/source/roaring_bitmap_eg.png)



- 原理补充

RBM 的基本原理就这些，基于这种设计原理会有一些额外的操作要提一下。

请注意上文提到的一句话：

>  若一个 Container 里面的 Integer 数量小于 4096，就用 Short 类型的有序数组来存储值。若大于 4096，就用 Bitmap 来存储值。 

先解释一下为什么这里用的 4096 这个阈值？因为一个 Integer 的低 16 位是 2Byte，因此对应到 Arrary Container 中的话就是 2Byte * 4096 = 8KB；同样，对于 Bitmap Container 来讲，2^16 个 bit 也相当于是 8KB。

然后，基于前面提到的两种 Container，在两个 Container 之间的 Union (bitwise OR)  或者 Intersection (bitwise AND) 操作又会出现下面三种场景：

- Bitmap vs Bitmap
- Bitmap vs Array
- Array vs Array
