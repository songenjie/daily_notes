# sql 开窗函数



![在这里插入图片描述](https://img-blog.csdnimg.cn/2019022312202720.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl8zOTAxMDc3MA==,size_16,color_FFFFFF,t_70)

`窗口`：记录集合
`窗口函数`：在满足某些条件的记录集合上执行的特殊函数，对于每条记录都要在此窗口内执行函数。有的函数随着记录的不同，窗口大小都是固定的，称为`静态窗口`；有的函数则相反，不同的记录对应着不同的窗口，称为`滑动窗口`。

#### 1. 窗口函数和普通聚合函数的区别：

①聚合函数是将多条记录聚合为一条；窗口函数是每条记录都会执行，有几条记录执行完还是几条。
②聚合函数也可以用于窗口函数。

#### 2. 窗口函数的基本用法：

> 函数名 **OVER** 子句

`over关键字`用来指定函数执行的窗口范围，若后面括号中什么都不写，则意味着窗口包含满足WHERE条件的所有行，窗口函数基于所有行进行计算；如果不为空，则支持以下4中语法来设置窗口。
①window_name：给窗口指定一个别名。如果SQL中涉及的窗口较多，采用别名可以看起来更清晰易读；
②`PARTITION BY 子句`：窗口按照哪些字段进行分组，窗口函数在不同的分组上分别执行；
③`ORDER BY子句`：按照哪些字段进行排序，窗口函数将按照排序后的记录顺序进行编号；
④`FRAME子句`：`FRAME`是当前分区的一个子集，子句用来定义子集的规则，通常用来作为滑动窗口使用。

#### 3. 按功能划分可将MySQL支持的窗口函数分为如下几类：

##### ①序号函数：`ROW_NUMBER()`、`RANK()`、`DENSE_RANK()`

- 用途：显示分区中的当前行号
- 应用场景：查询每个学生的分数最高的前3门课程



## 4 实践

```sql
Id.  金额  地点  发生时间  useid

create table use_salary_log (
orderid varchar(10) NOT NULL ,
salary  int ,
site    varchar(20),
dt      DateTime,
userid  varchar(10) NOT NULL
)
ENGINE=OLAP
DUPLICATE KEY(`orderid`)
COMMENT "OLAP"
DISTRIBUTED BY HASH(`orderid`) BUCKETS 2
PROPERTIES (
"storage_type" = "COLUMN"
);


insert into use_salary_log values(1,100,'beijing','2020-10-01 00:00:00',001);
insert into use_salary_log values(2,200,'beijing','2020-10-01 00:00:00',001);
insert into use_salary_log values(3,300,'beijing','2020-10-01 00:00:00',001);
insert into use_salary_log values(4,400,'beijing','2020-10-01 00:00:00',001);
insert into use_salary_log values(5,500,'beijing','2020-10-01 00:00:00',001);
insert into use_salary_log values(6,100,'beijing','2020-10-01 00:00:00',002);
insert into use_salary_log values(7,200,'beijing','2020-10-01 00:00:00',002);
insert into use_salary_log values(8,300,'beijing','2020-10-01 00:00:00',003);
insert into use_salary_log values(9,400,'beijing','2020-10-01 00:00:00',004);
insert into use_salary_log values(0,400,'beijing','2020-10-01 00:00:00',005);
insert into use_salary_log values(10,100,'hangzhou','2020-10-01 00:00:00',001);
insert into use_salary_log values(11,200,'hangzhou','2020-10-01 00:00:00',002);
insert into use_salary_log values(12,300,'hangzhou','2020-10-01 00:00:00',002);
insert into use_salary_log values(13,500,'hangzhou','2020-10-01 00:00:00',001);
insert into use_salary_log values(14,100,'hangzhou','2020-10-01 00:00:00',002);
insert into use_salary_log values(15,200,'hangzhou','2020-10-01 00:00:00',003);


//用户消费 榜单
//1
mysql> select userid ,sum(salary) as sumsalary from use_salary_log group by userid order by sumsalary DESC limit 4;
+--------+-----------+
| userid | sumsalary |
+--------+-----------+
| 1      |      2100 |
| 5      |      1000 |
| 2      |       900 |
| 3      |       500 |
+--------+-----------+
4 rows in set (0.01 sec)




// 每个城市
select 
  site, 
  userid, 
  sum(salary) as sumsalary 
from 
  use_salary_log 
group by 
  site, 
  userid 
order by 
  site, 
  sumsalary DESC;
+----------+--------+-----------+
| site     | userid | sumsalary |
+----------+--------+-----------+
| beijing  | 1      |      1500 |
| beijing  | 5      |      1000 |
| beijing  | 4      |       400 |
| beijing  | 2      |       300 |
| beijing  | 3      |       300 |
| hangzhou | 1      |       600 |
| hangzhou | 2      |       600 |
| hangzhou | 3      |       200 |
+----------+--------+-----------+
8 rows in set (0.01 sec)


// 每个城市（site) ,消费最高的前两名用户(userid), 消费金额(sumsalary)
// 开窗函数
select 
  site, 
  userid, 
  sumsalary 
from 
  (
    select 
      site, 
      userid, 
      sum(salary) as sumsalary, 
      row_number() over(
        partition by site 
        order by 
          sum(salary) DESC
      ) rn 
    from 
      use_salary_log 
    group by 
      site, 
      userid
  ) t1 
where 
  t1.rn < 3;


+----------+--------+-----------+
| site     | userid | sumsalary |
+----------+--------+-----------+
| beijing  | 1      |      1500 |
| beijing  | 5      |      1000 |
| hangzhou | 2      |       600 |
| hangzhou | 1      |       600 |
+----------+--------+-----------+
4 rows in set (0.01 sec)
```









- 排序开窗函数

row_number（行号）

rank（排名）

dense_rank（密集排名）

ntile（分组排名）



学习参考

https://zhuanlan.zhihu.com/p/132477535

https://blog.csdn.net/weixin_39010770/article/details/87862407