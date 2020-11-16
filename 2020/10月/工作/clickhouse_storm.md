# 译文-ClickHouse In the Storm. Part 1 - Maximum QPS estimation - 最大QPS估算

[ 2020-05-03 ](http://fuxkdb.com/2020/05/03/2020-05-03-[译文]ClickHouse-In-the-Storm.-Part-1-Maximum-QPS-estimation---最大QPS估算/) 阅读量4484

# ClickHouse In the Storm. Part 1: Maximum QPS estimation - 最大QPS估算

ClickHouse是一个用于分析的OLAP数据库, 因此典型的使用场景是处理相对少量的请求:

- 每小时几个查询到每秒几十甚至几百个查询
- 影响大量数据(gigabytes/millions of rows)

但是它在其他情况下表现如何? Let’s try to use a steam-hammer to crack nuts, 并检查ClickHouse每秒将如何处理数千个小请求。 这将帮助我们更好地理解可能的用例范围和限制。

这篇文章分为两个部分。 第一部分介绍连接性基准测试和测试设置。 下一部分将介绍涉及实际数据的方案中的最大QPS。

## Environment

在最初的测试中，我选择了现有的旧工作站：

- 4-cores Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
- 8Gb of RAM
- SSD disk
- CentOS 7

本文介绍了从该机器收集的结果，但是当然，尝试在功能更强大的硬件上重复这些测试非常有趣。 我将这项任务留给我们的读者，因此您可以在自己的硬件上的不同情况下测试ClickHouse的最大QPS。 如果可以，请发布结果！ 为了运行基准测试，我还创建了一套可在Altinity github中免费使用的脚本：https://github.com/Altinity/clickhouse-sts/。 这些脚本需要Docker（I have v18.09）和Bash。 要运行测试套件，只需克隆GitHub存储库并在根文件夹中运行“ make test”命令。 它将在您的主机上执行所有测试（将花费几个小时），并将结果放入一个CSV文件中，以后可以在Excel，Pandas或ClickHouse本身中进行分析。 当然，您可以共享您的发现以将它们与本文的结果进行比较。

Under the hood those scripts use:

- https://github.com/wg/wrk，一种轻量级且快速的HTTP基准测试工具，允许创建不同的HTTP工作负载
- ClickHouse发行版中包含的clickhouse-benchmark工具-用于本机协议ClickHouse测试

这两种工具都允许您创建所需的并发负载（模拟不同数量的并发客户端），并测量每秒服务的查询数量和延迟百分位数。

## A few words about handling concurrent requests in ClickHouse

默认情况下ClickHouse最多可以处理4096个inbound connections (*max_connections* setting in server config file), 但只会同时执行100个查询(*max_concurrent_queries*.), 所以所有其他client会在队列中等待so all other clients will just wait in the queue.客户端请求可以保持多久排队最长持续时间通过设置[queue_max_wait_ms](https://github.com/ClickHouse/ClickHouse/issues/4283)定义(这个参数文档中没有找到, 只有issue中搜到了)(5000 or 5 sec by default)

译者注:

这里说queue_max_wait_ms默认5000 or 5 sec 有点描述不清, 5000估计单位是ms. 但是我查询默认值并不是5ms, 应该是版本差异

```
SELECT *
FROM settings
WHERE name = 'queue_max_wait_ms'

┌─name──────────────┬─value─┬─changed─┬─description───────────────────────────────────────────────────────────────────────────────────┬─min──┬─max──┬─readonly─┐
│ queue_max_wait_ms │ 0     │       0 │ The wait time in the request queue, if the number of concurrent requests exceeds the maximum. │ ᴺᵁᴸᴸ │ ᴺᵁᴸᴸ │        0 │
└───────────────────┴───────┴─────────┴───────────────────────────────────────────────────────────────────────────────────────────────┴──────┴──────┴──────────┘
```

It is a user/profile setting, so users can define some smaller value to prompt an exception in cases where the queue is too long. Keepalive timeout for http connection is relatively low by default - it’s 3 seconds (*keep_alive_timeout* setting).

There are also a lot of advanced network-related settings to fine-tune different timeouts, poll intervals, listen_backlog size etc.

## HTTP ping: theoretically possible maximum throughput of HTTP server - HTTP ping: 理论上可能的最大HTTP服务器吞吐量

首先，让我们检查一下ClickHouse本身使用的HTTP服务器有多快。 换句话说，服务器可以处理多少个”do nothing”请求。

对于HTTP，两个主要的场景很重要:

- 使用keepalive(使用持久连接来处理多个请求，无需重新连接)
- 没有keepalive(为每个请求建立新连接)。

另外，ClickHouse在默认情况下有一个非常详细的日志级别(“trace”)。对于每个查询，它都会向日志文件写入几行代码，这对于调试来说很好，但是当然会造成一些额外的延迟。因此，我们还检查了禁用日志的两个相同场景。

我们在不同的并发级别上检查了这些场景，以模拟不同数量的同时连接的客户机(一个接一个地发送请求)。每个测试执行15秒，然后取每秒处理请求的平均值。

Results:

[![Снимок экрана 2019-05-02 в 0.07.43.png](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556744999878-1AOR3NVKLVYPAOKCGY30/ke17ZwdGBToddI8pDm48kK912QhFD_RZzoZ8YTHxjyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UX44wccPXaMcdXdex7UdqamiCZYjJzZUsb_6EQFvPnlWZDqXZYzu2fuaodM4POSZ4w/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA+%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0+2019-05-02+%D0%B2+0.07.43.png?format=1500w)](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556744999878-1AOR3NVKLVYPAOKCGY30/ke17ZwdGBToddI8pDm48kK912QhFD_RZzoZ8YTHxjyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UX44wccPXaMcdXdex7UdqamiCZYjJzZUsb_6EQFvPnlWZDqXZYzu2fuaodM4POSZ4w/Снимок+экрана+2019-05-02+в+0.07.43.png?format=1500w)Снимок экрана 2019-05-02 в 0.07.43.png

在X轴上，您可以看到同时连接的客户端数量。在Y轴上是每个特定场景中每秒处理的请求的平均数量。

Well, results look good:

- 在每种情况下，该server上QPS的最大值为8到64个并发连接。
- 启用keepalive和禁用日志后，最大吞吐量约为97K QPS。
- 启用日志后，速度降低了约30％，并提供了约71K QPS。
- 两种非Keepalive变体都慢得多（约18.5 kqps），甚至在此处看不到日志记录开销。 这是可以预期的，因为有了Keepalive，ClickHouse当然可以处理更多的ping命令，这是因为跳过了为每个请求建立连接的额外费用。

现在，我们对ClickHouse web-server理论上可能达到的最大吞吐量和并发级别有了一种感觉。事实上，ClickHouse HTTP-server实现非常快。例如，在同一台机器上使用默认设置的NGINX每秒可以处理大约30K个请求。

## SELECT 1

让我们进一步检查一个普通的”SELECT 1”请求. 这样的查询是在查询解析阶段“执行”的，这样就会显示“网络+授权+查询解析+格式化结果”(‘network + authorization + query parser + formatting result’)的理论最大吞吐量，也就是说实际的请求永远不会比这个速度快。

We will test http and https using keepalive and no-keepalive options, and native client (both secure and non-secure).

Results:

[![Снимок экрана 2019-05-02 в 0.13.34.png](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745244145-K0JF7HVEM626W61138SE/ke17ZwdGBToddI8pDm48kDHsWk0j0KtJBSTMxHMgRv57gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1URwcK_b7CzesNjbqVA38XWDsg8P6CEr8Uw78nvIV_BOyoRwB-dUGsSquCnVTFQcaRg/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA+%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0+2019-05-02+%D0%B2+0.13.34.png?format=1500w)](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745244145-K0JF7HVEM626W61138SE/ke17ZwdGBToddI8pDm48kDHsWk0j0KtJBSTMxHMgRv57gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1URwcK_b7CzesNjbqVA38XWDsg8P6CEr8Uw78nvIV_BOyoRwB-dUGsSquCnVTFQcaRg/Снимок+экрана+2019-05-02+в+0.13.34.png?format=1500w)Снимок экрана 2019-05-02 в 0.13.34.png

- 最佳情况约为14K QPS: http & keepalive
- 在https＆keepalive情况下, 性能稍差一些(13K QPS). 在这种情况下, Https开销并不重要
- 10.7 kqps for http no-keepalive.
- 10.1 kqps for native (no secure).
- 9.3 kqps for native (secure)
- And quite poor 4.3 kqps for https no-keepalive

在最高并发级别上，我们记录了几十个连接错误（即小于0.01％），这很可能是由操作系统级别上的套接字重用问题引起的。 ClickHouse在该测试中的运行情况稳定，我没有发现任何可见的问题。

令人惊讶的是，本机协议的性能比http差，但实际上这是预期的:本机TCP/IP更复杂，并且有许多额外的协议特性。它不适用于高QPS，而是用于来回传输大数据块。

当本机客户端中的并发增长时，QPS也会显着下降，并发级别更高（> 3000）。 此时，系统变得无响应，并且不返回任何结果。 这很可能是由于clickhouse-benchmark工具为每个连接使用了一个单独的线程，并且线程和上下文切换的数量对于系统来说太多了。

现在让我们看一下等待时间，即每个客户等待结果集的时间。 该数字在每个请求中有所不同，因此该图显示了每种情况下延迟的90％(90th percentile of the latency)。 这意味着90％的用户比显示的数字更快地得到答案。

### LATENCIES (90TH PERCENTILE) - 1-256 CONCURRENCY LEVELS

[![Снимок экрана 2019-05-02 в 0.15.17.png](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745339323-L4S5YCIEXK42GW0UVHMB/ke17ZwdGBToddI8pDm48kOA3d6m9GALCB4yNtwBAeS0UqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYy7Mythp_T-mtop-vrsUOmeInPi9iDjx9w8K4ZfjXt2dltFsg0LrgF5tasHO0-U2kQ4i40yCEL4HeBY9ABQn9daCjLISwBs8eEdxAxTptZAUg/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA+%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0+2019-05-02+%D0%B2+0.15.17.png?format=1500w)](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745339323-L4S5YCIEXK42GW0UVHMB/ke17ZwdGBToddI8pDm48kOA3d6m9GALCB4yNtwBAeS0UqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYy7Mythp_T-mtop-vrsUOmeInPi9iDjx9w8K4ZfjXt2dltFsg0LrgF5tasHO0-U2kQ4i40yCEL4HeBY9ABQn9daCjLISwBs8eEdxAxTptZAUg/Снимок+экрана+2019-05-02+в+0.15.17.png?format=1500w)Снимок экрана 2019-05-02 в 0.15.17.png

随着并发性的增长，延迟会降低。现在看起来还不错:如果您的并发用户少于256个，那么延迟可能会低于50毫秒(注意这里指的是’network + authorization + query parser + formatting result’用时)。

让我们看看它是如何处理更高的并发性的。

### LATENCIES (90TH PERCENTILE) - >256 CONCURRENCY LEVELS

[![Снимок экрана 2019-05-02 в 0.16.18.png](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745410892-A9TNVNWGA7IIZ567UYZQ/ke17ZwdGBToddI8pDm48kMkUSgykeosjzR5in8oR6_AUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYy7Mythp_T-mtop-vrsUOmeInPi9iDjx9w8K4ZfjXt2dokwvAnPdUqWiOeBlqoiBKw2zXDUDcjjzrdCPf3u9F5SCjLISwBs8eEdxAxTptZAUg/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA+%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0+2019-05-02+%D0%B2+0.16.18.png?format=1500w)](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745410892-A9TNVNWGA7IIZ567UYZQ/ke17ZwdGBToddI8pDm48kMkUSgykeosjzR5in8oR6_AUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYy7Mythp_T-mtop-vrsUOmeInPi9iDjx9w8K4ZfjXt2dokwvAnPdUqWiOeBlqoiBKw2zXDUDcjjzrdCPf3u9F5SCjLISwBs8eEdxAxTptZAUg/Снимок+экрана+2019-05-02+в+0.16.18.png?format=1500w)Снимок экрана 2019-05-02 в 0.16.18.png

现在，延迟退化变得更加严重，并且本机协议native protocol再次显示出最差的结果。

有趣的是，没有keepalive的http请求的行为非常稳定，即使有2K个并发用户，其延迟也低于50ms。如果没有keepalive，延迟将更加可预测，并且stdev将随着并发性的增加而保持较小的值，但是QPS的速率会降低一些。它可能与webserver的实现细节有关:例如，当每个连接使用一个线程时，线程上下文切换会使服务器变慢，并在一定的并发级别后增加延迟。

我们还检查了其他设置，如max_concurrent_queries、queue_max_wait_ms、max_threads、network_compression_method、enable_http_compression和一些输出格式。在这种情况下，调整它们的效果基本上可以忽略不计。

## Effects of multithreading

默认情况下，ClickHouse使用多个线程来处理更大的查询，从而有效地使用所有的CPU核心。然而，如果您有大量的并发连接，多线程将在上下文切换、重新连接线程和工作同步方面产生额外的成本。

为了衡量并发连接和多线程的交互作用, 我们看看在使用默认的multithreading设置(我认为这里作者是指max_threads默认值, 即为the number of physical CPU cores)和指定max_threads=1两种情况下运行查询”synthetic select for finding maximum of 100K random numbers”(这里应该是指查询system.numbers_mt表)的性能差异

> To measure the interaction of concurrent connections and multithreading let’s look at the difference in a synthetic select for finding maximum of 100K random numbers with default multithreading settings and with *max_threads=1*.

[![Снимок экрана 2019-05-02 в 0.17.38.png](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745474494-UGR0VQP2SJH8UWUMX0Z1/ke17ZwdGBToddI8pDm48kKaTsQSl8-jTyTlsLCZtyy0UqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKc7yNLI-iFzKB_pLtyhsdSpX8BIm9uUyCxZ2Z1znvbrG66EocOrYTIGAiMRxT7-thT/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA+%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0+2019-05-02+%D0%B2+0.17.38.png?format=1500w)](https://images.squarespace-cdn.com/content/v1/58d158119f745633ea326878/1556745474494-UGR0VQP2SJH8UWUMX0Z1/ke17ZwdGBToddI8pDm48kKaTsQSl8-jTyTlsLCZtyy0UqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKc7yNLI-iFzKB_pLtyhsdSpX8BIm9uUyCxZ2Z1znvbrG66EocOrYTIGAiMRxT7-thT/Снимок+экрана+2019-05-02+в+0.17.38.png?format=1500w)Снимок экрана 2019-05-02 в 0.17.38.png

结论很简单:要在高并发场景中实现更高的QPS，使用max_threads=1设置。

## To Be Continued…

本文介绍了ClickHouse的一般连接测试。我们检查了服务器本身的速度有多快，它可以处理多少个简单的查询，以及在高并发性场景中哪些设置会影响QPS。请参阅后续文章，其中我们深入研究了在键值场景中估计实际查询的最大QPS，这将向测试用例添加数据。

# 原文链接:

https://www.altinity.com/blog/clickhouse-in-the-storm-part-1