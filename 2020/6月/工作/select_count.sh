#!/bin/bash

for IP in $(cat  ./$1 )
do
	echo "echo $IP" >> tongji
	mysql --protocol=tcp -h $IP -P 9704  -udefault -e " select CounterID  from finaljson_1 " >> tongji
done
