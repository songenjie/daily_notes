```shell
cmake -DCMAKE_BUILD_TYPE=Debug -G "CodeBlocks - Unix Makefiles" /Users/songenjie/Code/olap/ClickHouse


cmake --build . --target clickhouse-server -- -j 8
```



从进度看 没有太大的改善 clickhouse server 几乎覆盖了所有的编译

```shell
root@f7fae38f8690:/ClickHouse/build-gcc-9# ninja
[0/2] Re-checking globbed directories...
[35/8590] Building C object base/glibc-compatibility/CMakeFiles/glibc-compatibility.dir/musl/utimensat.c.o
ninja: build stopped: interrupted by user.

root@f7fae38f8690:/ClickHouse/build-gcc-9# cmake --build .  --target clickhouse-server -- -j 4
[0/2] Re-checking globbed directories...
[21/8231] Building CXX object contrib/libcxxabi-cmake/CMakeFiles/cxxabi.dir/__/libcxxabi/src/cxa_virtual.cpp.o
```



https://github.com/ClickHouse/ClickHouse/issues/17624









内存不够了还

