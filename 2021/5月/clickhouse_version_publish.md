clickhouse 自2016年开源依赖 版本号经历过三个历史阶段：

第一阶段：1.1版本 (1.1.54245, 2017-07-04 ---- 1.1.54394, 2018-07-12)

这是早期clickhouse开源的版本号，命名规则为：Major.Minor.patch
这一时期的patch版本好变化比较大。
但是版本号码很是不好记忆。
第二阶段：18.1.x---19.17.x (18.1.0, 2018-07-23 --- 19.17.6.36, 2019-12-27)

这一阶段的版本命名规则为：Year.Major.Minor.patch
2018年7月份在18.1.0版本发布的说明中表述如下：
Changed the numbering scheme for release versions. Now the first part contains the year of release 
(A.D., Moscow timezone, minus 2000), the second part contains the number for major changes (increases
 for most releases), and the third part is the patch version. Releases are still backward compatible,
 unless otherwise stated in the changelog.


这一阶段2018年
Major 若是单数表示测试版本testing，或者 prestable 版本
新的特性多在偶数版本。

2018年 主要发布的版本有18.1,18.3，然后是偶数 4 10 12 14 16.

2019年：
发布周期比较频繁，新增特性和测试版本都比较随机 ，2019年marjor用的比较多达到了17，
2019年最新的版本为19.17.6.36 (2019-12-27).

这期间：2019.Major.1.patch 确定为测试版本。个别版本因为测试不过关一直没有变更标签为stable。


第三阶段：20.1.2.*版本至今（v20.1.2.4, 2020-01-22 -- now）



 

进入2020年后稳定版本发版本比较规律 基本是一个月以一个新的稳定版本 发版稍有延迟(可能受疫情影响)

Year.Major.1.patch 1 表示测试版，大于1表示稳定版本。有重大的更新和新特性主要在Minor为2的版本。
特别版本：LTS版本



早期发版的版本太快，要使用新特性和修修正了一些bug需要经常更新。对于一起企业来说需要一些稳定的功能和版本，
clickhouse在2019年12月17日发布了第一个LTS(Long Term Support）v19.14.8.9


LTS version is released twice a year with limited support during one year. Limited support includes 
backports of bugfixes (only fixes that were easy to backport or that were required by customer).


于2020年4月16日发布 了第二个LTS版本 20.3.6.40

版本的选择：

要是体验最新的测试功能 可以选择prestable或者testing版本，
对于企业来说可以选择LTS的稳定版本，差不多6个月分布一个LTS版本，一年发布两个。维护的周期要比stable版本长。