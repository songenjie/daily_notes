# 1 developer tools

```
yum groupinstall "Development Tools"

yum install glibc-static libstdc++-static

```





# 2 gcc 9.2

```
export GCC_VERSION=9.2.0

wget https://mirrors.ustc.edu.cn/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz

tar xzvf gcc-${GCC_VERSION}.tar.gz

vim ./contrib/download_prerequisites 将数据元 ftp -> https(这里下载可能很慢,可以搜下，后面我上传到oss)

./contrib/download_prerequisites 这里可能会有点慢 数据源问题



构建build 目录，个人习惯和代码同级别，隔离

mkdir gcc-${GCC_VERSION}-build

cd gcc-${GCC_VERSION}-build

../gcc-${GCC_VERSION}/configure --prefix=/usr/local/gcc9 --enable-languages=c,c++  --disable-multilib

make -j $(nproc)

make install



env 问题

rm -f /usr/bin/gcc

rm -f /usr/bin/g++

ln -s /usr/local/gcc9/bin/gcc /usr/bin/gcc

ln -s /usr/local/gcc9/bin/gcc /usr/bin/gcc-9

ln -s /usr/local/gcc9/bin/g++ /usr/bin/g++

ln -s /usr/local/gcc9/bin/g++ /usr/bin/g++-9



export CC=gcc

export CXX=g++



g++ --version

gcc --version
```



#  3 cmake

```
wget https://cmake.org/files/v3.12/cmake-3.12.0.tar.gz

tar -zxvf cmake-3.12.0.tar.gz

cd cmake-3.12.0

./bootstrap --prefix=/usr/local

make

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

