#!/bin/bash

# $1 be/fe/broker 
# $2 ip file
# $3 start restart stop

CODESOUCE=/home/prodadmin/songenjie/jason-deploy/jason-clickhouse/jason_ck_04
INSTALLDIR=jason

if [[ "$1" == "clickhouse" ]] 
then
	cat > deploy.yaml << EOF
---
- hosts: all
  gather_facts: no
  become: true
  tasks:
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data1/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data3/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data5/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data6/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data7/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/storage_policy1.xml  dest=/data0/${INSTALLDIR}/$1/conf/storage_policy.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/metrika.xml  dest=/data0/${INSTALLDIR}/$1/conf/metrika.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/users.xml  dest=/data0/${INSTALLDIR}/$1/conf/users.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: start $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data0/jason ;systemctl daemon-reload ;systemctl enable clickhouse-server1.service; systemctl start clickhouse-server1;
      tags:
        - start
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/storage_policy2.xml  dest=/data2/${INSTALLDIR}/$1/conf/storage_policy.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/metrika.xml  dest=/data2/${INSTALLDIR}/$1/conf/metrika.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/users.xml  dest=/data2/${INSTALLDIR}/$1/conf/users.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: start $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data2/jason ;systemctl daemon-reload ;systemctl enable clickhouse-server2.service; systemctl start clickhouse-server2;
      tags:
        - start
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/config3.xml  dest=/data4/${INSTALLDIR}/$1/conf/config.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/storage_policy3.xml  dest=/data4/${INSTALLDIR}/$1/conf/storage_policy.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/metrika.xml  dest=/data4/${INSTALLDIR}/$1/conf/metrika.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/users.xml  dest=/data4/${INSTALLDIR}/$1/conf/users.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: start $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data4/jason ;systemctl daemon-reload ;systemctl enable clickhouse-server3.service; systemctl start clickhouse-server3;
      tags:
        - start
EOF
	#--extra-vars "master=$1 user=$1"
	cat deploy.yaml
	ansible-playbook deploy.yaml  -i $2 -f 100  
	\rm -rf deploy.yaml
	exit

fi
