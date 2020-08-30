`切记 java clickhouse jdbc 关联 clickhouse server ,使用的clickhouse http port 连接`



- 创建maven项目引入依赖

引入ClickHouse驱动包

```html
<dependency>



   <groupId>ru.yandex.clickhouse</groupId>



   <artifactId>clickhouse-jdbc</artifactId>



   <version>0.1.40</version>



</dependency>
```

## 

- 修改ClickHouse配置文件

vim /etc/clickhouse-server/config.xml

配置jdbc访问端口

```html
<http_port>8123</http_port>
```

配置ip地址

```html
<listen_host>::1</listen_host>



<listen_host>172.16.1.23</listen_host>
```

注：需要配置listen_host,不然会出现 Connection refused的情况，修改完成之后需要重启



## 

- 编写测试类



```java
package com.zhangwq;



 



import java.sql.*;



import java.util.ArrayList;



import java.util.HashMap;



import java.util.List;



import java.util.Map;



 



/**



 * @author zhangwq



 * @date 2018/6/30 20:58



 */



public class ClickHouseJDBC {



    public static void main(String[] args) {



        String sqlDB = "show databases";//查询数据库



        String sqlTab = "show tables";//查看表



        String sqlCount = "select count(*) count from ontime";//查询ontime数据量



        exeSql(sqlDB);



        exeSql(sqlTab);



        exeSql(sqlCount);



    }



 



    public static void exeSql(String sql){



        String address = "jdbc:clickhouse://172.16.1.23:8123/default";



        Connection connection = null;



        Statement statement = null;



        ResultSet results = null;



        try {



            Class.forName("ru.yandex.clickhouse.ClickHouseDriver");



            connection = DriverManager.getConnection(address);



            statement = connection.createStatement();



            long begin = System.currentTimeMillis();



            results = statement.executeQuery(sql);



            long end = System.currentTimeMillis();



            System.out.println("执行（"+sql+"）耗时："+(end-begin)+"ms");



            ResultSetMetaData rsmd = results.getMetaData();



            List<Map> list = new ArrayList();



            while(results.next()){



                Map map = new HashMap();



                for(int i = 1;i<=rsmd.getColumnCount();i++){



                    map.put(rsmd.getColumnName(i),results.getString(rsmd.getColumnName(i)));



                }



                list.add(map);



            }



            for(Map map : list){



                System.err.println(map);



            }



        } catch (Exception e) {



            e.printStackTrace();



        }finally {//关闭连接



            try {



                if(results!=null){



                    results.close();



                }



                if(statement!=null){



                    statement.close();



                }



                if(connection!=null){



                    connection.close();



                }



            } catch (SQLException e) {



                e.printStackTrace();



            }



        }



    }



}
```

启动项目测试，发现如下报错。