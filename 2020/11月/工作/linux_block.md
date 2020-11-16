**1.tune2fs命令查看block size大小：**

[root@localhost tmp]# tune2fs -l /dev/sda1|grep "Block size"

Block size:        1024

/dev/sda1 为/boot 分区的挂载点；



**2.stat命令查看block size大小：**

[root@localhost tmp]# stat /boot/|grep "IO Block"

 Size: 1024    Blocks: 4      IO Block: 1024  目录



**3.dumpe2fs命令查看block size大小：**

[root@localhost tmp]# dumpe2fs /dev/sda1 |grep "Block size"

dumpe2fs 1.41.12 (17-May-2010)

Block size:        1024





