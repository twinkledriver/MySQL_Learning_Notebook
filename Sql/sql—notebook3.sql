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