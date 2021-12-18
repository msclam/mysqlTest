# 进阶7 子查询
/*
出现在其他语句的select语句称为子查询和内查询
外部的查询叫主查询或外查询
分类：
按子查询出现的位置：
	select后
		仅仅支持标量子查询
	from后
		支持表子查询
	where或having后
		标量子查询（单行）
		列子查询（多行）
		行子查询
	exists后
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一行一列
	列子查询（一列多行）
	行子查询（一行多列）
	表子查询（一般为多行多列）
*/
# 一 where和having后面
/*
1 标量子查询（单行）
2 列子查询（一列多行）
3 行子查询（一行多列）

特点：
①子查询放小括号
②子查询放条件右侧
③标量子查询一般搭配单行操作符使用 > < >= <= 
列子查询 一般搭配多行操作符使用 in any/some all
④子查询执行先于主查询
*/

# 1 标量子查询
# case 1 查询谁的工资比Abel高
SELECT salary 
FROM employees
WHERE last_name = 'Abel';

SELECT * 
FROM employees 
WHERE salary > (
	SELECT salary 
	FROM employees
	WHERE last_name = 'Abel'
);

# case 2 返回job_id与141号员工相同，salary比143号员工多的员工 姓名、job_id和工资
SELECT job_id
FROM employees
WHERE employee_id = 141;

SELECT salary
FROM employees
WHERE employee_id = 143 ;

# 查询员工姓名、job_id和salary，且job_id在①，salary在②
SELECT last_name, job_id, salary 
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141
)AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 143
);

# case 3 返回员工工资最少的员工的last_name, job_id和salary
SELECT MIN(salary)
FROM employees;

SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

# case 4 查询最低工资大于50号部门最低工资的部门id和最低工资
SELECT MIN(salary) 
FROM employees
WHERE department_id = 50;

# 查询每个部门的最低工资
SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id;


SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary) 
	FROM employees
	WHERE department_id = 50
);

# 非法使用标量子查询
SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT salary 
	FROM employees
	WHERE department_id = 50
);

# 2 列子查询（多行子查询）
# case 1 返回location_id是1400或1700的部门中的所有员工姓名
# ① 查询department_id为1400或1700的部门编号
SELECT DISTINCT department_id
FROM departments
WHERE location_id IN (1400, 1700);

# ②查询员工姓名，要求部门号是①列表中的某一个
SELECT last_name
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400, 1700)
);

# case 2 返回其他部门中比job_id为'IT_PROG'部门任意工资低的员工的员工号、姓名、job_id以及salary
# ① 查询job_id为'IT_PROG'部门工资
SELECT DISTINCT salary
FROM employees 
WHERE job_id='IT_PROG';

# ②查询员工号、姓名、job_id以及salary， salary < ①的任意一个
SELECT last_name, employee_id, job_id, salary
FROM employees
WHERE salary < ANY (
	SELECT DISTINCT salary
	FROM employees 
	WHERE job_id='IT_PROG'
) AND job_id != 'IT_PROG';

SELECT last_name, employee_id, job_id, salary
FROM employees
WHERE salary < (
	SELECT MAX(salary)
	FROM employees 
	WHERE job_id='IT_PROG'
) AND job_id != 'IT_PROG';

# case 3 返回其他部门中比job_id为'IT_PROG'部门所有工资低的员工的员工号、姓名、job_id以及salary
SELECT last_name, employee_id, job_id, salary
FROM employees
WHERE salary < ALL (
	SELECT DISTINCT salary
	FROM employees 
	WHERE job_id='IT_PROG'
) AND job_id != 'IT_PROG';

或者

SELECT last_name, employee_id, job_id, salary
FROM employees
WHERE salary < (
	SELECT MIN(salary)
	FROM employees 
	WHERE job_id='IT_PROG'
) AND job_id != 'IT_PROG';

# 3 行子查询（一行多列或多行多列）
# case 1 查询员工编号最小并且工资最高的员工信息
SELECT MIN(employee_id)
FROM employees;

SELECT MAX(salary) 
FROM employees;


SELECT *
FROM employees
WHERE employee_id = (
	SELECT MIN(employee_id)
	FROM employees
) AND salary = (
	SELECT MAX(salary) 
	FROM employees
);

# 行子查询
SELECT *
FROM employees
WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary) 
	FROM employees
);


# 二 select 后面
# case 1 查询每个部门的员工个数
SELECT d.*, (
	SELECT COUNT(*)
	FROM employees e
	WHERE e.department_id =d.department_id
	) 个数
FROM departments d;

# case 2 查询员工号=102的部门名
SELECT (
	SELECT department_name
	FROM departments d
	INNER JOIN employees e
	ON d.department_id=e.department_id
	WHERE e.employee_id = 102
) 部门名;


# 三 from后面 (查询的结果当作一个表，起别名)
# case 1 查询每个部门的平均工资的工资等级
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;

SELECT ag_dep.*, g.`grade_level`
FROM (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) AS ag_dep
INNER JOIN job_grades AS g
ON ag_dep.ag BETWEEN lowest_sal AND highest_sal;’

# exists（判断查询结果是否存在）
/*
exists(完整查询语句) 相关子查询
结果1或0
*/
SELECT EXISTS(SELECT employee_id FROM employees);
SELECT EXISTS(SELECT employee_id FROM employees WHERE salary = 30000);

# case 1 查询有员工名的部门名
SELECT department_name, COUNT(*) 个数
FROM departments d
WHERE EXISTS (
	SELECT *
	FROM employees e
	WHERE d.department_id = e.`department_id`
)
GROUP BY department_name;


SELECT DISTINCT department_name, COUNT(*) 个数
FROM departments d
WHERE manager_id IS NOT NULL
GROUP BY department_name;

SELECT department_name
FROM departments d
WHERE d.`department_id` IN (
	SELECT department_id
	FROM employees
);

# 查询有女朋友的男生信息
USE girls;
SELECT bo.*
FROM boys bo
WHERE bo.id IN (
	SELECT boyfriend_id
	FROM beauty
);

# 查询男朋友名字在男生表中的女名字
USE girls;
SELECT b.name, bo.*
FROM beauty b
INNER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`;

USE girls;
SELECT b.name, bo.*
FROM beauty b
LEFT JOIN boys bo
ON b.`boyfriend_id`=bo.`id`
WHERE bo.`id` IS NOT NULL;