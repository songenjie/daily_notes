

https://docs.github.com/en

# cmake 语法

参考资料[cmake教程](http://wuhongyi.cn/CodeProject/cmake/cmake教程.pdf)[CMake使用教程](http://wuhongyi.cn/CodeProject/cmake/CMake使用教程.pdf)

------

## 基本语法规则

cmake 其实仍然要使用 “cmake 语言和语法” 去构建,最简单的语法规则是:

- 变量使用${}方式取值,但是在 IF 控制语句中是直接使用变量名
- 指令(参数1 参数2 …),参数使用括弧括起,参数之间使用空格或分号分开。
- 指令是大小写无关的,参数和变量是大小写相关的。但,推荐你全部使用大写指令。

跟经典的 autotools 系列工具一样,运行:

```
make clean
```

即可对构建结果进行清理。

cmake 并不支持 make distclean,关于这一点,官方是有明确解释的:因为 CMakeLists.txt 可以执行脚本并通过脚本生成一些临时文件,但是却没有办法来跟踪这些临时文件到底是哪些。因此,没有办法提供一个可靠的 make distclean 方案。

内部构建(in-source build),外部构建(out-of-source build):强烈推荐的是外部构建

------

## ADD_DEFINITIONS

向 C/C++编译器添加-D 定义,比如:

```
ADD_DEFINITIONS(-DENABLE_DEBUG -DABC)#,参数之间用空格分割。
```

如果你的代码中定义了

```
#ifdef ENABLE_DEBUG

#endif
```

这个代码块就会生效。如果要添加其他的编译器开关,可以通过 CMAKE_C_FLAGS 变量和 CMAKE_CXX_FLAGS 变量设置。

------

## ADD_DEPENDENCIES

```
ADD_DEPENDENCIES(target-name depend-target1 depend-target2 ...)
```

定义 target 依赖的其他 target,确保在编译本 target 之前,其他的 target 已经被构建。

------

## ADD_EXECUTABLE

```
ADD_EXECUTABLE(hello ${SRC_LIST})
```

编译成可执行文件

------

## ADD_LIBRARY

```
ADD_LIBRARY(libname
	[SHARED|STATIC|MODULE]
	[EXCLUDE_FROM_ALL]
	source1 source2 ... sourceN)
```

类型有三种:

- SHARED,动态库
- STATIC,静态库
- MODULE,在使用 dyld 的系统有效,如果不支持 dyld,则被当作 SHARED 对待。

EXCLUDE_FROM_ALL 参数的意思是这个库不会被默认构建,除非有其他的组件依赖或者手工构建。

不需要写全 libhello.so,只需要填写 hello 即可,cmake 系统会自动为你生成libhello.X

同样使用上面的指令,我们在支持动态库的基础上再为工程添加一个静态库,按照一般的习惯,静态库名字跟动态库名字应该是一致的,只不过后缀是 .a 罢了。用以上方法同时构建动态库和静态库会发现静态库根本没有被构建,只生成了一个动态库。这种结果显示不是我们想要的,我们需要的是名字相同的静态库和动态库,因为 target 名称是唯一的,所以,我们肯定不能通过 ADD_LIBRARY 指令来实现了。这时候我们需要用到另外一个指令:SET_TARGET_PROPERTIES

------

## ADD_SUBDIRECTORY

```
ADD_SUBDIRECTORY(source_dir [binary_dir] [EXCLUDE_FROM_ALL])
```

这个指令用于向当前工程添加存放源文件的子目录,并可以指定中间二进制和目标二进制存放的位置。EXCLUDE_FROM_ALL 参数的含义是将这个目录从编译过程中排除,比如,工程 的 example,可能就需要工程构建完成后,再进入 example 目录单独进行构建(当然,你也可以通过定义依赖来解决此类问题)。

例如：ADD_SUBDIRECTORY(src bin) 定义了将 src 子目录加入工程,并指定编译输出(包含编译中间结果)路径为 bin 目录。如果不进行 bin 目录的指定,那么编译结果(包括中间结果)都将存放在 build/src 目录(这个目录跟原有的 src 目录对应),指定 bin 目录后,相当于在编译时将 src 重命名为 bin,所有的中间结果和目标二进制都将存放在 bin 目录。

可以通过 SET 指令重新定义 EXECUTABLE_OUTPUT_PATH 和 LIBRARY_OUTPUT_PATH 变量来指定最终的目标二进制的位置(指最终生成的 hello 或者最终的共享库,不包含编译生成的中间文件)

```
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
```

PROJECT_BINARY_DIR 变量指的编译发生的当前目录,如果是内部编译,就相当于 PROJECT_SOURCE_DIR 也就是工程代码所在目录,如果是外部编译,指的是外部编译所在目录,也就是本例中的 build 目录。所以,上面两个指令分别定义了:可执行二进制的输出路径为 build/bin 和库的输出路径为 build/lib.

------

## ADD_TEST

```
ADD_TEST(testname Exename arg1 arg2 ...)
```

testname 是自定义的 test 名称,Exename 可以是构建的目标文件也可以是外部脚本等等。后面连接传递给可执行文件的参数。如果没有在同一个 CMakeLists.txt 中打开 ENABLE_TESTING()指令,任何 ADD_TEST 都是无效的。

------

## AUX_SOURCE_DIRECTORY

```
AUX_SOURCE_DIRECTORY(dir VARIABLE)
```

作用是发现一个目录下所有的源代码文件并将列表存储在一个变量中,这个指令临时被用来 自动构建源文件列表。因为目前 cmake 还不能自动发现新添加的源文件。比如

```
AUX_SOURCE_DIRECTORY(. SRC_LIST)
ADD_EXECUTABLE(main ${SRC_LIST})
```

你也可以通过后面提到的 FOREACH 指令来处理这个 LIST

------

## CMAKE_MINIMUM_REQUIRED

```
CMAKE_MINIMUM_REQUIRED(VERSION versionNumber [FATAL_ERROR])
```

如果 cmake 版本小于设置版本,则出现严重错误,整个过程中止。

------

## ENABLE_TESTING

```
ENABLE_TESTING()
```

指令用来控制 Makefile 是否构建 test 目标,涉及工程所有目录。语法很简单,没有任何参数,一般情况这个指令放在工程的主 CMakeLists.txt 中.

------

## EXEC_PROGRAM

```
EXEC_PROGRAM(Executable [directory in which to run]
	[ARGS <arguments to executable>]
	[OUTPUT_VARIABLE <var>]
	[RETURN_VALUE <var>])
```

在 CMakeLists.txt 处理过程中执行命令,并不会在生成的 Makefile 中执行。用于在指定的目录运行某个程序,通过 ARGS 添加参数,如果要获取输出和返回值,可通过 OUTPUT_VARIABLE 和 RETURN_VALUE 分别定义两个变量。这个指令可以帮助你在 CMakeLists.txt 处理过程中支持任何命令,比如根据系统情况去修改代码文件等等。

举个简单的例子,我们要在 src 目录执行 ls 命令,并把结果和返回值存下来。可以直接在 src/CMakeLists.txt 中添加:

```
EXEC_PROGRAM(ls ARGS "*.c" OUTPUT_VARIABLE LS_OUTPUT RETURN_VALUE
LS_RVALUE)
IF(not LS_RVALUE)
MESSAGE(STATUS "ls result: " ${LS_OUTPUT})
ENDIF(not LS_RVALUE)
```

在 cmake 生成 Makefile 的过程中,就会执行 ls 命令,如果返回 0,则说明成功执行,那么就输出 ls *.c 的结果。关于 IF 语句,后面的控制指令会提到。

------

## FILE

```
FILE(WRITE filename "message to write"... )
FILE(APPEND filename "message to write"... )
FILE(READ filename variable)
FILE(GLOB variable [RELATIVE path] [globbing expressions]...)
FILE(GLOB_RECURSE variable [RELATIVE path] [globbing expressions]...)
FILE(REMOVE [directory]...)
FILE(REMOVE_RECURSE [directory]...)
FILE(MAKE_DIRECTORY [directory]...)
FILE(RELATIVE_PATH variable directory file)
FILE(TO_CMAKE_PATH path result)
FILE(TO_NATIVE_PATH path result)
```

文件操作指令

------

## FIND

```
FIND_FILE(<VAR> name1 path1 path2 ...)
## VAR 变量代表找到的文件全路径,包含文件名

FIND_LIBRARY(<VAR> name1 path1 path2 ...)
## VAR 变量表示找到的库全路径,包含库文件名

FIND_PATH(<VAR> name1 path1 path2 ...)
## VAR 变量代表包含这个文件的路径。

FIND_PROGRAM(<VAR> name1 path1 path2 ...)
## VAR 变量代表包含这个程序的全路径。

FIND_PACKAGE(<name> [major.minor] [QUIET] [NO_MODULE]
	[[REQUIRED|COMPONENTS] [componets...]])
## 用来调用预定义在 CMAKE_MODULE_PATH 下的 Find<name>.cmake 模块,你也可以自己定义 Find<name>模块,通过 SET(CMAKE_MODULE_PATH dir)将其放入工程的某个目录中供工程使用,我们在后面的章节会详细介绍 FIND_PACKAGE 的使用方法和 Find 模块的编写。
```

------

## GET_TARGET_PROPERTY

```
GET_TARGET_PROPERTY(VAR target property)
```

------

## INCLUDE

```
INCLUDE(file1 [OPTIONAL])
INCLUDE(module [OPTIONAL])
```

OPTIONAL 参数的作用是文件不存在也不会产生错误。

用来载入 CMakeLists.txt 文件,也用于载入预定义的 cmake 模块。你可以指定载入一个文件,如果定义的是一个模块,那么将在 CMAKE_MODULE_PATH 中搜索这个模块并载入。载入的内容将在处理到 INCLUDE 语句是直接执行。

------

## INCLUDE_DIRECTORIES

```
INCLUDE_DIRECTORIES([AFTER|BEFORE] [SYSTEM] dir1 dir2 ...)
```

这条指令可以用来向工程添加多个特定的头文件搜索路径,路径之间用空格分割,如果路径中包含了空格,可以使用双引号将它括起来,默认的行为是追加到当前的头文件搜索路径的后面,你可以通过两种方式来进行控制搜索路径添加的方式: 1,CMAKE_INCLUDE_DIRECTORIES_BEFORE,通过 SET 这个 cmake 变量为 on,可以将添加的头文件搜索路径放在已有路径的前面。 2,通过 AFTER 或者 BEFORE 参数,也可以控制是追加还是置前。

------

## INSTALL

目标文件的安装:

```
INSTALL(TARGETS targets...
        [[ARCHIVE|LIBRARY|RUNTIME]
		[DESTINATION <dir>]
		[PERMISSIONS permissions...]
		[CONFIGURATIONS [Debug|Release|...]]
		[COMPONENT <component>]
		[OPTIONAL]
		] [...])
```

参数中的 TARGETS 后面跟的就是我们通过 ADD_EXECUTABLE 或者 ADD_LIBRARY 定义的目标文件,可能是可执行二进制、动态库、静态库。目标类型也就相对应的有三种,ARCHIVE 特指静态库,LIBRARY 特指动态库,RUNTIME 特指可执行目标二进制。

DESTINATION 定义了安装的路径,如果路径以/开头,那么指的是绝对路径,这时候 CMAKE_INSTALL_PREFIX 其实就无效了。如果你希望使用 CMAKE_INSTALL_PREFIX 来定义安装路径,就要写成相对路径,即不要以/开头,那么安装后的路径就是 ${CMAKE_INSTALL_PREFIX}/<DESTINATION 定义的路径>

举个简单的例子:

```
INSTALL(TARGETS myrun mylib mystaticlib
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION libstatic
	)
上面的例子会将:
可执行二进制 myrun 安装到${CMAKE_INSTALL_PREFIX}/bin 目录
动态库 libmylib 安装到${CMAKE_INSTALL_PREFIX}/lib 目录
静态库 libmystaticlib 安装到${CMAKE_INSTALL_PREFIX}/libstatic 目录
特别注意的是你不需要关心 TARGETS 具体生成的路径,只需要写上 TARGETS 名称就可以了。
```

普通文件的安装:

```
INSTALL(FILES files... DESTINATION <dir>
	[PERMISSIONS permissions...]
	[CONFIGURATIONS [Debug|Release|...]]
	[COMPONENT <component>]
	[RENAME <name>] [OPTIONAL])
```

可用于安装一般文件,并可以指定访问权限,文件名是此指令所在路径下的相对路径。如果默认不定义权限 PERMISSIONS,安装后的权限为: OWNER_WRITE, OWNER_READ,GROUP_READ,和 WORLD_READ,即 644 权限。

非目标文件的可执行程序安装(比如脚本之类):

```
INSTALL(PROGRAMS files... DESTINATION <dir>
	[PERMISSIONS permissions...]
	[CONFIGURATIONS [Debug|Release|...]]
	[COMPONENT <component>]
	[RENAME <name>] [OPTIONAL])
```

跟上面的 FILES 指令使用方法一样,唯一的不同是安装后权限为: OWNER_EXECUTE, GROUP_EXECUTE, 和 WORLD_EXECUTE,即 755 权限

目录的安装:

```
INSTALL(DIRECTORY dirs... DESTINATION <dir>
	[FILE_PERMISSIONS permissions...]
	[DIRECTORY_PERMISSIONS permissions...]
	[USE_SOURCE_PERMISSIONS]
	[CONFIGURATIONS [Debug|Release|...]]
	[COMPONENT <component>]
	[[PATTERN <pattern> | REGEX <regex>]
	[EXCLUDE] [PERMISSIONS permissions...]] [...])
```

这里主要介绍其中的 DIRECTORY、PATTERN 以及 PERMISSIONS 参数。

DIRECTORY 后面连接的是所在 Source 目录的相对路径,但务必注意:abc 和 abc/有很大的区别。如果目录名不以/结尾,那么这个目录将被安装为目标路径下的 abc,如果目录名以/结尾,代表将这个目录中的内容安装到目标路径,但不包括这个目录本身。PATTERN 用于使用正则表达式进行过滤,PERMISSIONS 用于指定 PATTERN 过滤后的文件权限。

------

## LINK_DIRECTORIES

```
LINK_DIRECTORIES(directory1 directory2 ...)
```

这个指令非常简单,添加非标准的共享库搜索路径,比如,在工程内部同时存在共享库和可执行二进制,在编译时就需要指定一下这些共享库的路径。

------

## MESSAGE

```
MESSAGE([SEND_ERROR | STATUS | FATAL_ERROR] "message to display" ...)
```

这个指令用于向终端输出用户定义的信息,包含了三种类型:

- SEND_ERROR,产生错误,生成过程被跳过。
- SATUS ,输出前缀为 — 的信息。
- FATAL_ERROR,立即终止所有 cmake 过程.

------

## PROJECT

```
PROJECT(projectname [CXX] [C] [Java])
```

可以用这个指令定义工程名称,并可指定工程支持的语言,支持的语言列表是可以忽略的,默认情况表示支持所有语言。

cmake 系统也帮助我们预定义了 PROJECT_BINARY_DIR 和 PROJECT_SOURCE_DIR 变量

------

## SET

```
SET(VAR [VALUE] [CACHE TYPE DOCSTRING [FORCE]])
```

比如我们用到的是 SET(SRC_LIST main.c),如果有多个源文件,也可以定义成: SET(SRC_LIST main.c t1.c t2.c)。

------

## SET_TARGET_PROPERTIES

```
SET_TARGET_PROPERTIES(target1 target2 ...
	PROPERTIES prop1 value1 prop2 value2 ...)
```

这条指令可以用来设置输出的名称,对于动态库,还可以用来指定动态库版本和 API 版本。

以下是同时生成动态、静态库的示例：

```
ADD_LIBRARY(hello SHARED ${LIBHELLO_SRC})
ADD_LIBRARY(hello_static STATIC ${LIBHELLO_SRC})
SET_TARGET_PROPERTIES(hello_static PROPERTIES OUTPUT_NAME "hello")
GET_TARGET_PROPERTY(OUTPUT_VALUE hello_static OUTPUT_NAME)
SET_TARGET_PROPERTIES(hello PROPERTIES CLEAN_DIRECT_OUTPUT 1)
SET_TARGET_PROPERTIES(hello_static PROPERTIES CLEAN_DIRECT_OUTPUT 1)
```

------

## TARGET_LINK_LIBRARIES

```
TARGET_LINK_LIBRARIES(target library1
	<debug | optimized> library2
		...)
```

这个指令可以用来为 target 添加需要链接的共享库,本例中是一个可执行文件,但是同样可以用于为自己编写的共享库添加共享库链接。

------

## 动态库版本号

按照规则,动态库是应该包含一个版本号的,我们可以看一下系统的动态库,一般情况是:libhello.so.1.2libhello.so ->libhello.so.1libhello.so.1->libhello.so.1.2

为了实现动态库版本号,我们仍然需要使用 SET_TARGET_PROPERTIES 指令。

具体使用方法如下:

```
SET_TARGET_PROPERTIES(hello PROPERTIES VERSION 1.2 SOVERSION 1)
```

VERSION 指代动态库版本,SOVERSION 指代 API 版本。

将上述指令加入 lib/CMakeLists.txt 中,重新构建看看结果。在 build/lib 目录会生成:libhello.so.1.2libhello.so.1->libhello.so.1.2libhello.so ->libhello.so.1

------

## cmake 常用变量

```
CMAKE_BINARY_DIR
PROJECT_BINARY_DIR
<projectname>_BINARY_DIR
```

这三个变量指代的内容是一致的,如果是 in source 编译,指得就是工程顶层目录,如果是 out-of-source 编译,指的是工程编译发生的目录。

```
CMAKE_SOURCE_DIR
PROJECT_SOURCE_DIR
<projectname>_SOURCE_DIR
```

这三个变量指代的内容是一致的,不论采用何种编译方式,都是工程顶层目录。也就是在 in source 编译时,他跟 CMAKE_BINARY_DIR 等变量一致。

```
CMAKE_CURRENT_SOURCE_DIR
```

指的是当前处理的 CMakeLists.txt 所在的路径。

```
CMAKE_CURRRENT_BINARY_DIR
```

如果是 in-source 编译,它跟 CMAKE_CURRENT_SOURCE_DIR 一致,如果是 out-of-source 编译,他指的是 target 编译目录。使用我们上面提到的 ADD_SUBDIRECTORY(src bin)可以更改这个变量的值。使用 SET(EXECUTABLE_OUTPUT_PATH <新路径>)并不会对这个变量造成影响,它仅仅修改了最终目标文件存放的路径。

```
CMAKE_CURRENT_LIST_FILE
```

输出调用这个变量的 CMakeLists.txt 的完整路径

```
CMAKE_CURRENT_LIST_LINE
```

输出这个变量所在的行

```
CMAKE_MODULE_PATH
```

这个变量用来定义自己的 cmake 模块所在的路径。如果你的工程比较复杂,有可能会自己编写一些 cmake 模块,这些 cmake 模块是随你的工程发布的,为了让 cmake 在处理 CMakeLists.txt 时找到这些模块,你需要通过 SET 指令,将自己的 cmake 模块路径设置一下。 比如 SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake) 这时候你就可以通过 INCLUDE 指令来调用自己的模块了。

```
EXECUTABLE_OUTPUT_PATH
LIBRARY_OUTPUT_PATH
```

分别用来重新定义最终结果的存放目录,前面我们已经提到了这两个变量。

```
PROJECT_NAME
```

返回通过 PROJECT 指令定义的项目名称。

```
CMAKE_C_FLAGS
```

设置 C 编译选项,也可以通过指令 ADD_DEFINITIONS()添加。

```
CMAKE_CXX_FLAGS
```

设置 C++编译选项,也可以通过指令 ADD_DEFINITIONS()添加。

------

## cmake 调用环境变量

```
使用$ENV{NAME}指令就可以调用系统的环境变量了。
比如 MESSAGE(STATUS “HOME dir: $ENV{HOME}”)
设置环境变量的方式是:
SET(ENV{变量名} 值)
```

## 系统信息

- CMAKE_MAJOR_VERSION,CMAKE 主版本号,比如 2.4.6 中的 2
- CMAKE_MINOR_VERSION,CMAKE 次版本号,比如 2.4.6 中的 4
- CMAKE_PATCH_VERSION,CMAKE 补丁等级,比如 2.4.6 中的 6
- CMAKE_SYSTEM,系统名称,比如 Linux-2.6.22
- CMAKE_SYSTEM_NAME,不包含版本的系统名,比如 Linux
- CMAKE_SYSTEM_VERSION,系统版本,比如 2.6.22
- CMAKE_SYSTEM_PROCESSOR,处理器名称,比如 i686.
- UNIX,在所有的类 UNIX 平台为 TRUE,包括 OS X 和 cygwin
- WIN32,在所有的 win32 平台为 TRUE,包括 cygwin