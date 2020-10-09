\rm -rf $(ls |grep jdolap | awk '{printf"%s ",$1}')

wget http://storage.jd.local/ssoftware/jdolap-clickhouse.zip && unzip jdolap-clickhouse.zip

cd   /data0 && cd jdolap-clickhouse/Sre && /bin/bash make.sh ZookeeperInstall.sh HT0_CK_Pub_01

\rm -rf $(ls |grep jdolap | awk '{printf"%s ",$1}')

ps -ef |grep zook



cd   /data0 && \rm -rf  $(ls |grep clickhouse | grep jdolap | awk '{printf"%s ",$1}')

cd   /data0 && wget http://storage.jd.local/ssoftware/jdolap-clickhouse.zip && unzip jdolap-clickhouse.zip

cd   /data0 && cd jdolap-clickhouse/Sre && /bin/bash make.sh metrika_old_method.sh ZYX_CK_Pub_07



cd   /data0 && cd jdolap-clickhouse/Sre  && /bin/bash make.sh metrika_old_method.sh ZYX_CK_Pub_062 

cd   /data0 && cd jdolap-clickhouse/Sre &&  /bin/bash make.sh all  ZYX_CK_TS_02 && /bin/bash make.sh metrika_old_method.sh ZYX_CK_TS_02 

cd   /data0 &&  \rm -rf  $(ls |grep clickhouse | grep jdolap | awk '{printf"%s ",$1}')

cd   /data0 &&  ps -ef |grep clickhouse



./metrika_install.sh ZYX_CK_Pub_02 ZYX_CK_Pub_02_ckip ZYX_CK_Pub_02_zkip 3 51 10.199.138.11 8 



