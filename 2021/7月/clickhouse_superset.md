# superset  实现ClickHouse 可视化 最佳实践



## 1 相关文档

supeset 社区支持 clickhouse 走HTTP

 https://github.com/apache/superset/blob/master/superset-frontend/images/clickhouse.png

https://github.com/apache/superset/blob/master/docs/src/pages/docs/Connecting%20to%20Databases/clickhouse.mdx

https://github.com/apache/superset/issues/13285



superset 社区clickhouse 安装文档

https://superset.apache.org/docs/databases/clickhouse

官方的模版是推荐 clickhouse-sqlsechema



- cloudfra  

[sqlalchemy-clickhouse](https://blog.csdn.net/m0_47467356/article/details/105844252#4安装sqlalchemy-clickhouse)

https://blog.csdn.net/m0_47467356/article/details/105844252

https://blog.csdn.net/m0_47467356/article/details/105844217





- altinity 公司

安装： https://altinity.com/blog/visualizing-clickhouse-data-with-apache-superset-part-1-installation

展示：https://altinity.com/blog/visualizing-clickhouse-data-with-apache-superset-part-2-dashboards



- superset 社区  clickhouse+superset 安装和展示 详解

英文 https://preset.io/blog/2021-5-26-clickhouse-superset/

中文 https://www.cnblogs.com/tree1123/p/14892202.html 如下



## 2 最佳实践



### 2.1 安装



#### 方法一：Python虚拟环境

第一种方法直接在您的主机上安装 Superset。我们将首先创建一个 Python 虚拟环境。以下是常用命令。

```
python3 -m venv clickhouse-sqlalchemy
. clickhouse-sqlalchemy/bin/activate
pip install --upgrade pi
```

##### 安装并启动 Superset

安装依赖包

```
sudo apt-get install build-essential libssl-dev libffi-dev python-dev python-pip libsasl2-dev libldap2-dev
```

处理与 ClickHouse 的 Superset 连接的命令。可能需要根据您的环境稍微调整。

```
export FLASK_APP=superset
pip install apache-superset
superset db upgrade
superset fab create-admin
superset load_examples
superset init
```

##### 安装 clickhouse-sqlalchemy 驱动程序

```text
pip install clickhouse-sqlalchemy
```

clickhouse-driver 版本必须为 0.2.0 或更高版本。

```text
pip freeze |grep clickhouse
clickhouse-driver==0.2.0
clickhouse-sqlalchemy==0.1.6
```

##### 启动 Superset 并登录

是时候开始 Superset 了。运行以下命令：

```text
superset run -p 8088 --with-threads --reload --debugger
```

浏览器访问 localhost:8088

您将看到如下所示的登录屏幕。输入您在 Superset 安装期间定义的管理员登录名和密码（例如，admin/secret）。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090746079-862666331.png)





#### 方法 2：使用 Docker Compose 运行 Superset

如果您不想纠结于 Python 版本、虚拟环境和 pip。可以使用docker。

首先安装docker和docker-compose。

安装完成查看版本。

```text
$ docker --version
Docker version 19.03.4, build 9013bf583a
$ docker-compose --version
docker-compose version 1.29.1, build c34c88b2
```

使用docker-compose 安装superset

```
git clone https://github.com/apache/superset
cd superset
touch ./docker/requirements-local.txt
echo "clickhouse-driver>=0.2.0" >> ./docker/requirements-local.txt
echo "clickhouse-sqlalchemy>=0.1.6" >> ./docker/requirements-local.txt
docker-compose -f docker-compose-non-dev.yml up
```

运行成功后 浏览器访问 localhost:8088

默认登录名/密码是**admin** / **admin**。







### 2.2 连接到 ClickHouse

无论您选择哪种安装方法，您现在都可以连接到您的第一个 ClickHouse 数据库。

登录后，您将看到一个屏幕，其中包含您最近的工作以及当前的仪表板。选择右上角的数据选项卡，然后选数据库。将出现一个页面，其中包含您当前的数据库连接。按**+ 数据库**按钮添加新数据库。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090756915-2081057514.png)

输入以下值：

```
数据库名称：clickhouse-public
SQLALCHEMY 网址：clickhouse+native://demo：demo@github.demo.trial.altinity.cloud /default?secure=true
```

Altinity.Cloud是一个公共的数据集站点。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090803870-1526930538.png)

按下测试连接按钮。成功后保存链接。





####  连接过程

连接使用了 SQLAlchemy，这是一种用于连接 ClickHouse 以及许多其他数据库的通用 API。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090811256-55313067.png)

SQLAlchemy 连接使用支持多个驱动程序的专用 URL 格式。要连接到 ClickHouse，您需要提供一个类似于我们之前显示的 URL：

```text
clickhouse+native://demo:demo@github.demo.trial.altinity.cloud/default?secure=true
```

连接ClickHouse 有两个主要的协议，原生TCP和HTTP。

建议使用原生TCP。

```text
clickhouse+native://<user>:<password>@<host>:<port>/<database>[?options…]
```



#### 配置Superset

我们已经成功连接了clickhouse，下面我们使用superset建立一个仪表盘。

首先，让我们创建数据集。选择 clickhouse-public 作为连接，然后选择 schema **default**和 table **ontime**。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090826889-1386955075.png)

有了数据集后，创建第一个图表就很简单了。只需单击数据集页面上的数据集名称。Superset 将切换到一个屏幕来定义一个图表，如下所示。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090834394-1082051347.png)

创建一个时间序列图表

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090840914-571259548.png)

在仪表盘发布图表。

选择DASHBOARD 按钮，将建立的图表添加进来。

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090911695-1037170768.png)

![img](https://img2020.cnblogs.com/blog/1089984/202106/1089984-20210617090915587-1983947493.png)









## 安装软件包

```
$ yum install -y pygpgme yum-utils
$ vi /etc/yum.repos.d/altinity_clickhouse.repo
// 粘贴以下内容
[altinity_clickhouse]
name=altinity_clickhouse
baseurl=https://packagecloud.io/altinity/clickhouse/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/altinity/clickhouse/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[altinity_clickhouse-source]
name=altinity_clickhouse-source
baseurl=https://packagecloud.io/altinity/clickhouse/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/altinity/clickhouse/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
// 结束

$ yum -q makecache -y --disablerepo='*' --enablerepo='altinity_clickhouse'
$ yum install -y clickhouse-server clickhouse-client
```

## 启动服务

```
$ systemctl start clickhouse-server
```

## tabix

```
$ git clone https://github.com/smi2/tabix.ui  // 或者使用 https://git.jd.com/jdolap/tabix.ui
$ yum install -y nginx
```

修改nginx.conf中root为`/export/servers/olap/tabix.ui/build`。

修改/etc/clickhouse-server/config.xml中listen_host，允许远程连接。

当前部署的机器是172.19.165.20。在浏览器上打开http://172.19.165.20/#!/login。如果是“404 Forbidden”，可能是tabix.ui的权限问题，不能被nginx用户访问。

选择直连方式连接CK，由于CK端口是8123，所以在办公网内要用浏览器代理。

```
Name： 随便
ck地址：http://172.19.165.20:8123
login：default
password：空
```

## 参考

- clickhouse安装： https://www.digitalocean.com/community/tutorials/how-to-install-and-use-clickhouse-on-centos-7
- tabix: [http://liangfan.tech/2019/01/25/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3ClickHouse%E4%B9%8B9-%E5%8F%AF%E8%A7%86%E5%8C%96%E6%9F%A5%E8%AF%A2%E5%8F%8A%E9%9B%86%E7%BE%A4%E7%8A%B6%E6%80%81%E7%9B%91%E6%B5%8B/](