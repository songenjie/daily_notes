```shell
docker run -it --name ck -v :/code/clickhouse  ubuntu:20.04 /bin/bash

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
```





https://github.com/ClickHouse/ClickHouse/issues/17624



