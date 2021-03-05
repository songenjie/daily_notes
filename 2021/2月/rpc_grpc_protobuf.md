export PROTOBUF=/usr/local/Cellar/protobuf/3.14.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${PROTOBUF}/lib/
#(静态库搜索路径) 程序编译期间查找动态链接库时指定查找共享库的路径
export LIBRARY_PATH=$LIBRARY_PATH:${PROTOBUF}/lib/
#执行程序搜索路径
export PATH=$PATH:${PROTOBUF}/bin/
#c程序头文件搜索路径
export C_INCLUDE_PATH=$C_INCLUDE_PATH:${PROTOBUF}/include/
#c++程序头文件搜索路径
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:${PROTOBUF}/include/
#pkg-config 路径
export PKG_CONFIG_PATH=${PROTOBUF}/lib/pkgconfig/





```shell
export GRPC=$HOME/.local
export PROTOBUF=/usr/local/Cellar/protobuf/3.14.0
export OPENSSL=/usr/local/opt/openssl
export PATH=$PATH:$GRPC/bin:$PROTOBUF/bin:$OPENSSL/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${PROTOBUF}/lib/:$GRPC/lib/:$OPENSSL/lib/

#(静态库搜索路径) 程序编译期间查找动态链接库时指定查找共享库的路径
export LIBRARY_PATH=$LIBRARY_PATH:${PROTOBUF}/lib/:$GRPC/lib/:$OPENSSL/lib/

#执行程序搜索路径
export PATH=$PATH:${PROTOBUF}/bin/:$GRPC/lib/:$OPENSSL/lib/

#c程序头文件搜索路径
export C_INCLUDE_PATH=$C_INCLUDE_PATH:${PROTOBUF}/include/:$GRPC/include/:$OPENSSL/include/

#c++程序头文件搜索路径
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:${PROTOBUF}/include/:$MY_INSTALL_DIR/include:$GRPC/include/:$OPENSSL/include/

#pkg-config 路径
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig:${PROTOBUF}/lib/pkgconfig/:$GRPC/lib/pkgconfig/:$OPENSSL/lib/pkgconfig/
```

