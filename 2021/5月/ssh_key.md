ssh无法连接服务器

```shell
 
DemondeMacBook-Pro:~ demon$ ssh -p 516 sky@47.113.134.16
kex_exchange_identification: read: Connection reset by peer
DemondeMacBook-Pro:~ demon$ 
```

看到网上资料，需要修改配置文件hosts.allow。
登录阿里云控制台

```shell
DemondeMacBook-Pro:~ demon$ vi /etc/hosts.allow
sshd: ALL    ##允许所有ip主机均能连接本机
DemondeMacBook-Pro:~ demon$ systemctl restart sshd
 
```

重新连接依然无法连接服务器。

由于使用的是公司的网络，可能做了限制。。

使用手机热点连接网络，重新ssh连接服务器成功。。







 ssh root@9.208.244.51
kex_exchange_identification: read: Connection reset by peer





mac restart ssh

```
sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
```