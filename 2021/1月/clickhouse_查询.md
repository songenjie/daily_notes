# 云数据库ClickHouse资源隔离-弹性资源队列

[stromal](https://developer.aliyun.com/profile/l3bobhip3uijy) 2021-01-13 74浏览量

**简介：** 作者：仁劼

## 引言

ClickHouse内核分析系列文章，本文将为大家深度解读ClickHouse当前的MPP计算模型、用户资源隔离、查询限流机制，在此基础上为大家介绍阿里巴巴云数据库ClickHouse在八月份即将推出的自研弹性资源队列功能。ClickHouse开源版本当前还没有资源队列相关的规划，自研弹性资源队列的初衷是更好地解决隔离和资源利用率的问题。下文将从ClickHouse的MPP计算模型、现有的资源隔离方案展开来看ClickHouse当前在资源隔离上的痛点，最后为大家介绍我们的自研弹性资源队列功能。

## MPP计算模型

在深入到资源隔离之前，这里有必要简单介绍一下ClickHouse社区纯自研的MPP计算模型，因为ClickHouse的MPP计算模型和成熟的开源MPP计算引擎（例如：Presto、HAWQ、Impala）存在着较大的差异（que xian），这使得ClickHouse的资源隔离也有一些独特的要求，同时希望这部分内容能指导用户更好地对ClickHouse查询进行调优。

ClickHouse的MPP计算模型最大的特点是：它压根没有分布式执行计划，只能通过递归子查询和广播表来解决多表关联查询，这给分布式多表关联查询带来的问题是数据shuffle爆炸。另外ClickHouse的执行计划生成过程中，仅有一些简单的filter push down，column prune规则，完全没有join reorder能力。对用户来说就是"所写即所得"的模式，要求人人都是DBA，下面将结合简单的查询例子来介绍一下ClickHouse计算模型最大的几个原则。

### 递归子查询

在阅读源码的过程中，我可以感受到ClickHouse前期是一个完全受母公司Yandex搜索分析业务驱动成长起来的数据库。而搜索业务场景下的Metric分析（uv / pv ...），对分布式多表关联分析的并没有很高的需求，绝大部分业务场景都可以通过简单的数据分表分析然后聚合结果（数据建模比较简单），所以从一开始ClickHouse就注定不擅长处理复杂的分布式多表关联查询，ClickHouse的内核只是把单机（单表）分析做到了性能极致。但是任何一个业务场景下都不能完全避免分布式关联分析的需求，ClickHouse采用了一套简单的Rule来处理多表关联分析的查询。

对ClickHouse有所了解的同学应该知道ClickHouse采用的是简单的节点对等架构，同时不提供任何分布式的语义保证，ClickHouse的节点中存在着两种类型的表：本地表（真实存放数据的表引擎），分布式表（代理了多个节点上的本地表，相当于"分库分表"的Proxy）。当ClickHouse的节点收到两表的Join关联分析时，问题比较收敛，无非是以下几种情况：本地表 Join 分布式表 、本地表 Join 本地表、 分布式表 Join 分布式表、分布式表 Join 本地表，这四种情况会如何执行这里先放一下，等下一小节再介绍。

接下来问题复杂化，如何解决多个Join的关联查询？ClickHouse采用递归子查询来解决这个问题，如下面的简单例子所示ClickHouse会自动把多个Join的关联查询改写成子查询进行嵌套, 规则非常简单：1）Join的左右表必须是本地表、分布式表或者子查询；2）倾向把Join的左侧变成子查询；3）从最后一个Join开始递归改写成子查询；4）对Join order不做任何改动；5）可以自动根据where条件改写Cross Join到Inner Join。下面是两个具体的例子帮助大家理解：
例一

```
select * from local_tabA 
join (select * from dist_tabB join local_tabC on dist_tabB.key2 = local_tabC.key2) as sub_Q1
on local_tabA.key1 = sub_Q1.key1
join dist_tabD on local_tabA.key1 = dist_tabD.key1;
=============>
select * from 
(select * from local_tabA join 
 (select * from dist_tabB join local_tabC on dist_tabB.key2 = local_tabC.key2) as sub_Q1
on local_tabA.key1 = sub_Q1.key1) as sub_Q2
join dist_tabD on sub_Q2.key1 = dist_tabD.key1;
```

例二：

```
select * from local_tabA 
join (select * from dist_tabB join local_tabC on dist_tabB.key2 = local_tabC.key2) as sub_Q1
on local_tabA.key1 = sub_Q1.key1
join dist_tabD on local_tabA.key1 = dist_tabD.key1;
=============>
select * from 
(select * from local_tabA join 
 (select * from dist_tabB join local_tabC on dist_tabB.key2 = local_tabC.key2) as sub_Q1
on local_tabA.key1 = sub_Q1.key1) as sub_Q2
join dist_tabD on sub_Q2.key1 = dist_tabD.key1;
```

Join关联中的子查询在计算引擎里就相关于是一个本地的"临时表"，只不过这个临时表的Input Stream对接的是一个子查询的Output Stream。所以在处理多个Join的关联查询时，ClickHouse会把查询拆成递归的子查询，每一次递归只处理一个Join关联，单个Join关联中，左右表输入有可能是本地表、分布式表、子查询，这样问题就简化了。

这种简单的递归子查询解决方案纯在最致命的缺陷是：

（1）系统没有自动优化能力，Join reorder是优化器的重要课题，但是ClickHouse完全不提供这个能力，对内核不够了解的用户基本无法写出性能最佳的关联查询，但是对经验老道的工程师来说这是另一种体验：可以完全掌控SQL的执行计划。

（2）无法完全发挥分布式计算的能力，ClickHouse在两表的Join关联中能否利用分布式算力进行join计算取决于左表是否是分布式表，只有当左表是分布式表时才有可能利用上Cluster的计算能力，也就是左表是本地表或者子查询时Join计算过程只在一个节点进行。

（3）多个大表的Join关联容易引起节点的OOM，ClickHouse中的Hash Join算子目前不支持spill（落盘），递归子查询需要节点在内存中同时维护多个完整的Hash Table来完成最后的Join关联。

### 两表Join规则

上一节介绍了ClickHouse如何利用递归子查询来解决多个Join的关联分析，最终系统只会focus在单个Join的关联分析上。除了常规的Join方式修饰词以外，ClickHouse还引入了另外一个Join流程修饰词"Global"，它会影响整个Join的执行计划。节点真正采用Global Join进行关联的前提条件是左表必须是分布式表，Global Join会构建一个内存临时表来保存Join右测的数据，然后把左表的Join计算任务分发给所有代理的存储节点，收到Join计算任务的存储节点会跨节点拷贝内存临时表的数据，用以构建Hash Table。

下面依次介绍所有可能出现的单个Join关联分析场景：

（1）（本地表/子查询）Join（本地表/子查询）：常规本地Join，Global Join不生效

（2）（本地表/子查询）Join（分布式表）：分布式表数据全部读到当前节点进行Hash Table构建，Global Join不生效

（3）（分布式表）Join（本地表/子查询）：Join计算任务分发到分布式表的所有存储节点上，存储节点上收到的Join右表取决于是否采用Global Join策略，如果不是Global Join则把右测的（本地表名/子查询）直接转给所有存储节点。如果是Global Join则当前节点会构建Join右测数据的内存表，收到Join计算任务的节点会来拉取这个内存表数据。

（4）（分布式表）Join（分布式表）：Join计算任务分发到分布式表的所有存储节点上，存储节点上收到的Join右表取决于是否采用Global Join策略，如果不是Global Join则把右测的分布式表名直接转给所有存储节点。如果是Global Join则当前节点会把右测分布式表的数据全部收集起来构建内存表，收到Join计算任务的节点会来拉取这个内存表数据。

从上面可以看出只有分布式表的Join关联是可以进行分布式计算的，Global Join可以提前计算Join右测的结果数据构建内存表，当Join右测是带过滤条件的分布式表或者子查询时，降低了Join右测数据重复计算的次数，还有一种场景是Join右表只在当前节点存在则此时必须使用Global Join把它替换成内存临时表，因为直接把右表名转给其他节点一定会报错。

ClickHouse中还有一个开关和Join关联分析的行为有关：distributed_product_mode，它只是一个简单的查询改写Rule用来改写两个分布式表的Join行为。当set distributed_product_mode = 'LOCAL'时，它会把右表改写成代理的存储表名，这要求左右表的数据分区对齐，否则Join结果就出错了，当set distributed_product_mode = 'GLOBAL'时，它会把自动改写Join到Global Join。但是这个改写Rule只针对左右表都是分布式表的case，复杂的多表关联分析场景下对SQL的优化作用比较小，还是不要去依赖这个自动改写的能力。

ClickHouse的分布式Join关联分析中还有另外一个特点是它并不会对左表的数据进行re-sharding，每一个收到Join任务的节点都会要全量的右表数据来构建Hash Table。在一些场景下，如果用户确定Join左右表的数据是都是按照某个Join key分区的，则可以使用（分布式表）Join（本地表）的方式来缓解一下这个问题。但是ClickHouse的分布式表Sharding设计并不保证Cluster在调整节点后数据能完全分区对齐，这是用户需要注意的。

### 小结

总结一下上面两节的分析，ClickHouse当前的MPP计算模型并不擅长做多表关联分析，主要存在的问题：1）节点间数据shuffle膨胀，Join关联时没有数据re-sharding能力，每个计算节点都需要shuffle全量右表数据；2）Join内存膨胀，原因同上；3）非Global Join下可能引起计算风暴，计算节点重复执行子查询；4）没有Join reorder优化。其中的1和3还会随着节点数量增长变得更加明显。在多表关联分析的场景下，用户应该尽可能为小表构建Dictionary，并使用dictGet内置函数来代替Join，针对无法避免的多表关联分析应该直接写成嵌套子查询的方式，并根据真实的查询执行情况尝试调整Join order寻找最优的执行计划。当前ClickHouse的MPP计算模型下，仍然存在不少查询优化的小"bug"可能导致性能不如预期，例如列裁剪没有下推，过滤条件没有下推，partial agg没有下推等等，不过这些小问题都是可以修复。

## 资源隔离现状

当前的ClickHouse开源版本在系统的资源管理方面已经做了很多的feature，我把它们总结为三个方面：全链路（线程-》查询-》用户）的资源使用追踪、查询&用户级别资源隔离、资源使用限流。对于ClickHouse的资深DBA来说，这些资源追踪、隔离、限流功能已经可以解决非常多的问题。接下来我将展开介绍一下ClickHouse在这三个方面的功能设计实现。

### trace & profile

ClickHouse的资源使用都是从查询thread级别就开始进行追踪，主要的相关代码在 ThreadStatus 类中。每个查询线程都会有一个thread local的ThreadStatus对象，ThreadStatus对象中包含了对内存使用追踪的 MemoryTracker、profile cpu time的埋点对象 ProfileEvents、以及监控thread 热点线程栈的 QueryProfiler。
1.MemoryTracker
ClickHouse中有很多不同level的MemoryTracker，包括线程级别、查询级别、用户级别、server级别，这些MemoryTracker会通过parent指针组织成一个树形结构，把内存申请释放信息层层反馈上去。

MemoryTrack中还有额外的峰值信息（peak）统计，内存上限检查，一旦某个查询线程的申请内存请求在上层（查询级别、用户级别、server级别）MemoryTracker遇到超过限制错误，查询线程就会抛出OOM异常导致查询退出。同时查询线程的MemoryTracker每申请一定量的内存都会统计出当前的工作栈，非常方便排查内存OOM的原因。

ClickHouse的MPP计算引擎中每个查询的主线程都会有一个ThreadGroup对象，每个MPP引擎worker线程在启动时必须要attach到ThreadGroup上，在线程退出时detach，这保证了整个资源追踪链路的完整传递。最后一个问题是如何把CurrentThread::MemoryTracker hook到系统的内存申请释放上去？ClickHouse首先是重载了c++的new_delete operator，其次针对需要使用malloc的一些场景封装了特殊的Allocator同步内存申请释放。为了解决内存追踪的性能问题，每个线程的内存申请释放会在thread local变量上进行积攒，最后以大块内存的形式同步给MemoryTracker。

```
class MemoryTracker
{
    std::atomic<Int64> amount {0};
    std::atomic<Int64> peak {0};
    std::atomic<Int64> hard_limit {0};
    std::atomic<Int64> profiler_limit {0};

    Int64 profiler_step = 0;

    /// Singly-linked list. All information will be passed to subsequent memory trackers also (it allows to implement trackers hierarchy).
    /// In terms of tree nodes it is the list of parents. Lifetime of these trackers should "include" lifetime of current tracker.
    std::atomic<MemoryTracker *> parent {};

    /// You could specify custom metric to track memory usage.
    CurrentMetrics::Metric metric = CurrentMetrics::end();
    ...
}
```

2.ProfileEvents:
ProfileEvents顾名思义，是监控系统的profile信息，覆盖的信息非常广，所有信息都是通过代码埋点进行收集统计。它的追踪链路和MemoryTracker一样，也是通过树状结构组织层层追踪。其中和cpu time相关的核心指标包括以下：

```
///Total (wall clock) time spent in processing thread.
RealTimeMicroseconds; 

///Total time spent in processing thread executing CPU instructions in user space.
///This include time CPU pipeline was stalled due to cache misses, branch mispredictions, hyper-threading, etc.
UserTimeMicroseconds; 

///Total time spent in processing thread executing CPU instructions in OS kernel space.
///This include time CPU pipeline was stalled due to cache misses, branch mispredictions, hyper-threading, etc.
SystemTimeMicroseconds; 

SoftPageFaults;
HardPageFaults;

///Total time a thread spent waiting for a result of IO operation, from the OS point of view.
///This is real IO that doesn't include page cache.
OSIOWaitMicroseconds;

///Total time a thread was ready for execution but waiting to be scheduled by OS, from the OS point of view.
OSCPUWaitMicroseconds; 

///CPU time spent seen by OS. Does not include involuntary waits due to virtualization.
OSCPUVirtualTimeMicroseconds;

///Number of bytes read from disks or block devices.
///Doesn't include bytes read from page cache. May include excessive data due to block size, readahead, etc.
OSReadBytes; 

///Number of bytes written to disks or block devices.
///Doesn't include bytes that are in page cache dirty pages. May not include data that was written by OS asynchronously
OSWriteBytes; 

///Number of bytes read from filesystem, including page cache
OSReadChars; 

///Number of bytes written to filesystem, including page cache
OSWriteChars; 
```

以上这些信息都是从linux系统中直接采集，参考 sys/resource.h 和 linux/taskstats.h。采集没有固定的频率，系统在查询计算的过程中每处理完一个Block的数据就会依据距离上次采集的时间间隔决定是否采集最新数据。

3.QueryProfiler:
QueryProfiler的核心功能是抓取查询线程的热点栈，ClickHouse通过对线程设置timer_create和自定义的signal_handler让worker线程定时收到SIGUSR信号量记录自己当前所处的栈，这种方法是可以抓到所有被lock block或者sleep的线程栈的。

除了以上三种线程级别的trace&profile机制，ClickHouse还有一套server级别的Metrics统计，也是通过代码埋点记录系统中所有Metrics的瞬时值。ClickHouse底层的这套trace&profile手段保障了用户可以很方便地从系统硬件层面去定位查询的性能瓶颈点或者OOM原因，所有的metrics, trace, profile信息都有对象的system_log系统表可以追溯历史。

### 资源隔离

资源隔离需要关注的点包括内存、CPU、IO，目前ClickHouse在这三个方面都做了不同程度功能：

1.内存隔离
当前用户可以通过max_memory_usage（查询内存限制），max_memory_usage_for_user（用户的内存限制），max_memory_usage_for_all_queries（server的内存限制），max_concurrent_queries_for_user（用户并发限制），max_concurrent_queries（server并发限制）这一套参数去规划系统的内存资源使用做到用户级别的隔离。但是当用户进行多表关联分析时，系统派发的子查询会突破用户的资源规划，所有的子查询都属于`default`用户，可能引起用户查询的内存超用。

2.CPU隔离
ClickHouse提供了Query级别的CPU优先级设置，当然也可以为不同用户的查询设置不同的优先级，有以下两种优先级参数：

```
///Priority of the query.
///1 - higher value - lower priority; 0 - do not use priorities.
///Allows to freeze query execution if at least one query of higher priority is executed.
priority;

///If non zero - set corresponding 'nice' value for query processing threads.
///Can be used to adjust query priority for OS scheduler.
os_thread_priority;
```

3.IO隔离
ClickHouse目前在IO上没有做任何隔离限制，但是针对异步merge和查询都做了各自的IO限制，尽量避免IO打满。随着异步merge task数量增多，系统会开始限制后续单个merge task涉及到的Data Parts的disk size。在查询并行读取MergeTree data的时候，系统也会统计每个线程当前的IO吞吐，如果吞吐不达标则会反压读取线程，降低读取线程数缓解系统的IO压力，以上这些限制措施都是从局部来缓解问题的一个手段。

### Quota限流

除了静态的资源隔离限制，ClickHouse内部还有一套时序资源使用限流机制--Quota。用户可以根据查询的用户或者Client IP对查询进行分组限流。限流和资源隔离不同，它是约束查询执行的"速率"，当前主要包括以下几种"速率"：

```
QUERIES;        /// Number of queries.
ERRORS;         /// Number of queries with exceptions.
RESULT_ROWS;    /// Number of rows returned as result.
RESULT_BYTES;   /// Number of bytes returned as result.
READ_ROWS;      /// Number of rows read from tables.
READ_BYTES;     /// Number of bytes read from tables.
EXECUTION_TIME; /// Total amount of query execution time in nanoseconds.
```

用户可以自定义规划自己的限流策略，防止系统的负载（IO、网络、CPU）被打爆，Quota限流可以认为是系统自我保护的手段。系统会根据查询的用户名、IP地址或者Quota Key Hint来为查询绑定对应的限流策略。计算引擎在算子之间传递Block时会检查当前Quota组内的流速是否过载，进而通过sleep查询线程来降低系统负载。

### 小结

总结一下ClickHouse在资源隔离/trace层面的优缺点：ClickHouse为用户提供了非常多的工具组件，但是欠缺整体性的解决方案。以trace & profile为例，ClickHouse在自身系统里集成了非常完善的trace / profile / metrics日志和瞬时状态系统表，在排查性能问题的过程中它的链路是完备的。但问题是这个链路太复杂了，对一般用户来说排查非常困难，尤其是碰上递归子查询的多表关联分析时，需要从用户查询到一层子查询到二层子查询步步深入分析。当前的资源隔离方案呈现给用户的更加是一堆配置，根本不是一个完整的功能。Quota限流虽然是一个完整的功能，但是却不容易使用，因为用户不知道如何量化合理的"速率"。

## 弹性资源队列

第一章为大家介绍了ClickHouse的MPP计算模型，核心想阐述的点是ClickHouse这种简单的递归子查询计算模型在资源利用上是非常粗暴的，如果没有很好的资源隔离和系统过载保护，节点很容易就会因为bad sql变得不稳定。第二章介绍ClickHouse当前的资源使用trace profile功能、资源隔离功能、Quota过载保护。但是ClickHouse目前在这三个方面做得都不够完美，还需要深度打磨来提升系统的稳定性和资源利用率。我认为主要从三个方面进行加强：性能诊断链路自动化使用户可以一键诊断，资源队列功能加强，Quota（负载限流）做成自动化并拉通来看查询、写入、异步merge任务对系统的负载，防止过载。

阿里云数据库ClickHouse在ClickHouse开源版本上即将推出用户自定义的弹性资源队列功能，资源队列DDL定义如下：

```
CREATE RESOURCE QUEUE [IF NOT EXISTS | OR REPLACE] test_queue [ON CLUSTER cluster]
memory=10240000000,  ///资源队列的总内存限制
concurrency=8,       ///资源队列的查询并发控制
isolate=0,           ///资源队列的内存抢占隔离级别
priority=high        ///资源队列的cpu优先级和内存抢占优先级
TO {role [,...] | ALL | ALL EXCEPT role [,...]};
```

我认为资源队列的核心问题是要在保障用户查询稳定性的基础上最大化系统的资源利用率和查询吞吐。传统的MPP数据库类似GreenPlum的资源队列设计思想是队列之间的内存资源完全隔离，通过优化器去评估每一个查询的复杂度加上队列的默人并发度来决定查询在队列中可占用的内存大小，在查询真实开始执行之前已经限定了它可使用的内存，加上GreenPlum强大的计算引擎所有算子都可以落盘，使得资源队列可以保障系统内的查询稳定运行，但是吞吐并不一定是最大化的。因为GreenPlum资源队列之间的内存不是弹性的，有队列空闲下来它的内存资源也不能给其他队列使用。抛开资源队列间的弹性问题，其要想做到单个资源队列内的查询稳定高效运行离不开Greenplum的两个核心能力：CBO优化器智能评估出查询需要占用的内存，全算子可落盘的计算引擎。
ClickHouse目前的现状是：1）没有优化器帮助评估查询的复杂度，2）整个计算引擎的落盘能力比较弱，在限定内存的情况下无法保障query顺利执行。因此我们结合ClickHouse计算引擎的特色，设计了一套弹性资源队列模型，其中核心的弹性内存抢占原则包括以下几个：

1. 对资源队列内的查询不设内存限制
2. 队列中的查询在申请内存时如果遇到内存不足，则尝试从优先级更低的队列中抢占式申请内存
3. 在2）中内存抢占过程中，如果抢占申请失败，则检查自己所属的资源队列是否被其他查询抢占内存，尝试kill抢占内存最多的查询回收内存资源
4. 如果在3）中尝试回收被抢占内存资源失败，则当前查询报OOM Exception
5. 每个资源队列预留一定比例的内存不可抢占，当资源队列中的查询负载到达一定水位时，内存就变成完全不可被抢占。同时用户在定义资源队列时，isolate=0的队列是允许被抢占的，isolate=1的队列不允许被抢占，isolate=2的队列不允许被抢占也不允许抢占其他队列
6. 当资源队列中有查询OOM失败，或者因为抢占内存被kill，则把当前资源队列的并发数临时下调，等系统恢复后再逐步上调。

ClickHouse弹性资源队列的设计原则就是允许内存资源抢占来达到资源利用率的最大化，同时动态调整资源队列的并发限制来防止bad query出现时导致用户的查询大面积失败。由于计算引擎的约束限制，目前无法保障查询完全没有OOM，但是用户端可以通过错误信息来判断查询是否属于bad sql，同时对误杀的查询进行retry。