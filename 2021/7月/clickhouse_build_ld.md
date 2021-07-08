ld terminated with signal 9 错误解决办法





arget Java: CameraEffectsTests (out/target/common/obj/APPS/CameraEffectsTests_intermediates/classes)
collect2: ld terminated with signal 9 [Killed]
编译出错主要原因是服务器虚拟内存不足导致，而服务器刚好又没有swap分区（我司信息管理部很伟大），所以需要建个swap分区，参考网上的方法：
# dd if=/dev/zero of=/opt/other/swapfile bs=1024 count=512K
# mkswap /opt/other/swapfile
# swapon /opt/other/swapfile
# swapon -s

Filename                Type        Size    Used    Priority
/opt/other/swapfile                     file        524280    0    -1

————————————————
版权声明：本文为CSDN博主「longkg」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/longkg/article/details/12839173







## Linux下增加交换分区的大小

2012年11月28日[admin](http://www.361way.com/author/admin)[发表评论](http://www.361way.com/increase-swap/1957.html#respond)[阅读评论](http://www.361way.com/increase-swap/1957.html#comments)

linux下增加swap的大小这个算是很基础的东西了。不过上帝赐给了人类一件非常好的礼物是遗忘。诚然，像增加swap的大小这样基础的操作，也常常在用到的时候发现已经忘了怎么去弄。搞的每次都要再去Internet上去查。所以索引在博客里记录下，以便以后用时能直接手到掂来。

增加swap大小的方法有两种，一种是已经分过swap交换分区，不过分配不合理，所以可以通过增加swap文件来增加交换分区的大小；另一种方法是通过增加swap分区大小来增加swap的大小。

方法一、通过swap文件增加：



1、创建交换文件





```js
[root@gataway ~]# dd if=/dev/zero of=/tmp/mem.swap bs=1M count=4096
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 59.694 seconds, 71.9 MB/s
```

当然根据bs指定的大小不同，我们也可以通过下面的文件增加：









```bsh
dd if=/dev/zero of=/tmp/mem.swap bs=1M count=4096 (增加4G)或
dd if=/dev/zero of=swapfile bs=1024 count=1048576  (增加1G) 
```

2、查看当前分区的大小









```
[root@gataway ~]# free -m
             total       used       free     shared    buffers     cached
Mem:           993        962         31          0          2        702
-/+ buffers/cache:        257        736
Swap:         2015          0       2015
```

3、格式转换并挂载









```bsh
[root@gataway ~]# mkswap /tmp/mem.swap
Setting up swapspace version 1, size = 4294963 kB
[root@gataway ~]# swapon /tmp/mem.swap 
```

4、三种确认是否增加成功的方法









```js
[root@gataway ~]# swapon -s
Filename                                Type            Size    Used    Priority
/dev/mapper/VolGroup00-LogVol01         partition       2064376 124     -1
/tmp/mem.swap                           file            4194296 0       -2
[root@gataway ~]# free -m
             total       used       free     shared    buffers     cached
Mem:           993        967         26          0          4        703
-/+ buffers/cache:        259        734
Swap:         6111          0       6111
[root@gataway ~]# cat /proc/swaps
Filename                                Type            Size    Used    Priority
/dev/mapper/VolGroup00-LogVol01         partition       2064376 124     -1
/tmp/mem.swap                           file            4194296 0       -2
```

以上不难看出，第一、三两种方法效果相同。linux/unix的一个奇妙之处也在此，很多命令和直接查看某些文件或更改某些文件的值，效果是一样的。





以上操作，在系统重启后，swap文件的大小又会变回原大小，我们可以在/etc/fstab里增加下面的配置，使其重启后，我们刚刚的配置仍然有效。



```
/tmp/mem.swap             swap                    swap    defaults        0 0
```

如果想卸载掉上面的分区，可以通过swapoff完成

```
[root@gataway ~]# swapoff /tmp/mem.swap 
```



方法二、通过fdisk增加swap分区



该方法和方法一主要操作步骤大同小异。不过该方法要求硬件目前有未分配的空间。

1、我们先通过fdisk新增分区



```js
fdisk  /dev/sda
Command (m for help): n
```

通过n新建分区，选择为主分区，分区ID为82，即swap分区。保存退出。接着对新建的分区进行格式化并挂载

```js
mkswap /dev/sda4
swapon /dev/swap
```



完成后，参照方法一里的查看方法进行查看确认。新增完成后，在/etc/fstab里新增如下配置



















方法一、通过swap文件增加：

　　1、创建交换文件

```
[root@gataway ~]# dd if=/dev/zero of=/tmp/mem.swap bs=1M count=4096
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 59.694 seconds, 71.9 MB/s
```

　　当然根据bs指定的大小不同，我们也可以通过下面的文件增加：

```
dd if=/dev/zero of=/tmp/mem.swap bs=1M count=4096 (增加4G)或
dd if=/dev/zero of=swapfile bs=1024 count=1048576  (增加1G) 
```

　　2、查看当前分区的大小

```
[root@gataway ~]# free -m
             total       used       free     shared    buffers     cached
Mem:           993        962         31          0          2        702
-/+ buffers/cache:        257        736
Swap:         2015          0       2015
```

　　3、格式转换并挂载

```
[root@gataway ~]# mkswap /tmp/mem.swap
Setting up swapspace version 1, size = 4294963 kB
[root@gataway ~]# swapon /tmp/mem.swap 
```

　　4、三种确认是否增加成功的方法

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[root@gataway ~]# swapon -s
Filename                                Type            Size    Used    Priority
/dev/mapper/VolGroup00-LogVol01         partition       2064376 124     -1
/tmp/mem.swap                           file            4194296 0       -2
[root@gataway ~]# free -m
             total       used       free     shared    buffers     cached
Mem:           993        967         26          0          4        703
-/+ buffers/cache:        259        734
Swap:         6111          0       6111
[root@gataway ~]# cat /proc/swaps
Filename                                Type            Size    Used    Priority
/dev/mapper/VolGroup00-LogVol01         partition       2064376 124     -1
/tmp/mem.swap                           file            4194296 0       -2
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　以上不难看出，第一、三两种方法效果相同。linux/unix的一个奇妙之处也在此，很多命令和直接查看某些文件或更改某些文件的值，效果是一样的。

 

　　以上操作，在系统重启后，swap文件的大小又会变回原大小，我们可以在/etc/fstab里增加下面的配置，使其重启后，我们刚刚的配置仍然有效。

```
/tmp/mem.swap             swap                    swap    defaults        0 0
```

　　如果想卸载掉上面的分区，可以通过swapoff完成

```
[root@gataway ~]# swapoff /tmp/mem.swap 
```

 

方法二、通过fdisk增加swap分区

　　该方法和方法一主要操作步骤大同小异。不过该方法要求硬件目前有未分配的空间。

　　1、我们先通过fdisk新增分区

```
fdisk  /dev/sda
Command (m for help): n
```

　　通过n新建分区，选择为主分区，分区ID为82，即swap分区。保存退出。接着对新建的分区进行格式化并挂载

```
mkswap /dev/sda4
swapon /dev/swap
```

　　完成后，参照方法一里的查看方法进行查看确认。新增完成后，在/etc/fstab里新增如下配置

```
/dev/sda4             swap                    swap    defaults        0 0
```

 