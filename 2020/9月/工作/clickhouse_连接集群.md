clickhouse 提供三个连接端口：http_port，tcp_port，mysql_port，分别支持不同的连接，可以在服务器网络进行直接连接，若需要通过办公网络访问，需要通过代理进行访问，其中sockets5代理可设置为：172.18.153.41:80。

TCP/HTTP/JDBC端口对应关系：

| 进程  | TCP  | HTTP | JDBC |
| :---- | :--- | :--- | :--- |
| 进程1 | 9600 | 8623 | 9504 |
| 进程2 | 9700 | 8723 | 9604 |
| 进程3 | 9800 | 8823 | 9704 |

#  1.http_port

处理http请求，官方的clickhouse-jdbc也使用http-client与该port通信。

jdolap clickhouse集群使用的http port为：8623，8723，8823（每个机器上三个节点）。

## 连接示例

### curl示例

curl '[http://localhost:8623/?user=test&password=1234&query=SELECT%201](http://localhost:8623/?user=test&password=1234&query=SELECT 1)'

### 官方clickhouse-jdbc示例

**clickhouse-jdbc示例**

```
//创建datasource``ClickHouseDataSource dataSource = ``new` `ClickHouseDataSource(``"jdbc:clickhouse://10.196.102.232:8623/db_name"``);``//获取connection``ClickHouseConnectionImpl connection = (ClickHouseConnectionImpl) dataSource.getConnection();``//使用statement查询``ClickHouseStatement statement = connection.createStatement();``ResultSet resultSet = statement.executeQuery(``"select * from system.parts"``);``//使用preparedStatement查询``String sql = String sql = ``"select * from system.parts where table = ?"``;``ClickHousePreparedStatement preparedStatement = (ClickHousePreparedStatement)``    ``connection.createPreparedStatement(sql, ResultSet.TYPE_FORWARD_ONLY);``preparedStatement.setString(``1``, ``"tb_test"``);``ResultSet resultSet = preparedStatement.executeQuery(sql);
```

### clickhouse-jdbc地址，insert示例

https://github.com/ClickHouse/clickhouse-jdbc

# 2.clickhouse-client端口tcp_port

处理tcp请求，目前仅有clickhouse client命令行客户端使用此端口。

jdolap clickhouse集群使用的tcp port为：9600，9700，9800（每个机器上三个节点）。

请下载对应的包tgz包，common和client两个都下载（目前CK集群版本为20.5.2版本）：

https://repo.clickhouse.tech/tgz/stable/

clickhouse-client-20.5.2.7.tgz

clickhouse-common-static-20.5.2.7.tgz

```
[lihaibo``@A02``-R12-I160-``19` `ck_client]$ mkdir clickhouse-``20.5``.``2.7``[lihaibo``@A02``-R12-I160-``19` `ck_client]$ tar zxvf clickhouse-common-``static``-``20.5``.``2.7``.tgz``[lihaibo``@A02``-R12-I160-``19` `ck_client]$ cp clickhouse-common-``static``-``20.5``.``2.7``/usr/bin/* clickhouse-``20.5``.``2.7``/``[lihaibo``@A02``-R12-I160-``19` `ck_client]$ tar zxvf clickhouse-client-``20.5``.``2.7``.tgz``[lihaibo``@A02``-R12-I160-``19` `ck_client]$ cp -d clickhouse-client-``20.5``.``2.7``/usr/bin/* clickhouse-``20.5``.``2.7``/` `连接：``./clickhouse-``20.5``.``2.7``/clickhouse-client -h ``10.196``.``102.231` `--port ``9600` `--user test --password ``1234` `-m --send_logs_level=trace` `1``、port : ``9600``/``9700``/``9800``2``、-m : 可以多行输入``3``、--send_logs_level=trace : 可以在客户端看到详细日志，一般情况下可以不加，性能调优时可以加上
```



连接示例

### 连接本地server

/data0/jdolap/clickhouse/lib/clickhouse client --port 9600 --user test --password 1234

### 连接远程server，并执行query

/data0/jdolap/clickhouse/lib/clickhouse client --host=10.196.102.232 --port 9600 --user test --password 1234 --send_logs_level=trace --query='select 1'

# 3.mysql客户端端口mysql_port

为兼容mysql，该端口处理mysql client发送的请求，但目前的clickhouse版本（20.4）对mysql的一些variables的查询如：isolation，sql_mode不兼容。

所以，依赖这些查询的mysql client连接clickhouse会出错。

jdolap clickhouse集群使用的mysql port为：9504，9604，9704（每个机器上三个节点）。

## 连接示例

mysql --protocol=tcp -h 10.198.16.98 -P 9504 -udefault

# 4.域名连接

使用域名支持访问clickhouse的http_port, tcp_port端口。

**注：不同的集群，端口可能不一样。**

## KC0_CK_TS_01

### http_port

[ckts01.olap.jd.com](http://ckts01.olap.jd.com/):2000

http_port连接clickhouse，参考1.http_port。

### mysql_port

mysql -h [ckts01.olap.jd.com](http://ckts01.olap.jd.com/) -P 2001 -utest -p1234

mysql_port连接clickhouse，参考3.mysql_port。

## jdolap_ck_04

### http_port

[ck.olap.jd.com](http://ck.olap.jd.com/):2004

http_port连接clickhouse，参考1.http_port。

### mysql_port

mysql -h ***  -P 2000

mysql_port连接clickhouse，参考3.mysql_port。

## HT0_CK_Pub_01

### http_port

[ckpub01.olap.jd.com](http://ckpub01.olap.jd.com/):2000

http_port连接clickhouse，参考1.http_port。

### mysql_port

mysql -h [ckpub01.olap.jd.com](http://ckpub01.olap.jd.com/) -P 2001 -uxxx -pxxx

mysql_port连接clickhouse，参考3.mysql_port。