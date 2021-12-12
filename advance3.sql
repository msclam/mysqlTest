# 进阶3 排序查询
USE myemployees;

/*
select 查询列表
from 表
where 筛选条件
order by 排序列表 [asc | desc]
	1、（不写默认是升序）
	2、orderby 后可以加字段、多个字段、表达式、函数、别名
	3、一般放子句最后，limit除外
*/
# case 1 查询员工信息，要求工资从高到低
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC;

# case 2 查询部门标号>= 90的员工信息，按入职时间的先后进行排序
SELECT *
FROM employees
WHERE department_id >= 90
ORDER BY hiredate ASC;

# case 3 按年薪的高低显示员工的信息和年薪【按表达式排序】
SELECT 
	*, salary * 12 * (1 + IFNULL(commission_pct, 0)) AS 年薪
FROM employees
ORDER BY salary * 12 * (1 + IFNULL(commission_pct, 0)) DESC;


# case 4 order by 后面可以加别名
SELECT 
	*, salary * 12 * (1 + IFNULL(commission_pct, 0)) AS 
FROM employees
ORDER BY 年薪 DESC;

# case 5 按照姓名的长度显示员工的姓名和工资【按函数排序】
SELECT LENGTH(last_name) AS 名字长度, last_name, salary
FROM employees
ORDER BY LENGTH(last_name) DESC;

# case 6 查询员工信息，要求先按工资排序，再按员工编号排序【按多个字段排序】
SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;