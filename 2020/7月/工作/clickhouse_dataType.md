# 三.Clickhouse 数据类型及数据类型转换(clichouse 极简教程系列)

clickhouse数据类型比较丰富
基本类型分为:

### 1.整形

```
UInt8, UInt16, UInt32, UInt64, Int8, Int16, Int32, Int64
```

U开头的表示无符号类型,表示范围从0开始,后面的数字表示 位数(bit) 表示范围为 0到2^N-1
U开头: 非U开头: -2^N/2 到 (2^N)/2-1

例如 int8 表示 8位 表示范围为 -128 到 127
​ Uint8因为表示范围 0-255

### **2,枚举类型**

A.枚举类型实际是整形的一个变种,通过映射map进行转换,map的key值进行排序.

B.枚举类型在排序(ORDER BY)时候特别注意,它不会按内容来排序,而是按枚举的数字key

目前有两个:

**Enum8 和 Enum16**

*其对应的是int8 和 int16*

例如:

```
Enum8('hello' = 1, 'world' = 2)
```

这里特别说明一下,Enum是使用有符号的整形进行映射,因此负数也是可以的,例如:

```
Enum8('test'=-1)
```

### 3.**字符串**

#### **1.FixedString(N)** 定字符串,类似CHAR

A.N是最大字节数(Byte),不是字符长度,如果是UTF8字符串,那么就会占用3字节,GBK会占用2字节.

B.当内容少于N,数据库会自动在右填充空字节(null byte)(跟PGsql不一样,PGsql填充的是空格),当内容大于N时候,会抛出错误.

C.当写入内容后面后空字节,系统不会自动去裁剪,查询的时候也会被输出(mysql不会输出)

D.查询时候,它会把添加的空字符串一同输出

E.**FixedString(N)比String** 支持更少的方法

#### 2.**String** ️无限长字符串

可以用来替换 VARCHAR ,BLOB,CLOB 等数据类型

**PS**:clickhouse`没有编码的概念`,字符串存储时候就是以字节流方式存放.如果是存放文本,建议使用UTF-8,使用过程只要客户端也是使用UTF-8那么就无需转码.而一些函数,例如lengthUTF8只会在内容是UTF8时候返回才是对的.

\###4 Boolean

不好意思,clickhouse没有这个数据类型,你可以用 int8来替代(个人感觉有点浪费)

### 5.时间类型DateTime

DateTime实际存储时候是Unsigned 4个字节的整数Unix时间戳.

A.因为是Unsigned的整形,因此不能支持1970年1月1日（UTC/GMT的午夜）以前的时间.

B.时区会影响输入和输出.请使–use_client_time_zone 进行切换时区,服务端启动时候最好使用TZ=X来保证时区

**Date两字节存储的时间戳,最多到2038年**

### 6.Array(T) 数组类型,

T是一个基本类型,包括array在内.

Clickhouse`不建议使用多维数组`,因为MergeTree系列引擎不能很好支持多维数组

### 7,**Tuple 元数组**

A可以认为是一种不能变的单维数组

B不能被内存表以外的引擎存储,一般用于临时数据,特别是in查询的时候用.

### 8.结构:Nested(Name1 Type1, Name2 Type2, …)

#### 类似于一种Map的格式.声明引擎的时候要明确声明结构格式.详细看引擎的介绍种的AggregatingMergeTree

例如:

```
CREATE TABLE test.visits(

    CounterID UInt32,

    StartDate Date,

    Sign Int8,

    IsNew UInt8,

    VisitID UInt64,

    UserID UInt64,

    ...

    Goals Nested

    (

        ID UInt32,

        Serial UInt32,

        EventTime DateTime,

        Price Int64,

        OrderID String,

        CurrencyID UInt32

    ),

    ...) ENGINE = CollapsingMergeTree(StartDate, intHash32(UserID), (CounterID, StartDate, intHash32(UserID), VisitID), 8192, Sign)
```

2.统计函数
支持使用统计函数作为数据类型,有点像PGSQL,需要启动时候加参数开启,需要用AggregatingMergeTree引擎,也用得比较少,这里要讲就会很长了,所以->_>详情请看官方文档.