# [Bug] query failed because `failed to initialize storage reader. tablet=4xxx, res=-230`

Describe the bug
I found that query failed because version already has been merged, following is the information.

MySQL [xxx]> select count from xxx where olap_date=20200506;
ERROR 1064 (HY000): errCode = 2, detailMessage = failed to initialize storage reader. tablet=411414.1806177919.7749a8df399f5efb-10b75b71f86b5e85, res=-230, backend=xxx


W0512 18:59:28.431733 116478 tablet.cpp:428] tablet:411414.1806177919.7749a8df399f5efb-10b75b71f86b5e85, version already has been merged. spec_version: [0-25913]
W0512 18:59:28.431846 116478 olap_scanner.cpp:63] OlapScanner preapre failed, status:failed to initialize storage reader. tablet=411414.1806177919.7749a8df399f5efb-10b75b71f86b5e85, res=-230, backend=10.136.30.22
W0512 18:59:29.928047 116507 tablet.cpp:428] tablet:411414.1806177919.7749a8df399f5efb-10b75b71f86b5e85, version already has been merged. spec_version: [0-25913]
W0512 18:59:29.928213 116507 olap_scanner.cpp:63] OlapScanner preapre failed, status:failed to initialize storage reader. tablet=411414.1806177919.7749a8df399f5efb-10b75b71f86b5e85, res=-230, backend=10.136.30.22


```
[wangcong@c3-bigdata-doris-client ~]$ curl -X GET http://xxx:8040/api/compaction/show?tablet_id=411414\&schema_hash=1806177919
{
    "cumulative point": 25920,
    "last cumulative failure time": "1970-01-01 08:00:00.000",
    "last base failure time": "1970-01-01 08:00:00.000",
    "last cumulative success time": "2020-05-12 17:18:45.339",
    "last base success time": "2020-05-12 12:34:19.746",
    "rowsets": [
        "[0-19371] 6 DATA NONOVERLAPPING",
        "[19372-20371] 1 DATA NONOVERLAPPING",
        "[20372-20805] 1 DATA NONOVERLAPPING",
        "[20806-21205] 1 DATA NONOVERLAPPING",
        "[21206-21605] 1 DATA NONOVERLAPPING",
        "[21606-21802] 1 DATA NONOVERLAPPING",
        "[21803-22251] 1 DATA NONOVERLAPPING",
        "[22252-22315] 1 DATA NONOVERLAPPING",
        "[22316-22705] 1 DATA NONOVERLAPPING",
        "[22706-22933] 1 DATA NONOVERLAPPING",
        "[22934-23405] 1 DATA NONOVERLAPPING",
        "[23406-23505] 1 DATA NONOVERLAPPING",
        "[23506-23905] 1 DATA NONOVERLAPPING",
        "[23906-24105] 1 DATA NONOVERLAPPING",
        "[24106-24114] 1 DATA NONOVERLAPPING",
        "[24115-24405] 1 DATA NONOVERLAPPING",
        "[24406-24419] 1 DATA NONOVERLAPPING",
        "[24420-24888] 1 DATA NONOVERLAPPING",
        "[24889-25253] 1 DATA NONOVERLAPPING",
        "[25254-25616] 1 DATA NONOVERLAPPING",
        "[25617-25909] 1 DATA NONOVERLAPPING",
        "[25910-25919] 1 DATA NONOVERLAPPING"
    ]
}
```



## fix 
- 引起原因：
1. 导入太频繁
2. 然后假如查询涉及的tablet多的情况下。
3. 查询执行的第一步，想获取tablet的版本信息，然后已经被合并了。
这个时候会出现这个问题。


- 这个bug主要的问题就是 be和新起来的fe master 不同步，为了避免这个问题
建议，fe重启的时候
1. pause all routine load
2. 缓个几分钟，然后重启fe


- 如果已经出现了
1 pause all routine load job
2 重启所有be，重新上报 tablet 让它 checkout一遍
3 …


