#*************************************
mysql������  07��ʼ  ����

-- ����

��Ϊ���֣�ϵͳ���� ���Զ������

ϵͳ����õģ��󲿷� ����Ҫʹ��ϵͳ����

-- �鿴����
show variables;

-- �鿴�������ֵ 
select @@������


-- �޸�ϵͳ����

���� ��ʽ���Ự���� ȫ�� ����

�Ự������ʱ�޸�  

Set ������=ֵ
Set @@ ������= ֵ;

ȫ�ּ���һ���޸� ��������Ч �����пͻ���

set global ������= ֵ;

#*************************************

�Զ������

Ϊ������  �涨 �û��Զ��� ֻ��@����

-- �����Զ������

set @name ='����';

-- �鿴

select @name;

��mysql �� ��=�� ��Ĭ�� ���� �Ƚ� ����      Ϊ������  �Ƚ� �͸���  ������ һ���µ� ��ֵ ����   :=

set @age :=18;


mysql ���� �� ���ݱ��ȡ ���� ���� �� ����

����1��
select @������ ��= �ֶ��� from ����Դ;  -- ���ֶ�ȡֵ ��ֵ ��������  =  �ǱȽϺ���

select @name:=name from te_student;

����2�� ֻ��ֵ �������   ���ݼ�¼ֻѭ���ȡһ��

select �ֶ� from ���� into �����б�;
select name,age from te_student where id =2 into @name,@age;   -- ��� ���ܶ��� һ��

�����Զ���ı��� ���ǻỰ���𣺵�ǰ�ͻ��� ����������Ч

#*************************************
-- ������ trigger
���� Ϊĳ�ű� ��һ�δ��� �����е����ݷ����ı��ʱ����ɾ�ģ�
ϵͳ���Զ��������� ִ��

���� һ�Ŷ�����  һ����Ʒ��  ÿ����һ������  ��Ʒ�Ŀ��Ҫ���١�
 

 �������¼����� ����ʱ�� ��������

 �¼����� �� ��ɾ�� 3�� insert delete update
 �����¼��� ǰbefore �� after
 �������� ��� ���� ��ÿһ����¼


 һ�ű� ֻ��ӵ��һ�� ����ʱ��  һ������ �Ĵ�����  ��� 6 ��������
#*************************************

����������

��mysql�߼��ṹ�� û�д����� �����ö�Ӧ ���ַ����� ����


�﷨

-- ��ʱ �޸� ������

Delimiter �Զ���  ֻ������ �Զ������ �Ž���

create trigger ����  ʱ�� �¼����� on ���� for  each row

begin -- ���� �� �����ţ� ��ʼ
		-- ����  ÿ�� ���� �ֺ�  ����

end  -- ���� �� ������  ����

�Զ������


�� ��ʱ�޸� ���� ����

Delimiter ;



-- ����

create table my_goods(
id int primary key auto_increment,
name varchar(20) not null, price decimal(10,2) default 1,
inv int comment '�������'
)charset utf8;

insert into my_goods values(null,'IPhone6s',5288,100),(null,'s6',6088,100);

create table my_order(
id int primary key auto_increment,
g_id int not null comment'��ƷID',
g_number int comment '��Ʒ����'
)charset utf8;

-- ������   �������� ������
-- ��ʱ ������

delimiter $$
create trigger after_order after insert on my_order for each row
begin -- ��ʼ
	update my_goods set inv =inv-1 where id =2;
end
$$
delimiter  ;

-- �鿴������  

1. �鿴���д�����

show triggers;
[like 'patterns']

show create trigger after_order\G;

���д����� ���ᱣ�浽 һ�ű���  information_schema.triggers;

select * from information_schema.triggers;


-- ʹ�ô�����

-- ���붩��  