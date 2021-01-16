# 6、在例子三至五中，我们始终用的静态库，那么用动态库应该更酷一点吧。 试着写一下

如果不考虑windows下，这个例子应该是很简单的，只需要在上个例子的 libhello/CMakeList.txt 文件中的
 **add_library命令中加入一个SHARED参数：**



```bash
add_library(libhello SHARED ${LIB_SRC})
```

一下午才搞了这点东西，至于多个平台的兼顾，以后有时间再讨论。



作者：Caiaolun
链接：https://www.jianshu.com/p/cb4f8136a265
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。