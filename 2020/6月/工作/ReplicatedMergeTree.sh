#!/bin/bash



COUNT=1
PORT=9504
IPCOUNT=`cat ./$1 | wc -l`
for((i=1;i<=3;i++))
do
	CURRENT=$COUNT
	if [ "$i" == 2 ]
	then 
		let CURRENT=$IPCOUNT
	fi
	if [ "$i" == 3 ]
	then 
		let CURRENT=$IPCOUNT-1
	fi
	for IP in $(cat  ./$1 )
	do
		echo "$IP $PORT $CURRENT $i"

		mysql --protocol=tcp -h $IP -P $PORT -udefault -e "
CREATE TABLE erp_03
(
    CounterID UInt32,
    UserID UInt32
	) ENGINE = ReplicatedMergeTree('/clickhouse/jason_ck_04/jdob_ha/shard_0${CURRENT}/erp_03', 'replica_0${i}')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha';"


		echo "
CREATE TABLE erp_03
(
    CounterID UInt32,
    UserID UInt32
	) ENGINE = ReplicatedMergeTree('/clickhouse/jason_ck_04/jdob_ha/shard_0${CURRENT}/erp_03', 'replica_0${i}')
ORDER BY (CounterID, intHash32(UserID))
SAMPLE BY intHash32(UserID)
SETTINGS storage_policy = 'jdob_ha';"


		let CURRENT+=1
		if [ "$CURRENT" = "11" ]
		then
			let CURRENT+=-10	
		fi
	done
	let PORT+=100
	let COUNT+=1
done



