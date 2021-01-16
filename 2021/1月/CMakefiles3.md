3、接前面的例子，我们将 hello.c 生成一个库，然后再使用会怎么样？

改写一下前面的CMakeList.txt文件试试：



```bash
project(HELLO)
set(LIB_SRC hello.c)
set(APP_SRC main.c)
add_library(libhello ${LIB_SRC})
add_executable(hello ${APP_SRC})
target_link_libraries(hello libhello)
```

和前面相比，我们添加了一个新的目标 libhello，并将其链接进hello程序



**因为我的可执行程序(add_executable)占据了 hello 这个名字，所以 add_library 就不能使用这个名字了
 然后，我们去了个libhello 的名字，这将导致生成的库为 libhello.lib(或 liblibhello.a)，很不爽
 想生成 hello.lib(或libhello.a) 怎么办?**

添加一行



```bash
set_target_properties(libhello PROPERTIES OUTPUT_NAME "hello")
```

就可以了



作者：Caiaolun
链接：https://www.jianshu.com/p/cb4f8136a265
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。