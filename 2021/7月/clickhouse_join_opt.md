```sql

select count(distinct P_PARTKEY) from
(select P_PARTKEY
from part_all where P_MFGR='MFGR#3') a 


join(
select C_CUSTKEY 
from customer_local 
where C_CITY='ARGENTINA0'
) b


on a.P_PARTKEY = b.C_CUSTKEY 
;


select count(distinct P_PARTKEY)

from part_all a 
join(
select C_CUSTKEY 
from customer_local 
where C_CITY='ARGENTINA0'
) b
on a.P_PARTKEY = b.C_CUSTKEY 
where a.P_MFGR='MFGR#3';
```





a.value = 

A

```sql
shard 1  
key , value ,value 
1  100 , 300 
1  100 , 300
 
 

shard 2 
2  100 , 400
2  200 , 300 
```



B 

```sql
shard 1 
key , value 
1  200
1  200
 
 
 
shard 2 
2 100
2 100
```



