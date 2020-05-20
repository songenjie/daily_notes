Click Housebuild on Centos 7.
## 提示 个人 20.4 开始就报错 使用当前版本的master编译通过

## clone 

1. git clone --recursive https://github.com/ClickHouse/ClickHouse.git  注意网络问题 ssh 和 http

或者
2. git clone  https://github.com/ClickHouse/ClickHouse.git  注意网络问题 ssh 和 http
- cd clickhouse
git submodule update --init --recursive




## 依赖环境解决
1. 官方提示
sudo yum update
yum --nogpg install git cmake make gcc-c++ python2

2. Cmake 3.8 安装
可以去 Cmake 下学习安装

3. gcc g++ 9.2
可以去 gcc 下学习安装




## build 

建议新建同层ClickHouse 目录
mkdir obj.ClickHouse
cmake ../ClickHouse
如果机器 gpu 没有
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_OPENCL=OFF -D WITH_CUDA=OFF -D BUILD_opencv_gpu=OFF -D BUILD_opencv_nonfree=OFF -D BUILD_opencv_stitching=OFF -D BUILD_opencv_superres=OFF ../ClickHouse
-DCMAKE_INSTALL_PREFIX=/usr -DGLIBC_COMPATIBILITY=OFF -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo 
-DGLIBC_COMPATIBILITY=OFF


https://github.com/ClickHouse/ClickHouse/issues/5043

make -j $(nproc)


