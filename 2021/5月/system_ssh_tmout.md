本文介绍下，linux中ssh连接超时时间的设置方法，以避免总是被强行退出。有需要的朋友，参考下吧。
有关修改ssh连接超时时间的方法，网上介绍的很多了。
比如下面这个：
可以减少ssh连接超时等待的时间：
方法：ssh -o ConnectTimeout=3 192.168.0.10
或修改sshd_config文件里面的UseDNS 选项，改为UseDNS no。
聪明的读者，一定会发现，上面这个修改，其实是减少ssh的连接时间，就是让ssh的响应时间快一些。
这点可以参考之前的一篇文章：ssh连接超时（ssh的usedns选项）的解决办法 。
再来看，设置ssh超时时间的方法。
修改自己 root 目录下的.bash_profile文件，加上
export TMOUT=1000000 (以秒为单位)
然后运行：
source .bash_profile
在/etc/ssh/sshd_config中加入：
ClientAliveInterval=60
每一分钟，sshd都和ssh client打个招呼，检测它是否存在，不存时即断开连接。
注意：设置完成后，要退出ssh远程连接，再次登录后才可以生效。因为要再读取一次./bash_profile。
为了方便，将设置写成了如下脚本：

echo export TMOUT=1000000 >> /root/.bash_profile
cat /root/.bash_profile
source .bash_profile
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_bak
echo ClientAliveInterval=60 >> /etc/ssh/sshd_config
service sshd restart
cat /etc/ssh/sshd_config
service sshd restart
exit
总结：
在ClientAliveInterval（/etc/ssh/sshd_config）、环境变量TMOUT（在/etc/profile或.bash_profile中设置）以及putty的"Seconds between keepalives“这些方法中，经
检测，只有TMOUT可以控制ssh连接在空闲时间超时，自动断开连接的时间，数字单位为“秒”。
在设置了TMOUT后（非0），另外两个变量则不起作用的。
另外，特别提醒的是，设置好ssh的登录超时时间以后，记得退出重新登录或重启系统，以使配置生效。