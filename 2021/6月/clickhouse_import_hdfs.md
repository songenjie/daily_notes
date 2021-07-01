Starting from ClickHouse 18.16.0 version, it supports reading files from HDFS. In 19.1.6 version, the HDFS access function is enhanced to support reading and writing. After 19.4 version, it supports Parquet format. This article describes how to read data from HDFS to ClickHouse, the test version is: 19.4
Before accessing HDFS, you need to define a table to access HDFS, and specify the table engine as HDFS. After the table is created, you can query this table.

**table of Contents**

[1. Query CSV file](https://www.programmersought.com/article/37416115472/#查询CSV文件)

[Second, query Parquet files](https://www.programmersought.com/article/37416115472/#二、查询Parquet文件)

[Three, import data from HDFS](https://www.programmersought.com/article/37416115472/#三、从HDFS导入数据)

[Four, summary](https://www.programmersought.com/article/37416115472/#总结)

[Five, reference materials](https://www.programmersought.com/article/37416115472/#参考资料)

------

### 1. Query CSV file

For example, there is a data file on HDFS: books.csv, the content is as follows:

hadoop fs -cat /user/hive/ck/book_csv/books.csv

```
0553573403,book,A Game of Thrones,7.99



0553579908,book,A Clash of Kings,7.99



055357342X,book,A Storm of Swords,7.99



0553293354,book,Foundation,7.99



0812521390,book,The Black Company,6.99



0812550706,book,Ender's Game,6.99



0441385532,book,Jhereg,7.95



0380014300,book,Nine Princes In Amber,6.99



0805080481,book,The Book of Three,5.99



080508049X,book,The Black Cauldron,5.99
```

Create a table on ClickHouse to access the books.csv file:

```sql
CREATE TABLE hdfs_books_csv



(



    isbn String,



    cat String,



    name String,



    price Float64



)



ENGINE = HDFS('hdfs://host123:9000/user/hive/ck/book_csv/books.csv', 'CSV')
```

Query the hdfs_books_csv table:

```sql
SELECT * FROM hdfs_books_csv
┌─isbn───────┬─cat──┬─name──────────────────┬─price─┐



│ 0553573403 │ book │ A Game of Thrones │ 7.99 │



│ 0553579908 │ book │ A Clash of Kings │ 7.99 │



│ 055357342X │ book │ A Storm of Swords │ 7.99 │



│ 0553293354 │ book │ Foundation │ 7.99 │



│ 0812521390 │ book │ The Black Company │ 6.99 │



│ 0812550706 │ book │ Ender's Game │ 6.99 │



│ 0441385532 │ book │ Jhereg │ 7.95 │



│ 0380014300 │ book │ Nine Princes In Amber │ 6.99 │



│ 0805080481 │ book │ The Book of Three │ 5.99 │



│ 080508049X │ book │ The Black Cauldron │ 5.99 │



└────────────┴──────┴───────────────────────┴───────┘
```

The data retrieved is the same as the content of books.csv.

When the user executes the SELECT * FROM hdfs_books_csv statement, the data flow is as follows:

![ ClickHouse HDFS ](https://www.programmersought.com/images/76/dce3449a96aa343a3fe662f231189a5c.png)

This usage scenario is equivalent to using HDFS as ClickHouse's external storage. When querying data, you can directly access HDFS files without importing HDFS files into ClickHouse and then querying. Since the data is pulled from HDFS, compared to ClickHouse's local storage query, the speed is slower.

### Second, query Parquet files

ClickHouse 19.4 has started to support Parquet format. Let's test the HDFS data file in Parquet format. First upload a Parquet data file books.parquet to HDFS. The content of the file is the same as books.csv. The path on HDFS is as follows:
/user/hive/ck/book_parquet/books.parquet

Create a table to access the books.parquet file:

```sql
CREATE TABLE hdfs_books_parquet



(



    isbn String,



    cat String,



    name String,



    price Float64



)



ENGINE = HDFS('hdfs://host123:9000/user/hive/ck/book_parquet/books.parquet', 'Parquet')
```

Query the hdfs_books_parquet table in ClickHouse:

```sql
SELECT * FROM hdfs_books_parquet
```

The data retrieved is the same as the content of books.csv.

The above operation is to query the data directly from HDFS, or load the read data to the local table of ClickHouse.

### Three, import data from HDFS

Create a target table in ClickHouse, and then execute INSERT...SELECT to import data from HDFS.

```sql
-Create the target table



CREATE TABLE books_local



(



    isbn String,



    cat String,



    name String,



    price Float64



)



ENGINE = Log;



 --Import data from HDFS



INSERT INTO books_local SELECT * FROM hdfs_books_parquet;



 --Query the target table



SELECT * FROM books_local;
```

Import data from HDFS to ClickHouse, and then query the data flow diagram of the ClickHouse local table as follows:

![ ](https://www.programmersought.com/images/416/eee2b15ccf20ff8ffd17ef12338e66a8.png)

> See the file formats supported by ClickHouse:https://clickhouse.yandex/docs/en/interfaces/formats/

### Four, summary

By executing SQL statements, users can directly read HDFS files in ClickHouse, or import the read data into ClickHouse local tables. ClickHouse provides a more friendly way to access the Hadoop ecosystem.

### Five, reference materials

https://github.com/yandex/ClickHouse/pull/3617/

https://github.com/yandex/ClickHouse/pull/4084/

Original works, please indicate the source for reprinting: https://blog.csdn.net/yangzhaohui168/article/details/88583489

This article is published simultaneously on[Headline Number ClickHouse](https://www.toutiao.com/i6667925339810824711/)

 

[Qt interprocess communication (1) --------QProcess](https://programmersought.com/article/8623174116/?utm_source=vdoai_stories)

[![VDO.AI](https://a.vdo.ai/core/assets/img/logo.svg)](https://vdo.ai/?utm_medium=stories&utm_term=programmersought.com&utm_source=vdoai_logo)

<iframe data-id="programmersought.com_728x90_3_DFP" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" width="1" height="1" data-rendered="true" style="max-width: 100%; max-height: 100%; border: 0px !important; width: 0px; height: 0px;"></iframe>

### Intelligent Recommendation

### [sqoop import data from MySQL to hdfs](https://www.programmersought.com/article/19953963353/)

Import MYSQL data into HDFS --Table is the table to be imported into HDFS –Columns select the columns to be imported, here select HDFS to import the name and age columns. –Where filters th...