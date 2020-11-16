https://github.com/ClickHouse/ClickHouse/issues/6565

index_granularity 8198 6416 8 





create table z(d Date, z String, u String) Engine=MergeTree partition by tuple() order by tuple();
CREATE MATERIALIZED VIEW mvz ENGINE = AggregatingMergeTree order by (z,d) settings index_granularity = 8  
as select d, z,uniqState(u) as us from z group by z,d;

insert into z select today()-1, toString(rand()%1000),concat('usr',toString(number)) from numbers(100000000);
insert into z select today()-2, toString(rand()%1000),concat('usr',toString(number)) from numbers(100000000);
insert into z select today()-3, toString(rand()%1000),concat('usr',toString(number)) from numbers(100000000);

select  uniq(u) as unique from z prewhere z='555' group by d order by d;
┌─unique─┐
│ 100351 │
│ 100175 │
│  99327 │
└────────┘

3 rows in set. Elapsed: 3.265 sec. Processed 300.00 million rows, 3.57 GB (91.87 million rows/s., 1.09 GB/s.)

select  uniqMerge(us) as unique from mvz prewhere z='555' group by d order by d;
┌─unique─┐
│ 100351 │
│ 100175 │
│  99327 │
└────────┘

3 rows in set. Elapsed: 0.024 sec.


select round(sum(bytes)/1024/1024) size, sum(rows),table
from system.parts 
where   table in ('z', '.inner.mvz')
group by table

┌─size─┬──sum(rows)─┬─table──────┐
│ 4416 │     349000 │ .inner.mvz │
│ 5567 │ 1327540992 │ z          │
└──────┴────────────┴────────────┘