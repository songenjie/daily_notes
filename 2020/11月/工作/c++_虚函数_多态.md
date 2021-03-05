**多态**
*定义：* 多态性可以简单地概括为“一个接口，多种方法”，程序在运行时才决定调用的函数

*原理：* C++多态性是通过虚函数来实现的
多态与非多态的实质区别就是函数地址是早绑定还是晚绑定。如果函数的调用，在编译器编译期间就可以确定函数的调用地址，并生产代码，是静态的，就是说地址是早绑定的。而如果函数调用的地址不能在编译器期间确定，需要在运行时才确定，这就属于晚绑定。

*作用：* 那么多态的作用是什么呢，封装可以使得代码模块化，继承可以扩展已存在的代码，他们的目的都是为了代码重用。而多态的目的则是为了接口重用。也就是说，不论传递过来的究竟是那个类的对象，函数都能够通过同一个接口调用到适应各自对象的实现方法。关于多态，简而言之就是用父类型别的指针指向其子类的实例，然后通过父类的指针调用实际子类的成员函数

*注意点：*
虚函数允许子类重新定义成员函数，而子类重新定义父类的做法称为覆盖(override)，或者称为重写。（这里我觉得要补充，重写的话可以有两种，直接重写成员函数和重写虚函数，只有重写了虚函数的才能算作是体现了C++多态性）

这种技术可以让父类的指针有“多种形态”，这是一种泛型技术。所谓泛型技术，说白了就是试图使用不变的代码来实现可变的算法。比如：模板技术，RTTI技术，虚函数技术，要么是试图做到在编译时决议，要么试图做到运行时决议。

------

**虚函数**
*作用：* C++中的虚函数的作用主要是实现了多态的机制

*原理：* 虚函数（Virtual Function）是通过一张虚函数表（Virtual Table）来实现的，简称为V-Table。
如果一个类中有虚函数，那么编译器就会为这个类构建一个虚函数表(所以类对象共享)。这个类的每个对象都有一个指向该虚表的隐式指针(虚函数指针)，并且保存在对象实例内存地址的最开始处（这是为了保证正确取到虚函数的偏移量）。意味着我们通过对象实例的地址得到这张虚函数表，然后就可以遍历其中函数指针，并调用相应的函数

*注意点*

- V-Table是每个Class类型一个，即所有类对象共有的。大小长度和这个类的虚函数总数正相关
- Vptr（虚函数表指针）是每个对象一个，大小固定，为4个字节

------

**一般继承（无虚函数覆盖）**

下面，再让我们来看看继承时的虚函数表是什么样的。假设有如下所示的一个继承关系：

![这里写图片描述](https://img-blog.csdn.net/20170816143329610?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

请注意，在这个继承关系中，子类没有重载任何父类的函数。那么，在派生类的实例中，其虚函数表如下所示：

对于实例：Derive d; 的虚函数表如下：

![这里写图片描述](https://img-blog.csdn.net/20170816143343976?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
我们可以看到下面几点：
1）虚函数按照其声明顺序放于表中。
2）父类的虚函数在子类的虚函数前面。

------

**一般继承（有虚函数覆盖）**

覆盖父类的虚函数是很显然的事情，不然，虚函数就变得毫无意义。下面，我们来看一下，如果子类中有虚函数重载了父类的虚函数，会是一个什么样子？假设，我们有下面这样的一个继承关系。

![这里写图片描述](https://img-blog.csdn.net/20170816143434812?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

为了让大家看到被继承过后的效果，在这个类的设计中，我只覆盖了父类的一个函数：f()。那么，对于派生类的实例，其虚函数表会是下面的一个样子：

![这里写图片描述](https://img-blog.csdn.net/20170816143443545?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

我们从表中可以看到下面几点，
1）覆盖的f()函数被放到了虚表中原来父类虚函数的位置。
2）没有被覆盖的函数依旧。

这样，我们就可以看到对于下面这样的程序，

```
Base *b = new Derive();

b->f();
123
```

由b所指的内存中的虚函数表的f()的位置已经被Derive::f()函数地址所取代，于是在实际调用发生时，是Derive::f()被调用了。这就实现了多态。

------

**重点内容**

**多重继承（无虚函数覆盖）**

下面，再让我们来看看多重继承中的情况，假设有下面这样一个类的继承关系。注意：子类并没有覆盖父类的函数。

![这里写图片描述](https://img-blog.csdn.net/20170816143501386?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
对于子类实例中的虚函数表，是下面这个样子：
![这里写图片描述](https://img-blog.csdn.net/20170816143509819?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

我们可以看到：
1） 每个父类都有自己的虚表。
2） 子类的成员函数被放到了第一个父类的表中。（所谓的第一个父类是按照声明顺序来判断的）

这样做就是为了解决不同的父类类型的指针指向同一个子类实例，而能够调用到实际的函数。

------

**多重继承（有虚函数覆盖）**

下面我们再来看看，如果发生虚函数覆盖的情况。

下图中，我们在子类中覆盖了父类的f()函数。

![这里写图片描述](https://img-blog.csdn.net/20170816143521509?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

下面是对于子类实例中的虚函数表的图：

![这里写图片描述](https://img-blog.csdn.net/20170816143529594?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveGlhb2ZlaXphaTExMTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

我们可以看见，三个父类虚函数表中的f()的位置被替换成了子类的函数指针。这样，我们就可以任一静态类型的父类来指向子类，并调用子类的f()了。如：

```
Derive d;
Base1 *b1 = &d;
Base2 *b2 = &d;
Base3 *b3 = &d;
b1->f(); //Derive::f()
b2->f(); //Derive::f()
b3->f(); //Derive::f()

b1->g(); //Base1::g()
b2->g(); //Base2::g()
b3->g(); //Base3::g()
1234567891011
```

------

**纯虚函数**
一、定义
纯虚函数是在基类中声明的虚函数，它在基类中没有定义，但要求任何派生类都要定义自己的实现方法。在基类中实现纯虚函数的方法是在函数原型后加“=0”
virtual void funtion()=0
二、引入原因
1、为了方便使用多态特性，我们常常需要在基类中定义虚拟函数。
2、在很多情况下，基类本身生成对象是不合情理的。例如，动物作为一个基类可以派生出老虎、孔雀等子类，但动物本身生成对象明显不合常理。
为了解决上述问题，引入了纯虚函数的概念，将函数定义为纯虚函数（方法：virtual ReturnType Function()= 0;），则编译器要求在派生类中必须予以重写以实现多态性。同时含有纯虚拟函数的类称为抽象类，它不能生成对象。这样就很好地解决了上述两个问题。
3、抽象类
包含纯虚函数的类称为抽象类。由于抽象类包含了没有定义的纯虚函数，所以不能定义抽象类的对象。