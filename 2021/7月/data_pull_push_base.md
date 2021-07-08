这篇论文主要对比了向量化和codegen，这两种不同的OLAP query engine实现，在性能表现的差异，进行了详细的benchmark，并对结果做了深入的解读。

在过去query engine实现用火山模型（Volcano-style iteration model,），是因为磁盘IO的瓶颈，计算引擎的执行占比并不高，但是现今cpu逐渐成为瓶颈的情况下，业界对volcano-style的改进方案，走了两派，向量化的代表是VectorWise（荷兰CWI研究院08年开发的MonetDB/X100, 后续并入VectorWise），而data-centric code generation的代表是HyPer。使用向量化的工业界系统包括DB2 BLU，SQL server列存和QuickStep，codegen则为spark和peloton。

实现方式上，火山模型是pull-based，每个算子实现一个next，输入是一个block，向量化的前提批量接口，然后vector-at-a-time的处理一批类型相同的数据，执行简单的操作。codegen，是push-based的接口，要实现produce和consume，在query plan tree上做类似于深度优先搜索的调用方式，codegen出来的代码都是要有特化类型的，把多个算子压缩成一个loop。

学术界没有针对这两种实现方式的比较，因为各个系统的实现算法、数据结构、并行化方式都不尽相同，很难对齐，为了屏蔽这些不同，公平的评测向量化和codegen，论文实现了两个简单的系统，codegen叫做Typer，向量叫做Tectorwise（后文简称TW）。

向量化的好处在于，以计算为中心，批量处理，充分利用计算局部性和数据局部性的特性，针对某些算子实现特定的向量化算法，cache friendly，更可以利用CPU super scalar流水线，out-of-order等特性，同时具备使用SIMD指令加速的条件。劣势在于，需要物化保存中间临时结果数据，IPC指令更多。

> 个人理解向量化 = 批量接口（vector） + 向量化算法 + 可选的SIMD指令应用。下图是论文中对于hash join算子的改造，改造前计算hash值的过程对于cpu不太友好， 存在指令间的依赖，以及分支预测失败的情况，另外对于cache的争抢也严重；改造后指令多了，但是执行更加紧凑，变量不再互相依赖，各自攒批执行，指令可以循环展开，有利用cpu在微架构（micro-architecting）层面的优化做out-of-order并行，另外访存cache friendly。

![img](https://pic3.zhimg.com/80/v2-0935f0cd61ea8da416d40d3e75bb35b2_1440w.jpg)

codegen的好处在于，算子的融合，一个loop完成操作，代码精简，instruction数低，IPC少，代表系统为Spark（在1.6版本里提出的Project Tungsten引入了codegen，然而在2020年DataBricks转向了向量化引擎photon并未开源）。

**结果显示，二者没有孰优孰劣的严格分界，在不同场景有各自的优势。**

论文评测了 scan、select、project（map）、join、group by算子以及部分TPC-H 5条典型query（Q1,Q6,Q3,Q9,Q18），benchmark了单并发、数据并行执行 （SIMD）、并行3种不同场景的表现。

## 1、单并发

查询耗时情况如下。

![img](https://pic3.zhimg.com/80/v2-10ed5dcbf5afc9a8c773374a4885bb96_1440w.jpg)

TPC-H Q1, Q18 Typer快，TPC-H Q3, Q9 TW快。

![img](https://pic3.zhimg.com/80/v2-dd9d749e5113eb4d2e03ce8e4deac782_1440w.jpg)

Q1 TW相比Typer需要执行更多指令（162/68=约2.4倍，如上图），并且通常会有更多的L1 cache miss（约3.3倍），TW所有的操作都需要物化，Q1是简单的算数运算符sum，avg，count等，所以Typer快在计算密集型查询，所有的结果可以在cpu寄存器缓存，避免了大量的cache miss。

Q3, Q9，TW比Typer快了4%到32%，LLC miss差不多，但是从memory stall角度分析（下图），TW比Typer优势明显。

![img](https://pic3.zhimg.com/80/v2-58f3b080771bd9575ccaecb0822845ce_1440w.jpg)

TW的hash table probe可以利用cpu乱序执行优化，而Typer则内部逻辑复杂，融合了scan，selection，hash table probe，aggregation等，无法利用cpu乱序执行优化，另外很多的判断逻辑，造成分支预测开销也很大。

所以TW的简单循环，可以把memory stall降低，在这种访存密集的场景中，TW的循环内代码逻辑足够简单，可以很好的利用上cpu乱序执行和推测执行来加速，相比Typer，可以hide cache miss latency，所以在这种场景中TW比Typer执行性能更好。

## 2、数据并行执行 （SIMD）

在selection和hashjoin probing两个算子上，计算hash table，lookup hash table可以用SIMD优化。hashing用murmur2.

hashing加速2.3x；hash table探测，加速1.4x，如下图。

![img](https://pic1.zhimg.com/80/v2-e9d14b1a4ac938988910c745ecdc70b0_1440w.jpg)

但是跑TPC-H场景，几乎没什么效果（图中d），1.1x提升，因为大部分耗时都在SIMD优化的逻辑上。这种现象的原因在于，随着数据量增加，SIMD加速的收益将逐渐减少，并且发现整体执行成本是由访问内存开销memory bound决定的，这部分SIMD无能为力。

## 3、intra-query并行

VectorWise使用经典的并行实现，算子不感知并行化。Hyper使用了Morsel-Driven Parallelism，这样可以实现更好的data locality，实验20个超线程，Hyper可以提速11.7x，而VectorWise只有7.2x。多线程执行TW和Typer都具备很好的扩展性，而且超线程可以弥补单线程的sub-optimal code。

## 总结

1）codegen适合计算密集型场景，如果数据可以都在cpu register里面，更少的指令加速效果明显。

2）向量化则适合在访存密集型场景，避免memory stall，例如aggregation和hash join。

3）SIMD理论上可以数倍加速，但是实际TPC-H评测，一些请求大部分受限于memory bound，所以效果并不十分明显。

4）两种实现都可以很好的并行化。