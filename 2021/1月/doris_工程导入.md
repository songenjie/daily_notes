# 安装虚拟机系统

装一个vmware软件，安装一个linux系统，我使用的是ubuntu16.04（不要装virtualbox mac上图形界面支持的不好，不流畅）。装的时候磁盘给大一些，我最初用的20g，很快就不够用了，自己又扩展了90g。

然后安装jdk,maven以及ide。



------

# 工程编译

# **方案1**

本地搭建可编译环境，等同于虚拟机进行编译。

在编译过程中主要是依赖库的安装，这个在编译中会体现，到时候缺什么安装什么。

在工程目录下执行build.sh进行编译

# **方案2**

编译直接用他的镜像，节省时间。**（我虽然没用这个，后来反思这个方式应该更快**）。









我自己的使用是编译和debug分离。

主要考虑是他自身有编译脚本。不用自己再去处理，需要注意的地方就是更新介质。



编译可以debug的be需要加一个环境变量去编译。

**export BUILD_TYPE=Debug**

如果不加这个，默认是release。debug的时候会出现变量被优化的情况。

------

# 部署

fe

fe默认配置文件我都没有修改，只要创建一个目录 fe/palo-meta/



启动fe

fe/bin/start_fe.sh --daemon



be

修改be/conf/be.conf中的storage_root_path

启动be

be/bin/start_be.sh --daemon









------

# 编译更新



编译后更新介质不需要完全重新部署。可以只替换部分重启即可，不丢数据。

**updatebe.sh**

\#!/bin/bash
/home/xie/workspace/output/be/bin/stop_be.sh
rm /home/xie/workspace/output/be/lib/meta_tool

rm /home/xie/workspace/output/be/lib/palo_be

cp /home/xie/workspace/codes/jdolap-engine/be/output/lib/meta_tool /home/xie/workspace/output/be/lib/
cp /home/xie/workspace/codes/jdolap-engine/be/output/lib/palo_be /home/xie/workspace/output/be/lib/
/home/xie/workspace/output/be/bin/start_be.sh --daemon

**updatefe.sh**

/home/xie/workspace/output/fe/bin/stop_fe.sh

cp /home/xie/workspace/codes/jdolap-engine/fe/target/palo-fe.jar /home/xie/workspace/output/fe/lib

/home/xie/workspace/output/fe/bin/start_fe.sh --daemon



------





***fe导入***

***
\***

支持maven工程的都可以，下面用idea为例。

file→open

目录选择到jdolap-engine/fe打开



***fe debug***

在启动的脚本start_fe.sh里加入

-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1900

**其中1900是debug端口，可以修改。**



使用idea的remote debug功能进行调试



![img](https://cf.jd.com/download/attachments/231477263/image2019-11-12_18-22-53.png?version=1&modificationDate=1573555913000&api=v2)



------

**
**

**be导入**

**
**

**clion为例**

把be的代码做一个软连接到一个自己的目录

file→new cmake project from source

在工程中打开Cmakelists.txt

用include_directories加入第三方的头文件，例如下面是我的路径（这里需要根据识别的头文件来看，有些情况识别不了就和我一样多加几个）

include_directories(/home/xie/workspace/codes/jdolap-engine/thirdparty/installed/include)

include_directories(/home/xie/workspace/codes/jdolap-engine/be/src)

include_directories(/home/xie/workspace/codes/jdolap-engine/gensrc/build)

直接用clion attach进程即可。

**（网上有用vscode debug的。我亲测可用，只是他debug功能的友好程度不高，vscode的工程比较简单。）**