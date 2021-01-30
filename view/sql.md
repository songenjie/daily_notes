​	



```mysql
SELECT uniq(user_log_acct)
FROM
(
    SELECT user_log_acct
    FROM app_l01_userprofile_active_da_new
    WHERE (((dt = '2021-01-20') AND (pred_age IN ('15岁以下', '16-25岁', '26-35岁', '36-45岁'))) AND ((dt = '2021-01-20') AND (pred_gender IN ('男')))) OR ((dt = '2021-01-20') AND (education IN (4, 5)))
)

SELECT uniq(user_log_acct)
FROM
(
    SELECT user_log_acct
    FROM app_l01_userprofile_active_da_new
    WHERE (((dt = '2021-01-20') AND (pred_age IN ('15岁以下', '16-25岁', '26-35岁', '36-45岁'))) AND ((dt = '2021-01-20') AND (pred_gender IN ('男')))) OR ((dt = '2021-01-20') AND (education IN (4, 5)))
)

\








SELECT uniq(user_log_acct)
FROM
(
    SELECT user_log_acct
    FROM
    (
        SELECT user_log_acct
        FROM app_l01_userprofile_active_da_new
        WHERE (dt = '2021-01-20') AND (medal_fresh IN ('V3', 'V2', 'V4'))
    )
    GLOBAL ANY INNER JOIN
    (
        SELECT user_log_acct
        FROM adm_l01_mkt_user_behavior_info_sum
        WHERE ((dt = '2021-01-20')  AND (item_first_cate_cd IN ('12218')) ) AND (((dt = '2021-01-20') AND ((max_view_dt >= '2021-01-18') AND (max_view_dt <= '2021-01-21')) AND (max_order_dt <= '2021-01-18')) OR ((dt = '2021-01-20') AND ((valid_par_ord_cnt_30 >= 1) AND (valid_par_ord_cnt_30 <= 2))))
    ) USING (user_log_acct)
)






SELECT uniq(user_log_acct)
FROM
(
    SELECT user_log_acct
    FROM
    (
        SELECT user_log_acct
        FROM app_l01_userprofile_stable_da_local
        WHERE (dt = '2021-01-20') AND (medal_fresh IN ('V3', 'V2', 'V4'))
    )
    ANY INNER JOIN
    (
        SELECT user_log_acct
        FROM adm_l01_mkt_user_behavior_info_sum_local
        WHERE (  (dt = '2021-01-20')   AND  (item_first_cate_cd IN ('12218'))   AND (max_view_dt >= '2021-01-18') AND (max_view_dt <= '2021-01-21')  AND (max_order_dt <= '2021-01-18')  ) OR (  (dt = '2021-01-20') AND (valid_par_ord_cnt_30 >= 1) AND (valid_par_ord_cnt_30 <= 2) )
    ) USING (user_log_acct)
)


SELECT uniq(user_log_acct)
FROM
(
    SELECT user_log_acct
    FROM
    (
        SELECT user_log_acct
        FROM app_l01_userprofile_active_da_new
        WHERE (dt = '2021-01-20') AND (medal_fresh IN ('V3', 'V2', 'V4'))
    )
    INNER JOIN
    (
        SELECT user_log_acct
        FROM adm_l01_mkt_user_behavior_info_sum
        WHERE (  (dt = '2021-01-20')   AND  (item_first_cate_cd IN ('12218'))   AND (max_view_dt >= '2021-01-18') AND (max_view_dt <= '2021-01-21')  AND (max_order_dt <= '2021-01-18')  ) OR (  (dt = '2021-01-20') AND (valid_par_ord_cnt_30 >= 1) AND (valid_par_ord_cnt_30 <= 2) )
    ) USING (user_log_acct)
)



```

