for i in  *; do echo $i; find $i | wc -l; done



```
echo '#! /bin/bash' > /reset_inode.sh

chmod a+x /reset_inode.sh

df -i |grep /dev/sd |grep data | sort | tail -n 8 | awk '{printf "umount %s \n" ,$6 }' >> /reset_inode.sh

df -i |grep /dev/sd |grep data | sort | tail -n 8 | awk '{printf "mkfs.ext3 %s -N 500000000 \n" ,$1 }' >> /reset_inode.sh

df -i |grep /dev/sd |grep data | sort | tail -n 8 | awk '{printf "mount %s %s\n" ,$1,$6 }' >> /reset_inode.sh

cat /reset_inode.sh

cd / && ./reset_inode.sh 

rm / /reset_inode.sh
```





【centos】文件过多情况处理 inodes占用100%

shuishen49 2017-04-26 20:44:57  3608  收藏
分类专栏： centos
版权
首先用命令查看



df -li

Filesystem      Inodes  IUsed  IFree IUse% Mounted on
/dev/xvda1     1310720 716819 593901   55% /
tmpfs            62559      4  62555    1% /dev/shm

发现 Inodes 使用过多 查看原因
输入命令

for i in /*; do echo $i; find $i | wc -l; done
挨个查看每个文件看文件夹个数。最后发现
/var/spool/postfix/maildrop/
文件数量过多。
解决：
1、vi /etc/crontab；将MAILTO=root修改为MAILTO=”“，保存。
2、/etc/init.d/crond restart
删除

find /var/spool/postfix/maildrop/ -type f |xargs rm -rf
