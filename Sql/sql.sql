alter database mydatabase charset UTF8;


-- ������(ѧ��)
create table if not exists student2(
name varchar(10),
gender varchar(10),
number varchar(10),
age int
)charset utf8; 

-- ������(�༶)
create table class(
name varchar(10),
room varchar(10)
)charset utf8;

-- �鿴��ṹ
desc student;

show columns from class;




