#!/bin/bash

# $1 be/fe/broker 
# $2 ip file
# $3 stop restop stop

CODESOUCE=/home/prodadmin/songenjie/clickhouse-mutilprocess
INSTALLDIR=jason

if [[ "$1" == "zookeeper" ]] 
then 

	cat > deploy.yaml << EOF
---
- hosts: all
  gather_facts: no
  become: true
  tasks:
    - name: stop $1 service
      shell: \rm -rf /data0/${INSTALLDIR}/$1/ ;
      tags:
        - stop
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/log state=directory mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/zookeeper-3.4.12.zip  dest=/data0/${INSTALLDIR}/$1/zookeeper-3.4.12.zip owner=root group=root mode=0755
      tags:
        - prepare
    - name: stop $1 service
      shell: cd /data0/${INSTALLDIR}/$1 && unzip zookeeper-3.4.12.zip && mv zookeeper-3.4.12  pkg  ;
      tags:
        - stop
EOF
	cat deploy.yaml
	ansible-playbook deploy.yaml  -i $2 -f 100  
	\rm -rf deploy.yaml
	exit


elif [[ "$1" == "clickhouse" ]] 
then
	cat > deploy.yaml << EOF
---
- hosts: all
  gather_facts: no
  become: true
  tasks:
    - name: stop $1 service
      shell:  system stop clickhouse-server; systemctl stop clickhouse-server1; systemctl stop clickhouse-server2; systemctl stop clickhouse-server3;systemctl stop clickhouse-server1; systemctl stop clickhouse-server4; systemctl stop clickhouse-server5; systemctl stop clickhouse-server6;
      tags:
        - stop
    - name: stop $1 service
      shell: \rm -rf /data0/${INSTALLDIR}/$1/ /data1/${INSTALLDIR}/$1/  /data2/${INSTALLDIR}/$1/  /data3/${INSTALLDIR}/$1/ /data4/${INSTALLDIR}/$1/ ;/data5/${INSTALLDIR}/$1/; /data6/${INSTALLDIR}/$1/ ; 
      tags:
        - stop
EOF
	#--extra-vars "master=$1 user=$1"
	cat deploy.yaml
	ansible-playbook deploy.yaml  -i $2 -f 100  
	\rm -rf deploy.yaml
	exit

fi
