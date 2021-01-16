# 4、在前面，我们成功地使用了库，可是源代码放在同一个路径下，还是不太正规，怎么办呢？

分开放呗，现在需要3个CMakeList.txt 文件了，每个源文件目录都需要一个，还好，每一个都不是太复杂

顶层的CMakeList.txt 文件



```undefined
project(HELLO)
add_subdirectory(src)
add_subdirectory(libhello)
```

src 中的 CMakeList.txt 文件



```bash
include_directories(${PROJECT_SOURCE_DIR}/libhello)
set(APP_SRC main.c)
add_executable(hello ${APP_SRC})
target_link_libraries(hello libhello)
```

libhello 中的 CMakeList.txt 文件



```bash
set(LIB_SRC hello.c)
add_library(libhello ${LIB_SRC})
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
```

恩，和前面一样，建立一个build目录，在其内运行cmake，然后可以得到
 build/src/hello.exe
 build/libhello/hello.lib
 回头看看，这次多了点什么，顶层的 CMakeList.txt 文件中使用 add_subdirectory 告诉cmake去子目录寻找新的CMakeList.txt 子文件
 在 src 的 CMakeList.txt 文件中，新增加了include_directories，用来指明头文件所在的路径。



作者：Caiaolun
链接：https://www.jianshu.com/p/cb4f8136a265
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。