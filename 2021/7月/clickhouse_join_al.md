https://github.com/ClickHouse/ClickHouse/issues/14794





Hi , Now we face some join case, and I had test the newest version about the join algorithm between hash join and partial merge join:`SET join_algorithm = 'partial_merge' SELECT number * 200000 as n, j FROM numbers(5) nums ANY LEFT JOIN (     SELECT number * 2 AS n, number AS j     FROM numbers(10000000) ) js2 USING n; MemoryTracker: Peak memory usage (for query): 457.46 MiB. 5 rows in set. Elapsed: 0.918 sec. Processed 10.02 million rows, 80.18 MB (10.92 million rows/s., 87.39 MB/s.)  SET join_algorithm = 'hash' SELECT number * 200000 as n, j FROM numbers(5) nums ANY LEFT JOIN (     SELECT number * 2 AS n, number AS j     FROM numbers(10000000) ) js2 USING n; MemoryTracker: Peak memory usage (for query): 845.12 MiB. 5 rows in set. Elapsed: 2.023 sec. Processed 10.02 million rows, 80.18 MB (4.95 million rows/s., 39.63 MB/s.) `Seems the partial merge join has two times better than hash join in respect of memory/time cost at least. And also do some test against business data, give the same result.After profiling the hash join, found all the cost from building memory table for right table. But how the partial merge join work? seems no detail doc about this. Just plan to upgrade to the partial merge join version and want make sure the partial merge join is really good for join case. big thanks.



[![@compasses](https://avatars.githubusercontent.com/u/10161171?s=60&u=d6d9a1c80e3c8808bfef8240fe41f8d58ea8950e&v=4)](https://github.com/compasses) [compasses](https://github.com/compasses) added the [question](https://github.com/ClickHouse/ClickHouse/labels/question) label [on 14 Sep 2020](https://github.com/ClickHouse/ClickHouse/issues/14794#event-3762476028)



[![@alexey-milovidov](https://avatars.githubusercontent.com/u/18581488?s=60&v=4)](https://github.com/alexey-milovidov) [alexey-milovidov](https://github.com/alexey-milovidov) assigned [4ertus2](https://github.com/4ertus2) [on 14 Sep 2020](https://github.com/ClickHouse/ClickHouse/issues/14794#event-3763135285)

[![@4ertus2](https://avatars.githubusercontent.com/u/8061274?s=88&v=4)](https://github.com/4ertus2)

 

Member

### **[4ertus2](https://github.com/4ertus2)** commented [on 14 Sep 2020](https://github.com/ClickHouse/ClickHouse/issues/14794#issuecomment-692041501)

I checked 'partial_merge' vs 'hash' algo when it was implemented on data from TPC-H test. It was 3-4 times slower when all data is in memory. So in general it should be slower.Any case, It's expected that in some cases (when data in both tables is already sorted by joining key) MergeJoin would be faster than HashJoin. But it needs more code out of join algo itself to make such improvement: we should pass sort info through query pipeline to take it into account. I think you've find a special case that works even without such optimizations.We need to investigate you question and recheck perf test results.

[![@compasses](https://avatars.githubusercontent.com/u/10161171?s=88&u=d6d9a1c80e3c8808bfef8240fe41f8d58ea8950e&v=4)](https://github.com/compasses)

 

Author

### **[compasses](https://github.com/compasses)** commented [on 14 Sep 2020](https://github.com/ClickHouse/ClickHouse/issues/14794#issuecomment-692137657) • edited 

[@4ertus2](https://github.com/4ertus2) very appreciate for your quick answer, please check my commentsI checked 'partial_merge' vs 'hash' algo when it was implemented on data from TPC-H test. It was 3-4 times slower when all data is in memory. So in general it should be slower.How big the TPC-H data-set? I mean build the memory hash table need cost many memory and time. Maybe the data-set not big enough?Any case, It's expected that in some cases (when data in both tables is already sorted by joining key) MergeJoin would be faster than HashJoin. But it needs more code out of join algo itself to make such improvement: we should pass sort info through query pipeline to take it into account. I think you've find a special case that works even without such optimizations.I think that's easy. The join table, left or right do have some related each other, and the join key exist in both two tables, and the order key of the two tables both contains the join key. So it should be what you said 'data in both tables is already sorted by joining key' ?

[![@4ertus2](https://avatars.githubusercontent.com/u/8061274?s=88&v=4)](https://github.com/4ertus2)

 

Member

### **[4ertus2](https://github.com/4ertus2)** commented [on 15 Sep 2020](https://github.com/ClickHouse/ClickHouse/issues/14794#issuecomment-692168522) • edited 

How big the TPC-H data-set? I mean build the memory hash table need cost many memory and time. Maybe the data-set not big enough?I do not remebmer data-set size exactly. But hash table size was about 10-16 Gb.So it should be what you said 'data in both tables is already sorted by joining key' ?Let me describe how does 'partial_merge' join algo works. It's a variant of MergeJoin adapted to ClickHouse query pipeline. ClickHouse streams left table in blocks and join it over full-known right table. It's a way how HashJoin expects join algo (first it builds hash table, second it scans left one). For honest MergeJoin we have to sort both tables and merge sorted results. 'partial_merge' algo do not sort left table, but has build and scan phases as 'hash' one instead. At build phase 'partial_merge' sorts right table by join key in blocks (and in general it's more expensive than just to make hash table). And create min-max index for sorted blocks. At 'scan' phase it sorts parts of left table by join key and merge join them over right table. It's also uses index to skip unneded right table blocks from join.So, 'partial_merge' join could be faster when we could avoid sorts in build and scan phase (when the data is already sorted by joining key). And it would be much more expensive to use 'partial_merge' instead of 'hash' join algo when your left table has some general distribution of join keys cause you have to join every left table part with entire right table and min-max index does not help you in this case.To make benefits of MergeJoin we have to tell it not to sort columns. If not we could have profit of merge join at build phase if sorting of blocks is faster then building a hash table. It could happen in joins with a few tight columns in key (when hash table memory alloacations are meaningful). Also it's possible to have some benefits in scan phase if min-max index of right table + merge join works faster than hash table lookups. We could have such situation when left table data is near to sorted. These are special cases. Make a uniform distribution of inputs and wide string column in joining key and hash join wins.

👍 3

<details class="details-overlay details-reset dropdown hx_dropdown-fullscreen position-relative float-left d-inline-block reaction-popover-container reactions-menu js-reaction-popover-container" style="box-sizing: border-box; display: inline-block !important; position: relative; float: left !important;"><summary class="btn-link reaction-summary-item add-reaction-btn" aria-label="Add your reaction" aria-haspopup="menu" role="button" style="box-sizing: border-box; display: inline-block; cursor: pointer; appearance: none; background-color: transparent; border: 0px; color: var(--color-text-link); font-size: inherit; padding: 9px 15px 7px; text-decoration: none; user-select: none; white-space: nowrap; opacity: 0; transition: opacity 0.1s ease-in-out 0s; float: left; line-height: 18px; list-style: none;"><svg aria-hidden="true" viewBox="0 0 16 16" version="1.1" data-view-component="true" height="16" width="16" class="octicon octicon-smiley"><path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z"></path></svg></summary></details>

[![@compasses](https://avatars.githubusercontent.com/u/10161171?s=88&u=d6d9a1c80e3c8808bfef8240fe41f8d58ea8950e&v=4)](https://github.com/compasses)

 

Author

### **[compasses](https://github.com/compasses)** commented [on 15 Sep 2020](https://github.com/ClickHouse/ClickHouse/issues/14794#issuecomment-692416786) • edited 

Big thanks, seems more clear now.In consideration of resource cost, the 'partial_merge' algorithm will have more less memory footprint, and I think usually more memory cost always cost more time. And especially under some resource limit environment.Start from partial merge algorithm, there are many ways to optimize your SQL or data localization, but the hash join we had nothing to do but need more memory.