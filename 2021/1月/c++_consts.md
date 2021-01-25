# [常量变量的生命周期及声明方式](https://my.oschina.net/wygan/blog/1477330)

原创

[晷骥](https://my.oschina.net/wygan)

[工作日志](https://my.oschina.net/wygan?tab=newest&catalogId=946860)

2017/07/21 18:07

阅读数 627

\##原生数据类型 [POD](https://my.oschina.net/wygan/blog/blank)的静态变量##

1. 静态成员初始化与一般数据成员初始化不同。

   静态成员变量在类里面声明的时候无法直接初始化，需要在类体外部进行初始化，格式如下：

   <数据类型> <类名>::<静态数据成员名>=<值>

   ```
    class Test {
    public:
        static int arg1;
    private :
        static int arg2;
    };
   
    int Test::arg1 = 1;
    int Test::arg2 = 2;
   ```

   初始化的时候不区分public或者private

2. 常量成员变量及静态常量成员变量的初始化

   - 常量成员变量和静态常量成员变量可以在声明的时候进行初始化
   - 常量成员变量可以在构造的时候进行初始化
   - 静态常量成员变量可以在类体外和静态成员变量一样进行初始化

   示例代码如下：

   ```
        class Test {
        public:
            Test() : arg6(6) {}
        public :
            const int arg5 = 5;
            const int arg6;
   
        private :
            const static int arg3 = 3;
            const static int arg4;
        };
        const int Test::arg4 = 4;
   ```

\##静态变量的生命周期##

\###**常量变量有以下几类：**###

1. 全局常量变量
2. 命名空间内的常量变量
3. 类的常量变量
4. 函数体内的常量变量

对于以上 1/2/3类的静态变量，**在程序启动时进行初始化，在程序结束时释放**

对于函数体内的静态变量，**在第一次执行到该static变量的定义时创建，在程序结束时释放**；如果程序一直没执行到该static变量的定义，则一直不会创建，也当然不会释放

\###测试分析###

1. 全局常量变量和命名空间内的常量变量

   ```
    class A {
    public:
        A() { cout << "A()" << endl; }
        ~A(){ cout << "~A()" << endl; }
    };
   
    A a;
   
    namespace test {
        class B {
        public:
            B() { cout << "B()" << endl; }
            ~B(){ cout << "~B()" << endl; }
        };
        B b;
    }
   
    int main()
    {
        cout << "main begin" << endl;
        cout << "main end" << endl;
        return 0;
    }
   ```

   输出：

   ```
    A()
    B()
    main begin
    main end
    ~B()
    ~A()
   ```

   如果把`A a`的定义放到`B b`的后面，则输出会变为

   ```
    B()
    A()
    main begin
    main end
    ~A()
    ~B()
   ```

   如果静态常量A和B分别定义在不同的头文件，在庞大的工程中，构建的顺序难以确定，此时静态变量的**构造函数、析构函数和初始化的顺序在 C++ 中是不确定的，甚至随着构建变化而变化，导致难以发现的 bug**. 所以除了禁用类类型的全局变量，我们也不允许用函数返回值来初始化 POD 变量，除非该函数不涉及（比如 getenv() 或 getpid()）不涉及任何全局变量。（**函数作用域里的静态变量除外，毕竟它的初始化顺序是有明确定义的，而且只会在指令执行到它的声明那里才会发生。**）

2. 类中的常量变量 class A { public: A() { cout << "A::A()" << endl; } ~A() { cout << "A::~A()" << endl; } };

   ```
    class B
    {
        static A a;
    };
   
    A B::a;
   
    int main(int argc, char* argv[])
    {
        cout << "main begin" << endl;
        system("pause");
        cout << "main end" << endl;
        return 0;
    }
   ```

   输出：

   ```
    A::A()
    main begin
    main end
    A::~A()
   ```

3. 函数中的常量变量

   ```
    class A
    {
    public:
        A() { cout << "A::A()" << endl; }
        ~A() { cout << "A::~A()" << endl; }
    };
   
    void func()
    {
        cout << "func start" << endl;
        static A a;
        cout << "func end" << endl;
    }
   
    int main(int argc, char* argv[])
    {
        cout << "main begin" << endl;
        func();
        system("pause");
        cout << "main end" << endl;
        return 0;
    }
   ```

   输出：

   ```
    main begin
    func start
    A::A()
    func end
    main end
    A::~A()
   ```

   如果不调用func()，则不会输出A::A()和A::~A()