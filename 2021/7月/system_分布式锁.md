在很多场景中，我们为了保证数据的最终一致性，需要很多的技术方案来支持，比如分布式事务、分布式锁等。那具体什么是分布式锁，分布式锁应用在哪些业务场景、如何来实现分布式锁呢？今天来探讨分布式锁这个话题。

![img](https://pic4.zhimg.com/80/v2-96ba22f13fd191c5eb33a54bdcc85d43_1440w.jpg)

## **什么是分布式锁**

要介绍分布式锁，首先要提到与分布式锁相对应的是线程锁、进程锁。

**1.线程锁**

主要用来给方法、代码块加锁。当某个方法或代码使用锁，在同一时刻仅有一个线程执行该方法或该代码段。线程锁只在同一JVM中有效果，因为线程锁的实现在根本上是依靠线程之间共享内存实现的，比如Synchronized、Lock等。

**2.进程锁**

为了控制同一操作系统中多个进程访问某个共享资源，因为进程具有独立性，各个进程无法访问其他进程的资源，因此无法通过synchronized等线程锁实现进程锁。

**3.分布式锁**

当多个进程不在同一个系统中，用分布式锁控制多个进程对资源的访问。

## **分布式锁的由来**

在传统单机部署的情况下，可以使用Java并发处理相关的API(如ReentrantLcok或synchronized)进行互斥控制。

但是在分布式系统后，由于分布式系统多线程、多进程并且分布在不同机器上，这将使原单机并发控制锁策略失效，为了解决这个问题就需要一种跨JVM的互斥机制来控制共享资源的访问，这就是分布式锁的由来。

当多个进程不在同一个系统中，就需要用分布式锁控制多个进程对资源的访问。

## **分布式锁的特点**

首先，为了确保分布式锁可用，我们至少要确保锁的实现同时满足以下四个条件：

1、**互斥性**：任意时刻，只能有一个客户端获取锁，不能同时有两个客户端获取到锁。

2、**安全性**：锁只能被持有该锁的客户端删除，不能由其它客户端删除。

3、**死锁**：获取锁的客户端因为某些原因（如down机等）而未能释放锁，其它客户端再也无法获取到该锁。

4、**容错**：当部分节点（redis节点等）down机时，客户端仍然能够获取锁和释放锁。

## **分布式锁的具体实现**



![img](https://pic1.zhimg.com/80/v2-b6cc27dec9d7752c6ad4bd5148b95580_1440w.jpg)



**分布式锁一般有三种实现方式：**

\1. 数据库乐观锁；

\2. 基于ZooKeeper的分布式锁;

3.基于Redis的分布式锁；

**Redis实现分布式锁**

基于Redis命令：SET key value NX EX max-lock-time

这里补充下： 从2.6.12版本后, 就可以使用set来获取锁, Lua 脚本来释放锁。setnx是老黄历了，set命令nx,xx等参数, 是为了实现 setnx 的功能。

**1.加锁**

> public class RedisTool {
> private static final String LOCK_SUCCESS = "OK";
> private static final String SET_IF_NOT_EXIST = "NX";
> private static final String SET_WITH_EXPIRE_TIME = "PX";
> /**
> \* 尝试获取分布式锁
> \* @param jedis Redis客户端
> \* @param lockKey 锁
> \* @param requestId 请求标识
> \* @param expireTime 超期时间
> \* @return 是否获取成功
> */
> public static boolean tryGetDistributedLock(Jedis jedis, String lockKey, String requestId, int expireTime) {
> String result = jedis.set(lockKey, requestId, SET_IF_NOT_EXIST, SET_WITH_EXPIRE_TIME, expireTime);
> if (LOCK_SUCCESS.equals(result)) {return true;}return false;}}

jedis.set(String key, String value, String nxxx, String expx, int time)

**这个set()方法一共有五个形参：**

第一个为key，我们使用key来当锁，因为key是唯一的。

第二个为value，我们传的是requestId，很多童鞋可能不明白，有key作为锁不就够了吗，为什么还要用到value？原因就是我们在上面讲到可靠性时，分布式锁要满足第四个条件解铃还须系铃人，通过给value赋值为requestId，我们就知道这把锁是哪个请求加的了，在解锁的时候就可以有依据。requestId可以使用UUID.randomUUID().toString()方法生成。

第三个为nxxx，这个参数我们填的是NX，意思是SET IF NOT EXIST，即当key不存在时，我们进行set操作；若key已经存在，则不做任何操作；

第四个为expx，这个参数我们传的是PX，意思是我们要给这个key加一个过期的设置，具体时间由第五个参数决定。

第五个为time，与第四个参数相呼应，代表key的过期时间。

总的来说，执行上面的set()方法就只会导致两种结果：1. 当前没有锁（key不存在），那么就进行加锁操作，并对锁设置个有效期，同时value表示加锁的客户端。2. 已有锁存在，不做任何操作。

**2.解锁**

> public class RedisTool {
> private static final Long RELEASE_SUCCESS = 1L;
> /**
> \* 释放分布式锁
> \* @param jedis Redis客户端
> \* @param lockKey 锁
> \* @param requestId 请求标识
> \* @return 是否释放成功
> */
> public static boolean releaseDistributedLock(Jedis jedis, String lockKey, String requestId) {
>
> String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
> Object result = jedis.eval(script, Collections.singletonList(lockKey),Collections.singletonList(requestId));if (RELEASE_SUCCESS.equals(result)) {return true;}return false;}}

那么这段Lua代码的功能是什么呢？其实很简单，首先获取锁对应的value值，检查是否与requestId相等，如果相等则删除锁（解锁）。

以上就是redis实现分布式锁详解，除此之外，也可以使用Redission(Redis 的客户端)集成进来实现分布式锁，也可以使用数据库等，具体可以参考Mike发表在优知学院官网的往期文章《阿里P8架构师谈分布式锁的3种实现：数据库、缓存、Zookeeper》。