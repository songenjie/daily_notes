```mysql
ABS(N)
　返回N的绝对值
mysql> select ABS(2);
　　-> 2
mysql> select ABS(-32);
　　-> 32

SIGN(N)
　返回参数的符号(为-1、0或1)
mysql> select SIGN(-32);
　　-> -1
mysql> select SIGN(0);
　　-> 0
mysql> select SIGN(234);
　　-> 1
MOD(N,M)
　取模运算,返回N被M除的余数(同%操作符)
mysql> select MOD(234, 10);
　　-> 4
mysql> select 234 % 10;
　　-> 4
mysql> select MOD(29,9);
　　-> 2
FLOOR(N)
　返回不大于N的最大整数值
mysql> select FLOOR(1.23);
　　-> 1
mysql> select FLOOR(-1.23);
　　-> -2
CEILING(N)
　返回不小于N的最小整数值
mysql> select CEILING(1.23);
　　-> 2
mysql> select CEILING(-1.23);
　　-> -1
ROUND(N,D)
　返回N的四舍五入值,保留D位小数(D的默认值为0)
mysql> select ROUND(-1.23);
　　-> -1
mysql> select ROUND(-1.58);
　　-> -2
mysql> select ROUND(1.58);
　　-> 2
mysql> select ROUND(1.298, 1);
　　-> 1.3
mysql> select ROUND(1.298, 0);
　　-> 1
EXP(N)
　返回值e的N次方(自然对数的底)
mysql> select EXP(2);
　　-> 7.389056
mysql> select EXP(-2);
　　-> 0.135335
LOG(N)
　返回N的自然对数
mysql> select LOG(2);
　　-> 0.693147
mysql> select LOG(-2);
　　-> NULL
LOG10(N)
　返回N以10为底的对数
mysql> select LOG10(2);
　　-> 0.301030
mysql> select LOG10(100);
　　-> 2.000000
mysql> select LOG10(-100);
　　-> NULL
POW(X,Y)
POWER(X,Y)
　返回值X的Y次幂
mysql> select POW(2,2);
　　-> 4.000000
mysql> select POW(2,-2);
　　-> 0.250000
SQRT(N)
　返回非负数N的平方根
mysql> select SQRT(4);
　　-> 2.000000
mysql> select SQRT(20);
　　-> 4.472136
PI()
　返回圆周率
mysql> select PI();
　　-> 3.141593
COS(N)
　返回N的余弦值
mysql> select COS(PI());
　　-> -1.000000
SIN(N)
　返回N的正弦值
mysql> select SIN(PI());
　　-> 0.000000
TAN(N)
　返回N的正切值
mysql> select TAN(PI() 1);
　　-> 1.557408
ACOS(N)
　返回N反余弦(N是余弦值,在-1到1的范围,否则返回NULL)
mysql> select ACOS(1);
　　-> 0.000000
mysql> select ACOS(1.0001);
　　-> NULL
mysql> select ACOS(0);
　　-> 1.570796
ASIN(N)
　返回N反正弦值
mysql> select ASIN(0.2);
　　-> 0.201358
mysql> select ASIN('foo');
　　-> 0.000000
ATAN(N)
　返回N的反正切值
mysql> select ATAN(2);
　　-> 1.107149
mysql> select ATAN(-2);
　　-> -1.107149
ATAN2(X,Y)
　返回2个变量X和Y的反正切(类似Y/X的反正切,符号决定象限)
mysql> select ATAN(-2,2);
　　-> -0.785398
mysql> select ATAN(PI(),0);
　　-> 1.570796
COT(N)
　返回X的余切
mysql> select COT(12);
　　-> -1.57267341
mysql> select COT(0);
　　-> NULL
RAND()
RAND(N)
　返回在范围0到1.0内的随机浮点值(可以使用数字N作为初始值)
mysql> select RAND();
　　-> 0.5925
mysql> select RAND(20);
　　-> 0.1811
mysql> select RAND(20);
　　-> 0.1811
mysql> select RAND();
　　-> 0.2079
mysql> select RAND();
　　-> 0.7888
DEGREES(N)
　把N从弧度变换为角度并返回
mysql> select DEGREES(PI());
　　-> 180.000000
RADIANS(N)
　把N从角度变换为弧度并返回
mysql> select RADIANS(90);
　　-> 1.570796
TRUNCATE(N,D)
　保留数字N的D位小数并返回
mysql> select TRUNCATE(1.223,1);
　　-> 1.2
mysql> select TRUNCATE(1.999,1);
　　-> 1.9
mysql> select TRUNCATE(1.999,0);
　　-> 1
LEAST(X,Y,...)
　返回最小值(如果返回值被用在整数(实数或大小敏感字串)上下文或所有参数都是整数(实数或大小敏感字串)则他们作为整数(实数或大小敏感字串)比较,否则按忽略大小写的字符串被比较)
mysql> select LEAST(2,0);
　　-> 0
mysql> select LEAST(34.0,3.0,5.0,767.0);
　　-> 3.0
mysql> select LEAST("B","A","C");
　　-> "A"
GREATEST(X,Y,...)
　返回最大值(其余同LEAST())
mysql> select GREATEST(2,0);
　　-> 2
mysql> select GREATEST(34.0,3.0,5.0,767.0);
　　-> 767.0
mysql> select GREATEST("B","A","C");
　　-> "C"
```

