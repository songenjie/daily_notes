# 1 developer tools

```shell
yum groupinstall "Development Tools"

yum install glibc-static libstdc++-static

```





# 2 gcc 10.2

```shell
export GCC_VERSION=10.2.0

wget https://mirrors.ustc.edu.cn/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz

tar xzvf gcc-${GCC_VERSION}.tar.gz

cd gcc-${GCC_VERSION}

vim ./contrib/download_prerequisites 将数据元 ftp -> https(这里下载可能很慢,可以搜下，后面我上传到oss)

./contrib/download_prerequisites 这里可能会有点慢 数据源问题


cd ..

mkdir gcc-${GCC_VERSION}-build

cd gcc-${GCC_VERSION}-build

../gcc-${GCC_VERSION}/configure --prefix=/usr/local/gcc10 --enable-languages=c,c++  --disable-multilib

make -j $(nproc)

make install



env 问题

rm -f /usr/bin/gcc

rm -f /usr/bin/g++

rm -f /usr/bin/gcc-10

rm -f /usr/bin/g++-10

ln -s /usr/local/gcc10/bin/gcc /usr/bin/gcc

ln -s /usr/local/gcc10/bin/gcc /usr/bin/gcc-10

ln -s /usr/local/gcc10/bin/g++ /usr/bin/g++

ln -s /usr/local/gcc10/bin/g++ /usr/bin/g++-10

export CC=gcc

export CXX=g++



g++ --version

gcc --version
```





```shell
yum install openssl openssl-devel
```





#  3 cmake

```shell
wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz

tar -zxvf cmake-3.18.0.tar.gz

cd cmake-3.18.0

./bootstrap --prefix=/usr/local

``
如果
失败
/root/cmake-3.18.0/Bootstrap.cmk/cmake: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.26' not found (required by /root/cmake-3.18.0/Bootstrap.cmk/cmake)
/root/cmake-3.18.0/Bootstrap.cmk/cmake: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by /root/cmake-3.18.0/Bootstrap.cmk/cmake)
/root/cmake-3.18.0/Bootstrap.cmk/cmake: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by /root/cmake-3.18.0/Bootstrap.cmk/cmake)

 find . -name 'libstdc++.so.6'
./root/gcc-10.2.0-build/x86_64-pc-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.6
./root/gcc-10.2.0-build/prev-x86_64-pc-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.6
./root/gcc-10.2.0-build/stage1-x86_64-pc-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.6
./usr/lib64/libstdc++.so.6
./usr/local/gcc10/lib64/libstdc++.so.6
./usr/1.2-compat/lib64/libstdc++.so.6
./usr/1.2-compat/lib/libstdc++.so.6
./usr/lib/libstdc++.so.6

 strings ./root/gcc-10.2.0-build/x86_64-pc-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.6 |grep GLIBCXX_3.4.20
 
``

make -j $(nproc)

make install

vim ~/.bash_profile

PATH=/usr/local/bin:$PATH:$HOME/bin

source ~/.bash_profile



cmake --version
```





# 4 clickhouse 20.4 稳定版

```
wget http://storage.jd.local/ssoftware/ClickHouse2.zip

unzip ClickHouse2.zip

cd ClickHouse

git checkout -f 20.4

#校验

git submodule update --init --recursive



#build 构建 与 ClickHouse 同层

mkdir ClickHouse-build

cd ClickHouse-build

cmake ../ClickHouse

make -j $(nproc)



完成
```



5.05