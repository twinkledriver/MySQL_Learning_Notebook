<?php
	//header('Content-type:text/html;charst=utf-8');
	
	//���빫���ļ�
	include_once 'public/public.php';


	//�û���¼ �������� ���¼ ��ص��������󣨼��ر��� ����֤��¼��
	//���ص�¼����


	//Ӧ�����ж� �û� ��ͼ����� �ύ���� Ϊ����֤
	if(isset($_POST['submit']))
	{
	 //��֤�û���Ϣ
	
	 //���ձ�������
	 $username=trim($_POST['username']);
	 $password=trim($_POST['password']);

		if(empty($username)||empty($password))
		{
			//�û��� ��������Ϊ�� 
			//��ת

		//����ط���refresh ����location 3 ���� ��3�� 
			//header('Refresh:3;url=login.php');
			//echo '�û��������붼����Ϊ�գ�';

		//��ֹ�ű�ִ��
			//exit;
			redirect('login.php','�û��������붼����Ϊ��!');
		}
		
		//�����ݿ��ѯ��ǰ�û�����������
		//�������ݿ⹫���ļ�

		include_once 'public/mysql.php';

		//��֤�û���Ϣ
		$username=addslashes($username);  //��ֹSQLע��
		$password=md5($password);  //�κεط�MD5����һ���ģ�����ͬ�����㷨��
		$sql="select * from pr_admin where username='{$username}' and password='{$password}'";
		
		//echo $sql;exit;



		//ִ�в�ѯ��SQL�п��ܳ���
		$res=my_error($sql);  //$res �ǽ���� ��Զ��true

		//���������

		$user=mysql_fetch_assoc($res);

		//�ж��û��Ƿ���Ĵ���

		if(!$user){
			//�û������ڣ��û�����������������µ�¼
			//header('Refresh:3;url=login.php');
			//echo '�û��������������';

			redirect('login.php','�û��������������');
		}

		redirect('index.php','��¼�ɹ�',1);

	}else{

	//���ص�¼����
	include_once'templates/login.html';	
	}
