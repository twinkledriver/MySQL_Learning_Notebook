#  mysql ������ ��Ƶ

#��ϰ

#��ʽ��
1NF  ԭ����
2NF ������  �������� û�и�������
3NF ������ ��������  

#******************************************************


mysql -uroot -p

set names gbk

use test2;


���� ��ѯ ѧ�� ������ѧ��

select * from te_student;

select * from my_class;

update te_student set StudentNumber=2016005 where name='John';

#��ĳ���ֶ� �ı� λ�á�

alter table my_class change id id int first;
alter table te_student change id id int first;

#���� ��ѯ

�����ű� ���м�¼ �����ӣ�ƴ�ӣ�  �������¼���ܱ仯 �ֶ� һ�������ӣ��ϲ�����

���壺���û���ѯ���ݵ�ʱ����Ҫ��ʾ���Զ��ű� �����ݡ�

-- ����

SQL �� �����Ӳ�ѯ �ֳ� 4�� 

������
������  
��Ȼ���� 
��������

-- �������� cross join ��һ�ű��� ѭ�� ȡ��ÿһ�� ��¼ ��Ȼ�� ��ȥ ��һ��
-- ƥ�� һӦ ������  �����γ� �ѿ�����

-- �����﷨ ���Ӳ�ѯ��
join 
#��� join �ұ�

-- ��������
��� cross join �ұ�==from  ��� ���ұ�

-- ���� ����һ�� ����Դ
select * from te_student cross join my_class;

-- �ѿ����� û������  �������⡣  ֻ�� Ϊ�˱�֤  �ṹ �������ԡ�








-- ����








