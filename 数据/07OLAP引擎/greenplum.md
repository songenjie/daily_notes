## **简介**

GreenPlum数据库是基于 PostgreSQL 基础上开发，具有巨大的并行处理能力的数据仓库，MPP( massively parallel processing )是 Greenplum的主要特性， MPP是指服务器上拥有两个或者以上的处理节点，并且多个处理节点可以并行,协同的工作来完成一个计算， 这些处理节点拥有独自的内存,操作系统和硬盘, 处理节点可以理解成为一台物理主机。Greenplum 会分发 TB 及以上的数据到所有的子节点，并且当在Greenplum上执行查询时，所有的子节点能够利用各自的资源来并发地执行这个查询。

Greenplum 实际上是由一组 PostgreSQL 数据库组合而成的强大数据仓库， Greenplum基于PostgreSQL 8.2.14 开发, 并且在多数据情况下和 PostgreSQL 非常相似，以至于用户可以像是在使 用PostgreSQL 一样来使用Greenplum。

Greenplum的发展可以分为下面6个阶段：

![img](https://bigdata.djbook.top/wp-content/uploads/2020/12/greenplum.jpg)

## **架构**

![img](https://bigdata.djbook.top/wp-content/uploads/2020/12/511150-20191203164947828-638897410.png)

在GreenPlum数据库中组件；从上图可以看出Master节点、Segment节点、interconnect

- Master节点：为主节点；作为数据库的入口，负责客服端连接；对客服端的请求生成查询计划；分发给某个或者所有的Segment节点。
- standby master: 作为master节点的备库；为其提供高可用性。在Master节点出现故障；通过gpactivestandby命令激活。接管master工作
- interconnect：是GreenPlum的网络层；负责每个节点之间的通信。
- segment节点：为数据节点；接收master分发下来的查询计划；执行返回结果给master节点
- mirror segment节点： 作为segment节点的备库；为了提供高可用性；通常跟对应的segment节点不在同一台机器上。在segment节点出现故障，mirror segment自动接管进行工作。但是为了数据库平稳；尽快恢复出现故障的segment。

对用户而言可以把整个GreenPlum数据库当成PostgreSQL数据库。

Greenplum数据库可以使用追加优化（append-optimized，AO）的存储个事来批量装载和读取数据，并且能提供HEAP表上的性能优势。 追加优化的存储为数据保护、压缩和行/列方向提供了校验和。行式或者列式追加优化的表都可以被压缩。