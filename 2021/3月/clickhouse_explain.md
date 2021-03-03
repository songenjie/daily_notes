```javascript
EXPLAIN [ PLAN | AST | SYNTAX | PIPELINE ] [setting = value, ...] SELECT ...
```

其中:

**PLAN** 用于查看执行计划;

**AST** 用于查看语法树;

**SYNTAX** 用于优化语法;

**PIPELINE** 用于查看 PIPELINE 计划。

**PLAN** 和 **PIPELINE** 还可以进行额外的显示设置，这一部分放到后续的演示过程中解释。



```mysql
EXPLAIN
SELECT count(*)
FROM system.parts_dis AS parts_all
INNER JOIN system.tables_dis AS tables_all ON parts_all.name = tables_all.name
FORMAT TSV

Union
  Expression (Projection)
    Expression (Before ORDER BY and SELECT)
      MergingAggregated
        ReadFromStorage (Read from Distributed)

5 rows in set. Elapsed: 1.443 sec.

BJHTYD-Hope-17-36.hadoop.jd.local :) explain plan   select count(*) from system.parts_dis as parts_all global join system.tables_dis as tables_all on parts_all.name = tables_all.name;

EXPLAIN
SELECT count(*)
FROM system.parts_dis AS parts_all
GLOBAL INNER JOIN system.tables_dis AS tables_all ON parts_all.name = tables_all.name
FORMAT TSV

Union
  CreatingSets (Create sets for subqueries and joins)
    Expression (Projection)
      Expression (Before ORDER BY and SELECT)
        MergingAggregated
          ReadFromStorage (Read from Distributed)
```





