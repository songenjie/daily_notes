https://www.jianshu.com/p/36f5d3524240


## env 
export GCC_VERSION=9.2.0

## wget  
wget https://mirrors.ustc.edu.cn/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz
tar xzvf gcc-${GCC_VERSION}.tar.gz
报错啥安装啥 如：yum installl bzip2

## contrib
vim ./contrib/download_prerequisites 将数据元 ftp -> https
./contrib/download_prerequisites 这里可能会有点慢 数据源问题

## 编译
mkdir obj.gcc-${GCC_VERSION}
cd ../obj.gcc-${GCC_VERSION}
yum groupinstall "Development Tools"
yum install glibc-static libstdc++-static

../gcc-${GCC_VERSION}/configure --prefix=/usr/local/gcc9 --enable-languages=c,c++,go  --disable-multilib
注意 --prefix 就是安装目录

## make
make -j $(nproc)
make install


## 环境

ls -lrt /usr/bin/gcc

rm -f /usr/bin/gcc
rm -f /usr/bin/g++

ln -s /usr/local/gcc9/bin/gcc /usr/bin/gcc
ln -s /usr/local/gcc9/bin/gcc /usr/bin/gcc-9
ln -s /usr/local/gcc9/bin/gcc /usr/bin/CC

ln -s /usr/local/gcc9/bin/g++ /usr/bin/g++
ln -s /usr/local/gcc9/bin/g++ /usr/bin/g++-9
ln -s /usr/local/gcc9/bin/g++ /usr/bin/CXX


ln -s /usr/local/gcc9/bin/gcc^ /usr/bin/gcc^ gcc 所有软连接这里到


## lib64
通过 ls -lrt /usr/lib64/libstdc++.so.6 可以看到不是链接我们最新的libstdc++.so.6.0.26
删除
rm -f /usr/lib64/libstdc++.so.6
更新
ln -s /usr/local/gcc9/lib64/libstdc++.so.6.0.27 /usr/lib64/libstdc++.so.6

## 可以使用了

