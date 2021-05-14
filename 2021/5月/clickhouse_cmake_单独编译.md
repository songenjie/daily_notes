```shell
cmake -DCMAKE_BUILD_TYPE=Debug -G "CodeBlocks - Unix Makefiles" /Users/songenjie/Code/olap/ClickHouse


cmake --build . --target clickhouse-server -- -j 8
```