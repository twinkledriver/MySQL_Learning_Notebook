<?php
	//数据库初始化

 $link=@mysql_connect('localhost','root','503503');
#判断结果

if(!$link){
	echo '数据库连接失败!<br/>';
	echo '错误编码是：'.mysql_errno().'<br/>';

	#乱码 是因为 mysql 获取的错误信息默认是GBK编码 所以需要函数 来转码

	echo '错误原因是：'. iconv('GBK','GBK',mysql_error()) .'<br/>';

	//有错，终止脚本

	exit;
}




#在操作数据库之前，要做一些初始化工作，其实每一条语句 都有可能有错，将判断错误信息的代码进行封装——————错误处理函数

/*
	封装错误处理函数
	@参数 要执行的sql 语句
	@return 执行结果  或者  直接终止脚本

*/

function my_error($sql){
	//执行sql语句
	$res=mysql_query($sql);

		if(!$res)
		{
		echo 'sql有语法错误!<br/>';
		echo '错误编码是：'.mysql_errno().'<br/>';
		#乱码 是因为 mysql 获取的错误信息默认是GBK编码 所以需要函数 来转码
		echo '错误原因是：'. iconv('GBK','GBK',mysql_error()) .'<br/>';
		//有错，终止脚本
		exit;
		}
	return $res;
}

#任何SQL语句 的执行 都可以用上面自定义的函数 my_error 来做


#操作数据库: 设置字符集 ，选择数据库

$sql="set names utf8";
$res=mysql_query($sql);

if(!$res){
	echo 'sql有语法错误!<br/>';
	echo '错误编码是：'.mysql_errno().'<br/>';
	#乱码 是因为 mysql 获取的错误信息默认是GBK编码 所以需要函数 来转码
	echo '错误原因是：'. iconv('GBK','GBK',mysql_error()) .'<br/>';
	//有错，终止脚本
	exit;
}

$sql="use project";
my_error($sql);
