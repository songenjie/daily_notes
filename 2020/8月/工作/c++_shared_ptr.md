**shared_ptr** 的类型是C + +标准库中一个聪明的指针，是为多个拥有者管理内存中对象的生命周期而设计的。在你初始化一个 **shared_ptr** 后，你可以复制它，把函数参数的值递给它，并把它分配给其它 **shared_ptr** 实例。所有实例指向同一个对象，并共享访问一个“控制块”，即每当一个新的**shared_ptr** 被添加时，递增和递减引用计数，超出范围，则复位。当引用计数到达零时，控制块删除内存资源和自身。

下图显示了指向一个内存位置的几个 **shared_ptr** 实例。

无论什么时候，当内存资源被第一次被创建时，就使用函数 [make_shared ()](https://msdn.microsoft.com/zh-cn/library/ee410595.aspx) 创建一个新的 **shared_ptr**。 **make_shared**异常安全。它使用同一调用分配的内存控制块和资源从而减少构造开销。如果你不使用 **make_shared**，那么在把它传递给 **shared_ptr** 的构造函数之前，你必须使用一个明确的新表达式创建的对象。下面的例子显示了在新对象中声明和初始化一个 **shared_ptr** 的各种方式





shared_ptr和unique_ptr之间的区别在于：shared_ptr是引用计数的智能指针，而unique_ptr不是。这意味着，可以有多个shared_ptr实例指向同一块动态分配的内存，当最后一个shared_ptr离开作用域时，才会释放这块内存。shared_ptr也是线程安全的。 另一方面，unique_ptr意味着所有权。单个unique_ptr离开作用域时，会立即释放底层内存。





# std::shared_ptr<T>::operator bool

 

[C++](https://en.cppreference.com/w/cpp)

 

[Utilities library](https://en.cppreference.com/w/cpp/utility)

 

[Dynamic memory management](https://en.cppreference.com/w/cpp/memory)

 

[`std::shared_ptr`](https://en.cppreference.com/w/cpp/memory/shared_ptr)

 

| explicit operator bool() const noexcept; |      |      |
| ---------------------------------------- | ---- | ---- |
|                                          |      |      |

Checks if *this stores a non-null pointer, i.e. whether get() != nullptr.

### Parameters

(none)

### Return value

true if *this stores a pointer, false otherwise.

### Notes

An empty shared_ptr (where use_count() == 0) may store a non-null pointer accessible by `get()`, e.g. if it were created using the aliasing constructor.

### Example

Run this code

```
#include <iostream>
#include <memory>
 
void report(std::shared_ptr<int> ptr) 
{
    if (ptr) {
        std::cout << "*ptr=" << *ptr << "\n";
    } else {
        std::cout << "ptr is not a valid pointer.\n";
    }
}
 
int main()
{
    std::shared_ptr<int> ptr;
    report(ptr);
 
    ptr = std::make_shared<int>(7);
    report(ptr);
}
```

Output:

```
ptr is not a valid pointer.
*ptr=7
```