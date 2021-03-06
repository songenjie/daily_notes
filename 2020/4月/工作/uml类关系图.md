https://processon.com/diagraming/5eaa7248f346fb177ba2c725

jdsongenjie@gmail.com
# 继承(也叫泛化 generalization) 实线 实心箭头
class A:class B

# 实现（Realization) interface 虚线 实心箭头
指的是一个class类实现了interface(可以是多个)的功能；实现是类与接口之前最常见的关系，在java中此类关系通过关键字 implementes 明确标识

# 依赖 (Dependency) 虚线 线箭头
可以简单的理解，就是类A使用了另外一个类B，而这种使用关系具有偶然性的、临时性的、非常弱，但是B类的变化会影响A；

比如：某人要过河，需要借用一条船，此时人与船之间的关系就是依赖；

表现在代码层面，为类B作为参数被A在某个method方法中使用

# 关联 (association) 实线 线箭头
他体现的是两个类，或者类与接口之间语义级别的一种强依赖关系，比如我和我的朋友；这行关系比依赖更强，不存在依赖关系的偶然性、关系也不是临时的

一般是长期性的，而且双方的关系一半是平等的、关联可以是单向、双向的；表现在代码层面，为被关联类B以以属性的形式出现在关联类中

也可能是关联类A饮用了一个类型为被关联类B的全局变量

# 聚合 (aggregation) 聚合特例 空心菱形 实线
聚合是关联关系的一种特例，他体现的是整体与部分、拥有的关系，即has-a的关系，此时整体与部分之间是不可分离，他们可以具有各自的生命周期，

部分可以数据多个整体对象，也可以为多个整理对象共享；比如计算机与cpu，公司与员工的关系；表现在代码层面，和关联关系是一致的，只能从语义级别来区分

# 组合 (composition) 聚合特例 实心菱形 实线
组合也是关联关系中的一种特例，他体现在一种 contains-a 的关系中，这种关系比聚合更强，也成为强聚合；他同样体现整理与部分间的关系，但此时整体与部分是

不可能分的，整体的生命周期结束也意味这部分的生命周期结束，比如你和你的大脑；

表现在代码层面，和关联关系是一致的，只能从语义级别来区分
