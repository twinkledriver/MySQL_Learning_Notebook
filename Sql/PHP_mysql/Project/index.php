<?php 
	//首页功能
	//加载公共文件
	include_once  'public/public.php';

	//加载mysql初始化文件
	include_once	'public/mysql.php';

	//组织SQL语句 查询所有学生信息
	$sql="select *,c.c_name,c.room  from pr_student as s left join pr_class as c on s.c_id=c.id";


	//执行
	$res=my_error($sql);

	//取出所有数据

	$students=array();
	while($row=mysql_fetch_assoc($res)){
		$students[]=$row;
	}


	//加载模板 显示数据
	include_once 'templates/index.html';