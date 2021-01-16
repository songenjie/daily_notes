# 2、一个源文件的例子一似乎没什么意思，拆成3个文件再试试看：

hello.h 头文件



```cpp
#ifndef DBZHANG_HELLO_
#define DBZHANG_HELLO_


void hello(const char* name);


#endif //DBZHANG_HELLO_
```

hello.c



```cpp
#include <stdio.h>
#include "hello.h"
void hello(const char * name)
{
printf ("Hello %s!/n", name);
}
```

main.c



```cpp
#include "hello.h"
int main()
{
hello("World");
return 0;
}
```

然后准备好CMakeList.txt 文件



```swift
project(HELLO)
set(SRC_LIST main.c hello.c)
add_executable(hello ${SRC_LIST})
```

执行cmake的过程同上



作者：Caiaolun
链接：https://www.jianshu.com/p/cb4f8136a265
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。