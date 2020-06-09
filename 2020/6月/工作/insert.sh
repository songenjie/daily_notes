#!/bin/bash

for((i=1;i<=60;i++))
do   
    
		mysql --protocol=tcp -h $ip -P 9504 -udefault -e "insert into erp_03_dis values  ($i,$(($i+1)));"
		echo  "insert into erp_03_dis values  ($i,$(($i+1)));"

done
