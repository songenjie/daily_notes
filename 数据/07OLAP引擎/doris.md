## 简介

Doris（原百度 Palo）是一款**基于大规模并行处理技术的分布式 SQL 数据库**，由百度在 2017 年开源，2018 年 8 月进入 Apache 孵化器。Doris是基于MPP架构的OLAP引擎，主要整合了Google Mesa（数据模型）、Apache Impala（MPP Query Engine）和Apache ORCFile （存储格式，编码和压缩）的技术。

## 使用场景

![img](https://cdn.jsdelivr.net/gh/hivefans/mypic/2020/07/22/93c0bc.png)

## 特点

- 同时支持高并发点查询和高吞吐的Ad-hoc查询。
- 同时支持离线批量导入和实时数据导入。
- 同时支持明细和聚合查询。
- 兼容MySQL协议和标准SQL。
- 支持Rollup Table和Rollup Table的智能查询路由。
- 支持较好的多表Join策略和灵活的表达式查询。
- 支持Schema在线变更。
- 支持Range和Hash二级分区。

 

## 架构

![img](https://cdn.jsdelivr.net/gh/hivefans/mypic/2020/07/22/0f8634.png)