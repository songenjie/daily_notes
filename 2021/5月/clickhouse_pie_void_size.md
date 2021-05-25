# How do I enable the compilation option -pie? #21177

```shell
In CMakeLists.txt，there are following compilation options by default:
set (CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -fno-pie")
set (CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO} -fno-pie")
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-no-pie")

Because I want to compile clickhouse in a more secure mode，I need to use "-fpie" or "-pie" compilation options in compiling。But if I change "-fno-pie" to "-fpie" and "-no-pie" to "-pie",I can not complie clickhouse successfully,the following is my compilation command:
cmake .. -DUSE_INTERNAL_BOOST_LIBRARY=1 -DENABLE_READLINE=1 -DCMAKE_BUILD_TYPE=Release -DENABLE_MYSQL=0 -DENABLE_DATA_SQLITE=0 -DPOCO_ENABLE_SQL_SQLITE=0 -DENABLE_JEMALLOC=ON -DENABLE_EMBEDDED_COMPILER=1 -DENABLE_PARQUET=1 -DENABLE_ORC=1 -DENABLE_PROTOBUF=1 -DENABLE_ODBC=0 -DENABLE_SSL=1 -DNO_WERROR=1 -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DUSE_INTERNAL_ODBC_LIBRARY=1 -DMAKE_STATIC_LIBRARIES=1

The following is error info:

-- Performing Test HAVE_PTRDIFF_T
-- Performing Test HAVE_PTRDIFF_T - Failed
-- Check size of void *
-- Check size of void * - failed
-- sizeof(void *) is bytes
CMake Error at contrib/zlib-ng/CMakeLists.txt:419 (message):
sizeof(void *) is neither 32 nor 64 bit

-- Configuring incomplete, errors occurred!

So how can I config my compilation options to compile clickhouse with pie enabled successfully? Thank you!
```



Member

### **[alexey-milovidov](https://github.com/alexey-milovidov)** commented [on 1 Mar](https://github.com/ClickHouse/ClickHouse/issues/21177#issuecomment-787539891)

Just remove `-fno-pie` and `-Wl,-no-pie`.

