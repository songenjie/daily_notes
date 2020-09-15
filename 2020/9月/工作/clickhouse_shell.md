\rm -rf $(ls |grep jdolap | awk '{printf"%s ",$1}')

wget http://storage.jd.local/ssoftware/jdolap-clickhouse.zip && unzip jdolap-clickhouse.zip

cd   /data0 && cd jdolap-clickhouse/Sre && /bin/bash make.sh ZookeeperInstall.sh ZYX_CK_Pub_062

\rm -rf $(ls |grep jdolap | awk '{printf"%s ",$1}')

ps -ef |grep zook



cd   /data0 && \rm -rf  $(ls |grep clickhouse | grep jdolap | awk '{printf"%s ",$1}')

cd   /data0 && wget http://storage.jd.local/ssoftware/jdolap-clickhouse.zip && unzip jdolap-clickhouse.zip

cd   /data0 && cd jdolap-clickhouse/Sre && /bin/bash make.sh all ZYX_CK_Pub_061 && /bin/bash make.sh metrika_old_method.sh ZYX_CK_Pub_061 

cd   /data0 &&  \rm -rf  $(ls |grep clickhouse | grep jdolap | awk '{printf"%s ",$1}')

cd   /data0 &&  ps -ef |grep clickhouse





