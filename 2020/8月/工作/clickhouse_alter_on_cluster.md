### clickhouse alter on cluster





##### 0、KEYWORD

on cluster {cluster_name}
 这个指令使得操作能在集群范围内的节点上都生效

##### 1、HOW TO USE？

- CREATE DATABASE db_name ON CLUSTER cluster
- CREATE TABLE db.table_name ON CLUSTER cluter
- ALTER TABLE db.table ON CLUSTER cluster ADD/DROP COLUMN column
- DROP TABLE table ON CLUSTER cluster

##### 2、与zk的关系

(打马的都是集群内各节点的ip:port)

- 在我们集群的配置中，到zk的路径中，可以看到在zk的节点下，有相应的指令节点。

![img](https:////upload-images.jianshu.io/upload_images/13508296-84963893327bd331.png?imageMogr2/auto-orient/strip|imageView2/2/w/469/format/webp)

指令znode

- get这个znode，可以看到这条指令的信息。

![img](https:////upload-images.jianshu.io/upload_images/13508296-e83473a1e36b6de6.png?imageMogr2/auto-orient/strip|imageView2/2/w/682/format/webp)

节点内容.png

- 在finished的znode中，可以看到哪些节点已经执行成功。如果哪台服务器暂时宕机，则不会出现在这个节点内。

![img](https:////upload-images.jianshu.io/upload_images/13508296-e57d1561c8857882.png?imageMogr2/auto-orient/strip|imageView2/2/w/651/format/webp)

已完成的ip节点.png



##### 3、OTHER

（1）每台节点的集群配置需要一样。当命令执行时一台节点可不用，这台节点恢复以后会再执行。
 （2）ALTER TABLE DROP PARTITION 不适用
 （3）drop table distributed table 不适用



0人点赞



[ClickHouse]()





作者：白奕新
链接：https://www.jianshu.com/p/7e21e2fce3ad
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。