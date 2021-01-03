

- [远程开发与调试](https://cf.jd.com/pages/viewpage.action?pageId=330233516#id-新手上路2-远程开发与调试)





# 远程开发与调试

1. **管理员执行一次，其余用户忽略**：把服务器ssh的监听端口加上443或80：echo Port 443 >> /etc/ssh/sshd_config && systemctl restart sshd ；

2. 本地电脑开通ssh免密登录（TLDR）：

   `# 在本机执行，生成本地公钥和私钥，一路回车，要用公钥的在~/.ssh/id_rsa.pub``$ ``ssh``-keygen``# 在服务器上准备.ssh目录和文件``$ ``mkdir` `-p ~/.``ssh` `&& ``touch` `~/.``ssh``/authorized_keys` `&& ``chmod` `700 ~/.``ssh` `&& ``chmod` `600 ~/.``ssh``/*``# 拷贝公钥到服务器的~/.ssh/authorized_keys里``$ ``echo` `'YOU PUB KEY'` `>> ~/.``ssh``/authorized_keys`

3. 配置ssh快捷登录（vim ~/.ssh/config，账号自行替换）：

   **~/.ssh/config**

   `Host ``164``    ``HostName ``10.203``.``46.164``    ``Port ``443``    ``User wanggaoming`

   在本地terminal里执行**ssh 164**来登录试试，确保可以登录。

4. IDE配置：

   1. vscode： 安装Remote-SSH插件，安装完成后点左下角按钮，选择164服务器连接，等右下角提示安装完成，再连接一次就可以打开远程目录了；
   2. IDEA： Ulimitate版已有ssh支持（社区版可以安装sourcecode syncer），更多请参考https://blog.csdn.net/hehuihh/article/details/80829818

5. 编译clickhouse:

   `$ ``cd` `Clickhouse``# 更新依赖库``$ git submodule update --init --recursive``# 准备编译脚本：``$ ``cat` `<< EOF > build.sh``set` `-e``mkdir` `-p build``cd` `build``cmake ..``ninja -j 90``EOF` `# 编译``docker run -it --``rm` `-``v` `$(``pwd``):``/src` `-w ``/src` `-u $(``id` `-u):$(``id` `-g) repo.jd.``local``/olap/ubuntu``:ck-build sh -c .``/build``.sh`