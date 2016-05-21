#*************************************
mysql第六天  07开始  变量

-- 变量

分为两种：系统变量 和自定义变量

系统定义好的：大部分 不需要使用系统变量

-- 查看变量
show variables;

-- 查看具体变量值 
select @@变量名


-- 修改系统变量

两种 方式：会话级别 全局 级别

会话级别：临时修改  

Set 变量名=值
Set @@ 变量名= 值;

全局级别：一次修改 ，永久生效 对所有客户端

set global 变量名= 值;

#*************************************

自定义变量

为了区分  规定 用户自定义 只有@符号

-- 定义自定义变量

set @name ='张三';

-- 查看

select @name;

在mysql 中 ‘=’ 会默认 当作 比较 处理      为了区分  比较 和复制  定义了 一个新的 赋值 符号   :=

set @age :=18;


mysql 允许 从 数据表获取 数据 复制 给 变量

方案1：
select @变量名 ：= 字段名 from 数据源;  -- 从字段取值 赋值 给变量名  =  是比较含义

select @name:=name from te_student;

方案2： 只赋值 不看结果   数据记录只循序获取一条

select 字段 from 表名 into 变量列表;
select name,age from te_student where id =2 into @name,@age;   -- 结果 不能多于 一条

所有自定义的变量 都是会话级别：当前客户端 当次连接有效

#*************************************
-- 触发器 trigger
事先 为某张表 绑定一段代码 当表中的内容发生改变的时候（增删改）
系统会自动触发代码 执行

需求： 一张订单表  一张商品表  每生成一个订单  商品的库存要减少。
 

 触发：事件类型 触发时间 触发对象

 事件类型 ： 增删改 3种 insert delete update
 触发事件： 前before 后 after
 触发对象： 针对 表中 的每一条记录


 一张表 只能拥有一种 触发时间  一种类型 的触发器  最多 6 个触发器
#*************************************

创建触发器

在mysql高级结构中 没有大括号 都是用对应 的字符符号 代替


语法

-- 临时 修改 结束符

Delimiter 自定义  只有遇到 自定义符号 才结束

create trigger 名字  时间 事件类型 on 表名 for  each row

begin -- 代表 左 大括号： 开始
		-- 内容  每行 都以 分好  结束

end  -- 代表 右 大括号  结束

自定义符号


将 临时修改 修正 回来

Delimiter ;



-- 举例

create table my_goods(
id int primary key auto_increment,
name varchar(20) not null, price decimal(10,2) default 1,
inv int comment '库存数量'
)charset utf8;

insert into my_goods values(null,'IPhone6s',5288,100),(null,'s6',6088,100);

create table my_order(
id int primary key auto_increment,
g_id int not null comment'商品ID',
g_number int comment '商品数量'
)charset utf8;

-- 触发器   订单生成 库存减少
-- 临时 结束符

delimiter $$
create trigger after_order after insert on my_order for each row
begin -- 开始
	update my_goods set inv =inv-1 where id =2;
end
$$
delimiter  ;

-- 查看触发器  

1. 查看所有触发器

show triggers;
[like 'patterns']

show create trigger after_order\G;

所有触发器 都会保存到 一张表中  information_schema.triggers;

select * from information_schema.triggers;


-- 使用触发器

-- 插入订单  

insert into my_order values(null,1,2);

-- 触发器 确实执行了 只是 不符合要求

-- 触发器删除

不能修改 只能删除

drop trigger 触发器 名字

drop trigger after_order;

修改 正确触发器

-- 触发器记录

触发器记录 ：不管触发器 是否触发 只要 当 某种操作准备执行 系统就会将当前要操作的记录的当前状态 和
即将执行之后的新的状态 分别 保留 下来，供 触发器使用：当前状态保存在 old中 操作之后的状态 new中

old 代表的是 旧的记录

都是代表记录本身  使用方式
old.字段名  new.字段名

-- 重写 触发器

delimiter $$
create trigger after_order after insert on my_order for each row
begin -- 开始
	update my_goods set inv =inv-new.g_number where id =new.g_id;
end
$$
delimiter  ;


查看 效果

select * from my_goods;

select * from my_order;

插入订单 记录

insert into my_order values(null,1,2);

-- 库存判断 

-- 代码执行结构  顺序 分支  循环


#***************************************************
分支结构
在mysql 中 只有 if分支
语法
if 条件判断 then 
		-- 执行代码
Else
		-- 否则执行
End if;


触发器 结合 if 分支：判断 商品库存是否足够，不够 不生成 订单

-- 触发器：订单 之前 判断

delimiter %%
create trigger before_order before insert on my_order for each row
begin			
	select inv from my_goods where id =new.g_id into @inv;		--  获取 商品库存 获取 变量
	if @inv <new.g_number then
		insert into XXX values (XXX);					-- 暴力 终止
	end if;
end
%%
delimiter  ;

--插入 订单 错误的

insert into my_order values(null,1,10000);



循环结构

循环结构：

While 条件判断 do
		-- 满足条件 执行 的循环
		-- 变更循环条件
End while;

循环控制：在循环内部进行循环判断 和 控制
mysql 中 某有 continue break
转而 用 iterate  迭代  代替 continue  后面代码不执行 循环重新来过
leave 离开 类似 break

使用方式 iterate leave 循环名字

-- 定义循环名字
循环名字 :while 条件 do
		-- 循环体
		-- 循环控制
		Leave/iterate 循环名字
	end while;

#**************************************************************
函数 

函数：代码复用
两类：系统函数  自定义

系统函数：  系统定义好的函数：直接调用即可。任何函数 都有返回值
			函数调用 以select调用

Mysql  字符串的基本操作单位 是 字符

Substring:截取字符串

set @cn=' 中国周琦';
set @en ='NBA draft';

select substring(@cn,1,2);

char_length:字符长度
Length:字节长度

select char_length(@cn);
select length(@cn);

instr：判断字符串 是否 在另一个字符串

select instr(@cn,'周');

Lpad：左填充，将字符串 按照某个指定的填充方式 填充到 指定长度
select lpad (@cn,10,'中国');

insert 替换 找到目标位置 替换成目标 字符串

select insert(@en,1,1,'C');




