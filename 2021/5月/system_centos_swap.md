Swap 空间增加推荐

（Redhat5官方推荐）

RAM	SWAP
RAM<=4G	2G
4G<RAM<16G	4G
16G<RAM<64G	8G
64G<RAM<256G	16G
（Redhat6/7官方推荐）

RAM	SWAP
RAM<=2G	2*RAM
2G<RAM<8G	RAM
8GRAM<64G	>=4G
RAM>=64G	>=4G
【1】使用分区文件增加SWAP
① 使用dd创建swapfile，bs单位bytes，也可以手动指定单位为M或者G，count为计数，例子为增加1M*1024=1G空间

cd /
mkdir swap
dd if=/dev/zero of=swapfile bs=1M count=1024
1
2
3
或者使用fallocate 命令来创建swap文件

fallocate -l 2G /swap/swapfile #指定文件为2G
1
② 设置该文件为swap文件

mkswap /swap/swapfile
1
③ 启用swap文件

swapon /swap/swapfile
1
④ 使swap文件永久生效

vim /etc/fstab
#末尾添加：
/swap/swapfile  swap   swap  defaults  0 0
1
2
3
⑤ 查看SWAP空间

可以使用如下命令查看：

free -m
cat /proc/meminfo | grep -i swap
fdisk -l
swap -s
1
2
3
4
⑥ 去掉swap空间

# 停用
[root@test swap]# swapoff swapfile

# 删除文件
[root@test swap]# rm  -rf swapfile 

# 删除随即启动swap 删除上面添加的记录
[root@test swap]#vim /etc/fstab
1
2
3
4
5
6
7
8
⑦ 更改swap配置

有则修改，无则添加：（按需修改数值）

vm.swappiness=30  #值越大表示越倾向于使用swap空间
1
可以重启服务器查看效果：

reboot
init 6
1
2
【2】使用分区空间增加swap
这是类似于挂载一块磁盘增加空间的思想。

① 创建分区 并设置为swap格式

fdisk /dev/sdb
n  //创建分区
p  //创建主分区
1  //创建分区1
两次回车 //起始扇区和Last扇区选择默认
t   //转换分区格式
82  //转换为swap空间
p  //查看已创建的分区结果
w  //保存退出
1
2
3
4
5
6
7
8
9
② 格式化为swap空间

mkswap /dev/sdb1
1
③ 启用swap

swapon /dev/sdb1
1
④ 编辑配置文件 设为开机自动挂载

vim /etc/fstab
1
添加以下内容 保存并退出

/dev/sdb1  swap   swap  defaults  0 0
1
⑤ 设置自动启用所有swap空间

swapon -a
1
⑥ 重启验证

init 6
————————————————
版权声明：本文为CSDN博主「流烟默」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/J080624/article/details/100972197









创建swap文件
fallocate -l 2G /etc/swap #指定文件为2G
1
设置文件权限，只允许root用户操作
chmod 600 /etc/swap
1
检查文件大小与权限是否正确
ls -lh /etc/swap
1
设置该文件为swap文件
mkswap /etc/swap
1
启用swap文件
swapon /etc/swap
1
使swap文件永久生效
vim /etc/fstab
1
末尾添加：

/etc/swap  swap   swap  defaults  0 0
1
更改swap配置
vim /etc/sysctl.conf
1
有则修改，无则添加：（按需修改数值）

vm.swappiness=30  #值越大表示越倾向于使用swap空间
1
重启生效
init 6
————————————————
版权声明：本文为CSDN博主「芽孢八叠球菌」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/u010457406/article/details/83753384