<?php
	//连接认证

	#此处 按照视频里mysql_connect 已经报错，是因为 PHP版本过高已经不支持mysql直接连接了 而要采用新的mysqli

//	$link=mysqli_connect('localhost:3306','root','503503');
//
//	$link2=mysqli_connect('localhost:3306','root','503503');
//	var_dump($link,$link2);

	#默认的mysql只会产生一次连接资源，不管你连多少

	#如果真要 多产生一个新的连接 就要在mysqli——connec函数加上第四个参数：True 
	#未能实现，估计因为mysqli 的原因
	//$link3=mysqli_connect('localhost:3306','root','503503'，true);
	//var_dump($link3);

/*
2.PHP发送 SQL指令

3.MYsql接受指令 执行 返回结果

4.PHP接收结果

Mixed Mysql_query(sql指令)

*/
 
#**********************************************************

/*
 #第一步 连接
	$link=mysqli_connect('localhost:3306','root','503503');
	//var_dump($link);

	//SQL指令执行 设置字符集

	//$sql="set names utf8";

	#此处要传递两个参数 与视频不一样
	//$res=mysqli_query($link,$sql);
	//var_dump($res);
//查询 所有数据库

	$sql="show databases";
	$res=mysqli_query($link,$sql);
	//var_dump($res);

	#PHP 没有办法直接使用结果集：需要解析  如mysql_fetch系列 都是指针操作，指针会移动

	#mysqli_fetch_array 得到的是索引 关联

	//var_dump(mysqli_fetch_array($res));

	#只获取 关联

	var_dump(mysqli_fetch_assoc($res));

	#只获取 索引
	var_dump(mysqli_fetch_row($res));
	
	#如果指针移动到最后，需要重置指针

	//mysqli_data_seek(资源，位置)
	var_dump(mysqli_data_seek($res,0));

	#获取的数据往往只有一行，实际上是为了 解析全部  循环遍历 实现

	//循环便利所有内容

	$databases=array();
	
	while($row=mysqli_fetch_assoc($res)){ //要么false 要么 取得 关联数组
		$databases[]=$row; //二维数组
	}
	echo'<hr/>';
	var_dump($databases);

	//释放资源：mysql 通常不需要释放（脚本周期不长）

	var_dump(mysqli_close($link));



*/
	#***********************************************
#用PHP完成数据库的增删改查  

#增删改 属于 写  #  查  属于 读

#写操作 根据人的需求，对结果进行分类操作： 增  和 删改
#新增操作：通常会获取新增记录的 自增长ID：用mysql_insert_id()，若没有自增长 id获取0 


#而删改操作，通常不能通过 mysql_query 的结果true  来判断 因为 只代表SQL没有语法错误。   要通过 受影响的行数 来判断 mysql_affeted——rows() 来判断

#*****************************************************
# 举例

#连接认证  若有错 用 mysql_errno()获取编号 ，mysql_error()获取错误信息


#有中文



# @ 抑制错误的符号 有错 就不报了

 header('Content-type:text/html;charset=utf-8');
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

$sql="use test2";
my_error($sql);

/*

//新增数据

$sql="insert into te_student values(6,2016006,'Kate','Female',27,167,2)";
my_error($sql);

//获取自增长id
$id= mysql_insert_id();
//如果id为0：说明没有自增长 受影响 为0
echo $id?$id :mysql_affected_rows();


*/

/*


//改数据

$sql="update te_student set age=floor(rand()*20+20) ";
my_error($sql);
$id= mysql_insert_id();
#通过受影响的函数来判断数据
echo $id?$id :mysql_affected_rows();


*/




/*  

//读操作  方法一

//从数据库中查出数据，在html 显示

#创建一个html 来显示


	//查询操作
$sql="select * from te_student";
$res=my_error($sql);

	//解析结果集
$student=array();
while($row=mysql_fetch_assoc($res)){
	$students[]=$row;
}

	//显示结果
include_once 'mysql_display.html';

	//显示数据


   */


   //读操作  方法二  
   //通常不这么做  因为 html一般只负责 显示 数据 不应该去处理数据。

//从数据库中查出数据，在html 显示

#创建一个html 来显示


	//查询操作
$sql="select * from te_student";
$res=my_error($sql);


#不要解析结果集
/*
	//解析结果集
$student=array();
while($row=mysql_fetch_assoc($res)){
	$students[]=$row;
}
*/


	//显示结果
include_once 'mysql_display2.html';

	//显示数据