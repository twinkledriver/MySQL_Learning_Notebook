<?php 
	//首页功能
	//加载公共文件
	include_once  'public/public.php';

	//加载mysql初始化文件
	include_once	'public/mysql.php';

	//获取分页相关信息
	// 获取页码

	$page = isset($_GET['page']) ? $_GET['page'] : 1;

	//设定每页显示的数据量
	$length = 3;

	//求出分页偏移量
	$offset = ($page-1) * $length;

	//获取总记录数
	$sql="select count(*) as c from pr_student as s left join pr_class as c on s.c_id=c.id  ";
	//结果集
	$res = my_error($sql);
	//解析结果集(是一个数组)
	$count = mysql_fetch_assoc($res);
	//总记录数
	$counts = $count['c'];
	
	//总页数(向上取整)

	$pages = ceil($counts / $length);

	//求出对应的上一页和下一页的页码
	$prev = $page>1 ? $page-1 : 1;
	$next = $page<$pages  ? $page+1 :$pages;


	//组织SQL语句 查询所有学生信息
	$sql="select *,c.c_name,c.room  from pr_student as s left join pr_class as c on s.c_id=c.id limit {$offset},{$length}";


	//执行
	$res=my_error($sql);

	//取出所有数据

	$students=array();
	while($row=mysql_fetch_assoc($res)){
		$students[]=$row;
	}


	//加载模板 显示数据
	include_once 'templates/index.html';