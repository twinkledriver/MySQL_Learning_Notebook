<?php

	//用户登录 ：负责处理 与登录 相关的所有请求（加载表单 ，验证登录）
	//加载登录表单


	//应该先判断 用户 意图：如果 提交数据 为了验证
	if(isset($_POST['submit']))
	{
	 //验证用户信息
	
	 //接收表单数据
	 $username=$_POST['username'];
	 $password=$_POST['password'];

		if(empty($username)||empty($password))
		{
			//用户名 或者密码为空
			//跳转

			header('Refresh:3;url=www.baidu.com');
			echo '用户名和密码都不能为空！';

		}
	}
	else
	{

	//加载登录表单
	include_once'templates/login.html';	
	}

