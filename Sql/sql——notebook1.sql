#************************************
mysql_�ʼǡ����ڶ���03��ʼ

mysql -uroot -p;
#�����������mysql

set names gbk;

use test2;

show tables;
-�������α�
create table my_int(
int_1 tinyint,
int_2 smallint,
int_3 int,
int_4 bigint

)charset utf8;

--��������
insert into my_int values (100,100,100,100);

insert into my_int values (255,100,100,100); --���У�����Χ

 --Ĭ���з��ŵģ�������


--����һ���޷�������
alter table my_int add int_5 tinyint unsigned;

--�鿴�ֶ�
desc my_int;

--�ٲ���

insert into my_int values(127,1000,10000,1000000,255);


--�鿴����

select * from my_int;

--�ֶ����ͺ�������Ŵ�����ʾ��ȡ���������������ʾ��λ����

--ָ����ʾ���(�������ƴ�С)
alter table my_int add int_6 tinyint(1) unsigned;

--��ʾ��ȵ����壺ǰ�油0���� ��ȡ�zerofill

--�����Զ���� �޷����͡�
alter table my_int add int_7 tinyint(2) zerofill;

--�����������0��䣻
insert into my_int values(1,1,1,1,1,1,1);
#**********************************************
mysql_�ʼǡ����ڶ���04��ʼ

--�����ͣ���ʧ���ȣ��������ͣ����ᶪʧ���ȣ� 

create table my_float(
f1 float,
f2 float(10,2),		
f3 float(6,2)		
)charset utf8;

desc my_float��

-- ��������

insert into my_float values(1000.10,1000.10,1000.10);
insert into my_float values(9999999999,1000.10,1000.10);

-- �����ͣ����Եı�֤�������ֲ����������루���ᶪʧ���ȣ��� 
-- �䳤���ݡ�

-- ������������ �� ������ �Ա�

create table my_decimal(
f1 float(10,2),
d1 decimal(10,2)
)charset utf8;


desc my_decimal;

-- ��������

insert into my_decimal values(12345678.90,12345678.90);
insert into my_decimal values(1234.90,1234.567890);

-- �鿴 ����
show warnings;

-- ���볬����Χ����
insert into my_decimal values(99999999.99,99999999.99); -- �߽�ֵ
insert into my_decimal values(99999999.99,99999999.999); 

#���ۣ� ����Ҫ�뾫ȷһ��Ҫʹ�� ������decimal�� ��֮���������Ϳ�����

#*********************************************************************
�ڶ���06 ʱ����������

create table my_date(
d1 datetime,
d2 date,
d3 time,
d4 timestamp,
d5 year
)charset utf8;

-- �� year(2) year(4) ������ ����Ƶ

insert into my_date values('2016-4-5 15:30:12','2016-4-5','15:31:05','2016-4-5 15:31:25',2016);

-- ���� ʱ�� Ҳ����

insert into my_date values('2016-4-5 15:30:12','2016-4-5','-15:31:05','2016-4-5 15:31:25',2016); -- ��ȥ��15:31:05������
insert into my_date values('2016-4-5 15:30:12','2016-4-5','-2 15:31:05','2016-4-5 15:31:25',2016); -- ��ȥ��24*2 +15:31:05������

-- yearʹ��2 λ ��4 λ


insert into my_date values('2016-4-5 15:30:12','2016-4-5','15:31:05','2016-4-5 15:31:25',56);
insert into my_date values('2016-4-5 15:30:12','2016-4-5','15:31:05','2016-4-5 15:31:25',78);

#year��4�� 1970 ��2069 ��Χ

select * from my_date��

-- timestamp:�޸ļ�¼  �޸Ķ��� timestampҲ���Զ�����

-- ��ȡ ʱ���
select unix_timestamp();

#******************************************************
#�ַ�������

-- ���ѡ�񶨳������Ǳ䳤�ַ����أ�
-- �����Ĵ��̿ռ�Ƚ��˷ѣ�����Ч�ʸߣ�������ݻ�����ȷ�����ȶ�һ������ʹ�ö����������֤���绰���룬�ֻ�����ȡ�
-- �䳤��֮��������ݲ���ȷ�����ȣ���ͬ�����б仯��������������ַ��

#�ı��ַ���

-- ����������ǳ��� ��ͨ��˵����255���ַ�
--�������ݸ�ʽ �ַ�Ϊtext blob
--Text���洢����  -- Blob �洢���������ݣ�ͨ�����ã�

#ö���ַ���  ���壺enum
-- ����ö�ٱ�
create table my_enum(
gender enum('����','Ů��','����')
)charset utf8;


desc my_enum;

#ö������
#����һ
-- �������� ������ֻ���ǹ涨�����е�һ����
insert into my_enum values('��'),('����');

#����
insert into my_enum values('Male');
 
#���ö�����ʡ�ռ䣨��ѡ��

#֤�����ݴ洢������ֵ���ֶ�ȡ��+0 �����

select gender+0 ,gender from my_enum;

#ö��ʵ�ʣ���� ���ȥ��ֵ  

insert into my_enum values('1'),('2');

select * from my_enum;

create table my_set(
hobby set('����','����','ƹ����','����','̨��','����','����')
)charset utf8;

-- ��������

insert into my_set values('����,̨��,����');
insert into my_set values(3);

select hobby+0,hobby from my_set;

--98ת������01100010��Ӧset λ�� ������
-- ����Ԫ�� ��Ӧ ������λ 
-- ˳�� �޹�ϵ ��Ӧλ�� ��1
-- �淶���� ��ʡ�ռ�


varchar ��utf8 �������ռ�21844  gbk��32766

max�磺
create table my_set(
name vachar(21844)
)charset utf8;

-- �����༶��
create table my_class(
name varchar(20) not null,
room varchar(20) null  --  Ĭ�� ��
)charset utf8;


-- ������
-- comment ��ʾ
create table my_teacher(
name varchar(20) not null comment '����',
money decimal(10.2) not null comment '����' 
)charset utf8;


desc my_teacher;
show create table my_teacher;

-- Ĭ��ֵ

--Ĭ��ֵ��ĳһ�����ݾ����Եĳ���ĳ�������ֵ��������һ��ʼ��ָ���ã��û�����ѡ����ʹ��
-- �ؼ��� �� default

-- ����

create table my_default(
name varchar(20) not null,
age tinyint unsigned default 0,
gender enum('��','Ů','����') default '��'
)charset utf8;

-- Ĭ��ֵ ��Ч



#*******************************************#*******************************************
#*******************************************#*******************************************
#*******************************************#*******************************************

#������ ��Ƶ

#�ֶ�����

#���� Ψһ�� ������

#������ һ�ű�ֻ��һ���ֶο���ʹ�ö�Ӧ�ļ��������ظ���
#һ�ű� ���ֻ��һ������


#һ��ʼ ��Ҫ Set name gbk;



#���� ���� ����Ϊ��

-- ����1�� ���ֶκ�� primary key

-- ����

create table my_pri1(
name varchar(20) not null comment '����',
number char(10) primary key comment 'ѧ��:itcast+0000,�����ظ�'
)charset utf8;

desc my_pri1;

--  ����2�� �������ֶ�֮��

-- ��������

create table my_pri2(
number char(10) comment'ѧ�ţ�itcast+0000',
course char(10) comment '�γ̴��룺3901+0000',
score tinyint unsigned default 60 comment '�ɼ�',
-- ���Ӹ�������
primary key(number,course)

)charset utf8;

desc my_pri2;


--  ����2�� ���Ѵ��� ׷������:�޸ı��ֶ� ����  �� ׷��
-- ׷�� ����

create table my_pri3(
course char(10) not null comment'�γ̱�ţ�',
name varchar(10) not null comment '�γ�����'
);

alter table my_pri3 modify course char(10) primary key comment '�γ̱�ţ�';
 -- ����

alter table my_pri3 add primary key(course);

#***********************************************
 #����Լ��  �����ж�Ӧ���ֶε����ݲ����� �ظ�

 # ����ɾ��  ����û�а취 ���£�ֻ��ɾ�� �� ����


 Alter table ���� drop primary key;

 Alter table my_pri3 drop primary key;

 #����(Ψһ)����
 ����ʹ��ҵ������ ��Ϊ���� �ֶΣ��� ���� ѧ�� �γ̺ţ�
�󲿷� ʹ���߼��� �ֶΣ��ֶ�û��ҵ���壬ֵ��ʲô����ν��

Create table my_student(
Id int primary key auto_increment comment'�߼�������������', -- �߼�����
Number char(10) not null comment' ѧ��',
Name varchar(10) not null
)

#�Զ�����

create table my_auto(
id int primary key auto_increment comment '�Զ�����',
name varchar(10) not null
)charset utf8;

desc my_auto;


# ��������ֵΪĬ�� NULL ����

-- ����������
insert into my_auto(name) values('����');
insert into my_auto values (null,'�к�');
insert into my_auto values (default,'��Ӯ');


select * from my_auto;

�����������Ӧ���ֶ� ������ֵ����ô������ʧЧ�������´δ����ʼ��������

-- ָ������

insert into my_auto values(8,'�ȵ�');
insert into my_auto values(NUll,'����');

show create table my_auto;

-- �޸�������
������������漰�� �ֶ� �ı䣺���� ��ɾ�� �ٴ���
�޸ĵ�ǰ������ ֻ�ܱȵ�ǰ�����ֵ Ҫ�� ������Ч

Alter table my_auto auto_increment =6; (��Ч)
Alter table my_auto auto_increment =15;



-- �鿴������ ����

show variables like 'auto_increment%'
-- increment ����  offset --��ʼֵ
-- �޸� ������������ݿ�ģ�һ�㲻�������޸� �ǻỰ���𣩣�������Ч��

-- ɾ��������

���������ֶε�һ�����ԣ�������modify ��

Alter table my_auto modify id int primary key;  -- ���� ������������


alter table my_auto modify id int;   

-- Ψһ�����ܶ��ֶξ���Ψһ������ֻ��һ����������������Ψһ��
-- Ψһ��Ĭ�ϵ�����Ϊ��
-- ����һ

create table my_unique1(
number char(10) unique comment 'ѧ�ţ�Ψһ������Ϊ��',
name varchar(20) not null
)charset utf8;

-- ������ Not null + Ψһ ��ʾ�� ������ʵ���ϲ�������
create table my_unique2(
number char(10) not null comment 'ѧ�ţ�Ψһ������Ϊ��',
name varchar(20) not null,

unique key(number)
)charset utf8;

-- ������ �ڴ�����־�� ����Ψһ�� ׷��

create table my_unique3(
id int primary key auto_increment,
number char(10) not null,
name varchar(20) not null 
)charset utf8;

alter table my_unique3 add unique (number);

-- ɾ�� Ψһ��

alter table ���� drop index �������� -- �ֶ��� ���� ��������

#���������壺
#1���� ��ѯ���ݵ�Ч��
#2 Լ�� ���ݵ���Ч��

#Ч�� ��  ���̿ռ� �� ����


#*****************************************************
��ϵ����֮��Ĺ�ϵ

��ϵ ��ӳ �� ���ݿ��������

һ��һ��
�����õ����� ���� �� Ӱ��Ч��
���� �� ������ �� ����洢���ֳ����ű� ��ʱ����Ҫ 1��1 �� ƥ����

��һ��Ψһ�Ե��ֶ� �� ȷ�� ��¼

һ�Զࣺ
��Զࣺ����� һ���ֶ�Ҫ���������ݵ�Ҫ�󡣲����ϱ����ƹ淶��
	��ʱ��Ҫ����һ���±�ר��ά�����ű�Ĺ�ϵ��

	����һ���м��ϵ��ר������ ��ʦ��ѧ���Ĺ�ϵ
	��ô���м�����ʦ���γ���һ�Զ�Ĺ�ϵ���������м�� �� ���

#*************************************************************
��ʽ 
��ʽ��Normal Format,��� ���ݵ� �洢 ���Ż� ���⣺��֤ ���� �Ĵ洢 ֮�� ��
	�����ܹ�ͨ����ϵѰ�ҵ����� ����������ظ��洢��Ŀ�� �������ݵ����ࡣ

	�ֲ�ṹ�� ����  Խ��Խ �ϸ�

	1NF��


	2NF

	3NF

	Mysql ���� ��ϵ��  ���ݿ�   ��� �� ��Ƶ�ʱ������ ��ʽ ��ָ����ơ�

	���ݿ� ���� �ռ� �� Ч�� ����
	��ʽ ֻ���� �ռ�

	������ ��ȫ ���� ��ʽҪ����� ֻҪ���� 1NF 2NF 3NF

	��ʽ ����ָ�� ���� �������� ǿ�� �淶�� 



	1NF��
	��һ��ʽ����� ���� �ֶε����� ��ȡ���� ����Ҫ ������֣����������һ��ʽ��
	��Ϊ ��һ��ʽ���� ԭ���ԡ������ٷ֡�

	

	2NF�� 
	�ڶ���ʽ������и������������ֶ����������ұ������ֶ����������е�ĳ���ֶΣ�
	������ �ֶ����������Ĳ��ֵ����⣬��֮Ϊ���������� ������ �ڶ���ʽ

	����� 1���ó��� �����ɱ� 2��ȡ������������ʹ���߼�����


	3NF��
	������ʽ�� �����Ͻ���һ�ű��е������ֶ� ��Ӧ��ֱ������������������д���һ��
	�ֶΣ�����ֱ����������������ͨ��ĳ��������������ɵ� ��֮Ϊ ����������
	������ʽ ��� ��������

	����������������������ֶ� ȡ�����������γ�һ����

	Ȼ������Ҫ��Ӧ��Ϣ��ʱ�� ���� ʵ��������


#**********************************
����Ʊ��ʱ������м����ֶ� ��Ҫ�� ��һ���� ȥ �ҡ������ϣ�Ч�ʻ��һ�㡣
��ʱ����������ĳЩ���У���ȥ�����������������߼�������������ֱ�ӱ��� ������Ϣ
Ŀ�� �����Ч��
���� ��  ��淶��  ���� �ᵼ�� �������� ���ӡ�

��淶����������������Ч�ʵĶԿ�

��������

#******************************************************
insert into ����[(�ֶ��б�)] values (ֵ�б�);



������ͻ�����²���

����һ

Insert into ����[(�ֶ��б���������)]values(ֵ�б�) on duplicate key update �ֶ� =��ֵ;


#�� �� my_class ����

desc my_class;

1����������

alter table my_class add primary key(name);

2,��������

insert into my_class values ('PHP0810','B203');

select * from my_class;

����ٴβ��룺
insert into my_class values ('PHP0810','B205')

-- ����
--  ���� ��ͻ����

on duplicate key update room='B205';

���� �Ͷ� �������� �ֶ� ������ �޸ġ�

��������������ͻ���滻��
Replace into my_class values('PHP0710','A203');

#**************************************************

��� ����

��渴�ƣ������е�������ȥ��ȡ ���ݣ�Ȼ���ֽ������������� ���� �ɱ����ӡ�

�����߼��������� ���б� �����±����Ʊ�ṹ��

��


create table my_gbk(
name varchar(32766)

)charset gbk;

-- ���� ������
-- ֻ ����  �ṹ �������� ����
create table my_copy like my_gbk;

-- ��渴�� �Ȳ����� ������һ��

insert into my_copy select * from my_collate_bin;

select * from my_copy;

 #ÿ����һ�� �͸��� һ�Ρ�������   �о������ѡ� 

#���壺
1�������б� ���� ���±� ��
1��ʹ�� Ѹ�� ���͵�һ���� ������ �Բ��ԡ�

#�߼�������������

�����﷨  

���²��� ����

update my_copy set name='c' where name='a' limit 3; # ǰ����

��Сд ���� ������

�鿴һ�£�
show create table my_copy;

#�߼� ���� ����ɾ��

��������ƣ�ͨ�� limit  ������ ����
 #  ɾ 10����b��
Delete from my_copy where name='b' limit 10;

ɾ�� ��������д��� ����  ������ ��ɾ��֮�� ����Ӱ�� ������

#�� student�� add һ������




alter table te_student modify id int not null ;

#�޸� id
update  te_student set id=1 where name='Jerry';

update  te_student set id=2 where name='Lucy';

update  te_student set id=3 where name='Marry';

update  te_student set id=4 where name='Lily';

update  te_student set id=5 where name='Bob';

insert into te_student values (201601,'Bob','Male',18,001);

show create table te_student;
alter table te_student add primary key(id);

#��id ��� ������

alter table te_student modify id int auto_increment;


#��� ɾ�� ����  �鿴 ������Ҳ���� ԭ����ֵ

delete from te_student;  #(δִ��)

#ֻ�� ɾ�����ؽ�

#��һ���µ� ��� ��ձ� ����������

truncate te_student;

#***********************************************

# �߼� ��ѯ����

select �ֶ� from ���� where ����

#���� �﷨��

select[select ѡ��]  �ֶ��б�[�ֶα���]����*   from  ����Դ  [where �����־�] [group by �־�] [having �־�] [order by �־�] [limit �־�];

���� Selectѡ��Բ�����Ľ�� �Ĵ��� ��ʽ
	All��Ĭ�ϵģ��������еĽ��
	distinct: ȥ��(��ȫһ��)

select distinct * from my_copy; #�ظ��� �Ͳ�Ҫ��

#************************************************

�ֶα���

�ֶα����������ݽ��в�ѯ������ʱ����ʱ�����ֲ���һ����������ͬ������
Ҫ���б��� ����

�ֶ��� [as] ����

Insert into te_student values(2016001,'Mary','Female','14',1);

desc te_student;

select 
id,
StudentNumber as ѧ��,
name as ����,
gender as �Ա�,
age from te_student;

#********************************************

����Դ�� ��ϵ�� ���ݿ����Դ ���� ���ݱ� 
����Դ ��Ϊ  ���� ����Դ  ��� ����Դ  ��ѯ���

��������Դ��  select * from ����;
���		select * from ��1,��2;

select * from te_student,my_teacher;
 ��һ�ű��һ����¼��ȥƥ����һ�ű��е����� ��¼������ ��������
 ���� ����   ��  ���ֽ�� ��Ϊ �ѿ��������������ӣ�.û�ã�Ӧ�ñ��⡣
#**********************************************

 #�Ӳ�ѯ�����ݵ���Դ ��һ�� ��ѯ���   ����һ�� ���滹�� 

 Select * from (select * from my_student) as s;

# ***********************************
 Where �־�   
 ���ж����� ɸѡ ���ݡ�  0:False 1:True û�в���

 �ж�������
 
�Ƚ������
 ���� like  between

 ��������� ��=��  �����ǡ�==�� 
�߼������
&& || ��

where ԭ��

Ψһһ���Ӵ���ȡ���ݵ�ʱ�� �Ϳ�ʼ 
�ж� ������� �����ڴ� 
�������

-- ���� �޸� age �� height �ֶ�

alter table te_student modify age tinyint unsigned;
alter table te_student add height tinyint unsigned;

select * from te_student;

-- ���ֵ��randȡ��0��1֮�������� �� ����ȡ��floor
Insert into te_student values(2016002,'Jack','Male',50,2,NUll);

Insert into te_student values(2016003,'Bob','Male',50,3,NUll);

Insert into te_student values(2016004,'Lily','Female',50,4,NUll);

Insert into te_student values(2016002,'John','Male',50,5,NUll);

update te_student set age=floor(rand()*20+20),height=floor(rand()*20+170);

#****************************************************
-- ��ѧ��idΪ1,3,5��ѧ�� ������

select * from te_student where id in(1,2);
select * from te_student where id =1||id=2;  -- �߼�����

-- ������� ���� ���180 190 ���� ��ѧ�� 

select * from te_student where height>=180 && height<=190;
select * from te_student where height between 180 and 190;

and ��� С�� �ұ�
#*********************************************************
 
 Group by �־�
  �������˼

  �����﷨��group by �ֶ�

  -- ���� �Ա����


���� Ϊ��ͳ��

ͳ�ƺ���

Count()
Max()
Min()
Avg()
Sum()


select gender,count(*),max(height),min(height),avg(age),sum(age) from te_student group by gender;


-- ���� ͳ�ƣ� ���  ���䡣��
-- ���� ��Ϊ�� ͳ��  ���� û����

Count ������ ���������ֲ�����* ����ͳ�Ƽ�¼��  �ֶ���  Ҳ���ԣ�NULL ��ͳ�ƣ�

-- ���� ���Զ����� ���ݷ����ֶΣ� Ĭ������

Group by  �ֶ�[asc|desc]

select gender,count(*),max(height),min(height),avg(age),sum(age) from te_student group by gender desc;


-- ���ֶ� ���� �ȷ�  �ٷ�

desc my_class;

-- ȡ������

alter table my_class drop primary key;


-- ���� id �ֶ� d�� ����

alter table my_class add id int primary key auto_increment;

select * from my_class;

insert into my_class values('PHP0910','C957',NULL);


-- �� te_student  ���� һͨ  ��Ϥ����  

# �鿴
desc te_student;

select * from te_student;

# ���� id �ֶ�
alter table te_student drop id ;
# ��� �µ� c_id �ֶ�

alter table te_student add c_id int;


alter table te_student add id int primary key auto_increment;



#ceil ����ȡ��
update te_student set c_id=ceil(rand()*3);

-- ���ֶ� ���飺�ȷְ༶ ��� ��Ů

select c_id,gender,count(*) from te_student group by c_id,gender;

#**********************************************

��һ�� ���� group_concat(�ֶ�): ���ԶԷ����е��ַ��� ��������  ��ʾ ������ �� ����Ա��Ϣ
select c_id,gender,count(*),group_concat(name) from te_student group by c_id,gender;

#*******************************************

����ͳ�ƣ� with rollup�� �κ�һ������ ����Ҫ ���ϼ����� ���� �㱨ͳ�ƣ����ݵ�ǰ������ֶ�

����ͳ�ƻὫ ���� �ÿ�
-- ����

select c_id,count(*) from te_student group by c_id;

-- ���ݷ�ʽ ��һ����¼
select c_id,count(*) from te_student group by c_id with rollup;

-- ���ֶ� ���� ���� ͳ��
select c_id,gender,count(*),group_concat(name) from te_student group by c_id,gender with rollup;

-- ���ֶ� ���� 
�� ���� ��һ�� ���� ����һ�� ���� ������ ���� ���� ���Ƕ���
�ڼ��� ��һ�� ����

#*******************************************
Having ���

having �� where һ�� �����ж�
��ͬ�㣺

Where ���� ���� �ж�  ���� �ڴ�֮��  ������� �� where ���ܴ��� ������
������Ҫhaving ������

having ���� where ��������������  ������ where ȴ����

����ͳ�ƽ��   ֻ��having�ܴ���

-- ����1

--  ���ÿ�������а༶���� ���ڵ���2 ��ѧ��(���� ֮��  �µ�����)

select c_id,count(*) from te_student group by c_id having count(*) >=2;

-- ����2
-- having ����ʹ���ֶα���    ��Ϊ ���� �� �����ڴ�Ų�����

select c_id,count(*) as total from te_student group by c_id having total >=2;

#ģ����ѯ j��ͷ��������
select name as ����,gender as �Ա� from te_student having ���� like 'J%';

 
 -- Order by

Order by�����򣬸��� ĳ���ֶ� ���� ����  ���� У�Լ�

Order by �ֶ��� [asc|desc]

#group by ֻȡ ��һ����¼  order by ȡ ���м�¼

select * from te_student order by c_id;

-- ���ֶ� ���� ���� ����

-- �� �༶ ���Ա�

select * from te_student order by c_id,gender desc;

-- limit �־� 

���� ������־�

limit ����ʹ�÷�ʽ
1�� ���Ƴ��ȣ���������

-- ����  �� ǰ����ѧ��
select * from te_student limit 2;

2�� ������ʼλ��  �� ���� �� �� ָ�� ��ʼ �����Ҽ��� ���ݣ�

-- ���� �� ��һ������ ��ʼ  ��
select * from te_student limit 1,2;

#  Ӧ�� ʵ�����ݵ� ��ҳ��Ϊ�û� ��ʡʱ�䣬�����Ӧ�� ������Դ���˷�

���û� ���������� ��ҳ�İ�ť
���� ������ ���� �û� ����ȡ  limit offset,length;

length:ÿһҳ��ʾ
Offset:offset=(ҳ��-1)*ÿҳ��ʾ��

































  













    















 




















 





















