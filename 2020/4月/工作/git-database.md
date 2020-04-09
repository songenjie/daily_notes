### olap 更新

1. 模糊查询 downsampling
- select avg(degree) from t1 interval(5m);

2. 定时查询
- select avg(degree) from thermometer where loc=‘beijing’ interval(5m) sliding(1m);

