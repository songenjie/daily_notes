I0309 15:09:22.161239 101566 routine_load_task_executor.cpp:175] begin to execute routine load task: id=25125b798df643cf-bfbc852826926dac, job id=16008, txn id=113652, label=bitmap_test-16008-25125b798df643cf-bfbc852826926dac-113652
I0309 15:09:22.161242 54668 routine_load_task_executor.cpp:154] submit a new routine load task: id=25125b798df643cf-bfbc852826926dac, job id=16008, txn id=113652, label=bitmap_test-16008-25125b798df643cf-bfbc852826926dac-113652, current tasks num: 1
I0309 15:09:22.162305 101566 stream_load_executor.cpp:50] begin to execute job:bitmap_test-16008-25125b798df643cf-bfbc852826926dac-113652 with txn id:113652 with query id:25125b798df643cf-bfbc852826926dac
I0309 15:09:22.162330 101566 plan_fragment_executor.cpp:74] Prepare(): query_id=25125b798df643cf-bfbc852826926dac fragment_instance_id=25125b798df643cf-bfbc852826926dad backend_num=0
I0309 15:09:22.393020 101566 data_consumer_group.cpp:95] start consumer group: d04829329a1e1216-22a174d6b88d44a8. max time(ms): 10000, batch rows: 200000, batch size: 104857600. id=25125b798df643cf-bfbc852826926dac, job id=16008, txn id=113652, label=bitmap_test-16008-25125b798df643cf-bfbc852826926dac-113652
I0309 15:09:22.393376 101677 tablets_channel.cpp:49] open tablets channel: (id=25125b798df643cf-bfbc852826926dac,index_id=10075)

//////mmmmmm

I0309 15:09:32.395174 101693 load_channel_mgr.cpp:179] load channel has been cancelled: 25125b798df643cf-bfbc852826926dac
I0309 15:09:32.395184 101693 load_channel.cpp:36] load channel mem peak usage: 0, info: limit: 2147483648; consumption: 0; label: 25125b798df643cf-bfbc852826926dac; all tracker size: 2; limit trackers size: 2; parent is null: false; , load id: 25125b798df643cf-bfbc852826926dac
W0309 15:09:32.395400 101500 stream_load_executor.cpp:83] fragment execute failed, query_id=25125b798df643cf-bfbc852826926dac, errmsg=cancelledid=25125b798df643cf-bfbc852826926dac, job id=16008, txn id=113652, label=bitmap_test-16008-25125b798df643cf-bfbc852826926dac-113652
I0309 15:09:32.447474 101566 routine_load_task_executor.cpp:138] finished routine load task id=25125b798df643cf-bfbc852826926dac, job id=16008, txn id=113652, label=bitmap_test-16008-25125b798df643cf-bfbc852826926dac-113652, status: Cancelled, current tasks num: 0

调度 

消费完之后 超时了 

更新状态 没有提交 走不下去了

并发 5 只有一个在执行


