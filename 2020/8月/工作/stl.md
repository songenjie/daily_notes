#### 介绍一下STL

Standard Template Library，标准模板库，是C++的标准库之一，一套基于模板的容器类库，还包括许多常用的算法，提高了程序开发和复用，有相同的接口，利用使用和阅读。
 **基本组件**
 容器（container）、迭代器（iterator）、函数对象（function object）、算法（algorithm）。在STL里，我们用容器来装东西（数据内容），用迭代器来访问他们，将他们传送到使用到的算法里，而算法的调用在函数对象里完成的。
 **容器**：容纳、包含一组元素的对象。顺序容器顺序访问、随机访问其中的元素；关联容器通过*优化关键值*访问。
 **迭代器**：提供一种顺序访问容器中每个元素的方法。

![img](https:////upload-images.jianshu.io/upload_images/12986350-a7515d03280cfeda.png?imageMogr2/auto-orient/strip|imageView2/2/w/532/format/webp)

迭代器分类


**函数对象**
 函数对象是一个行为类似函数的对象，对它可以向调用函数一样调用。
 任何普通的函数和任何重载了()运算符的类的对象都可以作为函数对象使用，函数对象是泛化的函数。
**算法**
 STL包括70多个算法，包括查找算法、排序算法、消除算法、计数算法、比较算法、变换算法、置换算法和容器管理等。使用STL的算法，需要包含头文件<algorithm>。
**六大组件简单介绍**



1. 空间配置器：内存池实现小块内存分配,对应到设计模式--单例模式（工具类，提供服务，一个程序只需要一个空间配置器即可），享元模式（小块内存统一由内存池进行管理）
    2.迭代器：迭代器模式，模板方法
    3.容器：STL的核心之一，其他组件围绕容器进行工作：迭代器提供访问方式，空间配置器提供容器内存分配，算法对容器中数据进行处理，仿函数伪算法提供具体的策略，类型萃取　　实现对自定义类型内部类型提取。保证算法覆盖性。其中涉及到的设计模式：组合模式（树形结构），门面模式（外部接口提供），适配器模式（stack，queue通过deque适配得到），建造者模式（不同类型树的建立过程）。
    4.类型萃取：基于范型编程的内部类型解析，通过typename获取。可以获取迭代器内部类型value_type,Poter,Reference等。
    5.仿函数：一种类似于函数指针的可回调机制，用于算法中的决策处理。涉及：策略模式，模板方法。
    6适配器：STL中的stack，queue通过双端队列deque适配实现，map，set通过RB-Tree适配实现。涉及适配器模式。

------

#### 泛型程序设计

概念：不依赖于具体数据类型的设计。
 将算法从特定的数据结构中抽离出来，C++的模板是它的关键基础。

------

#### 选择容器准则

Level 1 - 仅仅作为Map使用:采用静态数组
 Level 2 - 保存定长数据，使用时也是全部遍历:采用动态数组(长度一开始就固定的话静态数组也行)
 Level 3 - 保存不定长数组，需要动态增加的能力，侧重于寻找数据的速度:采用vector
 Level 3 - 保存不定长数组，需要动态增加的能力，侧重于增加删除数据的速度:采用list
 Level 4 - 对数据有复杂操作，即需要前后增删数据的能力，又要良好的数据访问速度:采用deque
 Level 5 - 对数据中间的增删操作比较多:采用list，建议在排序的基础上，批量进行增删可以对运行效率提供最大的保证
 Level 6 - 上述中找不到适合的:组合STL容器或者自己建立特殊的数据结构来实现

------

#### C++ STL 的实现：

1.vector：  底层数据结构为数组 ，支持快速随机访问。
 2.list：    底层数据结构为双向链表，支持快速增删。
 3.deque：  底层数据结构为一个中央控制器和多个缓冲区，详细见STL源码剖析P146，支持首尾（中间不能）快速增删，也支持随机访问。
 4.stack ：  底层一般用23实现，封闭头部即可，不用vector的原因应该是容量大小有限制，扩容耗时
 5.queue：   底层一般用23实现，封闭头部即可，不用vector的原因应该是容量大小有限制，扩容耗时（stack和queue其实是适配器,而不叫容器，因为是对容器的再封装）
 6.priority_queue： 的底层数据结构一般为vector为底层容器，堆heap为处理规则来管理底层容器实现
 7.set：  底层数据结构为红黑树，有序，不重复。
 8.multiset： 底层数据结构为红黑树，有序，可重复。
 9.map：      底层数据结构为红黑树，有序，不重复。
 10.multimap： 底层数据结构为红黑树，有序，可重复。
 11.hash_set： 底层数据结构为hash表，无序，不重复。
 12.hash_multiset： 底层数据结构为hash表，无序，可重复 。
 13.hash_map ：     底层数据结构为hash表，无序，不重复。
 14.hash_multimap： 底层数据结构为hash表，无序，可重复。

------

#### 顺序容器

**std::vector的底层（存储）机制**
 vector就是一个动态数组，里面有一个指针指向一片连续的内存空间，当空间不够装下数据时，会自动申请另一片更大的空间（一般是增加当前容量的50%或100%），然后把原来的数据拷贝过去，接着释放原来的那片空间；当释放或者删除里面的数据时，其存储空间不释放，仅仅是清空了里面的数据。
 **std::vector的自增长机制**
 当已经分配的空间不够装下数据时，分配双倍于当前容量的存储区，把当前的值拷贝到新分配的内存中，并释放原来的内存。
 **说说std::list的底层（存储）机制**
 以结点为单位存放数据，结点的地址在内存中不一定连续，每次插入或删除一个元素，就配置或释放一个元素空间
 **什么情况下用vector，什么情况下用list**
 vector可以随机存储元素（即可以通过公式直接计算出元素地址，而不需要挨个查找），但在非尾部插入删除数据时，效率很低，适合对象简单，对象数量变化不大，随机访问频繁。
 list不支持随机存储，适用于对象大，对象数量变化频繁，插入和删除频繁。
 **list自带排序函数的排序原理**
 将前两个元素合并，再将后两个元素合并，然后合并这两个子序列成4个元素的子序列，重复这一过程，得到8个，16个，...，子序列，最后得到的就是排序后的序列。
 时间复杂度：O(nlgn)



```php
void List::sort()
{
    List carry;
    List counter[64];  //数组元素为链表
    int fill = 0;
    while (head->next != tail)
    {
        carry.transfer(carry.getHead()->next, head->next, head->next->next); //head是哨兵，不存放有效值
                                                                             //head->next元素被移走，所以while循环不需要head=head->next;
        int i = 0;
        while (i < fill && counter[i].getHead()->next != counter[i].getHead())//counter[i]不是空
        {
            counter[i].merge(carry);
            carry.swap(counter[i++]);
        }
        carry.swap(counter[i]);
        if (i == fill) ++fill;
    }
    for (int i = 1; i < fill; i++)
        counter[i].merge(counter[i - 1]);   //通过这个实现排序（将有序的链表合成一个新的有序链表）
    swap(counter[fill - 1]);
}
```

**说说std::deque的底层机制**
 deque动态地以分段连续空间组合而成，随时可以增加一段新的连续空间并链接起来。不提供空间保留功能。
 注意：除非必要，我们尽可能选择使用vector而非deque，因为deque的迭代器比vector迭代器复杂很多。对deque排序，为了提高效率，可先将deque复制到一个vector上排序，然后再复制回deque。
 deque采用一块map（不是STL的map容器）作为主控，其为一小块连续空间，其中每个元素都是指针，指向另一段较大的连续空间（缓冲区）。
 deque的迭代器包含4个内容：
 1）cur：迭代器当前所指元素
 2）first：此迭代器所指的缓冲区的头。
 3）last：缓冲区尾。
 4）node：指向管控中心。
 ** deque与vector的区别**
 1）vector是单向开口的连续线性空间，deque是双向开口的连续线性空间。（双向开口是指可以在头尾两端分别做元素的插入和删除操作）。
 2）deque没有提供空间保留功能，而vector则要提供空间保留功能。
 3）deque也提供随机访问迭代器，但是其迭代器比vector迭代器复杂很多。
 **不允许有遍历行为的容器有哪些（不提供迭代器**
 1）queque，除了头部外，没有其他方法存取deque的其他元素。
 2）stack（底层以deque实现），除了最顶端外，没有任何其他方法可以存取stack的其他元素。
 3）heap，所有元素都必须遵循特别的排序规则，不提供遍历功能。
 **vector插入删除和list的区别**
 vector插入和删除数据，需要对现有数据进行复制移动，如果vector存储的对象很大或者构造函数很复杂，则开销较大，如果是简单的小数据，效率优于list。
 list插入和删除数据，需要对现有数据进行遍历，但在首部插入数据，效率很高。

#### 举例实现vector



```cpp
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;
void printf(vector<int> v);

int main()
{
    vector<int> vec;
    vec.push_back(23);
    vec.push_back(24);
    printf(vec);

    vector<int>::iterator p;
    p=vec.begin();
    *p=69;
    *(p+1)=74;
    *(p+2)=89;
    printf(vec);
    vec.pop_back();
    int i=0;
    while(i<vec.size())
        cout<<vec[i]<<" "<<endl;
    vec[3]=1000;
    while(i<vec.size())
        cout<<vec[i]<<" "<<endl;
    sort(vec.begin(),vec.end());
    return 0;
}

void printf(vector<int> v)
{
    cout<<"这个向量的大小为"<<v.size()<<endl;
    vector<int>::iterator p ;
    for(p = v.begin();p!=v.end();p++)
    {
        cout<<*p<<" "<<endl;
    }
    return;
}
```

**扩展**当vector的内存用完了，它是如何动态扩展内存的？它是怎么释放内存的？用clear可以释放掉内存吗？是不是线程安全的？

#### STL如何实现list

#### STL如何实现deque

#### 关联容器

标准关联容器set, multiset, map, multimap内部采用的一种非常高效的平衡检索二叉树:红黑树，也称为RB树(Red-BlackTree)。RB树的统计性能要好于一般的 [平衡二叉树](http://www.nist.gov/dads/HTML/avltree.html)
 **STL map和set的使用虽不复杂，但也有一些不易理解的地方**
 如:
 map: type [pair] <constKey, T> ，很多不同的 constKey 对应的 T 对象的一个集合，所有的记录集中只要 const Key 不一样就可以， T 无关! set: type const Key. 只存单一的对 const Key ，没有 map 的 T 对像!可以看成 map 的一个特例
 **为何map和set的插入删除效率比用其他序列容器高?**
 答:因为对于关联容器来说，不需要做内存拷贝和内存移动。map和set容器内所有元素都是以节点的方式来存储，其节点结构和链表差不多，指向父节点和子节点
 **为何每次insert之后，以前保存的iterator不会失效?**
 答:iterator这里就相当于指向节点的指针，内存没有变，指向内存的指针怎么会失效呢(当然被删除的那个元素本身已经失效了)。相对于vector来说，每一次删除和插入，指针都有可能失效，调用push_back在尾部插入也是如此。因为为了保证内部数据的连续存放，iterator指向的那块内存在删除和插入过程中可能已经被其他内存覆盖或者内存已经被释放了。即使时push_back的时候，容器内部空间可能不够，需要一块新的更大的内存，只有把以前的内存释放，申请新的更大的内存，复制已有的数据元素到新的内存，最后把需要插入的元素放到最后，那么以前的内存指针自然就不可用了。特别时在和find等算法在一起使用的时候，牢记这个原则:不要使用过期的iterator。
 **为何map和set不能像vector一样有个reserve函数来预分配数据?**
 答:引起它的原因在于在map和set内部存储的已经不是元素本身了，而是包含元素的节点。也就是说map内部使用的Alloc并不是map<Key, Data, Compare, Alloc>声明的时候从参数中传入的Alloc。
 **set, multiset**
 set和multiset会根据特定的排序准则自动将元素排序，set中元素不允许重复，multiset可以重复。
 因为是排序的，所以set中的元素不能被修改，只能删除后再添加。
 向set中添加的元素类型必须重载<操作符用来排序。排序满足以下准则:
 1、非对称，若A<B为真，则B<A为假。
 2、可传递，若A<B,B<C，则A<C。
 3、A<A永远为假。
 set中判断元素是否相等:
 if(!(A<B || B<A))，当A<B和B<A都为假时，它们相等。
 **map，multimap**
 map和multimap将key和value组成的pair作为元素，根据key的排序准则自动将元素排序，map中元素的key不允许重复，multimap可以重复。
 map<key,value>
 因为是排序的，所以map中元素的key不能被修改，只能删除后再添加。key对应的value可以修改。
 向map中添加的元素的key类型必须重载<操作符用来排序。排序与set规则一致。

#### map/set的实现

http://www.cnblogs.com/zlcxbb/p/5753906.html
 **红黑树的特性**
 https://blog.csdn.net/lf_2016/article/details/52974143

#### hash_map和map的区别

**构造函数** hash_map需要hash函数，等于函数;map只需要比较函数(小于函数).
 **存储结构** hash_map采用hash表存储，map一般采用红黑树实现。因此其memory数据结构是不一样的。
 **什么时候用hash_map,什么时候用map**
 权衡三个因素: 查找速度, 数据量, 内存使用。
 hash_map底层是散列的所以理论上操作的平均复杂度是常数时间，map底层是红黑树，理论上平均复杂度是O(logn)
 下面是借鉴的网上的总结：
 这里总结一下，选用map还是hash_map，关键是看关键字查询操作次数，以及你所需要保证的是查询总体时间还是单个查询的时间。如果是要很多次操作，要求其整体效率，那么使用hash_map，平均处理时间短。如果是少数次的操作，使用 hash_map可能造成不确定的O(N)，那么使用平均处理时间相对较慢、单次处理时间恒定的map，考虑整体稳定性应该要高于整体效率，因为前提在操作次数较少。如果在一次流程中，使用hash_map的少数操作产生一个最坏情况O(N)，那么hash_map的优势也因此丧尽了。
 http://www.cnblogs.com/lang5230/p/5556611.html



作者：里里角
链接：https://www.jianshu.com/p/f921122ba125
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。