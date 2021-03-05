这两天测试总结了下，ck的权限管理还有点问题（基于ck20.5.2.7验证）：
1. `ALL`并非所有的权限，部分权限是没有的（文档里没有提及），比如这些权限：
    - CREATE TEMPORARY TABLE privilege；
    - KILL QUERY；
    - SOURCES（包括MYSQL、REMOTE权限）；
    - ACCESS MANAGEMENT；
    - some SYSTEM privilege；
    
    
    参考mysql的话，mysql的ALL包含CREATE TEMPORARY TABLE权限，上面提到的这些应该是bug（尤其是temporary table和sources）；
1. 关于某些权限的说明不清晰，比如SOURCES里的REMOTE（创建distribute表时需要这个权限）的作用；
1. 新用户不赋予某些权限就可以访问system库，这个似乎不太安全，不过从文档看是功能需要、设计如此；
1. 可以直接用`show grants for {user}`查看其他用户的授权信息（mysql不存在这个问题）；
1. 跨instance的访问，似乎用的不是本地定义的user，比如本地default未开启user管理权限，但是仍然可以on cluster远程用default创建新user；
1. 社区仍然存在一些rbac相关的bug：[rbac-issues](https://github.com/ClickHouse/ClickHouse/issues?q=label%3Acomp-rbac)   [issue#2451](https://github.com/ClickHouse/ClickHouse/issues/2451) [issue#12575](https://github.com/ClickHouse/ClickHouse/issues/12575)





### 1. 背景及测试发现问题
  1. clickhouse基于RBAC的模式进行权限管理（2020Q1开始支持）；
  1. ck内置（配置文件）的user（比如defatul）无法修改（比如移除某些权限），因为配置文件是readonly的；
  1. 比较灵活的控制方法是配置文件里给default加密码只供管理员使用，然后新建普适性测试账号给测试集群的用户用，私有数据库的需求可以对测试账号收回该库的权限；
  1. ck20.5+开始引入对show users/roles以及system.users表，之前的版本里对user/role的管理全部依赖于配置文件，非常不灵活，建议升级到20.5+；
  1. user.xml里配置user的相关配置后会自动reload；
  1. 用户有user管理权限需要1.config.xml里开启access_control_path，2.users.xml里给用户添加access_management权限；
  1. ck里用户即使有`ALL on db.*`的权限也不能创建分布式表，这是赋予的是database level的权限，而创建distributed表需要REMOTE权限，而REMOTE是属于SOURCES，是global level的；
  1. `REVOKE ALL`会收回所有的global权限，需要特别注意（即使有ON db.*）；
  1. `REVOKE ALL ON *.*`结合role使用时有可能权限没有真正回收，似乎是个bug（先db level grant再global revoke）；
  1. user/role可以同名，这样会很困惑；
  1. default user重名操作时会出问题，参考：[issue](https://github.com/ClickHouse/ClickHouse/issues/12950)；



![](/source/ck_privileges.jpg)

