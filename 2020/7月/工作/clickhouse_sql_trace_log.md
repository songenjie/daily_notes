```
kc-bcc-pod22-10-196-102-231.hadoop.jd.local :) select count(*)  from app_pop_ord_basic;

SELECT count(*)
FROM app_pop_ord_basic

[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.182485 [ 39458 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Debug> executeQuery: (from [::ffff:172.18.160.19]:54726) select count(*) from app_pop_ord_basic;
↑ Progress: 0.00 rows, 0.00 B (0.00 rows/s., 0.00 B/s.) 
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.183227 [ 39458 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> ContextAccess (default): Access granted: SELECT(sale_qtty) ON open_inventory.app_pop_ord_basic
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.183688 [ 39458 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> ContextAccess (default): Access granted: SELECT(sale_qtty) ON open_inventory.app_pop_ord_basic
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.184334 [ 39458 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.184957 [ 39458 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.185317 [ 39458 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> InterpreterSelectQuery: WithMergeableState -> Complete
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.185850 [ 16300 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> MergingAggregatedTransform: Reading blocks of partially aggregated data.
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 15:45:12.199506 [ 106043 ] {0198afea-6eb3-4b65-869a-54aee85c9df6} <Debug> executeQuery: (from [::ffff:10.196.102.231]:40102, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 15:45:12.184743 [ 129791 ] {4e9fc7f5-296e-4e47-a4e6-6e624d6d8a78} <Debug> executeQuery: (from [::ffff:10.196.102.231]:55464, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 15:45:12.193365 [ 64425 ] {da5e01b6-f710-4d5f-b559-ec3aece940e1} <Debug> executeQuery: (from [::ffff:10.196.102.231]:52994, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 15:45:12.196445 [ 91159 ] {7165d2cf-d8ea-4078-b416-8a300701c686} <Debug> executeQuery: (from [::ffff:10.196.102.231]:24032, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 15:45:12.190907 [ 88470 ] {b5a04727-502e-4aa4-b483-b31a999bbf55} <Debug> executeQuery: (from [::ffff:10.196.102.231]:44894, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 15:45:12.185597 [ 116076 ] {1e8bbfb0-bf05-43a2-82da-65ee8a9cfe0b} <Debug> executeQuery: (from [::ffff:10.196.102.231]:50970, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 15:45:12.184925 [ 41655 ] {df9d5e70-dd49-44a6-8347-90af32d62f99} <Debug> executeQuery: (from [::ffff:10.196.102.231]:54944, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 15:45:12.187533 [ 107855 ] {d5488c0d-57be-41bd-b766-2124e0514054} <Debug> executeQuery: (from [::ffff:10.196.102.231]:51858, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 15:45:12.185587 [ 28474 ] {17efd446-7e42-443a-85be-59ec3e7c6c83} <Debug> executeQuery: (from [::ffff:10.196.102.231]:27258, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 15:45:12.184903 [ 112656 ] {7b947693-7891-4793-8652-078007b4e38e} <Debug> executeQuery: (from [::ffff:10.196.102.231]:11804, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 15:45:12.184510 [ 8078 ] {0023715a-aee8-4ad1-b142-9ba48da1c6dd} <Debug> executeQuery: (from [::ffff:10.196.102.231]:50100, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 15:45:12.188603 [ 112006 ] {e1531a66-1c3f-460e-a14a-2a80f331bbe3} <Debug> executeQuery: (from [::ffff:10.196.102.231]:29904, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 15:45:12.185462 [ 131014 ] {462d4966-896e-4b78-8428-77e64691de7f} <Debug> executeQuery: (from [::ffff:10.196.102.231]:56578, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 15:45:12.186678 [ 29981 ] {ade668ca-becd-4474-8a75-3b7445f13c69} <Debug> executeQuery: (from [::ffff:10.196.102.231]:23448, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 15:45:12.187721 [ 39944 ] {9df58b7b-2f4d-4412-a3e7-e85c73882421} <Debug> executeQuery: (from [::ffff:10.196.102.231]:37690, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 15:45:12.183358 [ 36644 ] {90ccf1ad-3f89-4fec-b316-682bc2964d08} <Debug> executeQuery: (from [::ffff:10.196.102.231]:43116, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 15:45:12.187377 [ 128367 ] {71f14734-090c-4ca7-835e-6d9a0ab09e6c} <Debug> executeQuery: (from [::ffff:10.196.102.231]:25058, initial_query_id: 31975fa8-7fd6-4847-aa0c-1527b3e341ab) SELECT count() FROM open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 15:45:12.186414 [ 116076 ] {1e8bbfb0-bf05-43a2-82da-65ee8a9cfe0b} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 15:45:12.187194 [ 116076 ] {1e8bbfb0-bf05-43a2-82da-65ee8a9cfe0b} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 15:45:12.184321 [ 36644 ] {90ccf1ad-3f89-4fec-b316-682bc2964d08} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 15:45:12.184815 [ 36644 ] {90ccf1ad-3f89-4fec-b316-682bc2964d08} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 15:45:12.200378 [ 106043 ] {0198afea-6eb3-4b65-869a-54aee85c9df6} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 15:45:12.201075 [ 106043 ] {0198afea-6eb3-4b65-869a-54aee85c9df6} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 15:45:12.188554 [ 107855 ] {d5488c0d-57be-41bd-b766-2124e0514054} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 15:45:12.189135 [ 107855 ] {d5488c0d-57be-41bd-b766-2124e0514054} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 15:45:12.186318 [ 131014 ] {462d4966-896e-4b78-8428-77e64691de7f} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 15:45:12.186893 [ 131014 ] {462d4966-896e-4b78-8428-77e64691de7f} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 15:45:12.188756 [ 39944 ] {9df58b7b-2f4d-4412-a3e7-e85c73882421} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 15:45:12.189285 [ 39944 ] {9df58b7b-2f4d-4412-a3e7-e85c73882421} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 15:45:12.185599 [ 8078 ] {0023715a-aee8-4ad1-b142-9ba48da1c6dd} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 15:45:12.186155 [ 8078 ] {0023715a-aee8-4ad1-b142-9ba48da1c6dd} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 15:45:12.187692 [ 29981 ] {ade668ca-becd-4474-8a75-3b7445f13c69} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 15:45:12.188398 [ 29981 ] {ade668ca-becd-4474-8a75-3b7445f13c69} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 15:45:12.186192 [ 129791 ] {4e9fc7f5-296e-4e47-a4e6-6e624d6d8a78} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 15:45:12.186651 [ 129791 ] {4e9fc7f5-296e-4e47-a4e6-6e624d6d8a78} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 15:45:12.185421 [ 36644 ] {90ccf1ad-3f89-4fec-b316-682bc2964d08} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.001975402 sec., 506 rows/sec., 1.98 MiB/sec.
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local] 2020.08.04 15:45:12.185452 [ 36644 ] {90ccf1ad-3f89-4fec-b316-682bc2964d08} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 15:45:12.188393 [ 128367 ] {71f14734-090c-4ca7-835e-6d9a0ab09e6c} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 15:45:12.189080 [ 128367 ] {71f14734-090c-4ca7-835e-6d9a0ab09e6c} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 15:45:12.187876 [ 116076 ] {1e8bbfb0-bf05-43a2-82da-65ee8a9cfe0b} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002236872 sec., 447 rows/sec., 1.75 MiB/sec.
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local] 2020.08.04 15:45:12.187907 [ 116076 ] {1e8bbfb0-bf05-43a2-82da-65ee8a9cfe0b} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 15:45:12.189739 [ 107855 ] {d5488c0d-57be-41bd-b766-2124e0514054} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002146582 sec., 465 rows/sec., 1.82 MiB/sec.
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local] 2020.08.04 15:45:12.189797 [ 107855 ] {d5488c0d-57be-41bd-b766-2124e0514054} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 15:45:12.187556 [ 131014 ] {462d4966-896e-4b78-8428-77e64691de7f} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002051511 sec., 487 rows/sec., 1.91 MiB/sec.
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local] 2020.08.04 15:45:12.187601 [ 131014 ] {462d4966-896e-4b78-8428-77e64691de7f} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 15:45:12.197913 [ 91159 ] {7165d2cf-d8ea-4078-b416-8a300701c686} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 15:45:12.198443 [ 91159 ] {7165d2cf-d8ea-4078-b416-8a300701c686} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 15:45:12.201855 [ 106043 ] {0198afea-6eb3-4b65-869a-54aee85c9df6} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002279675 sec., 438 rows/sec., 1.72 MiB/sec.
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local] 2020.08.04 15:45:12.201884 [ 106043 ] {0198afea-6eb3-4b65-869a-54aee85c9df6} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 15:45:12.189806 [ 112006 ] {e1531a66-1c3f-460e-a14a-2a80f331bbe3} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 15:45:12.190476 [ 112006 ] {e1531a66-1c3f-460e-a14a-2a80f331bbe3} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 15:45:12.186791 [ 8078 ] {0023715a-aee8-4ad1-b142-9ba48da1c6dd} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002233524 sec., 447 rows/sec., 1.75 MiB/sec.
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local] 2020.08.04 15:45:12.186823 [ 8078 ] {0023715a-aee8-4ad1-b142-9ba48da1c6dd} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 15:45:12.189976 [ 39944 ] {9df58b7b-2f4d-4412-a3e7-e85c73882421} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002166346 sec., 461 rows/sec., 1.81 MiB/sec.
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local] 2020.08.04 15:45:12.190009 [ 39944 ] {9df58b7b-2f4d-4412-a3e7-e85c73882421} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 15:45:12.188946 [ 29981 ] {ade668ca-becd-4474-8a75-3b7445f13c69} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002210924 sec., 452 rows/sec., 1.77 MiB/sec.
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local] 2020.08.04 15:45:12.188994 [ 29981 ] {ade668ca-becd-4474-8a75-3b7445f13c69} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 15:45:12.187244 [ 129791 ] {4e9fc7f5-296e-4e47-a4e6-6e624d6d8a78} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002460738 sec., 406 rows/sec., 1.59 MiB/sec.
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local] 2020.08.04 15:45:12.187276 [ 129791 ] {4e9fc7f5-296e-4e47-a4e6-6e624d6d8a78} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 15:45:12.192538 [ 88470 ] {b5a04727-502e-4aa4-b483-b31a999bbf55} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 15:45:12.193100 [ 88470 ] {b5a04727-502e-4aa4-b483-b31a999bbf55} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 15:45:12.198979 [ 91159 ] {7165d2cf-d8ea-4078-b416-8a300701c686} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002488727 sec., 401 rows/sec., 1.57 MiB/sec.
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local] 2020.08.04 15:45:12.199010 [ 91159 ] {7165d2cf-d8ea-4078-b416-8a300701c686} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 15:45:12.189784 [ 128367 ] {71f14734-090c-4ca7-835e-6d9a0ab09e6c} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002316893 sec., 431 rows/sec., 1.69 MiB/sec.
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local] 2020.08.04 15:45:12.189809 [ 128367 ] {71f14734-090c-4ca7-835e-6d9a0ab09e6c} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 15:45:12.187266 [ 28474 ] {17efd446-7e42-443a-85be-59ec3e7c6c83} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 15:45:12.187857 [ 28474 ] {17efd446-7e42-443a-85be-59ec3e7c6c83} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 15:45:12.191163 [ 112006 ] {e1531a66-1c3f-460e-a14a-2a80f331bbe3} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002501297 sec., 399 rows/sec., 1.56 MiB/sec.
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local] 2020.08.04 15:45:12.191219 [ 112006 ] {e1531a66-1c3f-460e-a14a-2a80f331bbe3} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 15:45:12.186732 [ 41655 ] {df9d5e70-dd49-44a6-8347-90af32d62f99} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 15:45:12.187341 [ 41655 ] {df9d5e70-dd49-44a6-8347-90af32d62f99} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 15:45:12.193760 [ 88470 ] {b5a04727-502e-4aa4-b483-b31a999bbf55} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.002766434 sec., 361 rows/sec., 1.41 MiB/sec.
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local] 2020.08.04 15:45:12.193791 [ 88470 ] {b5a04727-502e-4aa4-b483-b31a999bbf55} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 15:45:12.188415 [ 28474 ] {17efd446-7e42-443a-85be-59ec3e7c6c83} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.00276752 sec., 361 rows/sec., 1.41 MiB/sec.
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local] 2020.08.04 15:45:12.188452 [ 28474 ] {17efd446-7e42-443a-85be-59ec3e7c6c83} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 15:45:12.195712 [ 64425 ] {da5e01b6-f710-4d5f-b559-ec3aece940e1} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 15:45:12.196180 [ 64425 ] {da5e01b6-f710-4d5f-b559-ec3aece940e1} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 15:45:12.188007 [ 41655 ] {df9d5e70-dd49-44a6-8347-90af32d62f99} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.00304485 sec., 328 rows/sec., 1.29 MiB/sec.
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local] 2020.08.04 15:45:12.188069 [ 41655 ] {df9d5e70-dd49-44a6-8347-90af32d62f99} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 15:45:12.196730 [ 64425 ] {da5e01b6-f710-4d5f-b559-ec3aece940e1} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.003324575 sec., 300 rows/sec., 1.18 MiB/sec.
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local] 2020.08.04 15:45:12.196763 [ 64425 ] {da5e01b6-f710-4d5f-b559-ec3aece940e1} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 15:45:12.190281 [ 112656 ] {7b947693-7891-4793-8652-078007b4e38e} <Trace> ContextAccess (default): Access granted: SELECT(school_agent_acct_num) ON open_inventory.app_pop_ord_basic_local
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 15:45:12.190747 [ 112656 ] {7b947693-7891-4793-8652-078007b4e38e} <Trace> InterpreterSelectQuery: WithMergeableState -> WithMergeableState
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 15:45:12.191460 [ 112656 ] {7b947693-7891-4793-8652-078007b4e38e} <Information> executeQuery: Read 1 rows, 4.01 KiB in 0.006484052 sec., 154 rows/sec., 618.10 KiB/sec.
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local] 2020.08.04 15:45:12.191498 [ 112656 ] {7b947693-7891-4793-8652-078007b4e38e} <Debug> MemoryTracker: Peak memory usage (for query): 0.00 B.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.193256 [ 16300 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> MergingAggregatedTransform: Read 18 blocks of partially aggregated data, total 18 rows.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.193291 [ 16300 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> Aggregator: Merging partially aggregated single-level data.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.193332 [ 16300 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> Aggregator: Merged partially aggregated single-level data.
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.193341 [ 16300 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> Aggregator: Converting aggregated data to blocks
[KC-BCC-POD22-10-196-102-231.hadoop.jd.local] 2020.08.04 15:45:12.193358 [ 16300 ] {31975fa8-7fd6-4847-aa0c-1527b3e341ab} <Trace> Aggregator: Converted aggregated data to blocks. 1 rows, 8.00 B in 5.929e-06 sec. (168662.50632484397 rows/sec., 1.29 MiB/sec.)



[KC-BCC-POD22-10-196-102-231.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-232.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-234.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-236.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-3.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-34.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-36.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-38.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-39.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-4.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-40.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-42.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-43.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-5.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-6.hadoop.jd.local]
[KC-BCC-POD22-10-196-102-67.hadoop.jd.local]
[KC-BCC-POD22-10-196-103-12.hadoop.jd.local]
[KC-BCC-POD22-10-196-103-37.hadoop.jd.local]
```

