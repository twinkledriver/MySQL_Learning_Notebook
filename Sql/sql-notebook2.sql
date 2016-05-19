#  mysql 第四天 视频

#复习

#范式：
1NF  原子性
2NF 不存在  部分依赖 没有复合主键
3NF 不存在 传递依赖  

#******************************************************


mysql -uroot -p

set names gbk

use test2;


需求： 查询 学生 ，返回学号

select * from te_student;

select * from my_class;

update te_student set StudentNumber=2016005 where name='John';

#把某个字段 改变 位置。

alter table my_class change id id int first;
alter table te_student change id id int first;

#连接 查询

将多张表 进行记录 的连接（拼接）  结果：记录可能变化 字段 一定会增加（合并表）

意义：在用户查询数据的时候，需要显示来自多张表 的数据。

-- 分类

SQL 中 将连接查询 分成 4类 

内连接
外连接  
自然连接 
交叉连接

-- 交叉连接 cross join 从一张表中 循环 取出每一条 记录 ，然后 都去 另一张
-- 匹配 一应 保留。  最终形成 笛卡尔积

-- 基本语法 连接查询：
join 
#左表 join 右表

-- 交叉连接
左表 cross join 右表==from  左表 ，右表

-- 整个 算作一个 数据源
select * from te_student cross join my_class;

-- 笛卡尔积 没有意义  尽量避免。  只是 为了保证
-- 结构 的完整性。

-- 常用的 内连接

内连接:[inner] join 左右表 匹配 ，必须有某个共同条件 ，才会保留结果。
语法：
左表 [inner] join 右表 on 条件 。条件 指 相同的业务含义


-- 举例
--c_id class_id  与 班级 id
select * from te_student inner join my_class on te_student.c_id=my_class.id;

用别名 去 区分 同名字段

select s.*,c.name as c_name,c.room from te_student as s inner join my_class as c  -- 字段别名 ，表别名
on s.c_id=c.id;

#on 说明 on 后面 先执行
# 如果数据里有null

#另外 where 可以 替代 on （但是 where 没有 on 效率高）
# 因为where 匹配 所有  on 只匹配 配对的

#*******************
# 外连接 outer join

#取出某一张 的所有 记录 与另一张匹配 不管 能不能匹配 都保留结果。不能匹配，置空

外连接 两种： 以  某张表 为主

left join 左 外连接，以左表为主表
右 相同

语法： 左表 left/right join 右表

-- 举例 左连接 左表 为主 最终数目 不少于 左表数目

select s.*,c.name as c_name,c.room from te_student as s left join my_class as c
on s.c_id=c.id;

没有数据匹配上 都置为NULL，

虽然有主副之分，左表数据 依然 在合表  的左边

#自然连接
#自然连接：自动匹配条件：以字段名字做为（同名）

自然连接：又分内外

自然内连接 左表 natural join 右表

select * from te_student natural join my_class;
-- 没有匹配的

#做修改
#使用同名字段作为连接条件：连接之后 会合并 同名字段
alter table my_class change name c_name varchar(20) not null;

-- 自然左外连接
select * from te_student natural left join my_class;

-- 内连接 外连接 可以 模拟 自然连接  使用同名 字段，合并字段
左表 left/right join 右表 using（字段）
select * from te_student  left join my_class using(id);

#*********************************************************
PHP操作mysql
本身无法操作，有扩展 可以操作mysql

三种扩展 :mysql ,mysqli PDO扩展

mysql扩展： 纯面向过程：里面都是 函数，可以调用函数。

mysqli扩展：面向过程 +面向对象，有函数 也有类。

PDO扩展：纯 面向 类  加载后 只能调用类。
 
#用第一种

#PHP操作 mysql
流程：连接流程：连接 和认证
数据库 连接 资源 ：Mysql_connect(服务器地址包含端口，用户名 ，密码)

转www文件夹下，PHP文件-用PHP控制mysql


#*****************************************************#*****************************************************
#*****************************************************#*****************************************************
#*****************************************************#*****************************************************

#mysql 学习 第五天 视频

回顾

连接查询：多张表连接到一起   
	内 外 自然 交叉
	
	交叉：笛卡尔 没用
	内连接：inner join，必须左右两张表 有连接匹配
	外连接：outer[left/right] join,主表有的记录，一定保留。副表没匹配到的NULL
	自然连接： natural join 自动匹配 （相同的字段名，数据会错），using关键字 模拟 自然连接

PHP操作 mysql
	PHP充当客户端，开启mysql扩展
	连接认证：mysql_connect; 发送SQL获取结果：mysql_query;解析结果集：mysql_fetch系列;释放资源 ：
	mysql_free_result 和 mysql_close
	错误处理：mysql_errno 和 mysql_error


#*****************************************************#*****************************************************

外键：foreign key；(键不在自己表中)：如果一张表中有一个字段（非主键）指向
另外一张表的逐渐，那么称该字段为外键。


一张表可以有多个外键

增加外键：外键可以在创建表 或 之后 增加。

1.创建表的时候增加外键：在字段之后 使用foreign key（外键字段）references 外部表
（主键字段）


desc my_class; 

-- 创建外键

create table my_foreign1(
id int primary key auto_increment,
name varchar(20) not null comment '学生姓名',
c_id int comment '班级id',

foreign key(c_id) references my_class(id)
)charset utf8;


2.在新增表之后增加外键：
Alter table 表名 add[constraint 外键名字] foreign key(外键字段) references 父表(主键字段);


-- 先创建表

create table my_foreign2(
id int primary key auto_increment,
name varchar(20) not null comment '学生姓名',
c_id int comment '班级id'
)charset utf8;

-- 增加外键
alter table my_foreign2 add
-- 指定外键名
constraint student_class_1
-- 指定外键字段
foreign key(c_id) 
-- 引用父表主键
references my_class(id);

desc my_foreign2; 

-- 修改外键& 删除外键

外键不可修改：只能 先删除 在 增加

alter table my_foreign2 drop foreign key 外键名;  -- 一张表中的外键 名字不能相同


alter table my_foreign1 drop foreign key my_foreign1_ibfk_1;

desc my_foreign1;  -- 查看的时候 还是没删(表结构 看不出来 )  实际 删了 从创建语句看出
show create table my_foreign1;

#*********************************************************************

外键作用

外键默认作用有两点：一个对父表，一个对子表（外键字段所在的表）

对子表约束：子表数据进行写操作的时候，如果对应的外键字段在父表找不到对应的匹配：
那么操作会失败。（约束子表的写操作）

-- 插入数据：外键字段在父表中不存在
insert into my_foreign2 values(null,'Zack',4); -- 其实并不存在 班级4 这里会失败；

-- 对父表的约束：父表数据进行写操作（删和改：涉及主键本身,如果对应的主键在子表
-- 中已经被数据所引用，那么就不允许操作。相当于数据之间已经有了绑定，就不能单一的
-- 改变了。

insert into my_foreign2 values(null,'Zack',1);
insert into my_foreign2 values(null,'Tony',2);
insert into my_foreign2 values(null,'ken',2);

select * from my_foreign2;

update my_foreign2 set name='Ken' where name='ken';

-- 若要更新父表记录
update my_class set id = 4 where id = 1; -- 失败: id=1 记录已经被学生给用了。不能再修改了
update my_class set id = 4 where id = 3; -- 成功：没有用过id=3；


#*******************************************************
 外键条件
 1.外键要存在，首先要保证 存储引擎是 innodb(默认)。如果不是innodb，外键
   可以创建成功，但是没有约束效果。
 2.外键字段的字段类型（列类型）必须要与父表的主键类型一致。
 3.一张表中外键名字不能重复。
 4.增加外键的字段（数据已经存在），必须保证数据与父表主键要求对应。 

-- 插入数据
insert into my_foreign1 values(null,'Leo',3);
-- 增加外键
alter table my_foreign1 add foreign key(c_id) references my_class(id);

#*******************************************************
 外键约束

 外键作用：是默认的。其实可以根据需求，进行定制操作；

 外键约束有三种约束模式：针对父表的约束
	District：严格模式，父表不能删除或者更新一个已经被子表数据引用的记录。
	Cascade:级联模式，父表操作 子表关联的数据也跟着操作。
	Set null：置空模式，父表操作之后，子表对应的数据 被置空。

通常的合理做法（约束模式）：

删除的时候 子表置空，
更新的时候子表级联操作，

指定模式的语法：
 foreign key(外键字段) references 父表(主键字段) on delete 模式 update 模式;

 foreign key(外键字段) references 父表(主键字段) on delete set null update cascade;

 -- 创建外键:指定模式:删除置空，更新级联

 create table my_foreign3(
 id int primary key auto_increment,
 name varchar(20) not null,
 c_id int,
 -- 增加外键
 foreign key(c_id) references my_class(id) on delete set null on update cascade
 )charset utf8;

show create table my_foreign3;

-- 插入数据

insert into my_foreign3 values(null,'刘备',1),(null,'曹操',1),(null,'孙权',1),(null,'诸葛亮',2),(null,'周瑜',2);

select * from my_foreign3;
select * from my_class;

-- 删除foreign2中的 外键(之前有绑定)
alter table my_foreign2 drop foreign key student_class_1;

-- 更新 副表 主键

update my_class set id=3 where id=1;

-- 此时原来foreign3 中所有的1 班 都变成3 班 （级联影响）

-- 删除操作  删除父表主键

delete from my_class where id = 2;

-- 此时 foreign3 中3 班 都变成null

-- 前提条件 外键字段必须允许为空（ 外键无法创建）

-- 外键能够进行 各种约束 但是对PHP来讲 ，更难可控了

-- 实际开发中 很少使用外键
 


#**********************************************#**************************
 #**********************************************#**************************

 联合查询

联合查询：将多次查询，在记录上进行拼接（但是 字段不会增加）

基本语法：

多条select ：每一条 获取的字段数 必须严格一致（与字段类型无关）   行列 对齐

select 语句1 Union[选项] select 语句2

union选项：all ：保留所有  distinct  ：去重（默认）


select * from my_class
union  -- 默认去重
select * from my_class;


select * from my_class
union  all 
select * from my_class;

-- 意义
-- 1.查同一张表 需求不同：如 查询 学生信息   ，男生身高升序  女生 身高降序
-- 2. 多表查询  结构一样  完全一样

-- 需求：男生（升），女生（降）

select * from te_student where gender='male' order by age asc
union
select * from te_student where gender='female' order by age desc;

-- 报错

在联合查询中 order by 不能直接查询  需要 用括号括起来。


(select * from te_student where gender='male' order by age asc)
union
(select * from te_student where gender='female' order by age desc);

-- 还是不行，需要搭配limit 使用限定

(select * from te_student where gender='Male' order by age asc limit 9999)
union
(select * from te_student where gender='Female' order by age desc limit 9999);

#**********************************************#**************************
 #**********************************************#**************************

 子查询：结果中 在查询

子查询：sub query,在某个条件下  新的条件排序

分类：

按位置 分类：子查询（select 语句）在外部查询 中出现了 位置。
			from 子查询：from后
			where子查询：where 条件中
			exists 子查询：exists里
		
按结果分：根据子查询得到的数据进行分类
		标量子查询：子查询得到的结果是一行一列
		列子查询：一列多行
		行子查询：多列一行（多行多列）
		表子查询：得到的结果是多行多列（from之后）

标量子查询：

-- 需求：知道班级名字为PHP0710 想获取该班的所有学生

#********************************************
-- 标量子查询
1.确定数据源：获取所有的学生
 select * from te_student where c_id=？;

 2.获取班级ID：可以通过班级名字确定

select id from my_class where c_name='PHP0710';

-- 组合1,2 括号
 select * from te_student where c_id=(select id from my_class where c_name='PHP0710');

 
 select * from my_class;
desc my_class;
#********************************************
--  列子查询

-- 先增加点数据

insert into my_class values(1,'PHP1027','A206');

-- 需求 查询所有在读班级的学生（班级表中存在的班级）

-- 数据源：学生
select * from te_student where c_id in(?);
-- 有效班级的id
select id from my_class;

--列子查询

select * from te_student where c_id in(select id from my_class);

-- 一列 多行 用in作为条件匹配 几个类似 all some  any 

#********************************************
--  行子查询


-- 需求：要求查出整个学生中，年龄最大且身高最高的学生。

-- 数据源：学生
select * from te_student where age=? And height=?; --  此处不能用where, 用max没进入内存,where 改成having



-- 最大年龄 且 最高身高
select max(age) from te_student

select max(height) from te_student


-- 组合 虽然可以 但是不符合
select * from te_student where age=(select max(age) from te_student) And height=(select max(height) from te_student);

-- 实际上要构造行元素


select * from te_student where
-- （age,height)称之为 行元素
(age,height)=( select max(age),max(height) from te_student); 


#********************************************

--  表子查询

表子查询：子查询返回的是 多行多列 的二维表：子查询 返回的结果是当作二维表来使用

-- 需求： 找出每一个班最高的一个学生

1.确定数据源:现将学生 按照身高 进行降序排序
select * from te_student order by height desc;
2.从里面选出第一个学生
select * te_student group by c_id; -- 选出第一个

表 子查询 归结为 :from 子查询  ：从得到的结果作为from的数据源

-- 表子查询
注意一下两种写法的区别：

select * from te_student group by c_id order by height desc; -- 先按id分组取学生 再按照身高排

-- 实质 是构建表
select * from (select * from te_student order by height desc) as student group by c_id;  --  找每个班 最高的。 注意 as 后面必须加  因为from后 智能跟表名
 
-- 这里与视频 不同 ，似乎是版本的原因 group by 用不了.

#********************************************
--  exists子查询

Exsits：存在：判断某些条件是否满足（跨表）,接在where之后：返回结果 只有0和1；

select exists(select * from te_student where id=100);

需求：查询所有 班级存在的学生；

-- 数据源

select * from te_student where ?;

-- 确定条件是否满足

exists(select * from my_class); --  是否成立


-- 结合

select * from te_student where exists(select * from my_class); 

#********************************************
--  视图

视图：view：虚拟表

创建视图
基本语法：
create view 视图 as select 语句;-- select 语句可以是普通查询;可以是连接查询 ;可以是联合查询; 

创建 单表 视图：
create view my_v1 as select * from te_student;

create view my_v2 as select * from my_class;

创建 多表 的 不能有 重名字段
create view my_v3 as select * from te_student as s left join my_class as c on s.c_id=c.id;  -- 创建不了 id 重名

create view my_v3 as select s.*,c.c_name,c.room from te_student as s left join my_class as c on s.c_id=c.id; 



-- 查看视图：查看视图结构

视图是一张虚拟表： 表的所有查看 方式 都使用于视图

-- 修改视图
修改视图：修改视图本身的来源（select语句）

Alter view  名字 as  新的 select 语句。

例如
alter view my_v1 as select id,name,age,gender,height,c_id from te_student;

alter view my_v3 as select id,name,age,gender,height,c_id from te_student;
-- 删除 视图
 
 create view my_v4 as select * from te_student;

 -- 删除

 drop view my_v4;

 -- 使用视图 主要是为了查询

 desc my_v1;


视图的本质：就是 执行封装了的select 语句.


视图的意义：
1.视图可以节省SQL语句：将一条复杂的查询语句使用视图 进行保存L以后对视图进行操作。
2.数据安全  对视图 处理  不会影响基表。
3.视图往往在大项目中使用，而且 多系统使用：可以只提供部分字段。隐藏关键的数据。数据安全。
4.对外友好型，好像 专门设计的
5.视图 更好的进行 权限控制

-- 视图数据操作

视图 可以 进行数据 写操作：但是有很多限制

-- 多表视图新增数据
insert into my_v3 values(null,'2016007','Zacker','Male',90,180,1,'PHP0326','D306');
-- 结果 是不能插入(多表)

--试试 单表： 也有前提：视图中包含的数据 必须有基表中所有不能为空（或者没有默认值 ）的子啊U单
insert into my_v1 values(7,'Zacker',90,'Male',180,1);
insert into my_v1 values(null,'Dog',20,'Male',130,1);

-- 视图 是可以 直接 像基表 插入 数据的


删除数据

多表视图 不能删除

delete from my_v3 where id=1;

单表可以删

-- 更新数据 单表 多表 都可以

update my_v3 set c_id =3

-- 可以 搞成 限制跟新
create view my_v4 as select * from te_student  where age > 30 whith check option;
-- 表示 视图的 数据来源 都是 年龄 大于30岁的： 更新的 时候 不能更改 此部分 的数据

-- 视图 算法

系统对 视图以及外部查询视图 的select语句的 一种解析方式

视图算法 有三种：
	undefined:未定义  不是 实际使用 推卸责任  
	temptable: 临时表 算法 系统 先执行 视图 的select 语句 后 执行 外部查询语句
	Merge  合并算法  视图 先将  视图对应 的 和  外部查询  的 合并 在 执行（效率高： 常态）

算法指定： 创建视图的时候

create algorithm=指定算法 view 


--  指定 算法 为临时表
create  algorithm=temptable view  my_v6 as select * from te_student order by height desc;

 select * from my_v6 group by c_id;

 -- 数据 备份 与还原

1.数据表备份
2单表数据备份
3SQL备份 
4增量备份

数据库备份
不需要 SQL备份 直接复制 文件夹 复制 数据文件。前提条件：存储引擎


存储引擎：mysql进行数据存储的方式 主要是 两种  innodb 和 myisam（免费）


查看 版本
select @@version

myisam：1 批量插入 速度快 2   只支持B树索引 3 空间使用 和内存使用 都低 4不支持外键
innodb ：1 批量插入 速度慢 2  支持 各种索引  3 空间使用 和内存使用 都高 (不好)  4支持外键
其他引擎 收费

innodb：只有表结构  数据 全部 都在 ibdata1 文件中。跨库 不能识别 只能拷贝结构 
mysiam： 表 数据 索引  全部单独 存储 适合备份  直接拷贝3个文件。


--2单表数据备份
 select * into outfile 路径 from 数据源;

 -- 高级备份 或者说输出

Terminated by 以 什么结束 “ \t” tab键

 fields：字段处理
	Enclosed by  以 什么包裹 默认 ""
	Terminated by 以 什么结束 “ \t” tab键
	Escaped by 特殊 符号处理  "\\" 反斜杠转移

lines：行处理
	starting by: 每行 以什么开始 默认 “”
	Terminated by 以 什么结束 “ \r\n”  换行键


-- 举例

 select * into outfile 'D:\class2.txt' 
 fields 
 enclosed by '"' -- 双引号 包裹
 terminated by '|'
lines 
starting by 'START:'
terminated by '\r\n'
 from my_class;


delete from my_class;
 -- 数据还原:讲一个 外部保存的数据 重新 回复

 Load data infile  路径 into table 表名 fields    lines    -- 怎么备份 怎么还原



 -- SQL 备份  访问量 小

 备份的是 SQL 语句：（主要针对 表结构）

 备份：mysql 并 没有 提供备份 的指令 需要利用mysql 提供的软件  mysqldump.exe

 也是一种客户端  必须 操作 服务器   必须连接 认证


-- 语法
 mysqldump -hPup 数据库名字  [ 数据表名字1 数据表名字2...]>外部文件目录(建议 以.sql结尾)

-- SQL 备份 单表备份
mysqldump -uroot -p503503 test2 te_student > D:/student.sql

-- 整库备份
mysqldump -uroot -p503503 test2 >D:/test2.sql

-- 数据库还原
-- 方案一
Mysql.exe -hPup 数据库名字 <备份文件目录

--  如
mysql -uroot -p503503 test2 <D:/test2.sql


--方案二 使用SQL指令还原

source D:/test2.sql 

SQL备份优点
1.有点：可以备份结构
2.缺点：会浪费空间（额外增加 SQL指令）

-- 增量备份

增量备份：指定时间段 开始备份，备份数据不会重复，所有操作都会备份（大项目都用增量备份）


#****************************************************#****************************************************
#****************************************************#****************************************************
#****************************************************#****************************************************
第六天

回顾

外键：表与表 关联关系  表中字段 指向 另外一张表 的主键
	条件：字段类型一致，存储引擎 为 innodb
	 外键约束：
		子表约束 父表约束

联合查询：union 多表合并 单表 不同查询条件

	使用 order by：select语句 使用括号，配合limit


子查询：查询语句中有查询语句
	分类：按位置（from where exists） 按 返回结果

视图;view
	节省SQL语句 安全控制
	视图本质：虚拟表，有结构 无数据
	视图数据操作
	视图算法：undefined  temptable merge

文件备份与还原
	文件备份：存储引擎（myisam适用）
	单表数据备份：只能备份数据
	SQL备份（mysqldump.exe）
	增量备份：备份系统日志文件

#****************************************************#****************************************************
事务

需求：有一张银行账户表，有A用户给B用户转账：A账户增加，B用户减少。但是A操作完后
断电了。

解决方案：A减少钱，但是不要立即修改数据表，B收到钱之后，同时修改数据表。

事务安全

transaction
事务：一系列要发生的连续的操作
事务安全：保护连续操作 同时满足的 机制
意义：保证数据操作的完整性

--   创建一个账户表

create table my_account(
number char(16) not null unique comment '账户',
name varchar(20) not null,
money decimal(10,2) default 0.0 comment '账户余额'
)charset utf8;

-- 插入数据

insert into my_account values('0000000000000001','张三',1000),('0000000000000002','李四',2000);

select * from my_account;

alter table my_account add id int primary key auto_increment first;

update my_account set money=money-1000 where id = 1;



事务操作 分为  自动事务（默认）  手动事务：操作流程

1.开启事务:告诉事务 的写操作 不要直接写入 到数据表，先存放到 事务日志
--  开启事务

start transaction；

2  进行事务操作 ,一系列操作   -- 相当于 中转站
a) 李四账户减少
 update my_account set money=money-1000 where id = 2;
--  生效（事务）  别人 查 数据 并没有开始变
b) 张三账户增加
update my_account set money=money+1000 where id =1;

3 关闭事务：选择性的将日志中操作的结果 保存到数据表（同步）  或者 清空 事务表
	a). 提交事务 ：commit
	b).回滚事务:		rollback;

事务 只能  在 innodb 引擎 下 操作  myisam不行

--  事务 原理 ：事务开启 后 所有 的操作 都会临时保存到  事务日志  事务 日志 只有
得到 commint 命令 才会同步其他情况  都会清空



-- 

回滚点 ：在某个成功的操作完成之后，后续的操作不确定  可以在当前成功的位置 设置一个个
点 可供 后面的操作 返回 

语法： 设置回滚点

savepoint 回滚点名字；

回到 回滚点语法： rollback to  回滚点名字

-- 回滚点 操作
-- 开启事务

start transaction;

-- 事务处理1:张三加钱


select * from my_account;
update my_account set money=money+10000 where id =1;

-- 设置 回滚点

savepoint sp1;


-- 银行扣税
update my_account set money=money-10000 *0.05 where id =2;  -- 错误


select * from my_account;

-- 执行 回滚

rollback to sp1;

-- 继续操作
update my_account set money=money-10000 *0.05 where id =1; 

--  查看结果

select * from my_account;

commit;
 
#*****************************************************************

-- 自动事务处理

在mysql 操作完 会自动同步到数据表中。
自动事务：系统通过 auto commit 变量控制

show variables like 'autocommit';

关闭自动提交

set autocommit=off;




手动 提交commit  rollback



事务特性  ACID

A	Atomic 原子性 要么全部成功 要么失败
C	 Consistency 一致性  操作前后 数据 没变化
I	 Isolation  隔离性 独立操作 不受影响 
D	Durabil 持久性  一旦提交  永久的 改变 数据表 数据

锁机制：innodb 默认是行锁  如果 在事务操作过程中 没有使用到索引  那么 自动升级到表锁
别的用户不能曹组