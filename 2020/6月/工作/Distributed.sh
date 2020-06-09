#!/bin/bash

COUNT=1

for IP in $(cat  ./$1 )
do
	echo "echo $IP"
	PORT=9504
	for((i=1;i<=3;i++))
	do   
	#echo "
	mysql --protocol=tcp -h $IP -P $PORT -udefault -e "
CREATE TABLE IF NOT EXISTS erp_03_dis (
   CounterID UInt32,
   UserID UInt32)
ENGINE = Distributed(jason_ck_04, '', erp_03, rand());"

	echo "
CREATE TABLE IF NOT EXISTS erp_03_dis (
   CounterID UInt32,
   UserID UInt32)
ENGINE = Distributed(jason_ck_04, '', erp_03, rand());
"
	echo "$IP  $PORT $COUNT $i"
	let PORT+=100
	let COUNT+=1
	done

done
