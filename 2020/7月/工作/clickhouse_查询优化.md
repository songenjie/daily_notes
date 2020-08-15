1. Join多表的子查询改写，如果是from多张表，性能非常差，因此需要改写为Join，并把过滤条件放到Join的子查询中

```
//TPC-DS的原始查询SQL
select i_item_id, 
        avg(cs_quantity) agg1,
        avg(cs_list_price) agg2,
        avg(cs_coupon_amt) agg3,
        avg(cs_sales_price) agg4 
 from catalog_sales, customer_demographics, date_dim, item, promotion
 where cs_sold_date_sk = d_date_sk and
       cs_item_sk = i_item_sk and
       cs_bill_cdemo_sk = cd_demo_sk and
       cs_promo_sk = p_promo_sk and
       cd_gender = 'M' and 
       cd_marital_status = 'D' and
       cd_education_status = 'Advanced Degree' and
       (p_channel_email = 'N' or p_channel_event = 'N') and
       d_year = 1998 
 group by i_item_id
 order by i_item_id
 limit 10;

//根据CK改写的SQL
select i_item_id, avg(cs_quantity) agg1, avg(cs_list_price) agg2, avg(cs_coupon_amt) agg3, avg(cs_sales_price) agg4
from catalog_sales_dist
global inner join ( select cd_demo_sk from customer_demographics_dist where cd_gender = 'M' and cd_marital_status = 'D' and cd_education_status = 'Advanced Degree' ) on cs_bill_cdemo_sk = cd_demo_sk
global inner join ( select d_date_sk from date_dim_dist where d_year = 1998 ) on  cs_sold_date_sk = d_date_sk
global inner join ( select i_item_sk, i_item_id from item_dist ) on cs_item_sk = i_item_sk
global inner join ( select p_promo_sk from promotion_dist where p_channel_email = 'N' or p_channel_event = 'N') on cs_promo_sk = p_promo_sk
group by i_item_id order by i_item_id limit 10;
```

1. clickhouse是强类型的SQL写法，需要转换类型，比如toDecimal32(100,2)

- 参考[类型转换函数](https://clickhouse.tech/docs/en/sql-reference/functions/type-conversion-functions/)
- 如果日期用String类型，会有10个字节，用Date类型只有3个字节，存储量下降2/3
- 根据相关测试结论整数用Int32会比String计算性能好1倍

1. GLOBAL JION和JOIN

- GLOBAL JOIN会把数据发送给所有节点参与计算，针对较小的维度表性能较好
- JOIN会在本地节点操作，适合于相同分片字段的两张表关联
- 参考[官方Join](https://clickhouse.tech/docs/en/sql-reference/statements/select/join/)

1. IN和JOIN

- IN的性能比JOIN好，优先使用IN
- 在做Join之前先过滤数据，然后再Join可以显著的提升性能，如下SQL从13.03秒优化到0.39秒

```mysql
SELECT COUNT(*) FROM (
        SELECT
          COALESCE(t1.orderid, '') AS sale_ord_id,
          COALESCE(t1.creatdate, '') AS re_ord_tm,
          COALESCE(t2.wareid, '') AS sku_id,
          COALESCE(t2.ware, '') AS sku_name,
          COALESCE(t2.num, '') AS sale_qtty
        FROM (
            SELECT DISTINCT kdanhao, churu, cdanhao, orderid, phdanhao, cgdanhao, yuandanhao, churuid, feilei, qianzi, jingban, remark, creatdate, lastdate, orgid, toorgid, laiyuancode, cityid
            FROM ods.ods_pek_jd_chuguan_chain
            WHERE creatdate >= toDate('2020-07-18') AND trim(churu) = '入库' AND trim(feilei) IN('退货', '退库')
          ) t1 JOIN (
            SELECT DISTINCT id, kdanhao, wareid, ware, num, creatdate, jiage, daima, succeed
            FROM ods.ods_pek_jd_qingdan_chain
            WHERE creatdate >= toDate('2020-07-18')
          ) t2 ON t1.kdanhao = t2.kdanhao
);
+---------+
| COUNT() |
+---------+
|   68134 |
+---------+
1 row in set (13.03 sec)

SELECT COUNT(*) FROM (
        SELECT
          COALESCE(t1.orderid, '') AS sale_ord_id,
          COALESCE(t1.creatdate, '') AS re_ord_tm,
          COALESCE(t2.wareid, '') AS sku_id,
          COALESCE(t2.ware, '') AS sku_name,
          COALESCE(t2.num, '') AS sale_qtty
        FROM (
            SELECT DISTINCT id, kdanhao, wareid, ware, num, creatdate, jiage, daima, succeed
            FROM ods.ods_pek_jd_qingdan_chain
            WHERE creatdate >= toDate('2020-07-18')
              AND kdanhao GLOBAL IN ( SELECT DISTINCT kdanhao FROM ods.ods_pek_jd_chuguan_chain WHERE creatdate >= toDate('2020-07-18') AND trim(churu) = '入库' AND trim(feilei) IN('退货', '退库') )
          ) t2 JOIN (
            SELECT DISTINCT kdanhao, churu, cdanhao, orderid, phdanhao, cgdanhao, yuandanhao, churuid, feilei, qianzi, jingban, remark, creatdate, lastdate, orgid, toorgid, laiyuancode, cityid
            FROM
              ods.ods_pek_jd_chuguan_chain
            WHERE
              creatdate >= toDate('2020-07-18')
              AND trim(churu) = '入库'
              AND trim(feilei) IN('退货', '退库')
          )
          t1 ON t1.kdanhao = t2.kdanhao
);
+---------+
| COUNT() |
+---------+
|   68134 |
+---------+
1 row in set (0.39 sec)
select avg(ss_quantity), avg(ss_ext_sales_price), avg(ss_ext_wholesale_cost), sum(ss_ext_wholesale_cost)
from store_sales_dist
global inner join date_dim_dist on ss_sold_date_sk = d_date_sk and d_year = toInt16(2001)
global inner join (
    select ss_item_sk,ss_ticket_number from (
        select ss_item_sk, ss_ticket_number from store_sales_dist
            global inner join customer_address_dist on ss_addr_sk = ca_address_sk and ca_country = 'United States'
            where ca_state in ('AK', 'TX', 'WV') and ss_net_profit between toDecimal32(100,2) and toDecimal32(200,2) 
        union all
        select ss_item_sk, ss_ticket_number from store_sales_dist
            global inner join customer_address_dist on ss_addr_sk = ca_address_sk and ca_country = 'United States'
            where ca_state in ('MT', 'NC', 'IN') and ss_net_profit between toDecimal32(150,2) and toDecimal32(300,2)
        union all
        select ss_item_sk, ss_ticket_number from store_sales_dist
            global inner join customer_address_dist on ss_addr_sk = ca_address_sk and ca_country = 'United States'
            where ca_state in ('MI', 'MO', 'KY') and ss_net_profit between toDecimal32(50,2) and toDecimal32(250,2)
    )
    inner join (
        select ss_item_sk, ss_ticket_number from store_sales_dist
            global inner join household_demographics_dist on ss_hdemo_sk=hd_demo_sk and hd_dep_count = toInt16(3)
            global inner join customer_demographics_dist on cd_demo_sk = ss_cdemo_sk and cd_marital_status = 'U' and cd_education_status = 'Secondary' 
            where  ss_sales_price between toDecimal32(100,2) and toDecimal32(150,2)
        union all
        select ss_item_sk, ss_ticket_number from store_sales_dist
            global inner join household_demographics_dist on ss_hdemo_sk=hd_demo_sk and hd_dep_count = toInt16(1)
            global inner join customer_demographics_dist on cd_demo_sk = ss_cdemo_sk and cd_marital_status = 'S' and cd_education_status = 'Advanced Degree' 
            where  ss_sales_price between toDecimal32(50,2) and toDecimal32(100,2)
        union all
        select ss_item_sk, ss_ticket_number from store_sales_dist
            global inner join household_demographics_dist on ss_hdemo_sk=hd_demo_sk and hd_dep_count = toInt16(1)
            global inner join customer_demographics_dist on cd_demo_sk = ss_cdemo_sk and cd_marital_status = 'M' and cd_education_status = 'College' 
            where  ss_sales_price between toDecimal32(150,2) and toDecimal32(200,2)
    ) using ss_item_sk, ss_ticket_number
) AS tbl2 on tbl2.ss_item_sk = store_sales_dist.ss_item_sk and tbl2.ss_ticket_number = store_sales_dist.ss_ticket_number
limit 10;
```

## [查询优化](https://cf.jd.com/pages/viewpage.action?pageId=320739153#查询优化)

1. Join的顺序，大表在左，小表在右

```
//如table1的数据量比table2大，则大表放在左侧
SELECT * FROM table1 JOIN table2 ON table1.id = table2.id
```

1. 子查询嵌套联合查询性能好

```mysql
//TPC-DS原始SQL，两层SQL嵌套
select c_last_name
       ,c_first_name
       ,c_salutation
       ,c_preferred_cust_flag 
       ,ss_ticket_number
       ,cnt from
   (select ss_ticket_number
          ,ss_customer_sk
          ,count(*) cnt
    from store_sales,date_dim,store,household_demographics
    where store_sales.ss_sold_date_sk = date_dim.d_date_sk
    and store_sales.ss_store_sk = store.s_store_sk  
    and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
    and date_dim.d_dom between 1 and 2 
    and (household_demographics.hd_buy_potential = '>10000' or
         household_demographics.hd_buy_potential = '5001-10000')
    and household_demographics.hd_vehicle_count > 0
    and case when household_demographics.hd_vehicle_count > 0 then 
             household_demographics.hd_dep_count/ household_demographics.hd_vehicle_count else null end > 1
    and date_dim.d_year in (1999,1999+1,1999+2)
    and store.s_county in ('Williamson County','Williamson County','Williamson County','Williamson County')
    group by ss_ticket_number,ss_customer_sk) dj,customer
    where ss_customer_sk = c_customer_sk
      and cnt between 1 and 5
    order by cnt desc, c_last_name asc;

//在Clickhouse中，构造了4层查询树，把过滤最多的条件放在最内层
select c_last_name, c_first_name, c_salutation, c_preferred_cust_flag, ss_ticket_number, cd_cnt
from customer_dist
global inner join (
    select * from (
        select ss_ticket_number, ss_customer_sk, count(0) as cd_cnt
        from store_sales_dist
        global inner join (
            select d_date_sk from date_dim_dist where (d_dom between 1 and 2) and d_year in (1999,1999+1,1999+2) 
            ) as tbl1 on  tbl1.d_date_sk = ss_sold_date_sk
        global inner join (
            select s_store_sk from store_dist where s_county in ('Williamson County','Williamson County','Williamson County','Williamson County') 
            ) as tbl2 on tbl2.s_store_sk = ss_store_sk
        global inner join (
            select hd_demo_sk from household_demographics_dist where (hd_buy_potential = '>10000' or hd_buy_potential = '5001-10000') and hd_vehicle_count > 0
                and case when hd_vehicle_count > 0 then hd_dep_count / hd_vehicle_count 
                    else null end > 1
            ) as tbl3 on tbl3.hd_demo_sk = ss_hdemo_sk
        group by ss_ticket_number,ss_customer_sk
    ) where cd_cnt between 1 and 5 
) as tbl4 on ss_customer_sk = c_customer_sk 
order by cd_cnt desc, c_last_name asc;
```

1. 先过滤再Join

```
SELECT * FROM table1 WHERE id IN (SELECT id FROM table3 WHERE xxx) 
JOIN table2 ON table1.id = table2.id
```

1. 优先用IN

- 如果是过滤条件，建议放到IN中，而不是Join

```
SELECT * FROM table1 WHERE id IN ( SELECT id FROM table2 WHERE xxx)
```

1. 本地In/Join

- 建表的时候分为分布式表和本地表，按照两张表关联的列分片

```
SELECT uniqCombined64(browser_uniq_id) as uv, count(browser_uniq_id) as pv
FROM gdm_m14_online_log_item_d
WHERE dt='2020-06-05'
AND sku_id IN (SELECT item_sku_id FROM hjy_poc.gdm_m03_item_sku_act_local WHERE dt='2020-06-05');
1 rows in set. Elapsed: 15.878 sec. Processed 1.72 billion rows, 19.97 GB (108.34 million rows/s., 1.26 GB/s.)
```

1. 近似计算

- 可以测试countDistinct(xxx)和uniqcombined的性能和数据误差，如下SQL，看误差是否在可以接受的范围内
- [uniqcombined](https://clickhouse.tech/docs/en/sql-reference/aggregate-functions/reference/uniqcombined/#agg_function-uniqcombined)

```
--测试uniqCombined64的误差
SELECT dept_id_3, uv1, uv2, abs(toFloat64(uv2-uv1)/uv1) delta FROM (
SELECT dept_id_3, countDistinct(browser_uniq_id) uv1, uniqCombined64(browser_uniq_id) uv2 FROM gdm_m14_online_log_item_d WHERE dt ='2020-06-05' GROUP BY dept_id_3)
WHERE delta > 0 ORDER BY delta DESC LIMIT 20;

┌─dept_id_3─┬────uv1─┬────uv2─┬─────────────────delta─┐
│ 3633      │ 327271 │ 329907 │  0.008054486954236703 │
│ 2314      │  80805 │  81332 │   0.00652187364643277 │
│ 1048      │ 209122 │ 207794 │  0.006350360076892914 │
│ 2667      │  30876 │  31047 │  0.005538282160901672 │
│ 3999      │  26903 │  27051 │  0.005501245214288369 │
│ 3769      │  76062 │  76480 │  0.005495516815229681 │
│ 2074      │ 157605 │ 158380 │  0.004917356682846356 │
│ 2344      │  80127 │  79741 │  0.004817352452980893 │
│ 2106      │  39906 │  40098 │ 0.0048113065704405355 │
│ 4340      │  34560 │  34725 │  0.004774305555555556 │
│ 141       │  83857 │  84246 │  0.004638849469930954 │
│ 4373      │ 101459 │ 100993 │  0.004592988300692891 │
│ 1502      │  64642 │  64931 │  0.004470777513071997 │
│ 2101      │  99887 │ 100327 │  0.004404977624715929 │
│ 3435      │  15270 │  15203 │  0.004387688277668631 │
│ 3306      │  55533 │  55776 │ 0.0043757765652855055 │
│ 1903      │ 189691 │ 190479 │  0.004154124339056676 │
│ 2874      │ 482760 │ 484706 │  0.004030988482890049 │
│ 2511      │  32925 │  32796 │  0.003917995444191344 │
│ 3630      │ 244074 │ 245014 │  0.003851291001909257 │
└───────────┴────────┴────────┴───────────────────────┘
```