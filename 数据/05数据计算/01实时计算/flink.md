- **简介**

Apache Flink是一个面向数据流处理和批量数据处理的可分布式的开源计算框架，它基于同一个Flink流式执行模型（streaming execution model），能够支持流处理和批处理两种应用类型。

由于流处理和批处理所提供的SLA(服务等级协议)是完全不相同， 流处理一般需要支持低延迟、Exactly-once保证，而批处理需要支持高吞吐、高效处理，所以在实现的时候通常是分别给出两套实现方法，或者通过一个独立的开源框架来实现其中每一种处理方案。比较典型的有：实现批处理的开源方案有MapReduce、Spark；实现流处理的开源方案有Storm；Spark的Streaming 其实本质上也是微批处理。
Flink在实现流处理和批处理时，与传统的一些方案完全不同，它从另一个视角看待流处理和批处理，将二者统一起来：Flink是完全支持流处理，也就是说作为流处理看待时输入数据流是无界的；批处理被作为一种特殊的流处理，只是它的输入数据流被定义为有界的。

- **特性**

有状态计算的Exactly-once语义。状态是指flink能够维护数据在时序上的聚类和聚合，同时它的checkpoint机制
支持带有事件时间（event time）语义的流处理和窗口处理。事件时间的语义使流计算的结果更加精确，尤其在事件到达无序或者延迟的情况下。
支持高度灵活的窗口（window）操作。支持基于time、count、session，以及data-driven的窗口操作，能很好的对现实环境中的创建的数据进行建模。
轻量的容错处理（ fault tolerance）。 它使得系统既能保持高的吞吐率又能保证exactly-once的一致性。通过轻量的state snapshots实现
支持高吞吐、低延迟、高性能的流处理
支持savepoints 机制（一般手动触发）。即可以将应用的运行状态保存下来；在升级应用或者处理历史数据是能够做到无状态丢失和最小停机时间。
支持大规模的集群模式，支持yarn、Mesos。可运行在成千上万的节点上
支持具有Backpressure功能的持续流模型
Flink在JVM内部实现了自己的内存管理
支持迭代计算
支持程序自动优化：避免特定情况下Shuffle、排序等昂贵操作，中间结果进行缓存

- **服务架构**

![img](https://image-static.segmentfault.com/182/116/1821160793-5bdf885ba7e77_articlex)

 

- **数据流架构**

![img](https://flink.apache.org/img/flink-home-graphic.png)

- **开发语言**

scala java