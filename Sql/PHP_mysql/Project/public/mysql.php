<?php
	//���ݿ��ʼ��

 $link=@mysql_connect('localhost','root','503503');
#�жϽ��

if(!$link){
	echo '���ݿ�����ʧ��!<br/>';
	echo '��������ǣ�'.mysql_errno().'<br/>';

	#���� ����Ϊ mysql ��ȡ�Ĵ�����ϢĬ����GBK���� ������Ҫ���� ��ת��

	echo '����ԭ���ǣ�'. iconv('GBK','GBK',mysql_error()) .'<br/>';

	//�д�����ֹ�ű�

	exit;
}




#�ڲ������ݿ�֮ǰ��Ҫ��һЩ��ʼ����������ʵÿһ����� ���п����д������жϴ�����Ϣ�Ĵ�����з�װ����������������������

/*
	��װ����������
	@���� Ҫִ�е�sql ���
	@return ִ�н��  ����  ֱ����ֹ�ű�

*/

function my_error($sql){
	//ִ��sql���
	$res=mysql_query($sql);

		if(!$res)
		{
		echo 'sql���﷨����!<br/>';
		echo '��������ǣ�'.mysql_errno().'<br/>';
		#���� ����Ϊ mysql ��ȡ�Ĵ�����ϢĬ����GBK���� ������Ҫ���� ��ת��
		echo '����ԭ���ǣ�'. iconv('GBK','GBK',mysql_error()) .'<br/>';
		//�д�����ֹ�ű�
		exit;
		}
	return $res;
}

#�κ�SQL��� ��ִ�� �������������Զ���ĺ��� my_error ����


#�������ݿ�: �����ַ��� ��ѡ�����ݿ�

$sql="set names utf8";
$res=mysql_query($sql);

if(!$res){
	echo 'sql���﷨����!<br/>';
	echo '��������ǣ�'.mysql_errno().'<br/>';
	#���� ����Ϊ mysql ��ȡ�Ĵ�����ϢĬ����GBK���� ������Ҫ���� ��ת��
	echo '����ԭ���ǣ�'. iconv('GBK','GBK',mysql_error()) .'<br/>';
	//�д�����ֹ�ű�
	exit;
}

$sql="use project";
my_error($sql);