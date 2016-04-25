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

-- 笛卡尔积 没有意义  尽量避免。  只是 为了保证  结构 的完整性。








-- 举例









