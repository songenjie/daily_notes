### 1 机器准备
node1 2 3 4 5 6 

### 2 group 部署

#### 2.1 group 1 

node1 node2 node3

#### 2.2 gourp2

node4 node5 node6

#### 2.3 s缩容前配置

group1 group2 分开

#### 2.4 部署

1. cluster jdolap_ck_05
2. shard 1 2 3
3. macros
4. path

### 3 import

#### 3.1 db

create database jason_test on cluster ck_05

#### 3.2 table

create table table_1 on cluster ck_06 have partition 016 0617 0618

#### 3.3 insert

insert into 

#### 3.4 look

查看数据分布

### 4 group2 部署

步骤 2

#### 4.1 去定配置正确

### 5 copier

#### 5.1 copier 配置 

#### 5.2 table

创建临时表 table2

#### 5.3 copier

#### 5.4 数据检测

### 6 mv

#### tabl2 --> table1

#### 检测数据

#### 导入试试再

#### 查询看看

### 完成
