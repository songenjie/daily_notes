### core file size of soft limit 设置问题
启动是service 设置
`LimitCORE=infinity`


### 现象 core file size soft limit 1073741824 一直是1G的大小
```
Limit                     Soft Limit           Hard Limit           Units
Max cpu time              unlimited            unlimited            seconds
Max file size             unlimited            unlimited            bytes
Max data size             unlimited            unlimited            bytes
Max stack size            8388608              unlimited            bytes
Max core file size        1073741824           unlimited            bytes
Max resident set          unlimited            unlimited            bytes
Max processes             514501               514501               processes
Max open files            500000               500000               files
Max locked memory         65536                65536                bytes
Max address space         unlimited            unlimited            bytes
Max file locks            unlimited            unlimited            locks
Max pending signals       514501               514501               signals
Max msgqueue size         819200               819200               bytes
Max nice priority         0                    0
Max realtime priority     0                    0
Max realtime timeout      unlimited            unlimited            us
```


### 原因
直接外围设置core file size 会被clickhouse 自带core file size 冲掉
代码如下
```
    DB::ConfigProcessor(config_path).savePreprocessedConfig(loaded_config, "");
    /// Write core dump on crash.
    {
        struct rlimit rlim;
        if (getrlimit(RLIMIT_CORE, &rlim))
            throw Poco::Exception("Cannot getrlimit");
        /// 1 GiB by default. If more - it writes to disk too long.
        rlim.rlim_cur = config().getUInt64("core_dump.size_limit", 1024 * 1024 * 1024);
        if (rlim.rlim_cur && setrlimit(RLIMIT_CORE, &rlim))
        {
            /// It doesn't work under address/thread sanitizer. http://lists.llvm.org/pipermail/llvm-bugs/2013-April/027880.html
            std::cerr << "Cannot set max size of core file to " + std::to_string(rlim.rlim_cur) << std::endl;
        }
    }
```

### 解决方案
找了一圈官方文档没有，自己尝试搞了下
单位默认为 bytes,

设置方案如下 config.xml 
```
   <core_dump>
      <size_limit>XXX</size_limit>
   </core_dump>
```

### 结果  设置为0 生效
```
Limit                     Soft Limit           Hard Limit           Units
Max cpu time              unlimited            unlimited            seconds
Max file size             unlimited            unlimited            bytes
Max data size             unlimited            unlimited            bytes
Max stack size            8388608              unlimited            bytes
Max core file size        0                    unlimited            bytes
Max resident set          unlimited            unlimited            bytes
Max processes             514501               514501               processes
Max open files            500000               500000               files
Max locked memory         65536                65536                bytes
Max address space         unlimited            unlimited            bytes
Max file locks            unlimited            unlimited            locks
Max pending signals       514501               514501               signals
Max msgqueue size         819200               819200               bytes
Max nice priority         0                    0
Max realtime priority     0                    0
```

### 目前问题
需要大家讨论 `core_dump.size_limit` 的大小
50G 是否合理


@lihaibo42 @wujianchao5 @liyang453 @zhouhui155 @wanggaoming1