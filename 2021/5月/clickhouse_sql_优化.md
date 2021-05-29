- ### 不要用select *

反例：



```csharp
select * from app.user_model
```

正例：



```csharp
select login_id,name,sex from app.user_model
```

理由：
 只查询需要的字段可以减少磁盘io和网络io，提升查询性能

- ### 不要在大结果集上构造虚拟列

反例：



```csharp
select id ,pv, uv , pv/uv rate from app.scene_model
```

正例：



```csharp
select id ,pv, uv from app.scene_model
```

理由：
 虚拟列非常消耗资源浪费性能，拿到pv uv后在前端显示时构造比率。

- ### 不要在唯一列或大基数列上进行分组或去重操作

反例：



```csharp
select id, count(1) cn from app.user_model group by id
```

正例：



```csharp
select id  from app.user_model  
```

理由：
 基数太大会消耗过多的io和内存。

- ### 根据需要查询指定范围的数据 （where）

反例：



```csharp
select login_id,name,sex from app.user_model
```

正例：



```csharp
select login_id,name,sex from app.user_model where create_time>'2020-03-30'
```

理由：
 减少磁盘io和网络io，提升查询性能

- ### 关联查询时小表在后（大表 join 小表）

反例：



```csharp
select login_id,name,sex,a.scene_name from app.scene_model a join app.user_model b on a.create_user=b.id
```

正例：



```csharp
select login_id,name,sex,a.scene_name from app.user_model  a join app.scene_model  b on a.id=b.create_user
```

理由：
 无论是Left Join 、Right Join还是Inner Join永远都是拿着右表中的每一条记录到左表中查找该记录是否存在

- ### 使用 uniqCombined 替代 distinct

反例：



```csharp
SELECT count( DISTINCT create_user ) from  app.scene_model
```

正例：



```csharp
SELECT uniqCombined( create_user ) from  app.scene_model
```

理由：
 uniqCombined对去重进行了优化，通过近似去重提升十倍查询性能

- ### 通过使用 limit 限制返回数据条数

反例：



```csharp
select id,scene_name,code,pv from app.scene_model order by pv desc 
```

正例：



```csharp
select id,scene_name,code,pv from app.scene_model order by pv desc limit 100
```

理由：
 使用limit返回指定的结果集数量，不会进行向下扫描，大大提升了查询效率

- ### 尽量不去使用字符串类型

反例：



```jsx
CREATE TABLE scene_model
(
    id String,
    scene_name String,
    pv String,
    create_time String
)
ENGINE = <Engine>
... 
```

正例：



```jsx
CREATE TABLE scene_model
(
    id String,
    scene_name String,
    pv Int32,
    create_time Date
)
ENGINE = <Engine>
... 
```

理由：
 时间类型最终会转换成数值类型进行处理，数值类型在执行效率和存储上远好过字符串

- ### 指定查询分区获取必要的数据

假设分区字段是day
 反例：



```csharp
select type,count(1) from app.user_model group by type
```

正例：



```csharp
select type,count(1) from app.user_model where day ='2020-03-30' group by type
```

理由：
 通过指定分区字段会减少底层数据库扫描的文件数量，提升查询性能

- ### 分组前过滤不必要的字段

反例：



```csharp
select type,count(1) from app.user_model group by type
```

正例：



```bash
select type,count(1) from app.user_model where type ='1' or  type ='2' group by type
```

理由：
 通过限制分组前结果集数量，查询性能一般能提示数十倍，甚至上百倍



作者：码到成功_易企秀
链接：https://www.jianshu.com/p/e5050f046699
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。