## routine load be fe 参数调优


routine load task 是需要fe be结合来的，有效的就是 只是因为消费的topic,partitions 数量太多，这样的参数才有意义
需要结合很多因素
1. 创建时候任务task数据量
2. fe routine load stask num 设置
3. be 个数
4. be max_consumer_num_per_group
5. be routine_load_thread_pool_size


最终达到的目的就是
分一下两种情况，
1. 主要按照 topic 单个partitions 单位时间产生的数据量计算
2. be 单个 routine load 线程单位时间能够消费的数据量结合 比如 `100w/s` *3就是才一个组 最大的消费） 这里先概括为 单个be 100w/s

那么就是 三个情况
1 topic 单个为时间数据量为 50w/s ，那么每个 consumer 线程处理 两个partition 合理
2 topic 单个数量为 100w/s,那么 每个consumer 线程处理 一个partitions 合理
3 topic 单位时间数据量为 200w/s ,那么 ，我们应该建议他们增加，partition,然后我们也增加 consumer 线程（这里你这设置的参数是下发给be的关键）

第三个条件，就是 我们也需要了解 topic 单个partitions 单位时间可以处理的数据量为多少，最后不要 超过我们的数据量


1 还需注意的就是 这里我说的 consumer 处理的数据，是一个原子性，到落盘，同步后的总时间，所以我们需要一个准确的测试数据就是
一个consumer处理不同数据，到落盘的真实时间是多少
