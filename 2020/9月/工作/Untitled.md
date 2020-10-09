```
[A01-R26-I140-10-5261017.JD.LOCAL] 2020.09.25 18:15:00.497928 [ 3668 ] {b3577826-d8e6-47f6-a13e-577cd07491eb} <Trace> Aggregator: Merging aggregated data
┌─database─┬─table──────────────────────────────────────┬─disk_name─┬─size───────┬─bytes_on_disk─┬─data_uncompressed_bytes─┬─data_compressed_bytes─┬──────compress_rate─┬───────rows─┬─days─┬─avgDaySize─┐
│ adm_ck   │ adm_d01_user_behavior_service_di_local     │ disk2     │ 1.36 GiB   │ 1.36 GiB      │ 3.17 GiB                │ 1.36 GiB              │ 43.043329825026625 │    9959419 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_behavior_service_di_local     │ disk3     │ 3.47 GiB   │ 3.47 GiB      │ 8.03 GiB                │ 3.47 GiB              │ 43.212030952930014 │   26211921 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_behavior_service_di_local     │ disk1     │ 1.07 GiB   │ 1.07 GiB      │ 2.47 GiB                │ 1.07 GiB              │ 43.437214692907716 │    8004917 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_behavior_service_di_local     │ disk0     │ 1.75 GiB   │ 1.75 GiB      │ 4.31 GiB                │ 1.75 GiB              │ 40.664567177883946 │   15157655 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_ord_sku_service_da_local      │ disk0     │ 7.39 GiB   │ 7.39 GiB      │ 36.05 GiB               │ 7.37 GiB              │ 20.451754078582795 │   42546189 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_ord_sku_service_da_local      │ disk1     │ 167.12 GiB │ 167.12 GiB    │ 999.46 GiB              │ 166.69 GiB            │  16.67834915707423 │ 1179381595 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_ord_sku_service_da_local      │ disk3     │ 8.20 GiB   │ 8.20 GiB      │ 40.20 GiB               │ 8.18 GiB              │ 20.354532246017886 │   47431702 │    0 │ inf YiB    │
│ adm_ck   │ adm_d01_user_ord_sku_service_da_local      │ disk2     │ 7.46 GiB   │ 7.46 GiB      │ 36.41 GiB               │ 7.44 GiB              │  20.44015454586158 │   42968699 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d03_sold_item_sku_da_local         │ disk1     │ 932.54 MiB │ 932.54 MiB    │ 2.60 GiB                │ 931.77 MiB            │   34.9461643215658 │    4566035 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d03_sold_item_sku_da_local         │ disk0     │ 45.36 MiB  │ 45.36 MiB     │ 135.31 MiB              │ 45.32 MiB             │ 33.494451240085525 │     241760 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d03_sold_item_sku_da_local         │ disk2     │ 526.58 MiB │ 526.58 MiB    │ 1.47 GiB                │ 526.14 MiB            │ 35.023767143767095 │    2566202 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d03_sold_item_sku_da_local         │ disk3     │ 292.25 MiB │ 292.25 MiB    │ 819.04 MiB              │ 292.01 MiB            │ 35.652831041482514 │    1427283 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d04_trade_ord_sku_service_di_local │ disk2     │ 11.05 GiB  │ 11.05 GiB     │ 71.96 GiB               │ 11.03 GiB             │ 15.330112237680451 │   66882920 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d04_trade_ord_sku_service_di_local │ disk3     │ 8.74 GiB   │ 8.74 GiB      │ 57.29 GiB               │ 8.73 GiB              │ 15.232748855262912 │   53259670 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d04_trade_ord_sku_service_di_local │ disk1     │ 7.58 GiB   │ 7.58 GiB      │ 49.60 GiB               │ 7.57 GiB              │ 15.257056408696556 │   46103984 │    0 │ inf YiB    │
│ adm_ck   │ adm_sch_d04_trade_ord_sku_service_di_local │ disk0     │ 2.13 GiB   │ 2.13 GiB      │ 14.51 GiB               │ 2.13 GiB              │ 14.675966013474111 │   13599419 │    0 │ inf YiB    │
│ system   │ query_log                                  │ default   │ 11.37 MiB  │ 11.37 MiB     │ 157.94 MiB              │ 11.33 MiB             │  7.174518423173544 │     106274 │    8 │ 1.42 MiB   │
│ system   │ query_thread_log                           │ default   │ 28.25 MiB  │ 28.25 MiB     │ 794.05 MiB              │ 28.15 MiB             │ 3.5456124349772833 │     382428 │    8 │ 3.53 MiB   │
│ system   │ trace_log                                  │ default   │ 53.74 MiB  │ 53.74 MiB     │ 606.18 MiB              │ 53.62 MiB             │  8.845428288194368 │    4006401 │    8 │ 6.72 MiB   │
└──────────┴────────────────────────────────────────────┴───────────┴────────────┴───────────────┴─────────────────────────┴───────────────────────┴────────────────────┴────────────┴──────┴────────────┘
```





```
. Poco::Net::ConnectionResetException::ConnectionResetException(int) @ 0x122f871d in /data0/jdolap/clickhouse/lib/clickhouse
2. ? @ 0x1231555a in /data0/jdolap/clickhouse/lib/clickhouse
3. Poco::Net::SocketImpl::receiveBytes(void*, int, int) @ 0x12313c53 in /data0/jdolap/clickhouse/lib/clickhouse
4. Poco::Net::HTTPSession::receive(char*, int) @ 0x122e1f28 in /data0/jdolap/clickhouse/lib/clickhouse
5. Poco::Net::HTTPSession::get() @ 0x122e1f93 in /data0/jdolap/clickhouse/lib/clickhouse
6. Poco::Net::HTTPHeaderStreamBuf::readFromDevice(char*, long) @ 0x122d6b4a in /data0/jdolap/clickhouse/lib/clickhouse
7. Poco::BasicBufferedStreamBuf<char, std::__1::char_traits<char>, Poco::Net::HTTPBufferAllocator>::underflow() @ 0x122d34a8 in /data0/jdolap/clickhouse/lib/clickhouse
8. std::__1::basic_streambuf<char, std::__1::char_traits<char> >::uflow() @ 0x1335713e in ?
9. std::__1::basic_istream<char, std::__1::char_traits<char> >::get() @ 0x1335e736 in ?
10. Poco::Net::HTTPRequest::read(std::__1::basic_istream<char, std::__1::char_traits<char> >&) @ 0x122d9c27 in /data0/jdolap/clickhouse/lib/clickhouse
11. Poco::Net::HTTPServerRequestImpl::HTTPServerRequestImpl(Poco::Net::HTTPServerResponseImpl&, Poco::Net::HTTPServerSession&, Poco::Net::HTTPServerParams*) @ 0x122e0055 in /data0/jdolap/clickhouse/lib/clickhouse
12. Poco::Net::HTTPServerConnection::run() @ 0x122dea1c in /data0/jdolap/clickhouse/lib/clickhouse
13. Poco::Net::TCPServerConnection::start() @ 0x1231cbeb in /data0/jdolap/clickhouse/lib/clickhouse
14. Poco::Net::TCPServerDispatcher::run() @ 0x1231d07b in /data0/jdolap/clickhouse/lib/clickhouse
15. Poco::PooledThread::run() @ 0x1249bba6 in /data0/jdolap/clickhouse/lib/clickhouse
16. Poco::ThreadImpl::runnableEntry(void*) @ 0x12496fa0 in /data0/jdolap/clickhouse/lib/clickhouse
17. start_thread @ 0x7dc5 in /usr/lib64/libpthread-2.17.so
18. clone @ 0xf621d in /usr/lib64/libc-2.17.so
 (version 20.6.5.8 (official build))
2020.09.25 16:47:21.499094 [ 1806 ] {} <Debug> DNSResolver: Updated DNS cache
2020.09.25 16:47:21.503175 [ 1824 ] {} <Debug> DiskLocal: Reserving 1.00 MiB on disk `default`, having unreserved 1.59 TiB.
2020.09.25 16:47:21.515898 [ 1824 ] {} <Trace> system.trace_log: Renaming temporary part tmp_insert_202009_83726_83726_0 to 202009_91154_91154_0.
2020.09.25 16:47:21.516267 [ 1824 ] {} <Trace> SystemLog (system.trace_log): Flushed system log
2020.09.25 16:47:21.516335 [ 1822 ] {} <Trace> system.trace_log: Found 12 old parts to remove.
2020.09.25 16:47:21.516408 [ 1822 ] {} <Debug> system.trace_log: Removing part from filesystem 202009_88705_91095_1755
2020.09.25 16:47:21.598221 [ 1820 ] {} <Debug> system.trace_log (MergerMutator): Selected 6 parts from 202009_91149_91149_0 to 202009_91154_91154_0
2020.09.25 16:47:21.598325 [ 1820 ] {} <Debug> DiskLocal: Reserving 1.00 MiB on disk `default`, having unreserved 1.59 TiB.
2020.09.25 16:47:21.598381 [ 1820 ] {} <Debug> system.trace_log (MergerMutator): Merging 6 parts: from 202009_91149_91149_0 to 202009_91154_91154_0 into Compact
2020.09.25 16:47:21.683421 [ 28000 ] {fb6c4065-2899-403d-90d9-f39a495c2202} <Debug> executeQuery: (from [::ffff:10.199.140.20]:56362, initial_query_id: 8577f7bf-beb0-4f2d-98d1-a22268b3e7ad) SELECT sku.bu_name, sale_cha_cd, uniqExact(intr_parent_sale_ord_id) AS intr_parent_num, uniqExact(intr_sale_ord_id) AS intr_sale_num, SUM(intr_sale_qtty) AS intr_qtty, SUM(intr_amt) AS intr_amt, uniqExact(valid_parent_sale_ord_id) AS valid_parent_num FROM adm_ck.adm_sch_d04_trade_ord_sku_service_di_local AS act ALL INNER JOIN adm_ck.adm_sch_d03_sold_item_sku_da_local AS sku ON act.real_sku_id = sku.item_sku_id WHERE dt >= '2020-07-24' GROUP BY sku.bu_name, sale_cha_cd
2020.09.25 16:47:22.617623 [ 1822 ] {} <Debug> system.trace_log: Removing part from filesystem 202009_88705_91096_1756
2020.09.25 16:48:01.909865 [ 28148 ] {} <Information> SentryWriter: Sending crash reports is disabled
2020.09.25 16:48:01.960521 [ 28148 ] {} <Trace> Pipe: Pipe capacity is 1.00 MiB
2020.09.25 16:48:02.114250 [ 28148 ] {} <Information> : Starting ClickHouse 20.6.5.8 with revision 54436, no build id, PID 28148
2020.09.25 16:48:02.114388 [ 28148 ] {} <Information> Application: starting up
2020.09.25 16:48:02.466677 [ 28148 ] {} <Debug> Application: rlimit on number of file descriptors is 500000
2020.09.25 16:48:02.466705 [ 28148 ] {} <Debug> Application: Initializing DateLUT.
2020.09.25 16:48:02.466715 [ 28148 ] {} <Trace> Application: Initialized DateLUT with time zone 'Asia/Shanghai'.
2020.09.25 16:48:02.466759 [ 28148 ] {} <Debug> Application: Setting up /data0/jdolap/clickhouse/tmpdata/ to store temporary data in it
2020.09.25 16:48:02.479077 [ 28148 ] {} <Debug> ConfigReloader: Loading config '/data0/jdolap/clickhouse/conf/users.xml'
2020.09.25 16:48:02.492633 [ 28148 ] {} <Debug> ConfigReloader: Loaded config '/data0/jdolap/clickhouse/conf/users.xml', performing update on configuration
```

202009_88705_91095_1755





202009_91149_91149_0



