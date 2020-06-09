#!/bin/bash

# $1 be/fe/broker 
# $2 ip file
# $3 restart rerestart stop

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
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/config1.xml  dest=/data0/${INSTALLDIR}/$1/conf/config.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/config2.xml  dest=/data2/${INSTALLDIR}/$1/conf/config.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/config3.xml  dest=/data4/${INSTALLDIR}/$1/conf/config.xml owner=root group=root mode=0755
      tags:
        - prepare
    - name: restart $1 service
      shell: chown -R clickhouse:clickhouse /data6/jason ;chown -R clickhouse:clickhouse /data7/jason ;
      tags:
        - restart
    - name: restart $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data0/jason ;chown -R clickhouse:clickhouse /data1/jason ;systemctl daemon-reload ;systemctl enable clickhouse-server1.service; systemctl restart clickhouse-server1;
      tags:
        - restart
    - name: restart $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data2/jason ;chown -R clickhouse:clickhouse /data3/jason ;systemctl daemon-reload ;systemctl enable clickhouse-server2.service; systemctl restart clickhouse-server2;
      tags:
        - restart
    - name: restart $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data4/jason ;chown -R clickhouse:clickhouse /data5/jason ;systemctl daemon-reload ;systemctl enable clickhouse-server3.service; systemctl restart clickhouse-server3;
      tags:
        - restart
EOF
	#--extra-vars "master=$1 user=$1"
	cat deploy.yaml
	ansible-playbook deploy.yaml  -i $2 -f 100  
	\rm -rf deploy.yaml
	exit

fi
