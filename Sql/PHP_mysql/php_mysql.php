<?php
	//连接认证

	#此处 按照视频里mysql_connect 已经报错，是因为 PHP版本过高已经不支持mysql直接连接了 而要采用新的mysqli

//	$link=mysqli_connect('localhost:3306','root','503503');
//
//	$link2=mysqli_connect('localhost:3306','root','503503');
//	var_dump($link,$link2);

	#默认的mysql只会产生一次连接资源，不管你连多少

	#如果真要 多产生一个新的连接 就要在mysqli——connec函数加上第四个参数：True

	$link3=mysqli_connect('localhost:3306','root','503503'，ture);
	var_dump($link3);
