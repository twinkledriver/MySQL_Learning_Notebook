<?php
	//header('Content-type:text/html;charst=utf-8');
	
	//引入公共文件
	include_once 'public/public.php';


	//用户登录 ：负责处理 与登录 相关的所有请求（加载表单 ，验证登录）
	//加载登录表单


	//应该先判断 用户 意图：如果 提交数据 为了验证
	if(isset($_POST['submit']))
	{
	 //验证用户信息
	
	 //接收表单数据
	 $username=trim($_POST['username']);
	 $password=trim($_POST['password']);

		if(empty($username)||empty($password))
		{
			//用户名 或者密码为空 
			//跳转

		//这个地方用refresh 不是location 3 代表 过3秒 
			//header('Refresh:3;url=login.php');
			//echo '用户名和密码都不能为空！';

		//终止脚本执行
			//exit;
			redirect('login.php','用户名和密码都不能为空!');
		}
		
		//从数据库查询当前用户和密码数据
		//加载数据库公共文件

		include_once 'public/mysql.php';

		//验证用户信息
		$username=addslashes($username);  //防止SQL注入
		$password=md5($password);  //任何地方MD5都是一样的，基于同样的算法。
		$sql="select * from pr_admin where username='{$username}' and password='{$password}'";
		
		//echo $sql;exit;



		//执行查询：SQL有可能出错
		$res=my_error($sql);  //$res 是结果集 永远是true

		//解析结果集

		$user=mysql_fetch_assoc($res);

		//判断用户是否真的存在

		if(!$user){
			//用户不存在：用户名或者密码错误；重新登录
			//header('Refresh:3;url=login.php');
			//echo '用户名或者密码错误！';

			redirect('login.php','用户名或者密码错误！');
		}

		redirect('index.php','登录成功',1);

	}else{

	//加载登录表单
	include_once'templates/login.html';	
	}

