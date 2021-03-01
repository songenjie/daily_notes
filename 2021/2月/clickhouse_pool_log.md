2021.02.24 16:05:01.458503 [ 12256 ] {1659BBE71E06CD54} <Warning> ConnectionPoolWithFailover: Connection failed at try №1, reason: Code: 32, e.displayText() = DB::Exception: Attempt to read after eof (version 20.12.3.3)







```
2021.02.24 16:05:01.333101 [ 92808 ] {} <Trace> HTTPHandler-factory: HTTP Request for HTTPHandler-factory. Method: GET, Address: [::ffff:10.199.141.8]:23046, User-Agent: Go-http-client/1.1, Content Type: , Transfer Encoding: identity
2021.02.24 16:05:01.333161 [ 92808 ] {} <Trace> DynamicQueryHandler: Request URI: /?query=SELECT%201
2021.02.24 16:05:01.333258 [ 92808 ] {1f3a9f92-5f7e-40fc-86e9-776e74252313} <Debug> executeQuery: (from [::ffff:10.199.141.8]:23046) SELECT 1
2021.02.24 16:05:01.333323 [ 92808 ] {1f3a9f92-5f7e-40fc-86e9-776e74252313} <Trace> ContextAccess (default): Access granted: SELECT(dummy) ON system.one
2021.02.24 16:05:01.333344 [ 92808 ] {1f3a9f92-5f7e-40fc-86e9-776e74252313} <Trace> InterpreterSelectQuery: FetchColumns -> Complete
2021.02.24 16:05:01.333513 [ 92808 ] {1f3a9f92-5f7e-40fc-86e9-776e74252313} <Information> executeQuery: Read 1 rows, 1.00 B in 0.000226437 sec., 4416 rows/sec., 4.31 KiB/sec.
2021.02.24 16:05:01.333549 [ 92808 ] {1f3a9f92-5f7e-40fc-86e9-776e74252313} <Debug> DynamicQueryHandler: Done processing query
2021.02.24 16:05:01.333558 [ 92808 ] {1f3a9f92-5f7e-40fc-86e9-776e74252313} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
2021.02.24 16:05:01.456901 [ 93006 ] {} <Trace> HTTPHandler-factory: HTTP Request for HTTPHandler-factory. Method: GET, Address: [::ffff:10.199.141.7]:20352, User-Agent: RemoteAddr: 10.199.205.22:5083; LocalAddr: 10.199.141.7:8090; CHProxy-User: default; CHProxy-ClusterUser: default; Go-http-client/1.1, Content Type: , Transfer Encoding: identity
2021.02.24 16:05:01.456957 [ 93006 ] {} <Trace> DynamicQueryHandler: Request URI: /?query=SELECT+user%2C+max_concurrent_queries%2C+max_execution_time%2C+requests_per_minute+FROM+chproxy.users_limit+FORMAT+JSON&query_id=1659BBE71E06CD54
2021.02.24 16:05:01.457107 [ 93006 ] {1659BBE71E06CD54} <Debug> executeQuery: (from [::ffff:10.199.141.7]:20352) SELECT user, max_concurrent_queries, max_execution_time, requests_per_minute FROM chproxy.users_limit FORMAT JSON
2021.02.24 16:05:01.457248 [ 93006 ] {1659BBE71E06CD54} <Trace> ContextAccess (default): Access granted: SELECT(user, max_concurrent_queries, max_execution_time, requests_per_minute) ON chproxy.users_limit
2021.02.24 16:05:01.457363 [ 93006 ] {1659BBE71E06CD54} <Trace> ContextAccess (default): Access granted: SELECT(user, max_concurrent_queries, max_execution_time, requests_per_minute) ON chproxy.users_limit
2021.02.24 16:05:01.457514 [ 93006 ] {1659BBE71E06CD54} <Trace> ContextAccess (default): Access granted: SELECT(user, max_concurrent_queries, max_execution_time, requests_per_minute) ON chproxy.users_limit_local
2021.02.24 16:05:01.457557 [ 93006 ] {1659BBE71E06CD54} <Debug> chproxy.users_limit_local (8c513bbf-8e47-44d9-88f8-cb821f19379c) (SelectExecutor): Key condition: unknown
2021.02.24 16:05:01.457562 [ 93006 ] {1659BBE71E06CD54} <Debug> chproxy.users_limit_local (8c513bbf-8e47-44d9-88f8-cb821f19379c) (SelectExecutor): MinMax index condition: unknown
2021.02.24 16:05:01.457568 [ 93006 ] {1659BBE71E06CD54} <Debug> chproxy.users_limit_local (8c513bbf-8e47-44d9-88f8-cb821f19379c) (SelectExecutor): Selected 0 parts by partition key, 0 parts by primary key, 0 marks by primary key, 0 marks to read from 0 ranges
2021.02.24 16:05:01.457601 [ 93006 ] {1659BBE71E06CD54} <Trace> InterpreterSelectQuery: FetchColumns -> WithMergeableState
2021.02.24 16:05:01.457703 [ 93006 ] {1659BBE71E06CD54} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
2021.02.24 16:05:01.458040 [ 14931 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.5:9600): Connecting. Database: (not specified). User: default
2021.02.24 16:05:01.458042 [ 15490 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.55:9700): Connecting. Database: (not specified). User: default
2021.02.24 16:05:01.458042 [ 12830 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.57:9600): Connecting. Database: (not specified). User: default
2021.02.24 16:05:01.458045 [ 12899 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.54:9800): Connecting. Database: (not specified). User: default
2021.02.24 16:05:01.458441 [ 14931 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.5:9600): Connected to ClickHouse server version 20.12.3.
2021.02.24 16:05:01.458503 [ 12256 ] {1659BBE71E06CD54} <Warning> ConnectionPoolWithFailover: Connection failed at try №1, reason: Code: 32, e.displayText() = DB::Exception: Attempt to read after eof (version 20.12.3.3)
2021.02.24 16:05:01.458512 [ 15490 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.55:9700): Connected to ClickHouse server version 20.12.3.
2021.02.24 16:05:01.458529 [ 12256 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.53:9800): Connecting. Database: (not specified). User: default
2021.02.24 16:05:01.458669 [ 12899 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.54:9800): Connected to ClickHouse server version 20.12.3.
2021.02.24 16:05:01.458727 [ 12830 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.57:9600): Connected to ClickHouse server version 20.12.3.
2021.02.24 16:05:01.459123 [ 12256 ] {1659BBE71E06CD54} <Trace> Connection (10.199.141.53:9800): Connected to ClickHouse server version 20.12.3.
2021.02.24 16:05:01.460828 [ 93006 ] {1659BBE71E06CD54} <Information> executeQuery: Read 1 rows, 28.00 B in 0.003688155 sec., 271 rows/sec., 7.41 KiB/sec.
2021.02.24 16:05:01.460974 [ 93006 ] {1659BBE71E06CD54} <Debug> DynamicQueryHandler: Done processing query
2021.02.24 16:05:01.461001 [ 93006 ] {1659BBE71E06CD54} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
2021.02.24 16:05:01.466243 [ 93204 ] {} <Trace> HTTPHandler-factory: HTTP Request for HTTPHandler-factory. Method: GET, Address: [::ffff:10.199.141.6]:61092, User-Agent: Go-http-client/1.1, Content Type: , Transfer Encoding: identity
```









http 测试 性能的bug

Query log 

```
 (version 20.12.3.3)
2021.02.25 18:30:37.858227 [ 39127 ] {dbd77360-e246-45af-939e-0c810223db7a} <Debug> MemoryTracker: Peak memory usage (for query): 4.00 MiB.
2021.02.25 18:30:37.858231 [ 15026 ] {910b7d76-b9e7-4057-86e2-00963255a93f} <Warning> ConnectionPoolWithFailover: Connection failed at try №3, reason: Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)
2021.02.25 18:30:37.858246 [ 39127 ] {} <Debug> MemoryTracker: Peak memory usage (for query): 4.00 MiB.
2021.02.25 18:30:37.858918 [ 12961 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Trace> Aggregator: Merged partially aggregated single-level data.
2021.02.25 18:30:37.858946 [ 12961 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Trace> Aggregator: Converting aggregated data to blocks
2021.02.25 18:30:37.858970 [ 12961 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Trace> Aggregator: Converted aggregated data to blocks. 1 rows, 8.00 B in 1.1676e-05 sec. (85645.76909900652 rows/sec., 669.11 KiB/sec.)
2021.02.25 18:30:37.859274 [ 37270 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Information> executeQuery: Read 62899 rows, 35.38 MiB in 1.412880903 sec., 44518 rows/sec., 25.04 MiB/sec.
2021.02.25 18:30:37.859315 [ 37270 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Trace> Aggregator: Destroying aggregate states
2021.02.25 18:30:37.859549 [ 37270 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Trace> Aggregator: Destroying aggregate states
2021.02.25 18:30:37.859701 [ 37270 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Debug> DynamicQueryHandler: Done processing query
2021.02.25 18:30:37.859715 [ 37270 ] {82058e00-c35e-42b3-9808-9ae8ad4f3fab} <Debug> MemoryTracker: Peak memory usage (for query): 12.22 MiB.
2021.02.25 18:30:37.859730 [ 37270 ] {} <Debug> MemoryTracker: Peak memory usage (for query): 12.22 MiB.
2021.02.25 18:30:37.863298 [ 39629 ] {acd28d9f-0106-4472-8baa-bf62fd678ec3} <Trace> StorageDistributed (parts_all): (10.199.141.4:9800) Cancelling query
2021.02.25 18:30:37.866367 [ 39119 ] {5f5cf21e-4ce9-4a8a-87cc-68a00af40e1b} <Error> executeQuery: Code: 279, e.displayText() = DB::NetException: All connection tries failed. Log:

Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)
Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)
Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)

: While executing Remote (version 20.12.3.3) (from [::ffff:172.18.160.19]:18864) (in query: select count(distinct partition) from system.parts_all FORMAT TabSeparatedWithNamesAndTypes;), Stack trace (when copying this message, always include the lines below):

0. /code/clickhouse/build/../contrib/poco/Foundation/src/Exception.cpp:27: Poco::Exception::Exception(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int) @ 0xc3ce6f0 in /data0/jdolap/clickhouse/lib/clickhouse
1. /code/clickhouse/build/../src/Common/Exception.cpp:39: DB::Exception::Exception(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int) @ 0x3ab3fb5 in /data0/jdolap/clickhouse/lib/clickhouse
2. /code/clickhouse/build/../src/Common/NetException.h:12: PoolWithFailoverBase<DB::IConnectionPool>::getMany(unsigned long, unsigned long, unsigned long, unsigned long, bool, std::__1::function<PoolWithFailoverBase<DB::IConnectionPool>::TryResult (DB::IConnectionPool&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >&)> const&, std::__1::function<unsigned long (unsigned long)> const&) @ 0x9857e51 in /data0/jdolap/clickhouse/lib/clickhouse
3. /code/clickhouse/build/../contrib/libcxx/include/functional:1825: DB::ConnectionPoolWithFailover::getManyImpl(DB::Settings const*, DB::PoolMode, std::__1::function<PoolWithFailoverBase<DB::IConnectionPool>::TryResult (DB::IConnectionPool&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >&)> const&) @ 0x9852f48 in /data0/jdolap/clickhouse/lib/clickhouse
4. /code/clickhouse/build/../contrib/libcxx/include/functional:1825: DB::ConnectionPoolWithFailover::getManyChecked(DB::ConnectionTimeouts const&, DB::Settings const*, DB::PoolMode, DB::QualifiedTableName const&) @ 0x98536e3 in /data0/jdolap/clickhouse/lib/clickhouse
5. /code/clickhouse/build/../contrib/libcxx/include/string:2134: std::__1::__function::__func<DB::RemoteQueryExecutor::RemoteQueryExecutor(std::__1::shared_ptr<DB::ConnectionPoolWithFailover> const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, DB::Block const&, DB::Context const&, DB::Settings const*, std::__1::shared_ptr<DB::Throttler> const&, std::__1::map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, DB::Block, std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, DB::Block> > > const&, std::__1::map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::shared_ptr<DB::IStorage>, std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, std::__1::shared_ptr<DB::IStorage> > > > const&, DB::QueryProcessingStage::Enum)::'lambda'(), std::__1::allocator<DB::RemoteQueryExecutor::RemoteQueryExecutor(std::__1::shared_ptr<DB::ConnectionPoolWithFailover> const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, DB::Block const&, DB::Context const&, DB::Settings const*, std::__1::shared_ptr<DB::Throttler> const&, std::__1::map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, DB::Block, std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, DB::Block> > > const&, std::__1::map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::shared_ptr<DB::IStorage>, std::__1::less<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, std::__1::shared_ptr<DB::IStorage> > > > const&, DB::QueryProcessingStage::Enum)::'lambda'()>, std::__1::unique_ptr<DB::MultiplexedConnections, std::__1::default_delete<DB::MultiplexedConnections> > ()>::operator()() @ 0x8fcef69 in /data0/jdolap/clickhouse/lib/clickhouse
6. /code/clickhouse/build/../contrib/libcxx/include/memory:2615: DB::RemoteQueryExecutor::sendQuery() @ 0x8fd2084 in /data0/jdolap/clickhouse/lib/clickhouse
7. /code/clickhouse/build/../src/Processors/Sources/RemoteSource.cpp:52: DB::RemoteSource::generate() @ 0x9a4e941 in /data0/jdolap/clickhouse/lib/clickhouse
8. /code/clickhouse/build/../contrib/libcxx/include/vector:1003: DB::ISource::work() @ 0x98c78f9 in /data0/jdolap/clickhouse/lib/clickhouse
9. /code/clickhouse/build/../src/Processors/Sources/SourceWithProgress.cpp:38: DB::SourceWithProgress::work() @ 0x9a54a67 in /data0/jdolap/clickhouse/lib/clickhouse
10. /code/clickhouse/build/../src/Processors/Executors/PipelineExecutor.cpp:90: std::__1::__function::__func<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::'lambda'(), std::__1::allocator<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::'lambda'()>, void ()>::operator()() @ 0x98eeb9e in /data0/jdolap/clickhouse/lib/clickhouse
11. /code/clickhouse/build/../contrib/libcxx/include/exception:180: DB::PipelineExecutor::executeStepImpl(unsigned long, unsigned long, std::__1::atomic<bool>*) (.constprop.1) @ 0x98f2e88 in /data0/jdolap/clickhouse/lib/clickhouse
12. /code/clickhouse/build/../src/Processors/Executors/PipelineExecutor.cpp:729: ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PipelineExecutor::executeImpl(unsigned long)::'lambda0'()>(DB::PipelineExecutor::executeImpl(unsigned long)::'lambda0'()&&)::'lambda'()::operator()() @ 0x98f3811 in /data0/jdolap/clickhouse/lib/clickhouse
13. /code/clickhouse/build/../contrib/libcxx/include/functional:1853: ThreadPoolImpl<std::__1::thread>::worker(std::__1::__list_iterator<std::__1::thread, void*>) @ 0x3abdd6f in /data0/jdolap/clickhouse/lib/clickhouse
14. /code/clickhouse/build/../contrib/libcxx/include/memory:2615: void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void ThreadPoolImpl<std::__1::thread>::scheduleImpl<void>(std::__1::function<void ()>, int, std::__1::optional<unsigned long>)::'lambda1'()> >(void*) @ 0x3abcbb3 in /data0/jdolap/clickhouse/lib/clickhouse
15. start_thread @ 0x7dc5 in /usr/lib64/libpthread-2.17.so
16. clone @ 0xf621d in /usr/lib64/libc-2.17.so

2021.02.25 18:30:37.866696 [ 39119 ] {5f5cf21e-4ce9-4a8a-87cc-68a00af40e1b} <Trace> Aggregator: Destroying aggregate states
2021.02.25 18:30:37.867041 [ 39119 ] {5f5cf21e-4ce9-4a8a-87cc-68a00af40e1b} <Error> DynamicQueryHandler: Code: 279, e.displayText() = DB::NetException: All connection tries failed. Log:

Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)
Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)
Code: 209, e.displayText() = DB::NetException: Timeout: connect timed out: 10.199.141.4:9600 (10.199.141.4:9600) (version 20.12.3.3)

: While executing Remote, Stack trace (when copying this message, always include the lines below):
```













Asked 9 months ago

Active [1 month ago](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof?lastactivity)

Viewed 768 times



1



I created a dictionary on Clickhouse using the following script:

```sql
CREATE DICTIONARY IF NOT EXISTS default.testDICT
(
    -- attributes
)
PRIMARY KEY DATETIME, SOMEID, SOMEID2
SOURCE(CLICKHOUSE(HOST 'localhost' PORT 9000 USER 'default' PASSWORD '' DB 'default' TABLE 'test'))
LIFETIME(MIN 0 MAX 300)
LAYOUT(COMPLEX_KEY_HASHED())
```

The table test has approximately 19 000 000 rows.

And when I try to execute a select

```sql
SELECT * FROM testDICT 
```

, which also loads the dictionary if I understood well, it sends me the following error:

```sh
Exception on client:
Code: 32. DB::Exception: Attempt to read after eof: while receiving packet from clickhouse-server:9000

Connecting to clickhouse-server:9000 as user default.
Code: 210. DB::NetException: Connection refused (clickhouse-server:9000)
```

Do you know what it means and also how can I correct it?

[sql](https://stackoverflow.com/questions/tagged/sql)[database](https://stackoverflow.com/questions/tagged/database)[dictionary](https://stackoverflow.com/questions/tagged/dictionary)[clickhouse](https://stackoverflow.com/questions/tagged/clickhouse)

[Share](https://stackoverflow.com/q/61805068)

[Improve this question](https://stackoverflow.com/posts/61805068/edit)

Follow

asked May 14 '20 at 18:44

[![img](https://www.gravatar.com/avatar/7ecbeec2cece6b21a35da40726a0c38f?s=32&d=identicon&r=PG&f=1)](https://stackoverflow.com/users/13182119/090238957548239)

[090238957548239](https://stackoverflow.com/users/13182119/090238957548239)

**87**11 silver badge99 bronze badges

- 1

  I think this is the wrong way to using a dictionary because the count of rows is huge. I suspect even using [cached layout](https://clickhouse.tech/docs/en/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache) (as @Denis Zhuravlev suggested) does not help because of the [hit rate](https://clickhouse.tech/docs/en/operations/system-tables/#system_tables-dictionaries) will be small that be pretty not effective. – [vladimir](https://stackoverflow.com/users/303298/vladimir) [May 14 '20 at 23:17](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof#comment109326939_61805068)

[Add a comment](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof#)



## 2 Answers

[Active](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof?answertab=active#tab-top)[Oldest](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof?answertab=oldest#tab-top)[Votes](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof?answertab=votes#tab-top)





2







19 000 000 rows is too many for a dictionary. Probably it will require 10-20GB RAM.

So your CH crashed or killed by OOM killer. Check `sudo dmesg|tail -100`

Try cached dictionaries layout to load only part of 19 000 000 into memory at once.



[Share](https://stackoverflow.com/a/61805594)

[Improve this answer](https://stackoverflow.com/posts/61805594/edit)

Follow

answered May 14 '20 at 19:13

[![img](https://i.stack.imgur.com/WCznI.jpg?s=32&g=1)](https://stackoverflow.com/users/11644308/denny-crane)

[Denny Crane](https://stackoverflow.com/users/11644308/denny-crane)

**4,317**22 gold badges44 silver badges1515 bronze badges

[Add a comment](https://stackoverflow.com/questions/61805068/clickhouse-code-32-dbexception-attempt-to-read-after-eof#)





0



As suggested in this blog, try to do the following before inserting: `set max_insert_threads=32;` I first also got the same error, but after I changed max_insert_threads, I successfully inserted almost 200GB of data.

https://altinity.com/blog/clickhouse-and-redshift-face-off-again-in-nyc-taxi-rides-benchmark