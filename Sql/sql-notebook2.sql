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
 




























