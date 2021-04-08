ninja是一个小型构建系统，专注于速度，和常用的make类似，有一些软件就是基于ninja编译构建的，比如clickhouse数据库就需要依赖ninja，因为最近在研究clickhouse，需要依赖于gcc 7，gtest，ninja等一些组件，所以单独拿出来这些组件记录安装过程，这样会更清晰一些.
 [https://ninja-build.org/](https://links.jianshu.com/go?to=https%3A%2F%2Fninja-build.org%2F)

![img](https:////upload-images.jianshu.io/upload_images/2333435-35cabfb653ecb05e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1130/format/webp)

ninja需要依赖于re2c，否则编译是会报错，re2c是一款语法分析器，官网地址是：[http://re2c.org/](https://links.jianshu.com/go?to=http%3A%2F%2Fre2c.org%2F)
 下载页面的安装说明都在：[http://re2c.org/install/install.html](https://links.jianshu.com/go?to=http%3A%2F%2Fre2c.org%2Finstall%2Finstall.html)，这里直接从源码安装最新版本

安装re2c：



```go
yum install autoconf
git clone https://github.com/skvadrik/re2c
cd re2c
./autogen.sh 
./configure make
make install
```

以上如果没有报错的话安装完毕了，因为re2c作为基础依赖，所以这里采用默认安装，上面的安装说明页面也给出了详细的安装细节.

然后可以安装ninja了，ninja官网地址：[https://ninja-build.org/](https://links.jianshu.com/go?to=https%3A%2F%2Fninja-build.org%2F)，github仓库地址：[https://github.com/ninja-build/ninja](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fninja-build%2Fninja)，可以从github仓库克隆项目切换到release分支或者下载release包安装过程如下：



```bash
git clone https://github.com/ninja-build/ninja.git
cd ninja
```

github上有提供以下两种安装的命令：

![img](https:////upload-images.jianshu.io/upload_images/2333435-1b75f110e71da306.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)



这里我们采用python的安装方式，较为方便



```undefined
./configure.py --bootstrap
```

等待完成即可



```bash
现在可以执行 ./configure.py --help 查看帮助，直接执行 ./configure.py --bootstrap 进行编译，编译完成之后，当前目录下会有ninja的可执行文件，执行 ./ninja -h 可以查看帮助
```

ninja比较精简，只需要一个可执行文件即可，现在可以做软链或者复制到/usr/bin下面就可以直接调用了，比如：



```undefined
cp ninja /usr/bin/ 
```

然后可以直接使用 ninja 命令，这样就安装好了.



作者：SYfarming
链接：https://www.jianshu.com/p/a9ee026d9c88
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。