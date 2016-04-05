#************************************
mysql_笔记——第二天03开始

mysql -uroot -p #输入密码进入mysql

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

 



















