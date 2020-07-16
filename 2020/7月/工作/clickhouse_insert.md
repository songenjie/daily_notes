# 五.clickhouse 批量导入数据(clickhouse极简教程系列)

大批量的数据建议使用CSV格式直接导入 优点:快,碎片少,极度非常非常非常`不`建议一个个sql

```
cat qv_stock_20160620035119.csv | clickhouse-client --query="INSERT INTO stock FORMAT CSV";
```

如果第一行是title

```
cat /tmp/qv_stock_20160623035104.csv | clickhouse-client --query="INSERT INTO stock FORMAT CSVWithNames";
```

另外注意的是 CSV文件必须是 NOBOM





 http://www.clickhouse.com.cn/topic/5ad9df839d28dfde2ddc5f8d

http://www.clickhouse.com.cn/topic/5ae417799d28dfde2ddc5ff0

http://www.clickhouse.com.cn/topic/5adfdfbc9d28dfde2ddc5fb3



我看很多因格式不对的 开发用户遇到类似导入失败，如果你的数据会重新间断性的失败 那么我们最好严格遵守下



https://clickhouse.tech/docs/en/interfaces/formats/