<?php 
	//��ҳ����
	//���ع����ļ�
	include_once  'public/public.php';

	//����mysql��ʼ���ļ�
	include_once	'public/mysql.php';

	//��ȡ��ҳ�����Ϣ
	// ��ȡҳ��

	$page = isset($_GET['page']) ? $_GET['page'] : 1;

	//�趨ÿҳ��ʾ��������
	$length = 3;

	//�����ҳƫ����
	$offset = ($page-1) * $length;

	//��ȡ�ܼ�¼��
	$sql="select count(*) as c from pr_student as s left join pr_class as c on s.c_id=c.id  ";
	//�����
	$res = my_error($sql);
	//���������(��һ������)
	$count = mysql_fetch_assoc($res);
	//�ܼ�¼��
	$counts = $count['c'];
	
	//��ҳ��(����ȡ��)

	$pages = ceil($counts / $length);

	//�����Ӧ����һҳ����һҳ��ҳ��
	$prev = $page>1 ? $page-1 : 1;
	$next = $page<$pages  ? $page+1 :$pages;


	//��֯SQL��� ��ѯ����ѧ����Ϣ
	$sql="select *,c.c_name,c.room  from pr_student as s left join pr_class as c on s.c_id=c.id limit {$offset},{$length}";


	//ִ��
	$res=my_error($sql);

	//ȡ����������

	$students=array();
	while($row=mysql_fetch_assoc($res)){
		$students[]=$row;
	}


	//����ģ�� ��ʾ����
	include_once 'templates/index.html';