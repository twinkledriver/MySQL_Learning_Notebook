-- �������ݿ�

create database project charset utf8;

use project;

-- ���ӱ�����Ա��
create table pr_admin(
id int primary key auto_increment,
username varchar(20) not null unique comment'�û���������Ψһ��',
password char(32) not null comment'�û����룺MD5����'
)charset utf8;

-- ��������

insert into pr_admin values(null,'admin',md5('admin'));

-- ���ѧ���� �Ͱ༶��
create table pr_student like test2.te_student;
create table pr_class like test2.my_class;


-- ��ȡ����:��渴��
insert into pr_student select * from test2.te_student;
insert into pr_class select * from test2.my_class;

-- ������ �ϲ��� 
select * from pr_student left join pr_class on c_id=pr_class.id;
