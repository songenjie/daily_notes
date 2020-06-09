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
    - name: start $1 service
      shell: \rm -rf /data0/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data1/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data2/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data3/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data4/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data5/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data6/${INSTALLDIR}/$1
      tags:
        - start
    - name: start $1 service
      shell: \rm -rf /data7/${INSTALLDIR}/$1
      tags:
        - start
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
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data1/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data3/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data5/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data6/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data7/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/lib state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/bin state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/tmpdata state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/format_schemas state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/ssl state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/user_files state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/ddl state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data0/${INSTALLDIR}/$1/log state=directory mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/clickhouse-server1.service dest=/etc/systemd/system/clickhouse-server1.service owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/clickhouse  dest=/data0/${INSTALLDIR}/$1/lib/clickhouse owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/config1.xml  dest=/data0/${INSTALLDIR}/$1/conf/config.xml owner=root group=root mode=0755
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
    - name: restart $1 service
      shell: chown -R clickhouse:clickhouse /data6/jason/clickhouse ;chown -R clickhouse:clickhouse /data7/jason/clickhouse ;
      tags:
        - restart
    - name: restart $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data0/jason/clickhouse ;chown -R clickhouse:clickhouse /data1/jason/clickhouse ;systemctl daemon-reload ;systemctl enable clickhouse-server1.service; systemctl restart clickhouse-server1;
      tags:
        - restart
    - name: start $1 service
      shell: \rm -rf /data2/${INSTALLDIR}/$1
      tags:
        - start
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/lib state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/bin state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/tmpdata state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/format_schemas state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/ssl state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/user_files state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/ddl state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data2/${INSTALLDIR}/$1/log state=directory mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/clickhouse-server2.service dest=/etc/systemd/system/clickhouse-server2.service owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/clickhouse  dest=/data2/${INSTALLDIR}/$1/lib/clickhouse owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/config2.xml  dest=/data2/${INSTALLDIR}/$1/conf/config.xml owner=root group=root mode=0755
      tags:
        - prepare
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
    - name: restart $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data2/jason/clickhouse ;chown -R clickhouse:clickhouse /data3/jason/clickhouse ;systemctl daemon-reload ;systemctl enable clickhouse-server2.service; systemctl restart clickhouse-server2;
      tags:
        - restart
    - name: start $1 service
      shell: \rm -rf /data4/${INSTALLDIR}/$1
      tags:
        - start
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/conf state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/lib state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/bin state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/data state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/tmpdata state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/format_schemas state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/ssl state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/user_files state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/ddl state=directory mode=0755
      tags:
        - prepare
    - name: create deploy directory
      file: path=/data4/${INSTALLDIR}/$1/log state=directory mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/clickhouse-server3.service dest=/etc/systemd/system/clickhouse-server3.service owner=root group=root mode=0755
      tags:
        - prepare
    - name: rsync $1 files to remote
      copy: src=$CODESOUCE/clickhouse  dest=/data4/${INSTALLDIR}/$1/lib/clickhouse owner=root group=root mode=0755
      tags:
        - prepare
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
    - name: restart $1 service
      shell: useradd clickhouse; chown -R clickhouse:clickhouse /data4/jason/clickhouse ;chown -R clickhouse:clickhouse /data5/jason/clickhouse ;systemctl daemon-reload ;systemctl enable clickhouse-server3.service; systemctl restart clickhouse-server3;
      tags:
        - restart
EOF
	#--extra-vars "master=$1 user=$1"
	cat deploy.yaml
	ansible-playbook deploy.yaml  -i $2 -f 100  
	\rm -rf deploy.yaml
	exit

fi

