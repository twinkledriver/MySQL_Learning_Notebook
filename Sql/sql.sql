alter database mydatabase charset UTF8;


-- 创建表(学生)
create table if not exists student2(
name varchar(10),
gender varchar(10),
number varchar(10),
age int
)charset utf8; 

-- 创建表(班级)
create table class(
name varchar(10),
room varchar(10)
)charset utf8;

-- 查看表结构
desc student;

show columns from class;




