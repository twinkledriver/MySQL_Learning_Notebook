#************************************
mysql_笔记——第二天03开始

mysql -uroot -p;
#输入密码进入mysql

set names gbk;

use test2;

show tables;
-创建整形表
create table my_int(
int_1 tinyint,
int_2 smallint,
int_3 int,
int_4 bigint

)charset utf8;

--插入数据
insert into my_int values (100,100,100,100);

insert into my_int values (255,100,100,100); --不行，超范围

 --默认有符号的，分正负


--增加一个无符号类型
alter table my_int add int_5 tinyint unsigned;

--查看字段
desc my_int;

--再插入

insert into my_int values(127,1000,10000,1000000,255);


--查看数据

select * from my_int;

--字段类型后面的括号代表显示宽度。即：数据最终显示的位数。

--指定显示宽度(并不控制大小)
alter table my_int add int_6 tinyint(1) unsigned;

--显示宽度的意义：前面补0来添够 宽度。zerofill

--它会自动变成 无符号型。
alter table my_int add int_7 tinyint(2) zerofill;

--添加数据试试0填充；
insert into my_int values(1,1,1,1,1,1,1);
#**********************************************
mysql_笔记——第二天04开始

--浮点型（丢失精度），定点型（不会丢失精度） 

create table my_float(
f1 float,
f2 float(10,2),		
f3 float(6,2)		
)charset utf8;

desc my_float；

-- 插入数据

insert into my_float values(1000.10,1000.10,1000.10);
insert into my_float values(9999999999,1000.10,1000.10);

-- 定点型：绝对的保证整数部分不会四舍五入（不会丢失精度）。 
-- 变长数据。

-- 创建定点数表 与 浮点数 对比

create table my_decimal(
f1 float(10,2),
d1 decimal(10,2)
)charset utf8;


desc my_decimal;

-- 插入数据

insert into my_decimal values(12345678.90,12345678.90);
insert into my_decimal values(1234.90,1234.567890);

-- 查看 警告
show warnings;

-- 插入超出范围数据
insert into my_decimal values(99999999.99,99999999.99); -- 边界值
insert into my_decimal values(99999999.99,99999999.999); 

#结论： 数据要想精确一定要使用 定点数decimal。 反之，浮点数就可以了

#*********************************************************************
第二天06 时间日期类型

create table my_date(
d1 datetime,
d2 date,
d3 time,
d4 timestamp,
d5 year
)charset utf8;

-- 有 year(2) year(4) 的区别 见视频

insert into my_date values('2016-4-5 15:30:12','2016-4-5','15:31:05','2016-4-5 15:31:25',2016);

-- 负数 时间 也可以

insert into my_date values('2016-4-5 15:30:12','2016-4-5','-15:31:05','2016-4-5 15:31:25',2016); -- 过去的15:31:05到现在
insert into my_date values('2016-4-5 15:30:12','2016-4-5','-2 15:31:05','2016-4-5 15:31:25',2016); -- 过去的24*2 +15:31:05到现在

-- year使用2 位 或4 位


insert into my_date values('2016-4-5 15:30:12','2016-4-5','15:31:05','2016-4-5 15:31:25',56);
insert into my_date values('2016-4-5 15:30:12','2016-4-5','15:31:05','2016-4-5 15:31:25',78);

#year（4） 1970 到2069 范围

select * from my_date；

-- timestamp:修改记录  修改东西 timestamp也会自动更新

-- 获取 时间戳
select unix_timestamp();

#******************************************************
#字符串类型

-- 如何选择定长或者是变长字符串呢？
-- 定长的磁盘空间比较浪费，但是效率高；如果数据基本上确定长度都一样，就使用定长，如身份证，电话号码，手机号码等。
-- 变长反之；如果数据不能确定长度（不同数据有变化），如姓名，地址等

#文本字符串

-- 如果数据量非常大 ，通常说超过255个字符
--根据数据格式 又分为text blob
--Text：存储文字  -- Blob 存储二进制数据（通常不用）

#枚举字符串  定义：enum
-- 创建枚举表
create table my_enum(
gender enum('男性','女性','保密')
)charset utf8;


desc my_enum;

#枚举作用
#作用一
-- 加入数据 （数据只能是规定数据中的一个）
insert into my_enum values('男'),('保密');

#错误
insert into my_enum values('Male');
 
#作用二：节省空间（单选框）

#证明数据存储的是数值：字段取出+0 看结果

select gender+0 ,gender from my_enum;

#枚举实质：编号 存进去数值  

insert into my_enum values('1'),('2');

select * from my_enum;

create table my_set(
hobby set('篮球','足球','乒乓球','排球','台球','网球','棒球')
)charset utf8;

-- 插入数据

insert into my_set values('足球,台球,网球');
insert into my_set values(3);

select hobby+0,hobby from my_set;

--98转二进制01100010对应set 位置 （逆序）
-- 集合元素 对应 二进制位 
-- 顺序 无关系 对应位置 置1
-- 规范数据 节省空间


varchar 在utf8 开辟最大空间21844  gbk下32766

max如：
create table my_set(
name vachar(21844)
)charset utf8;

-- 创建班级表
create table my_class(
name varchar(20) not null,
room varchar(20) null  --  默认 空
)charset utf8;


-- 创建表
-- comment 提示
create table my_teacher(
name varchar(20) not null comment '姓名',
money decimal(10.2) not null comment '工资' 
)charset utf8;


desc my_teacher;
show create table my_teacher;

-- 默认值

--默认值：某一种数据经常性的出现某个具体的值，可以在一开始就指定好，用户可以选择性使用
-- 关键字 ： default

-- 举例

create table my_default(
name varchar(20) not null,
age tinyint unsigned default 0,
gender enum('男','女','保密') default '男'
)charset utf8;

-- 默认值 生效



#*******************************************#*******************************************
#*******************************************#*******************************************
#*******************************************#*******************************************

#第三天 视频

#字段属性

#主键 唯一键 自增长

#主键： 一张表只有一个字段可以使用对应的键，不能重复。
#一张表 最多只有一个主键


#一开始 就要 Set name gbk;



#增加 主键 不能为空

-- 方案1： 在字段后加 primary key

-- 举例

create table my_pri1(
name varchar(20) not null comment '姓名',
number char(10) primary key comment '学号:itcast+0000,不能重复'
)charset utf8;

desc my_pri1;

--  方案2： 在所有字段之后，

-- 复合主键

create table my_pri2(
number char(10) comment'学号：itcast+0000',
course char(10) comment '课程代码：3901+0000',
score tinyint unsigned default 60 comment '成绩',
-- 增加复合主键
primary key(number,course)

)charset utf8;

desc my_pri2;


--  方案2： 表已创建 追加主键:修改表字段 属性  和 追加
-- 追加 主键

create table my_pri3(
course char(10) not null comment'课程编号：',
name varchar(10) not null comment '课程名字'
);

alter table my_pri3 modify course char(10) primary key comment '课程编号：';
 -- 或者

alter table my_pri3 add primary key(course);

#***********************************************
 #主键约束  主键中对应的字段的数据不允许 重复

 # 主键删除  主键没有办法 更新，只能删除 在 增加


 Alter table 表名 drop primary key;

 Alter table my_pri3 drop primary key;

 #主键(唯一)分类
 很少使用业务数据 作为主键 字段（如 主键 学号 课程号）
大部分 使用逻辑性 字段（字段没有业务含义，值是什么无所谓）

Create table my_student(
Id int primary key auto_increment comment'逻辑主键；自增长', -- 逻辑主键
Number char(10) not null comment' 学号',
Name varchar(10) not null
)

#自动增长

create table my_auto(
id int primary key auto_increment comment '自动增长',
name varchar(10) not null
)charset utf8;

desc my_auto;


# 当给定的值为默认 NULL 触发

-- 触发自增长
insert into my_auto(name) values('东红');
insert into my_auto values (null,'感号');
insert into my_auto values (default,'躺赢');


select * from my_auto;

自增长如果对应的字段 输入了值，那么自增长失效，但是下次从最大开始自增长。

-- 指定数据

insert into my_auto values(8,'等等');
insert into my_auto values(NUll,'发给');

show create table my_auto;

-- 修改自增长
自增长如果是涉及到 字段 改变：必须 先删除 再创建
修改当前自增长 只能比当前的最大值 要大 否则无效

Alter table my_auto auto_increment =6; (无效)
Alter table my_auto auto_increment =15;



-- 查看自增长 配置

show variables like 'auto_increment%'
-- increment 步长  offset --起始值
-- 修改 是针对整个数据库的，一般不操作（修改 是会话级别）（单次有效）

-- 删除自增长

自增长是字段的一个属性：可以用modify 改

Alter table my_auto modify id int primary key;  -- 不行 主键不在属性


alter table my_auto modify id int;   

-- 唯一键：很多字段具有唯一键，但只有一个主键。所以有了唯一键
-- 唯一键默认的允许为空
-- 方案一

create table my_unique1(
number char(10) unique comment '学号：唯一，允许为空',
name varchar(20) not null
)charset utf8;

-- 方案二 Not null + 唯一 显示成 主键，实质上不是主键
create table my_unique2(
number char(10) not null comment '学号：唯一，允许为空',
name varchar(20) not null,

unique key(number)
)charset utf8;

-- 方案三 在创建标志后 增加唯一键 追加

create table my_unique3(
id int primary key auto_increment,
number char(10) not null,
name varchar(20) not null 
)charset utf8;

alter table my_unique3 add unique (number);

-- 删除 唯一键

alter table 表名 drop index 索引名字 -- 字段名 就是 索引名字

#索引的意义：
#1提升 查询数据的效率
#2 约束 数据的有效性

#效率 和  磁盘空间 的 博弈


#*****************************************************
关系：表之间的关系

关系 反映 到 数据库表的设计上

一对一：
不常用的数据 往往 会 影响效率
常用 与 不常用 的 分离存储，分成两张表 这时就需要 1对1 的 匹配了

用一个唯一性的字段 来 确定 记录

一对多：
多对多：会出现 一个字段要保存多个数据的要求。不符合表的设计规范。
	这时需要增加一张新表：专门维护两张表的关系：

	增加一张中间关系表：专门描述 老师与学生的关系
	那么，中间表和老师表形成了一对多的关系：而且是中间表 是 多表

#*************************************************************
范式 
范式：Normal Format,解决 数据的 存储 与优化 问题：保证 数据 的存储 之后 ，
	凡是能够通过关系寻找的数据 ，坚决不在重复存储。目的 减少数据的冗余。

	分层结构： 六层  越来越 严格。

	1NF：


	2NF

	3NF

	Mysql 属于 关系型  数据库   因此 在 设计的时候，利用 范式 来指导设计。

	数据库 考虑 空间 与 效率 问题
	范式 只考虑 空间

	不可能 完全 按照 范式要求，因此 只要满足 1NF 2NF 3NF

	范式 具有指导 意义 。并不是 强制 规范。 



	1NF：
	第一范式：如果 表中 字段的数据 在取出来 还需要 处理（拆分），不满足第一范式。
	因为 第一范式具有 原子性。不可再分。

	

	2NF： 
	第二范式：如果有复合主键（多字段主键），且表中有字段依赖主键中的某个字段：
	即存在 字段依赖主键的部分的问题，称之为部分依赖。 不符合 第二范式

	解决： 1，拿出来 单独成表 2，取消复合主键，使用逻辑主键


	3NF：
	第三范式： 理论上讲，一张表中的所有字段 都应该直接依赖主键，如果表中存在一个
	字段，并不直接依赖主键，而是通过某个非主键依赖完成的 称之为 传递依赖。
	第三范式 解决 传递依赖

	解决方案：将传递依赖的字段 取出来，单独形成一个表

	然后在需要对应信息的时候 加入 实体表的主键


#**********************************
在设计表的时候，如果有几个字段 需要从 另一个表 去 找。理论上，效率会低一点。
这时，会刻意的在某些表中，不去保存另外表的主键（逻辑主键），而是直接保存 数据信息
目的 ，提高效率
这种 叫  逆规范化  但是 会导致 数据冗余 增加。

逆规范化：磁盘利用率与效率的对抗

新增数据

#******************************************************
insert into 表名[(字段列表)] values (值列表);



主键冲突：更新操作

方法一

Insert into 表名[(字段列表：包含主键)]values(值列表) on duplicate key update 字段 =新值;


#对 表 my_class 操作

desc my_class;

1，增加主键

alter table my_class add primary key(name);

2,插入数据

insert into my_class values ('PHP0810','B203');

select * from my_class;

如果再次插入：
insert into my_class values ('PHP0810','B205')

-- 报错
--  进行 冲突处理

on duplicate key update room='B205';

这样 就对 有主键的 字段 进行了 修改。

方法二：主键冲突：替换：
Replace into my_class values('PHP0710','A203');

#**************************************************

蠕虫 复制

蠕虫复制：从已有的数据中去获取 数据，然后又进行新增操作。 数据 成倍增加。

表创建高级操作：从 已有表 创建新表（复制表结构）

对


create table my_gbk(
name varchar(32766)

)charset gbk;

-- 复制 创建表
-- 只 复制  结构 并不复制 数据
create table my_copy like my_gbk;

-- 蠕虫复制 先查数据 再新增一遍

insert into my_copy select * from my_collate_bin;

select * from my_copy;

 #每操作一次 就复制 一次。整个表   感觉‘分裂’ 

#意义：
1，从已有表 拷贝 到新表 。
1，使表 迅速 膨胀到一定的 数量级 以测试。

#高级——更新数据

基本语法  

跟新部分 数据

update my_copy set name='c' where name='a' limit 3; # 前三个

大小写 都被 更改了

查看一下：
show create table my_copy;

#高级 —— 数据删除

与更新类似，通过 limit  来限制 数量
 #  删 10个‘b’
Delete from my_copy where name='b' limit 10;

删除 ：如果表中存在 主键  自增长 ，删除之后 不会影响 自增长

#给 student表 add 一个主键




alter table te_student modify id int not null ;

#修改 id
update  te_student set id=1 where name='Jerry';

update  te_student set id=2 where name='Lucy';

update  te_student set id=3 where name='Marry';

update  te_student set id=4 where name='Lily';

update  te_student set id=5 where name='Bob';

insert into te_student values (201601,'Bob','Male',18,001);

show create table te_student;
alter table te_student add primary key(id);

#给id 添加 自增长

alter table te_student modify id int auto_increment;


#如果 删除 数据  查看 自增长也保持 原来的值

delete from te_student;  #(未执行)

#只能 删除表重建

#有一个新的 语句 清空表 重置自增长

truncate te_student;

#***********************************************

# 高级 查询数据

select 字段 from 表名 where 条件

#完整 语法：

select[select 选项]  字段列表[字段别名]或者*   from  数据源  [where 条件字句] [group by 字句] [having 字句] [order by 字句] [limit 字句];

其中 Select选项：对查出来的结果 的处理 方式
	All：默认的，保留所有的结果
	distinct: 去重(完全一样)

select distinct * from my_copy; #重复的 就不要了

#************************************************

字段别名

字段别名：当数据进行查询出来的时候，有时候名字并不一定满足需求（同名）；
要进行别名 操作

字段名 [as] 别名

Insert into te_student values(2016001,'Mary','Female','14',1);

desc te_student;

select 
id,
StudentNumber as 学号,
name as 姓名,
gender as 性别,
age from te_student;

#********************************************

数据源： 关系型 数据库的来源 都是 数据表： 
数据源 分为  单表 数据源  多表 数据源  查询语句

单表数据源：  select * from 表名;
多表		select * from 表1,表2;

select * from te_student,my_teacher;
 将一张表的一条记录，去匹配另一张表中的所有 记录，而且 都保留。
 像是 连线   。  这种结果 称为 笛卡尔积（交叉连接）.没用，应该避免。
#**********************************************

 #子查询：数据的来源 是一条 查询语句   介绍一下 后面还有 

 Select * from (select * from my_student) as s;

# ***********************************
 Where 字句   
 ：判断数据 筛选 数据。  0:False 1:True 没有布尔

 判断条件：
 
比较运算符
 还有 like  between

 有区别的是 “=”  而不是“==” 
逻辑运算符
&& || ！

where 原理：

唯一一个从磁盘取数据的时候 就开始 
判断 结果成立 进入内存 
否则放弃

-- 增加 修改 age 和 height 字段

alter table te_student modify age tinyint unsigned;
alter table te_student add height tinyint unsigned;

select * from te_student;

-- 添加值：rand取得0到1之间的随机数 ； 向下取整floor
Insert into te_student values(2016002,'Jack','Male',50,2,NUll);

Insert into te_student values(2016003,'Bob','Male',50,3,NUll);

Insert into te_student values(2016004,'Lily','Female',50,4,NUll);

Insert into te_student values(2016002,'John','Male',50,5,NUll);

update te_student set age=floor(rand()*20+20),height=floor(rand()*20+170);

#****************************************************
-- 找学生id为1,3,5的学生 或运算

select * from te_student where id in(1,2);
select * from te_student where id =1||id=2;  -- 逻辑运算

-- 查出区间 落在 身高180 190 区间 的学生 

select * from te_student where height>=180 && height<=190;
select * from te_student where height between 180 and 190;

and 左边 小于 右边
#*********************************************************
 
 Group by 字句
  分组的意思

  基本语法：group by 字段

  -- 根据 性别分组


分组 为了统计

统计函数

Count()
Max()
Min()
Avg()
Sum()


select gender,count(*),max(height),min(height),avg(age),sum(age) from te_student group by gender;


-- 分组 统计： 身高  年龄。。
-- 分组 是为了 统计  否则 没意义

Count 函数： 可以用两种参数：* 代表统计记录，  字段名  也可以（NULL 不统计）

-- 分组 会自动排序 根据分组字段： 默认升序

Group by  字段[asc|desc]

select gender,count(*),max(height),min(height),avg(age),sum(age) from te_student group by gender desc;


-- 多字段 分组 先分  再分

desc my_class;

-- 取消主键

alter table my_class drop primary key;


-- 增加 id 字段 d带 主键

alter table my_class add id int primary key auto_increment;

select * from my_class;

insert into my_class values('PHP0910','C957',NULL);


-- 对 te_student  操作 一通  熟悉操作  

# 查看
desc te_student;

select * from te_student;

# 丢弃 id 字段
alter table te_student drop id ;
# 添加 新的 c_id 字段

alter table te_student add c_id int;


alter table te_student add id int primary key auto_increment;



#ceil 向上取整
update te_student set c_id=ceil(rand()*3);

-- 多字段 分组：先分班级 后分 男女

select c_id,gender,count(*) from te_student group by c_id,gender;

#**********************************************

有一个 函数 group_concat(字段): 可以对分组中的字符串 进行连接  显示 分完组 后 的组员信息
select c_id,gender,count(*),group_concat(name) from te_student group by c_id,gender;

#*******************************************

回溯统计： with rollup： 任何一个分组 ，需要 向上级分组 进行 汇报统计，根据当前分组的字段

回溯统计会将 分组 置空
-- 比如

select c_id,count(*) from te_student group by c_id;

-- 回溯方式 多一条记录
select c_id,count(*) from te_student group by c_id with rollup;

-- 多字段 分组 回溯 统计
select c_id,gender,count(*),group_concat(name) from te_student group by c_id,gender with rollup;

-- 多字段 回溯 
先 考虑 第一层 分组 会有一次 回溯 ，组数 多少 回溯 就是多少
在加上 第一层 回溯

#*******************************************
Having 语句

having 与 where 一样 条件判断
不同点：

Where 进行 磁盘 判断  进入 内存之后  分组操作 ： where 不能处理 分组结果
所以需要having 来处理

having 能做 where 能做的所有事情  反过来 where 却不行

分组统计结果   只有having能处理

-- 举例1

--  求出每个班所有班级人数 大于等于2 的学生(分组 之后  新的条件)

select c_id,count(*) from te_student group by c_id having count(*) >=2;

-- 举例2
-- having 可以使用字段别名    因为 别名 是 进入内存才产生的

select c_id,count(*) as total from te_student group by c_id having total >=2;

#模糊查询 j开头　的名字
select name as 名字,gender as 性别 from te_student having 名字 like 'J%';

 
 -- Order by

Order by：排序，根据 某个字段 进行 排序  依赖 校对集

Order by 字段名 [asc|desc]

#group by 只取 第一个记录  order by 取 所有记录

select * from te_student order by c_id;

-- 多字段 排序 排了 再排

-- 先 班级 后性别

select * from te_student order by c_id,gender desc;

-- limit 字句 

限制 结果的字句

limit 两种使用方式
1， 限制长度（数据量）

-- 举例  查 前两个学生
select * from te_student limit 2;

2， 限制起始位置  和 长度 。 从 指定 开始 往后找几个 数据；

-- 举例 从 第一个数完 开始  找
select * from te_student limit 1,2;

#  应用 实现数据的 分页：为用户 节省时间，提高响应率 减少资源的浪费

对用户 来讲：可以 分页的按钮
对于 服务器 根据 用户 来获取  limit offset,length;

length:每一页显示
Offset:offset=(页码-1)*每页显示量

































  













    















 




















 





















