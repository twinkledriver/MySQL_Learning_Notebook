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





























