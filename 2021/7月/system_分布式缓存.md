# [什么是分布式缓存？](https://www.cnblogs.com/canfengfeixue/p/8053092.html)

[缓存](https://baike.baidu.com/item/缓存)这种能够提升指令和数据读取速度的特性，随着本地[计算机](https://baike.baidu.com/item/计算机)系统向分布式系统的扩展，在[分布式计算](https://baike.baidu.com/item/分布式计算)领域中得到了广泛的应用，称为分布式缓存。

 

- 中文名

  分布式缓存

- 外文名

  Distribute Cache

## 简介

分布式缓存能够处理大量的动态数据，因此比较适合应用在Web 2.0时代中的社交网站等需要由用户生成内容的场景。从本地缓存扩展到分布式缓存后，关注重点从[CPU](https://baike.baidu.com/item/CPU)、[内存](https://baike.baidu.com/item/内存)、[缓存](https://baike.baidu.com/item/缓存)之间的数据传输速度差异也扩展到了业务系统、[数据库](https://baike.baidu.com/item/数据库)、分布式缓存之间的数据传输速度差异。

![img](https://bkimg.cdn.bcebos.com/pic/d043ad4bd11373f0405c73d1a70f4bfbfbed0418?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U4MA==,g_7,xp_5,yp_5/format,f_auto)

业务系统、数据库、分布式缓存之间的数据流

图1 业务系统、数据库、分布式缓存之间的数据流

## 特点

分布式缓存由一个服务端实现管理和控制，有多个客户端节点存储数据，可以进一步提高数据的读取速率。那么我们要读取某个数据的时候，应该选择哪个节点呢？如果挨个节点找，那效率就太低了。因此需要根据[一致性哈希](https://baike.baidu.com/item/一致性哈希)算法确定数据的存储和读取节点。以数据D，节点总个数N为基础，通过一致性哈希算法计算出数据D对应的[哈希值](https://baike.baidu.com/item/哈希值)（相当于门牌号），根据这个哈希值就可以找到对应的节点了。一致哈希算法的好处在于节点个数发生变化（减少或增加）时无需重新计算哈希值，保证数据储存或读取时可以正确、快速地找到对应的节点。

分布式缓存能够高性能地读取数据、能够动态地扩展缓存节点、能够自动发现和切换故障节点、能够自动均衡数据分区，而且能够为使用者提供图形化的管理界面，部署和维护都十分方便。

分布式缓存已经在分布式领域、云计算领域得到了广泛的应用。