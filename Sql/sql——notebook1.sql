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






 





















