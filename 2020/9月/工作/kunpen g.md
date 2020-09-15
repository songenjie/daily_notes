### 1 package 准备

1. zkip 
2. ckip
3. clustername
4. replicacount
5. shardcount
6. 安装脚本
7. 打包 cluster_new.zip  http://storage.jd.local/ssoftware/cluster_new.zip

![image-20200908105825892](/Users/songenjie/Library/Application Support/typora-user-images/image-20200908105825892.png)





#### 2 鲲鹏安装模版

1. 新建模版

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908105436541.png" alt="image-20200908105436541" style="zoom:33%;" />

2. 执行命令 cmd cmd.run

   - zookeeper install 

   ```shell
   \rm -rf  $(ls |grep cluster | awk '{printf"%s ",$1}')
   
   wget http://storage.jd.local/ssoftware/cluster_new.zip 
   
   unzip cluster_new.zip
   
   cd cluster && ./zookeeper_install.sh zkipfile 
   
   \rm -rf  $(ls |grep cluster | awk '{printf"%s ",$1}')
   ```

   

   - clickhouse install.sh 

   ```shell
   \rm -rf  $(ls |grep cluster | awk '{printf"%s ",$1}')
   
   wget http://storage.jd.local/ssoftware/cluster_new.zip 
   
   unzip cluster_new.zip
   
   cd cluster && ./clickhouse_install.sh  clustername ckipfile zkipfile processcount
   
   cd cluster && ./metrika_install.sh clustername ckipfile zkfile  replicacount shardcount 
   
   \rm -rf  $(ls |grep cluster | awk '{printf"%s ",$1}')
   ```

   - 集群验证

   ```shell
   wget http://storage.jd.local/ssoftware/clickhouse_20.5.zip 
   unzip clickhouse_20.5.zip 
   ./clickhouse ./clickhouse_20.5 client  -h 10.196.100.36   --port 9600 -u default -m  --password=jd_olap --log-level=trace --send_logs_level=trace
   
   
   1. create database on cluster clustername
   2. create replicatedtable on cluster clustername
   ```



#### 3 鲲鹏部署操作

1. 部署集群操作

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908110515531.png" alt="image-20200908110515531" style="zoom: 67%;" />

2. 选择模版

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908110622040.png" alt="image-20200908110622040" style="zoom: 67%;" />



3. 提交到部署管理

![image-20200908114601856](/Users/songenjie/Library/Application Support/typora-user-images/image-20200908114601856.png)



4. 执行 

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908110802059.png" alt="image-20200908110802059" style="zoom:25%;" />



#### 4 vip申请

1. np.jd.com 

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908110839234.png" alt="image-20200908110839234"  />

2. 域名申请

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908111128578.png" alt="image-20200908111128578" style="zoom: 33%;" />

3. 端口映射

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908111223718.png" alt="image-20200908111223718" style="zoom:25%;" />

<img src="/Users/songenjie/Library/Application Support/typora-user-images/image-20200908111250088.png" alt="image-20200908111250088" style="zoom:25%;" />



#### 5  更新文档





#### 6 节点下线 

1. 配置更新

```
\rm -rf  $(ls |grep cluster | awk '{printf"%s ",$1}')

wget http://storage.jd.local/ssoftware/cluster_new.zip 

unzip cluster_new.zip

cd cluster && ./metrika_install.sh clustername ckipfile zkfile  replicacount shardcount offlinip

\rm -rf  $(ls |grep cluster | awk '{printf"%s ",$1}')
```

2. 删除zk.. 

 https://git.jd.com/jdolap/clickhouse/issues/33