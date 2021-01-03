### 大致介绍

TPC-DS采用星型、雪花型等多维数据模式。它包含7张事实表，17张纬度表平均每张表含有18列。其工作负载包含99个SQL查询，覆盖SQL99和2003的核心部分以及OLAP。这个测试集包含对大数据集的统计、报表生成、联机查询、数据挖掘等复杂应用，测试用的数据和值是有倾斜的，与真实数据一致。可以说TPC-DS是与真实场景非常接近的一个测试集，也是难度较大的一个测试集。
[Clickhouse](https://clickhouse.tech/)是俄罗斯Yandex公司开源的一个非常快的数据管理系统，性能非常强悍。[Apache Doris](http://doris.apache.org/master/zh-CN/)是百度开源的另一个基于 MPP 的交互式 SQL 数据仓库，主要用于解决报表和多维分析，成熟稳定。

### 下载编译

[下载官方网址](http://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp)
也可以通过Git下载

```
git clone https://github.com/gregrahn/tpcds-kit.git
cd tpcds-kit/tools
make OS=LINUX
123
tpcds.sql是建表SQL
[tools]$ ll *.sql
-rw-r----- 1 prodadmin prodadmin 13875 Mar 12 03:44 tpcds_ri.sql
-rw-r----- 1 prodadmin prodadmin 22153 Mar 12 03:44 tpcds_source.sql
-rw-r----- 1 prodadmin prodadmin 30001 Mar 12 03:44 tpcds.sql
12345
dsdgen是生成数据的工具，dsqgen是生成Query的工具
[tools]$ ll ds*
-rwxr-x--- 1 prodadmin prodadmin 455880 Apr 16 19:15 dsdgen
-rwxr-x--- 1 prodadmin prodadmin 292254 Apr 16 19:15 dsqgen
1234
在query_templates中是query模板
[tools]$ ls ../query_templates/
ansi.tpl     query12.tpl  query18.tpl  query23.tpl  query29.tpl  query34.tpl  query3.tpl   query45.tpl  query50.tpl  query56.tpl  query61.tpl  query67.tpl  query72.tpl  query78.tpl  query83.tpl  query89.tpl  query94.tpl  query9.tpl
db2.tpl      query13.tpl  query19.tpl  query24.tpl  query2.tpl   query35.tpl  query40.tpl  query46.tpl  query51.tpl  query57.tpl  query62.tpl  query68.tpl  query73.tpl  query79.tpl  query84.tpl  query8.tpl   query95.tpl  README
netezza.tpl  query14.tpl  query1.tpl   query25.tpl  query30.tpl  query36.tpl  query41.tpl  query47.tpl  query52.tpl  query58.tpl  query63.tpl  query69.tpl  query74.tpl  query7.tpl   query85.tpl  query90.tpl  query96.tpl  sqlserver.tpl
oracle.tpl   query15.tpl  query20.tpl  query26.tpl  query31.tpl  query37.tpl  query42.tpl  query48.tpl  query53.tpl  query59.tpl  query64.tpl  query6.tpl   query75.tpl  query80.tpl  query86.tpl  query91.tpl  query97.tpl  templates.lst
query10.tpl  query16.tpl  query21.tpl  query27.tpl  query32.tpl  query38.tpl  query43.tpl  query49.tpl  query54.tpl  query5.tpl   query65.tpl  query70.tpl  query76.tpl  query81.tpl  query87.tpl  query92.tpl  query98.tpl
query11.tpl  query17.tpl  query22.tpl  query28.tpl  query33.tpl  query39.tpl  query44.tpl  query4.tpl   query55.tpl  query60.tpl  query66.tpl  query71.tpl  query77.tpl  query82.tpl  query88.tpl  query93.tpl  query99.tpl
12345678
```

### 建表语句

请根据Hive、Doris、Clickhouse等组件特点，修改建表语句，请注意，列是否为空，列的顺序等和后面步骤的导入数据密切相关，请勿轻易修改。
1 [Clickhouse数据类型](https://clickhouse.tech/docs/zh/interfaces/formats/#data-types-matching-sql_referencedata_types-matching)
2 [Doris建表和数据类型](http://doris.apache.org/master/zh-CN/sql-reference/sql-statements/Data Definition/CREATE TABLE.html#description)

```
create table dbgen_version
create table customer_address
create table customer_demographics
create table date_dim
create table warehouse
create table ship_mode
create table time_dim
create table reason
create table income_band
create table item
create table store
create table call_center
create table customer
create table web_site
create table store_returns
create table household_demographics
create table web_page
create table promotion
create table catalog_page
create table inventory
create table catalog_returns
create table web_returns
create table web_sales
create table catalog_sales
create table store_sales
12345678910111213141516171819202122232425
```

### 数据生成

可以建一个脚本，来生成数据
1 数据分隔符是“|”，空值默认为空。[Clickhouse支持的格式](https://clickhouse.tech/docs/zh/interfaces/formats/#shu-ju-jie-xi-fang-shi)，[Doris Load格式](http://doris.apache.org/master/zh-CN/administrator-guide/load-data/stream-load-manual.html)。
2 scale单位为G，指生成的数据量大小，paralle指分割多少个文件，child指第几个文件

```
[tools]$ cat build_data_tsv.h
echo $1
mkdir ../../data_tsv/
nohup ./dsdgen  -scale 100 -dir ../../data_tsv/ -paralle 10 -child $1 > child$1.log &
1234
```

### 数据导入

- Clickhouse数据导入，一个例子，我写了一个convert.py的小脚本，处理分隔符、空值、列顺序等问题

```
if [ ! -f "./data_tsv/dbgen_version_$1_10.done" ]; then
cat ./data_tsv/dbgen_version_$1_10.dat|python convert.py ck|clickhouse-client --query="INSERT INTO default.dbgen_version_dist FORMAT CSV"
touch ./data_tsv/dbgen_version_$1_10.done
fi
1234
```

- Doris数据导入

```
cat ./data_tsv/dbgen_version_$1_10.dat|python convert.py dr dbgen_version|curl --location-trusted -u root: -H "label:dbgen_version_$1_10_" -H "timeout:1200" -T - http://ip:port/api/testdb/dbgen_version/_stream_load
1
```

### 生成Query

```
cat build_sql.sh
./dsqgen \
-DIRECTORY ../query_templates \
-INPUT ../query_templates/templates.lst \
-VERBOSE Y \
-QUALIFY Y \
-SCALE 100 \
-DIALECT sqlserver \
-OUTPUT_DIR ../../query/
123456789
```

### Query改写

比如如下的SQL，在Doris中是可以正确的执行的，但是在Clickhouse中不行，CK中需要子查询嵌套或者用global inner join来显示指定broadcast的字表。

```
select
  c_last_name,c_first_name,substr(s_city,1,30),ss_ticket_number,amt,profit
  from
   (select ss_ticket_number
          ,ss_customer_sk
          ,store.s_city
          ,sum(ss_coupon_amt) amt
          ,sum(ss_net_profit) profit
    from store_sales,date_dim,store,household_demographics
    where store_sales.ss_sold_date_sk = date_dim.d_date_sk
    and store_sales.ss_store_sk = store.s_store_sk
    and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
    and (household_demographics.hd_dep_count = 1 or household_demographics.hd_vehicle_count > -1)
    and date_dim.d_dow = 1
    and date_dim.d_year in (2000,2000+1,2000+2)
    and store.s_number_employees between 200 and 295
    group by ss_ticket_number,ss_customer_sk,ss_addr_sk,store.s_city) ms,customer
    where ss_customer_sk = c_customer_sk
 order by c_last_name,c_first_name,substr(s_city,1,30), profit
 limit 10;
1234567891011121314151617181920
```

改写后

```
select c_last_name, c_first_name, substr(tbl1.s_city,1,30), ss_ticket_number, amt, profit
from customer_dist
global inner join (
   select ss_ticket_number, ss_customer_sk, s_city, sum(ss_coupon_amt) as amt, sum(ss_net_profit) as profit
   from store_sales_dist
   global inner join ( select d_date_sk from date_dim_dist where date_dim_dist.d_dow = 1 and d_year in (2000,2000+1,2000+2) ) on ss_sold_date_sk = d_date_sk
   global inner join ( select s_store_sk, s_city from store_dist where s_number_employees between 200 and 295 ) on ss_store_sk = s_store_sk
   global inner join ( select hd_demo_sk from household_demographics_dist where hd_dep_count = 1 or hd_vehicle_count > -1 ) on ss_hdemo_sk = hd_demo_sk
   group by ss_ticket_number, ss_customer_sk, ss_addr_sk, s_city
) tbl1 on ss_customer_sk = c_customer_sk
order by c_last_name, c_first_name, substr(s_city,1,30), profit
limit 10;
123456789101112
```

### 测试结论

1 导入数据Clickhouse快
2 数据压缩率Clickhouse好
3 单表查询Clickhouse快
4 Join查询两者各有优劣，数据量小情况下Clickhouse好，数据量大Doris好
5 Doris对SQL支持情况要好