/*
进阶1 基础查询
语法：
select 查询列表 from 表名

查询列表是： 表中字段、常量值、表达式、函数
类似 System.out.println()
*/
USE myemployees;

# 0 显示表结构
DESC departments;

# 1 查询表中单个字段
SELECT last_name FROM employees;

# 2 查询表中多个字段
SELECT department_name, department_id FROM departments;

# 3 查询表中所有字段 f12格式化代码
SELECT * FROM departments;
SELECT `department_name` FROM departments;

# 4 查询常量值
SELECT 100 AS 结果;
SELECT 'abc';

# 5 查询表达式
SELECT 100%98

# 6 查询函数
SELECT VERSION();

# 7 为字段起别名
# 方式一 as
SELECT last_name AS 性, first_name AS 名 FROM employees;

# 方式二 空格代替as
SELECT last_name 性, first_name 名 FROM employees;

# 案例： 有空格的别名要加""或者''
SELECT salary AS "out put" FROM employees;

# 8 去重复 distinct
SELECT DISTINCT department_id FROM employees;

# 9 +的作用(mysql的+只有运算作用)
/*
select 100+90
select '90'+100 字符转为数字
select 'john'+90 字符无法转，直接为0
select null + 10 只要有一个为null，结果为null
*/
SELECT NULL + 100;

# 性和名合并显示？
# select last_name+first_name as 姓名
# from employees;

SELECT CONCAT(last_name, first_name) AS 姓名
FROM employees;


# 进阶2 条件查询
/*
select 
	查询列表
from
	表名
where 
	筛选条件

一、按条件表达式筛选
	条件运算符：> < = != <> >= <=
	
二、按逻辑表达式筛选
	逻辑运算符
	&& || !
	and or not
三、模糊查询
	like
	between and
	in
	is null  || is not null
*/

# 一 按照条件表达式筛选
# case 1 查询工资>12000的员工信息
SELECT * FROM employees WHERE salary > 12000;

# case 2 查询部门编号不等于90号的员工名和部门编号
SELECT last_name, department_id
FROM employees
WHERE department_id <> 90;

# 二 按照逻辑表达式筛选
# case 1 查询工资在10000到20000之间员工的名字、工资以及奖金
SELECT 
	last_name, salary, commission_pct
FROM employees
WHERE salary >= 10000 AND salary <= 20000;

# case 2 查询部门编号不在90到110之间，或者工资高于15000的员工信息
SELECT 
	*
FROM employees
WHERE NOT(department_id >= 90 AND department_id <= 110) OR salary > 15000;

# 三 模糊查询
/*
like： 一般和通配符搭配使用
% 代表任意多个字符（包含0个字符）
_ 代表任意单个字符
between and
in
is null || is not null
*/

# case 1 like   查询员工名字中包含字符a的员工信息
SELECT 
	*
FROM 
	employees
WHERE 
	last_name LIKE '%a%';

# case 2 查询员工名字中第三个字符为e,第五个字符为a的员工名和工资
SELECT 
	last_name,
	salary
FROM 
	employees
WHERE 
	last_name LIKE '__n_l%';

# case 3 查询员工名字中第三个字符为_的员工名 （需要转义方式）
SELECT 
	last_name
FROM
	employees
WHERE
	last_name LIKE '__\_%';
# 	last_name LIKE '__$_%' escape '$';

# case 4 between and
# 查询员工编号在100到200之间的员工信息
SELECT 
	*
FROM 
	employees
# where employee_id >= 100 and employee_id <= 200;
WHERE employee_id BETWEEN 100 AND 200;