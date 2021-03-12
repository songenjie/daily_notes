IOPS：(Input/Output operations Per Second,既每秒处理I/O的请求次数)

IOPS是指存储每秒可接受多少次主机发出的访问，主机的一次IO需要多次访问存储才可以完成,这里提到磁盘读写能力,比如它每秒读100M,写50M.这个说明的是数据吞吐量，而IOPS指的则是每秒处理I/O的请求次数.详细展开来说请求次数就是读80M的文件是一次I/O请求,写1K的的数据也是一次I/O请求,那么IOPS的数值越高自然在一定时间内能接受的相应请求就越多,如果你在深入想一下也会发现这只是理论而已.因为同一个请求读80M与写1K所需要的时间自然不一样,除了寻道、数据传输等方面考虑的因素其实很多很多,那么如果IOPS够高的话,那么用在OLTP系统上会更加合适.对于如何获得IOPS的值,在Linux、Windows上都有很多工具可供测试,不过可参考的价值未必多.如果要提高IOPS,传统方案还是使用RAID条带后使I/O能力获得提升,近几年固态硬盘SSD很火热,不同厂商之间的技术指标也不尽相同,至于像Fusion-IO这种变态级的IOPS都可以干到百万级别.一般情况下用SSD基本上可以满足需求了.多块SSD条带性能还是很猛的.不过烧钱烧的多还有就是寿命问题.

IOPS的计算公式IOPS=1000ms/(寻道时间+旋转延迟时间)

------

QPS(Query Per Second,既每秒请求、查询次数)

说完IOPS在来说说数据库中非常重要的QPS,这个指标在所有数据库中都有,只不过[MySQL](https://cloud.tencent.com/product/cdb?from=10680)应该更加关注.获取这个指标值也很容易在MySQL中执行status命令就可以看到了.不过这个值是在MySQL生命周期内全局指标,可我们的系统不是每时每刻都在忙碌,那么在系统峰值时QPS又是多少,我们只能自己动手算了.当我们执行status的时候有个Questions,尽管它也是全局指标.不过我们可以每隔一秒查询下这个值,并将相邻的两值相减,得到的就是精确的每一秒的实际请求数了.如果MySQL处于繁忙的状态,那么我们获取的值就可以视为MySQL QPS的峰值响应能力了.

QPS计算公式:Questions/Uptime(Uptime换成自己定义的时间单位)

```javascript
mysql> show global status like "Questions";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Questions     | 10    |
+---------------+-------+
row in set (0.02 sec)

mysql> show global status like "Uptime";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Uptime        | 308   |
+---------------+-------+
row in set (0.02 sec)
```

------

TPS(Transcantion Per Second,既每秒事务数) 至于TPS嘛..同样是衡量数据库的重要指标.不过MySQL不是每个存储引擎都支持事务.所以就拿InnoDB来说好了.TPS主要涉及提交和回滚 TPS=(Commit+Rollback)/Seconds

```javascript
mysql> show global status like "Com_commit";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Com_commit    | 0     |
+---------------+-------+
row in set (0.02 sec)

mysql> show global status like "Com_rollback";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Com_rollback  | 0     |
+---------------+-------+
row in set (0.01 sec)
```

------

**总结：**

如果IOPS过高，分析原因：

1. 内存不足，查询数据较多（一般为慢查询，但有时候并不是，单纯的查询数据较多），特别关注一下数据量大还需要排序的分页的，不能通过内存一次完成查询，产生大量的io操作
2. 前面几种情景都没有问题，那可能是你的写操作过多了，从代码、业务或者架构考虑优化
3. 最后的办法..提升mysql、硬件服务器的iops配置，说白了就是换硬件比如机械磁盘换固态

在业务量级没有明显变化的时候主要排查1,2,可以通过优化sql或者对数据量较大的表进行分表处理，3就不说了就是花钱换速度

如果QPS过高，分析原因：

这个一般没什么解决办法，很直观的指标，你的数据库访问次数过多了，可以通过缓存减少查询次数、[消息队列](https://cloud.tencent.com/product/cmq?from=10680)削峰等

如果TPS过高，分析原因：

1. 一般也是直观的写操作过度了
2. 也可能是大量的写操作发生回滚

解决办法同QPS