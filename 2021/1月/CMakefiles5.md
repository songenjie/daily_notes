# 5、前面还是有一点不爽：如果想让可执行文件在 bin 目录，库文件在 lib 目录怎么办？

**一种办法：**修改顶级的 CMakeList.txt 文件



```undefined
project(HELLO)
add_subdirectory(src bin)
add_subdirectory(libhello lib)
```

不是build中的目录默认和源代码中结构一样么，我们可以指定其对应的目录在build中的名字。
 这样一来：build/src 就成了 build/bin 了，可是除了 hello.exe，中间产物也进来了。还不是我们最想要的。





**另一种方法：**不修改顶级的文件，修改其他两个文件



```bash
src/CMakeList.txt 文件
include_directories(${PROJECT_SOURCE_DIR}/libhello)
#link_directories(${PROJECT_BINARY_DIR}/lib)
set(APP_SRC main.c)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
add_executable(hello ${APP_SRC})
target_link_libraries(hello libhello)



libhello/CMakeList.txt 文件
set(LIB_SRC hello.c)
add_library(libhello ${LIB_SRC})
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
```





