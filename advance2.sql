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
USE myemployees;
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

# （一）like的使用
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

# （二）between and的使用
# case 4 between and
# 查询员工编号在100到200之间的员工信息
SELECT 
	*
FROM 
	employees
# where employee_id >= 100 and employee_id <= 200;
WHERE employee_id BETWEEN 100 AND 200;

# （三）in的使用
# case 5  in 判断某字段的值是否在in列表中的某一项(in 列表的值类型必须一致或者可转换转换('123' 123))
# 查询员工工种编号为IT_PROG、AD_Vp、AD_PRES中的员工名和工种编号
SELECT 
	last_name,
	job_id
FROM 
	employees
WHERE 
#	job_id = 'IT_PROG' or job_id = 'AD_Vp' or job_id = 'AD_PRES';
	job_id	IN ('IT_PROG', 'AD_Vp','AD_PRES'); 
	
# （四）is null 仅仅可以判断null值，但是<=>可以判断null值和普通的数值
# case 6 查询没有奖金的员工名和奖金率
SELECT 
	last_name,
	commission_pct
FROM 	
	employees
WHERE commission_pct IS NULL;

# case 7 查询有奖金的员工名和奖金率
SELECT 
	last_name,
	commission_pct
FROM 	
	employees
WHERE commission_pct IS NOT NULL;

# 安全等于 <=>
SELECT 
	last_name,
	commission_pct
FROM 	
	employees
WHERE commission_pct <=> NULL;

#-----------------------------
SELECT 
	last_name,
	salary
FROM 	
	employees
WHERE salary <=> 12000

