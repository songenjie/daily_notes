表信息：

app_l01_userprofile_stable_da (存的是时效性不高的标签) (13.8亿)  ps: 有重复数据2亿+ 去重后数据：11.6亿

app_l01_userprofile_dynamic_da (存的时效性高的标签) （13.9亿）



 用户行为表：adm_l01_mkt_user_behavior_info_sum (256亿)



 Easylabel表：adm_l01_easy_label_dev_models （45亿）



指标信息：

**Stable：**

预测年龄：pred_age  

预测性别：pred_gender

学生学历：education

生鲜勋章：medal_fresh

**Dynamic：**

最近一年有效父单量：last1y_buy_valid_parent_ord_qtty

最近一年有效已购商品总金额：last1y_buy_valid_total_amount

**用户行为表：**

一级类目：item_first_cate_cd

浏览未购买：max_view_dt 

近30成交父单量：valid_par_ord_cnt_30

**easylabel表：**  

全品类最近一次加购时间：user_behavior_date



验证case的逻辑：

单表到多表 采标后标签平台的圈人最多涉及5张表 ：2张宽表、1张行为表、1张label表、1张私域标签表。

**Case1: app_l01_userprofile_stable_da**  **:** (预测年龄:15岁以下,16-25岁,26-35岁,36-45岁 且 预测性别:男) 或 学生学历:硕士,博士)

**Case2: app_l01_userprofile_dynamic_da :** (最近一年有效父单量:1-5或最近一年有效已购商品总金额:1-1000)

**Case3:stable+****用户行为 2张表** (生鲜勋章:V3,V4,V2)且(一级类目:生鲜且(浏览:最近3天未购买 或 近30成交父单量:近30成交父单量1-2单))

**Case4:dynamic+****stable+****用户行为 3张表 :** (生鲜勋章:V3,V2,V4 或 最近一年有效父单量:1-5) 且 (一级类目:生鲜 且 ( 浏览:最近3天未购买 或 近30成交父单量: 近30成交父单量1-2单))

**Case5:dynamic****+****用户行为****+label** **3****张表 ：**(生鲜勋章:V3,V2,V4)且(一级类目:生鲜 且 (浏览:最近3天未购买 或 近30成交父单量: 近30成交父单量1-2单) 且 全品类最近一次加购时间：2021-01-01-2021-01-31)

**Case6:stable+dynamic****+****用户行为****+label** **4****张表：（**生鲜勋章: V3,V2,V4 或 最近一年有效父单量:1-5） 且 (一级类目:生鲜 且 ( 浏览: 最近3天未购买 或 近30成交父单量: 近30成交父单量1-2单 ) 且 全品类最近一次加购时间：2021-01-01-2021-01-31)



**case1:** 

原SQL：数量 180362373 , 耗时1s

SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM app_l01_userprofile_active_da_new WHERE ((((((`dt` = '2021-01-20' AND `pred_age` IN ('15岁以下','16-25岁','26-35岁','36-45岁'))) AND ((`dt` = '2021-01-20' AND `pred_gender` IN ('男'))))) OR ((`dt` = '2021-01-20' AND `education` IN (4,5))))));

新SQL: 数量236322295 ，耗时1.3s

SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM app_l01_userprofile_stable_da WHERE ((((((`dt` = '2021-01-19' AND `pred_age` IN ('15岁以下','16-25岁','26-35岁','36-45岁'))) AND ((`dt` = '2021-01-19' AND `pred_gender` IN ('男'))))) OR ((`dt` = '2021-01-19' AND `education` IN (4,5))))));


**case2:** 

原SQL：数量 361754175，耗时1.7s

SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM app_l01_userprofile_active_da_new WHERE (((((`last1y_buy_valid_parent_ord_qtty` >= 1 AND `last1y_buy_valid_parent_ord_qtty` <= 5) AND `dt` = '2021-01-20')) OR (((`last1y_buy_valid_total_amount` >= 1 AND `last1y_buy_valid_total_amount` <= 1000) AND `dt` = '2021-01-20')))));

新SQL：数量411854690，耗时1.8s

SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM app_l01_userprofile_dynamic_da WHERE (((((`last1y_buy_valid_parent_ord_qtty` >= 1 AND `last1y_buy_valid_parent_ord_qtty` <= 5) AND `dt` = '2021-01-20')) OR (((`last1y_buy_valid_total_amount` >= 1 AND `last1y_buy_valid_total_amount` <= 1000) AND `dt` = '2021-01-20')))));



case3: 数量 5206893，耗时16s

SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM (SELECT user_log_acct FROM app_l01_userprofile_active_da_new WHERE ((((`dt` = '2021-01-20' AND `medal_fresh` IN ('V3','V2','V4')))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM adm_l01_mkt_user_behavior_info_sum WHERE ((((`dt` = '2021-01-20' AND `item_first_cate_cd` IN ('12218'))) AND ((((`dt` = '2021-01-20' AND (`max_view_dt` >= '2021-01-18' AND `max_view_dt` <= '2021-01-21') AND (`max_order_dt` <= '2021-01-18'))) OR ((`dt` = '2021-01-20' AND (`valid_par_ord_cnt_30` >= 1 AND `valid_par_ord_cnt_30` <= 2)))))))) USING user_log_acct);



新SQL: 数量 3717435， 耗时15s

SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM (SELECT user_log_acct FROM app_l01_userprofile_stable_da WHERE ((((`dt` = '2021-01-19' AND `medal_fresh` IN ('V3','V2','V4')))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM adm_l01_mkt_user_behavior_info_sum WHERE ((((`dt` = '2021-01-19' AND `item_first_cate_cd` IN ('12218'))) AND ((((`dt` = '2021-01-19' AND (`max_view_dt` >= '2021-01-18' AND `max_view_dt` <= '2021-01-21') AND (`max_order_dt` <= '2021-01-18'))) OR ((`dt` = '2021-01-19' AND (`valid_par_ord_cnt_30` >= 1 AND `valid_par_ord_cnt_30` <= 2)))))))) USING user_log_acct);




case4: 数量 8452062，耗时17s
SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM (SELECT user_log_acct FROM app_l01_userprofile_active_da_new WHERE ((((`dt` = '2021-01-20' AND `medal_fresh` IN ('V3','V2','V4'))) OR (((`last1y_buy_valid_parent_ord_qtty` >= 1 AND `last1y_buy_valid_parent_ord_qtty` <= 5) AND `dt` = '2021-01-20'))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM adm_l01_mkt_user_behavior_info_sum WHERE ((((`dt` = '2021-01-20' AND `item_first_cate_cd` IN ('12218'))) AND ((((`dt` = '2021-01-20' AND (`max_view_dt` >= '2021-01-18' AND `max_view_dt` <= '2021-01-21') AND (`max_order_dt` <= '2021-01-18'))) OR ((`dt` = '2021-01-20' AND (`valid_par_ord_cnt_30` >= 1 AND `valid_par_ord_cnt_30` <= 2)))))))) USING user_log_acct);


case5: 数量 4850001，耗时37s
SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM (SELECT user_log_acct FROM app_l01_userprofile_active_da_new WHERE ((((`dt` = '2021-01-20' AND `medal_fresh` IN ('V3','V2','V4')))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM (SELECT user_log_acct FROM adm_l01_mkt_user_behavior_info_sum WHERE ((((`dt` = '2021-01-20' AND `item_first_cate_cd` IN ('12218'))) AND ((((`dt` = '2021-01-20' AND (`max_view_dt` >= '2021-01-18' AND `max_view_dt` <= '2021-01-21') AND (`max_order_dt` <= '2021-01-18'))) OR ((`dt` = '2021-01-20' AND (`valid_par_ord_cnt_30` >= 1 AND `valid_par_ord_cnt_30` <= 2)))))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM ((select user_log_acct from (select user_log_acct from (select user_log_acct, splitByString(':', splitted) as array, array[1] as label_id, array[2] as label_value, dt from adm_l01_easy_label_dev_models array join user_behavior_date as splitted) where (((label_value >= '2021-01-01' AND label_value <= '2021-01-31')) AND `label_id` = '513' AND `dt` = '2021-01-20'))))) USING user_log_acct) USING user_log_acct);


case6: 数量 6463183，耗时43s
SELECT uniq(user_log_acct) FROM (SELECT user_log_acct FROM (SELECT user_log_acct FROM app_l01_userprofile_active_da_new WHERE ((((`dt` = '2021-01-20' AND `medal_fresh` IN ('V3','V2','V4'))) OR (((`last1y_buy_valid_parent_ord_qtty` >= 1 AND `last1y_buy_valid_parent_ord_qtty` <= 5) AND `dt` = '2021-01-20'))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM (SELECT user_log_acct FROM adm_l01_mkt_user_behavior_info_sum WHERE ((((`dt` = '2021-01-20' AND `item_first_cate_cd` IN ('12218'))) AND ((((`dt` = '2021-01-20' AND (`max_view_dt` >= '2021-01-18' AND `max_view_dt` <= '2021-01-21') AND (`max_order_dt` <= '2021-01-18'))) OR ((`dt` = '2021-01-20' AND (`valid_par_ord_cnt_30` >= 1 AND `valid_par_ord_cnt_30` <= 2)))))))) GLOBAL ANY INNER JOIN (SELECT user_log_acct FROM ((select user_log_acct from (select user_log_acct from (select user_log_acct, splitByString(':', splitted) as array, array[1] as label_id, array[2] as label_value, dt from adm_l01_easy_label_dev_models array join user_behavior_date as splitted) where (((label_value >= '2021-01-01' AND label_value <= '2021-01-31')) AND `label_id` = '513' AND `dt` = '2021-01-20'))))) USING user_log_acct) USING user_log_acct);