2020.08.21 17:47:41.901152 [ 5410 ] {} <Trace> PrometheusHandler-factory: HTTP Request for PrometheusHandler-factory. Method: GET, Address: [::ffff:172.21.134.11]:57916, User-Agent: Go-http-client/1.1, Content Type: , Transfer Encoding: identity

2020.08.21 17:47:42.989042 [ 5389 ] {} <Debug> songenjie.table_test_local6 (ReplicatedMergeTreeQueue): Pulling 1 entries to queue: log-0000000003 - log-0000000003

2020.08.21 17:47:42.992956 [ 5389 ] {} <Debug> songenjie.table_test_local6 (ReplicatedMergeTreeQueue): Pulled 1 entries to queue.

2020.08.21 17:47:42.998056 [ 5378 ] {} <Debug> songenjie.table_test_local6: Fetching part 20200616_0_0_0 from /clickhouse/ZYX_CK_Pub_04/jdob_ha/songenjie/table_test_local6/08/replicas/01

2020.08.21 17:47:43.001129 [ 5378 ] {} <Error> songenjie.table_test_local6: DB::StorageReplicatedMergeTree::queueTask()::<lambda(DB::StorageReplicatedMergeTree::LogEntryPtr&)>: Poco::Exception. Code: 1000, e.code() = 0, e.displayText() = Host not found: A01-R26-I137-246-J33KMKX.JD.LOCAL, Stack trace (when copying this message, always include the lines below):



\0. Poco::IOException::IOException(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int) @ 0x10ed9500 in /data0/jdolap/clickhouse/lib/clickhouse

\1. Poco::Net::HostNotFoundException::HostNotFoundException(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int) @ 0x10dca95d in /data0/jdolap/clickhouse/lib/clickhouse

\2. Poco::Net::DNS::aierror(int, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&) @ 0x10d9e80d in /data0/jdolap/clickhouse/lib/clickhouse

\3. ? @ 0x10d9e98e in /data0/jdolap/clickhouse/lib/clickhouse

\4. ? @ 0x968ca7a in /data0/jdolap/clickhouse/lib/clickhouse

\5. DB::DNSResolver::resolveHost(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&) @ 0x968e90c in /data0/jdolap/clickhouse/lib/clickhouse

\6. ? @ 0xc0b2af9 in /data0/jdolap/clickhouse/lib/clickhouse

\7. PoolBase<Poco::Net::HTTPClientSession>::get(long) @ 0xc0b5b34 in /data0/jdolap/clickhouse/lib/clickhouse

\8. ? @ 0xc0b3423 in /data0/jdolap/clickhouse/lib/clickhouse

\9. DB::makePooledHTTPSession(Poco::URI const&, DB::ConnectionTimeouts const&, unsigned long) @ 0xc0b4e8c in /data0/jdolap/clickhouse/lib/clickhouse

\10. DB::DataPartsExchange::Fetcher::fetchPart(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int, DB::ConnectionTimeouts const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, bool, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&) @ 0xe3a50f4 in /data0/jdolap/clickhouse/lib/clickhouse

\11. ? @ 0xe26cbb3 in /data0/jdolap/clickhouse/lib/clickhouse

\12. DB::StorageReplicatedMergeTree::fetchPart(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, bool, unsigned long) @ 0xe2b6d23 in /data0/jdolap/clickhouse/lib/clickhouse

\13. DB::StorageReplicatedMergeTree::executeFetch(DB::ReplicatedMergeTreeLogEntry&) @ 0xe2b9f63 in /data0/jdolap/clickhouse/lib/clickhouse

\14. DB::StorageReplicatedMergeTree::executeLogEntry(DB::ReplicatedMergeTreeLogEntry&) @ 0xe2bb591 in /data0/jdolap/clickhouse/lib/clickhouse

\15. ? @ 0xe2bb97d in /data0/jdolap/clickhouse/lib/clickhouse

\16. DB::ReplicatedMergeTreeQueue::processEntry(std::__1::function<std::__1::shared_ptr<zkutil::ZooKeeper> ()>, std::__1::shared_ptr<DB::ReplicatedMergeTreeLogEntry>&, std::__1::function<bool (std::__1::shared_ptr<DB::ReplicatedMergeTreeLogEntry>&)>) @ 0xe5a99b2 in /data0/jdolap/clickhouse/lib/clickhouse

\17. DB::StorageReplicatedMergeTree::queueTask() @ 0xe26e52e in /data0/jdolap/clickhouse/lib/clickhouse

\18. DB::BackgroundProcessingPool::workLoopFunc() @ 0xe39f763 in /data0/jdolap/clickhouse/lib/clickhouse

\19. ? @ 0xe3a0092 in /data0/jdolap/clickhouse/lib/clickhouse

\20. ThreadPoolImpl<std::__1::thread>::worker(std::__1::__list_iterator<std::__1::thread, void*>) @ 0x95f6e97 in /data0/jdolap/clickhouse/lib/clickhouse

\21. ? @ 0x95f5383 in /data0/jdolap/clickhouse/lib/clickhouse

\22. start_thread @ 0x7dc5 in /usr/lib64/libpthread-2.17.so

\23. clone @ 0xf621d in /usr/lib64/libc-2.17.so

 (version 20.5.2.7 (official build))