linux系统中，可以利用grep查看指定的内容，
比如：grep “123” test.log //查看test.log中包含123字符的日志

如果想查看指定内容上下几行，可以用参考下面的用法：

**$grep -10 ‘123’ test.log//打印匹配行的前后10行**
或
**$grep -C 10 ‘123’ test.log//打印匹配行的前后10行**
或
**$ grep -A 10 -B 10 ‘123’ test.log //打印匹配行的前后10行**

**$grep -A 10 ‘123’ test.log //打印匹配行的后10行**

**$grep -B 10 ‘123’ test.log//打印匹配行的前10行**

其他例子：
//显示既匹配 ‘123’又匹配 ‘456’的行
grep ‘123’ test.log| grep ‘456’

//搜索test.log中满足123的内容的行号
grep -n ‘123’ test.log

//查看test.log指定行号后的内容，比如50行
tail -n +50 test.log

//查看test.log的第50行到100行
sed -n ‘50,100p’ test.log#记得p字母



grep -E ' | ' 