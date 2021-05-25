```shell
docker run -it --name ckbuild-01  -v :/code/clickhouse  ubuntu:20.04 /bin/bash

apt-get update
apt-get install -y gcc-10 g++-10
export CC=gcc-10
export CXX=g++-10
apt-get install -y git cmake python ninja-build


cd /code/clickhouse
git submodule sync
git submodule update --init --recursive
mkdir build
cd build
cmake ..
ninja
exit
docker start liyang-ubuntu-ck




docker run -it --name clickhouse-server-01 -v /Users/songenjie/Engine/ClickHouse/docker:/Users/songenjie/Engine/ClickHouse/master -p 28000:28000 -p 28001:28001 -p 28002:28002 -p 28003:28003 -p 28004:28004 /bin/bash  --entrypoint "/ClickHouse/clickhouse server --config-file=/Users/songenjie/Engine/ClickHouse/master/conf/config1.xml --pid-file=/Users/songenjie/Engine/ClickHouse/master/01/clickhouse-server1.pid"


```





https://github.com/ClickHouse/ClickHouse/issues/17624



