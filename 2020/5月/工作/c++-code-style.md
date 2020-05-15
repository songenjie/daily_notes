1. 大多数格式化可以用 clang-format 自动完成。

2. 缩进是4个空格。 配置开发环境，使得 TAB 代表添加四个空格。

3. 左右花括号需在单独的行。
```
inline void readBoolText(bool & x, ReadBuffer & buf)
{
    char tmp = '0';
    readChar(tmp, buf);
    x = tmp != '0';
}
```
4. 若整个方法体仅有一行 描述， 则可以放到单独的行上。 在花括号周围放置空格（除了行尾的空格）。
```
inline size_t mask() const                { return buf_size() - 1; }
inline size_t place(HashValue x) const    { return x & mask(); }
```
5. 对于函数。 不要在括号周围放置空格。
```
void reinsert(const Value & x)
memcpy(&buf[place_value], &x, sizeof(x));
```
6. 在if，for，while和其他表达式中，在开括号前面插入一个空格（与函数声明相反）。

for (size_t i = 0; i < rows; i += storage.index_granularity)
7. 在二元运算符（+，-，/％，…）和三元运算符 ?: 周围添加空格。
```
UInt16 year = (s[0] - '0') * 1000 + (s[1] - '0') * 100 + (s[2] - '0') * 10 + (s[3] - '0');
UInt8 month = (s[5] - '0') * 10 + (s[6] - '0');
UInt8 day = (s[8] - '0') * 10 + (s[9] - '0');
```

8. 若有换行，新行应该以运算符开头，并且增加对应的缩进。
```
if (elapsed_ns)
    message << " ("
        << rows_read_on_server * 1000000000 / elapsed_ns << " rows/s., "
        << bytes_read_on_server * 1000.0 / elapsed_ns << " MB/s.) ";
```
9. 如果需要，可以在一行内使用空格来对齐。
```
dst.ClickLogID         = click.LogID;
dst.ClickEventID       = click.EventID;
dst.ClickGoodEvent     = click.GoodEvent;
```
10. 不要在 .，-> 周围加入空格

如有必要，运算符可以包裹到下一行。 在这种情况下，它前面的偏移量增加。

11. 不要使用空格来分开一元运算符 (--, ++,  &, …) 和参数。

12. 在逗号后面加一个空格，而不是在之前。同样的规则也适合 for 循环中的分号。

13. 不要用空格分开 [] 运算符。

14. 在 template <...> 表达式中，在 template 和 < 中加入一个空格，在 < 后面或在 > 前面都不要有空格。
```
template <typename TKey, typename TValue>
struct AggregatedStatElement
{}
```
15. 在类和结构体中， public， private 以及 protected 同 class/struct 无需缩进，其他代码须缩进。
```
template <typename T>
class MultiVersion
{
public:
    /// Version of object for usage. shared_ptr manage lifetime of version.
    using Version = std::shared_ptr<const T>;
    ...
}
```
16. 如果对整个文件使用相同的 namespace，并且没有其他重要的东西，则 namespace 中不需要偏移量。

17. 在 if, for, while 中包裹的代码块中，若代码是一个单行的 statement，那么大括号是可选的。 可以将 statement 放到一行中。这个规则同样适用于嵌套的 if， for， while， …
```
但是如果内部 statement 包含大括号或 else，则外部块应该用大括号括起来。

/// Finish write.
for (auto & stream : streams)
    stream.second->finalize();
```
18. 行的某尾不应该包含空格。

19. 源文件应该用 UTF-8 编码。

20. 非ASCII字符可用于字符串文字。

<< ", " << (timer.elapsed() / chunks_stats.hits) << " μsec/hit.";
21 不要在一行中写入多个表达式。

22. 将函数内部的代码段分组，并将它们与不超过一行的空行分开。

23. 将 函数，类用一个或两个空行分开。

24. const 必须写在类型名称之前。
```
//correct
const char * pos
const std::string & s
//incorrect
char const * pos
```
25. 声明指针或引用时， 和 ＆ 符号两边应该都用空格分隔。
```
//correct
const char * pos
//incorrect
const char pos
const char pos
```
26. 使用模板类型时，使用 using 关键字对它们进行别名（最简单的情况除外）。
```
换句话说，模板参数仅在 using 中指定，并且不在代码中重复。

using可以在本地声明，例如在函数内部。

//correct
using FileStreams = std::map<std::string, std::shared_ptr<Stream>>;
FileStreams streams;
//incorrect
std::map<std::string, std::shared_ptr<Stream>> streams;
```
27. 不要在一个语句中声明不同类型的多个变量。
```
//incorrect
int x, y;
```
28. 不要使用C风格的类型转换。
```
//incorrect
std::cerr << (int)c <<; std::endl;
//correct
std::cerr << static_cast<int>(c) << std::endl;
```
29. 在类和结构中，组成员和函数分别在每个可见范围内。

30. 对于小类和结构，没有必要将方法声明与实现分开。
```
对于任何类或结构中的小方法也是如此。

对于模板化类和结构，不要将方法声明与实现分开（因为否则它们必须在同一个转换单元中定义）
```
31. 您可以将换行规则定在140个字符，而不是80个字符。

32. 如果不需要 postfix，请始终使用前缀增量/减量运算符。

for (Names::const_iterator it = column_names.begin(); it != column_names.end(); ++it)
