- Q1
  DB::Exception: Cannot create table from metadata file /data/clickhouse/metadata/default/dwd_test.sql, error: DB::Exception: The local set of parts of table default.dwd_test doesn’t look like the set of parts in ZooKeeper: 65.88 million rows of 85.04 million total rows in filesystem are suspicious. There are 545 unexpected parts with 65883643 rows (191 of them is not just-written with 65883643 rows), 0 missing parts (with 0 blocks).

- A1
  这是由于truncate、alter等ddl语句用了on cluster，偶尔导致zookeeper同步异常。解决方法1：删除有问题节点的本地表数据 rm -r /data/clickhouse/data/default/dwd_test，再重新启动CK，副本会自动重新同步该表数据。(如果没有副本请不要使用此方法。)
  解决方法2：命令行执行sudo -u clickhouse touch /data/clickhouse/flags/force_restore_data 然后手动恢复有问题的partition

- Q2
  Connected to ClickHouse server version 20.3.8 revision 54433.
  Poco::Exception. Code: 1000, e.code() = 13, e.displayText() = Access to file denied: /home/qspace/.clickhouse-client-history (version 20.3.8.53 (official build))

- A2

  创建该文件、并设置开放权限。
  chown clickhouse:clickhouse /home/qspace/.clickhouse-client-history (没有则创建)

- Q3
  Application: DB::Exception: Listen [::]:8124 failed: Poco::Exception. Code: 1000, e.code() = 0, e.displayText() = DNS error: EAI: Address family for hostname not supported (version 20.5.2.7 (official build))

- A3
  本机没有开放ipv6，只能对ipv4生效。在/etc/click-house/config.xml中，把<listen_host> 改成0.0.0.0 或者 ::

- Q4
  Code: 32, e.displayText() = DB::Exception: Received from hadoop8:9900. DB::Exception: Attempt to read after eof: Cannot parse Int32 from String, because value is too short. (version 20.3.8.53 (official build))
  字符串转数字异常，有些为空或者非数字的字符导致转换失败

- A4
  使用toUInt64OrZero函数、转换失败则为0。

- Q5
  Application: DB::Exception: Suspiciously many (125) broken parts to remove.: Cannot attach table `default`.`test`
  Code: 231. DB::Exception: Received from ck10:9000. DB::Exception: Suspiciously many (125) broken parts to remove…

- A5
  因为写入数据造成的元数据和数据不一致问题。先删除磁盘数据、再重启节点删除本地表，如果是复制表再上zookeeper删除副本，然后重新建表。复制表的话数据会同步其他副本的。

- Q6
  Cannot execute replicated DDL query on leader.

- A6
  由于分布式ddl语句比较耗时会超时响应、改为本地执行或者减少作用的数据范围。如ALTER、OPTIMIZE全表改为具体的partition.

- Q7
  Code: 76. DB::Exception: Received from 0.0.0.0:9900. DB::Exception: Cannot open file /data/clickhouse/data/default/test/tmp_insert_20200523_55575_55575_0/f0560_deep_conversion_optimization_goal.mrk2, errno: 24, strerror: Too many open files.

- A7
  修改/etc/security/limits.conf 添加：
  clickhouse soft nofile 262144
  clickhouse hard nofile 262144
  使用ulimit -n 查询、看到的是所有用户可打开的总数，而ck能打开的大小只是系统的默认值，所以不要被这个命令干扰，重启ck后、获取ck的进程、再通过`cat /proc/${pid}/limits |grep open` ，判断配置是否生效







# 1. clickhouse修改字段类型

当别人往表中插入数据，也就是对字段进行操作时，是不能修改字段类型的

此时若要修改字段类型，需要先drop掉该字段，再进行add，如果单纯使用modify是不会修改成功的。

🌰：

原始 col1 类型是 string，此时若要修改为int32:

> alter table base.table ON CLUSTER *** modify column col1 Int32;

but：如果此列一直在进行被修改，比如插入数据，则会报错：

Exception: Received from 10.2.29.1:9000 . DB::Exception: There was an error on [10.2.29.2:9000] : Code: 439, [e.displayText](https://blog.csdn.net/yuanyuanxingxing/article/details/e.displayText) () = DB::Exception: Cannot schedule a task (version [19.9.2.4](https://blog.csdn.net/yuanyuanxingxing/article/details/19.9.2.4) (official build)).

 此时应该先删除此列，再重新add列及数据类型

> ALTER TABLE base.table ON CLUSTER *** DROP COLUMN col1;  --drop列
>
> alter table base.table ON CLUSTER *** add column col1 Int32; --add列

#  2. clickhouse建表，导入CSV数据

如果表中没有时间戳，也没有key，则可以使用 **ENGINE = TinyLog;**

> CREATE TABLE defult.industry_tag (`industry` String, `tag` String) ENGINE = TinyLog;

导入CSV数据时，如果csv表中有相应的列明，则需要指明使用 **FORMAT CSVWithNames，**如果csv表没有列明，则使用 **FORMAT CSV**

🌰：

## 1. 倘若CSV长这样：

>  industry,tag
>  社交,QQ
>  社交,WeChat
>  社交,陌陌

使用如下代码导入到clickhouse 

> cat industry-tag.csv | clickhouse-client -h 10.2.**.* --password *** -m --query="INSERT INTO defult.industry_tag FORMAT CSVWithNames";

## 2. 倘若CSV长这样：

> 社交,QQ
> 社交,WeChat
> 社交,陌陌

使用如下代码导入到clickhouse 

> cat industry-tag.csv | clickhouse-client -h 10.2.**.* --password *** -m --query="INSERT INTO defult.industry_tag FORMAT CSV";

# 3. 要该字段类型，需先改底层表，再改分布式表，否则报错

# 4. 建分布式表

> ```html
> CREATE TABLE IF NOT EXISTS database.test_dist_table(
> 
> 
> 
> event_date Date MATERIALIZED toDate(now())
> 
> 
> 
> , pv Int32
> 
> 
> 
> , click Int32
> 
> 
> 
> , download Int32
> 
> 
> 
> , install Int32
> 
> 
> 
> , active Int32
> 
> 
> 
> , request Int32
> 
> 
> 
> )  ENGINE = Distributed(cluster_name***, database, test_table, rand());  --test_table为非分布式底层表
> ```