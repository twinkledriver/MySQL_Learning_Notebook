<?php

	//�����ļ�

	//�趨�ַ���
 //header('Content-type:text/html;charset=utf-8');
 //header('Content-type:text/html;charset=utf-8');
	/*
	 *	 ��ת����
	 *  @param1 string $url ,��תĿ��
	 *  @param2 string $msg ,��ת��Ϣ
	 *  @param3 int $time ,��ת�ȴ�ʱ��
	*/

	function redirect($url,$msg,$time=3){
		//��ת
		header("Refresh:{$time};url={$url}");
		//��ʾ
		echo $msg;
		//��ֹ�ű�ִ��
		exit;
	}