<?php
	//������֤

	#�˴� ������Ƶ��mysql_connect �Ѿ�����������Ϊ PHP�汾�����Ѿ���֧��mysqlֱ�������� ��Ҫ�����µ�mysqli

//	$link=mysqli_connect('localhost:3306','root','503503');
//
//	$link2=mysqli_connect('localhost:3306','root','503503');
//	var_dump($link,$link2);

	#Ĭ�ϵ�mysqlֻ�����һ��������Դ��������������

	#�����Ҫ �����һ���µ����� ��Ҫ��mysqli����connec�������ϵ��ĸ�������True

	$link3=mysqli_connect('localhost:3306','root','503503'��ture);
	var_dump($link3);