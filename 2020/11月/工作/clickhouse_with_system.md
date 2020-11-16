| Sectors  | disk Block | File  | Inode | clickhouse block | clickhouse index | doris segment | doris  clumn page        |
| -------- | ---------- | ----- | ----- | ---------------- | ---------------- | ------------- | ------------------------ |
| 512Bytes | 4k         | eg 4M |       | 64k~1M           | 8192rows 8k      | 512M          | Page size    1024rows 1k |
| 0.5K     | 2^2K       | 2^12K |       | 2^10K            | 2^3K             | 2^19K         | 1K                       |
| 2^20     | 2^17       | 2^7   |       | 2^9              | 2^16             | 1             | 2^19                     |



clickhouse 原子同步性 block id ,1M

doris 原子同步性 rowset--segment  nM



clickhouse 命中一个索引 命中一个block 1M到内存，1024个扇区

clickhouse block 目前和系统block  现在数据 1:2^8 的比例，命中多个block，索引区间选择需要耗时，建议修改 disk block size





sql like where  column_name in ('1','4','6')...



clickhouse 某业务 分析字段 多维命中索引分析 

column_name.bin     23M.     23*2^10K 大约  2^16k

column_name.mrk2  32k

count.txt   5554818     2^22

┌─power(5554818, divide(1, 2))─┐
│           2356.8661396014836 │
└──────────────────────────────┘



一行大约 1/46 k/row. 一行 0.02k index

 8192行索引情况下,索引间隔为 178k/index  block size 1M. 23M

23个Block

1M/178K 一个 block 5.75 个索引

意思就是命中一个索引的情况下 有 4.75的数据是多余load 从磁盘load的，内存 4.75/5。百分之82.6的数据从磁盘load是浪费的



解决方案

1. 索引大小修改为 2048,行数开根号算得 ，跟资源浪费还没关系，是操作系统命中索引最快的方式
2. 一个索引 178k/index. 建议系统block 改为从4k改为128K
3. 百分之82.6虽然浪费，但是索引会尽快过滤他们，基本没有 index:block  一对多block浪费磁盘io的情况



