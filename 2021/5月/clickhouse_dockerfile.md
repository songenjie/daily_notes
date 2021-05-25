```dockerfile
FROM centos:7.2.1511

RUN yum install -y unzip

RUN mkdir -p /ClickHouse

COPY clickhouse.zip  /ClickHouse/

RUN  cd /ClickHouse/ && unzip clickhouse.zip

RUN  cd /ClickHouse/ &&  \rm -rf clickhouse.zip

ENTRYPOINT ["/ClickHouse/clickhouse", "server", "--config-file=/Users/songenjie/Engine/ClickHouse/master/conf/config1.xml", "--pid-file=/Users/songenjie/Engine/ClickHouse/master/01/clickhouse-server1.pid"]

RUN ls -lh /ClickHouse
```



command + p + q 

