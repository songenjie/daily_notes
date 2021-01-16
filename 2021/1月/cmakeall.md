sample |——Demo  （盛放可执行程序binary directory）

    |——CMakeLists.txt 
    
    （内容为：include_directories                                                                                                      (${HELLO_SOURCE_DIR}/Hello                                                                                                    #确认compiler能在Hello 库中找到它include的库
    
    
    link_directories (${HELLO_BINARY_DIR}/Hello)                                                                          #确认一旦built时，linker能找到Hello库
    
    
    add_executable (helloDemo demo.cxx demo_b.cxx)                                                                  
    #可执行文件叫做helloDemo,它的源码文件是"demo.cxx" 和"demo_b.cxx"
    
    
    target_link_libraries (helloDemo Hello)                                                                                          #link可执行文件helloDemo 到Hello lib
    
    
    
                | ——Hello  (盛放源代码source directory)
    
                            |——CMakeLists.txt （内容为：add_library (Hello hello.cxx)                                                                                              #创建Hello 库,源文件为hello.cxx）                      
    
                |——CMakeLists.txt  (内容为：project (HELLO) #工程名
    
    
    add_subdirectory (Hello) 
    # 子目录，路径为  ${HELLO_SOURCE_DIR}）
    
    
    add_subdirectory (Demo) #子目录 ，路径为                                                                                ${HELLO_BINARY_DIR}   )





## 例子一

用 cmake 来构建一个经典的 C++ 程序：

```
//main.cpp
#include <iostream>
int main()
{
    std::cout<<"Hello World!"<<std::endl;
    return 0;
}
```

编写一个 CMakeList.txt 文件(可看做cmake的工程文件)：

```
project(HELLO)
set(CODE_LIST main.cpp)
add_executable(hello ${CODE_LIST})
```

然后，建立一个任意目录（习惯在本目录下创建一个 build 子目录），在该 build 目录下调用 cmake

**注意：为了简单起见，我们从一开始就采用cmake的 out-of-source 方式来构建（即生成中间产物与源代码分离），并始终坚持这种方法，这也就是此处为什么单独创建一个目录，然后在该目录下执行 cmake 的原因。**

```
cmake ..
make 
```

即可生成可执行程序 hello。 **目录结构：**

```
+
| 
+--- main.cpp
+--- CMakeList.txt
|
/--+ build/
   |
   +--- hello
```

### CMakeList.txt

第一行 project 不是强制性的，但最好始终都加上。这一行会引入两个变量：

HELLO_BINARY_DIR 和 HELLO_SOURCE_DIR

同时，cmake自动定义了两个等价的变量：

PROJECT_BINARY_DIR 和 PROJECT_SOURCE_DIR

因为是 out-of-source 方式构建，所以我们要时刻区分这两个变量对应的目录

可以通过 message 来输出变量的值：

```
message(${PROJECT_SOURCE_DIR})
```

- set 命令用来设置变量
- add_exectuable 告诉工程生成一个可执行文件。
- add_library 则告诉生成一个库文件。 **注意：CMakeList.txt 文件中，命令名字是不区分大小写的，而参数和变量是大小写相关的。**

### cmake命令

cmake 命令后跟一个路径(..)，用来指出 CMakeList.txt 所在的位置。由于系统中可能有多套构建环境，我们可以通过 -G 来制定生成哪种工程文件，通过 cmake -h 可得到详细信息。

要显示执行构建过程中详细的信息(比如为了得到更详细的出错信息)，可以在 CMakeList.txt 内加入：

```
SET( CMAKE_VERBOSE_MAKEFILE on )
```

或者执行 make 时

```
$ make VERBOSE=1
```

或者

```
$ export VERBOSE=1
$ make
```

对单一文件 cmake 可能看不出其无比优越性，那就继续往下呗。

------

## 例子二

一个源文件的例子一似乎没什么意思，拆成 3 个文件再试试看：

- hello.h 头文件

```
#ifndef _HELLO_
#define _HELLO_
void hello(const char* name);
#endif //_HELLO_
```

- hello.cpp

```
#include <stdio.h>
#include "hello.h"
void hello(const char * name)
{
    printf ("Hello %s!/n", name);
}
```

- main.cpp

```
#include "hello.h"
int main()
{
    hello("World");
    return 0;
}
```

- 准备好 CMakeList.txt 文件

```
project(HELLO)
set(CODE_LIST main.cpp hello.cpp)
add_executable(hello ${CODE_LIST})
```

执行 cmake 的过程同上， **目录结构**

```
+
| 
+--- main.cpp
+--- hello.h
+--- hello.cpp
+--- CMakeList.txt
|
/--+ build/
   |
   +--- hello
```

------

## 例子三

如果先将 helio.cpp 生成一个库，然后再使用呢? 修改一下前面的 CMakeList.txt 文件试试：

```
project(HELLO)
set(LIB_SRC hello.cpp)
set(APP_SRC main.cpp)
add_library(libhello ${LIB_SRC})
add_executable(hello ${APP_SRC})
target_link_libraries(hello libhello)
```

和前面相比，我们添加了一个新的目标 libhello，并将其链接进 hello 程序。 同前面一样运行 cmake，结果： **目录结构**

```
+
| 
+--- main.cpp
+--- hello.h
+--- hello.cpp
+--- CMakeList.txt
|
/--+ build/
   |
   +--- hello
   +--- liblibhello.so
```

因为我的可执行程序(add_executable)占据了 hello 这个名字，所以 add_library 就不能使用这个名字了，所以，我们才取了个 libhello 的名字，这将导致生成的库为 liblibhello.so(或 liblibhello.a)，很不爽，想生成 hello.so(或hello.a) 怎么办? 添加一行：

```
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
```

------

## 例子四

在前面，我们成功地使用了库，可是源代码放在同一个路径下，不大规范，于是下面就是分开放了。 我们想要以下这样一种结构：

```
+
|
+--- CMakeList.txt
+--+ src/
|  |
|  +--- main.cpp
|  /--- CMakeList.txt
|
+--+ libhello/
|  |
|  +--- hello.h
|  +--- hello.cpp
|  /--- CMakeList.txt
|
/--+ build/
```

现在需要 3 个 CMakeList.txt 文件了，每个源文件目录都需要一个，每一个都不是太复杂。

- 顶层的CMakeList.txt 文件

```
project(HELLO)
add_subdirectory(src)
add_subdirectory(libhello)
```

- src 中的 CMakeList.txt 文件

```
include_directories(${PROJECT_SOURCE_DIR}/libhello)
set(APP_SRC main.cpp)
add_executable(hello ${APP_SRC})
target_link_libraries(hello libhello)
```

- libhello 中的 CMakeList.txt 文件

```
set(LIB_SRC hello.cpp)
add_library(libhello ${LIB_SRC})
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
```

和前面一样，建立一个 build 目录，在其内运行 cmake，然后可以得到 - build/src/hello - build/libhello/hello.so 顶层的 CMakeList.txt 文件中使用 add_subdirectory 告诉 cmake 去子目录寻找新的 CMakeList.txt 子文件。在 src 的 CMakeList.txt 文件中，新增加了include_directories，用来指明头文件所在的路径。

------

## 例子五

前面还是有一点不爽：如果想让可执行文件在 bin 目录，库文件在 lib 目录怎么办？ 想要以下的目录结构：

```
   + build/
   |
   +--+ bin/
   |  |
   |  /--- hello.exe
   |
   /--+ lib/
      |
      /--- hello.lib
```

- 一种办法：修改顶级的 CMakeList.txt 文件

```
project(HELLO)
add_subdirectory(src bin)
add_subdirectory(libhello lib)
```

这样一来：build/src 就成了 build/bin 了，可是除了 hello，中间产物也进来了。还不是我们最想要的。

- 另一种方法：不修改顶级的文件，修改其他两个文件

  - src/CMakeList.txt 文件

  ```
  include_directories(${PROJECT_SOURCE_DIR}/libhello)
  #link_directories(${PROJECT_BINARY_DIR}/lib)
  set(APP_SRC main.cpp)
  set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
  add_executable(hello ${APP_SRC})
  target_link_libraries(hello libhello)
  ```

  - libhello/CMakeList.txt 文件

  ```
  set(LIB_SRC hello.cpp)
  add_library(libhello ${LIB_SRC})
  set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
  set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
  ```