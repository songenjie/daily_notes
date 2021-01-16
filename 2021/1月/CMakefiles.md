**cmake执行的流程:**



```ruby
$> ccmake directory
$> cmake directory
$> make
```

其中directory为CMakeList.txt所在目录；

1. 第一条语句用于配置编译选项，如VTK_DIR目录 ，一般这一步不需要配置，直接执行第二条语句即可，但当出现错误时，这里就需要认为配置了，这一步才真正派上用场；
2. 第二条命令用于根据CMakeLists.txt生成Makefile文件；
3. 第三条命令用于执行Makefile文件，编译程序，生成可执行文件；

> cmake的执行流程很简单，我们的重点是如何编写CMakeLists.txt文件呢，我们通过例子来学习cmake的语法。

例子从这篇文章中学习https://www.jianshu.com/p/f3da16a89f39，大致如下：

# 1、一个最简单的例子：

输出hello world



```cpp
// main.c
#include <stdio.h>
int main()
{
printf("hello world");
return 0;
}
```

CMakeLists.txt文件：



```bash
project(HELLO)
set(SRC_LIST main.c)
add_executable(hello ${SRC_LIST}))
```

就这几句，是不是很简单，由于执行cmake的时候会产生很多中间文件，我们采用out of source（外部编译）方式进行构建，我们建立一个build目录储存中间执行过程。

![img](https:////upload-images.jianshu.io/upload_images/12730381-872d5402725a9679.png?imageMogr2/auto-orient/strip|imageView2/2/w/558/format/webp)


 例子目录下的文件，进入build目录，执行cmake ..，cmake执行指向上一个目录，也就是存储CMakeLists.txt的目录，完成后就会看到makefile文件，make过后就会看到执行文件。
**第一个行project不是强制性的，最好加上，这会引入两个变量：**



```undefined
HELLO_BINARY_DIR, HELLO_SOURCE_DIR
```

**同时也会定义两个等价的变量：**



```undefined
PROJECT_BINARY_DIR, PROJECT_SOURCE_DIR
```

**外部编译要时刻区分这两个变量对应的目录:**
 可以通过message进行输出



```bash
message(${PROJECT_SOURCE_DIR})
```

**set 命令用来设置变量:**



```undefined
add_exectuable 告诉工程生成一个可执行文件。
add_library 则告诉生成一个库文件。
```

**注意：**CMakeList.txt 文件中，命令名字是不区分大小写的，而参数和变量是大小写相关的。



作者：Caiaolun
链接：https://www.jianshu.com/p/cb4f8136a265
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。