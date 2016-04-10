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


















