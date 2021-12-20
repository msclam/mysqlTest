# 一 练习
USE myemployees;
# 1 显示表中全部列，各列使用逗号连接，列头为out put
SELECT IFNULL(commission_pct, 0) AS 奖金率,
	commission_pct
FROM employees;

SELECT CONCAT(`first_name`,',',`last_name`,',',IFNULL(commission_pct, 0)) AS "out put"
FROM employees;

# 2 查询员工号为176的员工的姓名和部门号和年薪
SELECT
	last_name,
	department_id,
	salary * 12 * (1 + IFNULL(commission_pct, 0)) AS 年薪
FROM employees;

# 3 查询没有奖金，且工资小于18000的salary，last_name
SELECT 
	salary, last_name
FROM 
	employees
WHERE commission_pct IS NULL AND salary < 180000;


# 4 查询job_id不为"IT"或者工资为12000的员工信息
SELECT * FROM employees WHERE job_id <> "IT" OR salary = 12000;

# 经典面试题
SELECT * FROM employees;
# 上面和下 相同
SELECT * FROM employees WHERE commission_pct LIKE '%%' OR last_name LIKE '%%';
# 上面和下 不同
SELECT * FROM employees WHERE commission_pct LIKE '%%' AND last_name LIKE '%%';


# 二 练习
# 1 查询员工的姓名和部门号和年薪，按年薪降序，按姓名升序
SELECT last_name, department_id, salary * 12 * (1 + IFNULL(commission_pct, 0)) AS 年薪
FROM employees
ORDER BY 年薪 DESC, last_name ASC;

# 2 选择工资不在8000到17000的员工的姓名和工资，按工资降序
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC;

# 3 查询邮箱中包含e的员工信息，并先按邮箱的字节数降序，再按部门号升序’
SELECT *, LENGTH(email) AS 字节长度
FROM employees
WHERE email LIKE '%e%'
ORDER BY LENGTH(email) DESC, department_id ASC;

# 三 练习
# 1 显示系统时间 日期+时间
SELECT NOW();

# 2 查询员工号，姓名，工资，以及工资提高百分之20%后的结果(new salary)
SELECT employee_id, last_name, salary, salary*1.2 AS "new salary" FROM employees;

# 3 将员工的姓名按首字母排序，并写出姓名的长度(length)
SELECT 
	LENGTH(last_name) AS 字节长度, 
	last_name,
	SUBSTR(last_name, 1, 1) AS 首字母
FROM 
	employees
ORDER BY 首字母 ASC;

# 4 做一个查询，产生下面的结果
# <last_name> earns <salary> monthly but wants <salary*3> Dream Salary
SELECT CONCAT(last_name, ' earns ', salary, ' monthly but wants ', salary*3) AS "Dream Salary"
FROM employees 
LIMIT 6; # 只显示前6条


# 5 使用case when 按照下面的条件
/*
job       grade
AD_PRES   A
ST_MAN	  B
IT_PROG   C
*/
SELECT job_id AS job, 
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_PRE' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
END AS grade
FROM employees;

# 四 练习 分组函数
# case 1  查询公司员工工资最大值、最小值、平均值、总和
SELECT 
	ROUND(MAX(salary), 2) AS mx_sal,
	MIN(salary) AS min_sal,
	AVG(salary) AS ag_sal,
	SUM(salary) AS sm_al
FROM 
	employees;
	 
# case 2 查询员工表中的最大入职时间和最小入职时间的相差天数
SELECT DATEDIFF(NOW(), birthday);
SELECT DATEDIFF(MAX(hiredate), MIN(hiredate)) AS DIFFERENCE
FROM employees;

# 查询部门编号为90的员工个数
SELECT COUNT(*)
FROM employees
WHERE department_id = 90;

# 五 练习
# case 1 查询各job_id的员工工资的最大值，最小值，平均值，总和，并按job_id升序
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary), job_id
FROM employees
GROUP BY job_id
ORDER BY job_id;

# case 2 查询员工最高工资和最低工资的差距（difference）
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;

# case 3 查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工计算在内
SELECT 
	MIN(salary), manager_id
FROM 
	employees
GROUP BY manager_id
HAVING MIN(salary) >= 6000;
	

# case 4 查询所有部门的编号，员工数量和工资平均值，并按平均工资降序
SELECT 
	department_id, COUNT(*), AVG(salary)
FROM 
	employees
GROUP BY department_id
ORDER BY AVG(salary) DESC;

# case 5 选择具有各个job_id的员工人数
SELECT 
  COUNT(*),
  job_id 
FROM
  employees 
GROUP BY job_id;


# 六 练习
# case 1 查询员工表的最大工资，工资平均值
SELECT MAX(salary), AVG(salary) 
FROM employees;

# case 2 查询员工表的employee_id, job_id, last_name，按department_id降序，salary升序
SELECT
	employee_id, job_id, last_name
FROM 	
	employees
ORDER BY
	department_id DESC, salary ASC;

# case 3 查询员工表的job_id中包含a和e的，并且a在e的前面
SELECT
	job_id
FROM 
	employees
WHERE job_id LIKE '%a%e%';

# case 5 显示当前日期，以及去前后空格，截取字字符串的函数
SELECT NOW();
SELECT TRIM(' a a ');
SELECT TRIM('b' FROM 'bababab');
SELECT SUBSTR(str, idx);
SELECT SUBSTR(str, idx, len);


# case 6 显示所有员工姓名，部门号，部门名称
SELECT last_name, e.department_id, department_name
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`;

# case 7 查询90号部门员工的job_id和90号部门的location_id
SELECT job_id, location_id
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
AND e.`department_id` = 90;

# case 8 选择所有有奖金的员工的 last_name department_name location_id city
SELECT last_name, department_name, l.location_id, city
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id`=l.`location_id`
AND e.`commission_pct` IS NOT NULL;

# case 9 选择city在Toronto工作的员工last_name job_id department_id department_name
SELECT last_name, job_id, d.department_id, department_name
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND city='Toronto';

# case 10 查询每个工种、每个部门的部门名、工种名和最低工资
SELECT job_title, department_name, MIN(salary) 最低工资
FROM employees e, departments d, jobs j
WHERE e.`department_id` = d.`department_id`
AND e.`job_id` = j.job_id
GROUP BY department_name, job_title;

# case 11 查询每个国家下的部门个数大于2的国家编号
SELECT country_id, COUNT(*) 部门个数
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
GROUP BY country_id
HAVING COUNT(*) > 2;

# case 12 查询指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果如下
/*
employees  Emp#   manager Mgr# 
kochhar    101    king    100
*/
SELECT e.last_name employees, e.employee_id "Emp#", m.last_name manager, m.employee_id "Mgr#"
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.last_name = 'kochhar'; 


# 七 练习
# case 1 查询编号>3号女生的男朋友信息，如果有则列出详细，如果没有，用null填充
SELECT b.id, b.name, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`
WHERE b.id > 3;	

# case 2 查询哪个城市没有部门
USE myemployees;
SELECT city, d.*
FROM departments d
RIGHT OUTER JOIN locations l
ON d.`location_id`=l.`location_id`
WHERE d.`department_id` IS NULL;

# case 3 查询部门名为SAL或IT的员工信息
USE myemployees;
SELECT e.*, d.department_name
FROM departments d
LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name` IN ('SAL', 'IT');


# 八 练习 子查询
# case 1 查询和员工Zlotkey相同部门的员工姓名和工资
SELECT department_id
FROM employees
WHERE last_name = 'Zlotkey';

SELECT last_name, salary
FROM employees
WHERE department_id IN (
	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey'
);

# case 2 查询工资比公司平均工资高的员工的员工号，姓名和工资
SELECT AVG(salary)
FROM employees;

SELECT last_name, employee_id, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

# case 3 查询各部门中工资比本部门平均工资高的员工的员工号，姓名和工资
# 查询各部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;

# 连接子查询和大表employees
SELECT employee_id, last_name, salary, e.`department_id`
FROM employees e
INNER JOIN (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) ag_dep
ON e.`department_id` = ag_dep.department_id
WHERE salary > ag_dep.ag;

# case 4 查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
# 查询姓名中包含字母u的员工所在部门
SELECT DISTINCT department_id
FROM employees
WHERE last_name LIKE '%u%';

# 查询部门号=上条件的任意一个的员工号和姓名
SELECT last_name, employee_id
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM employees
	WHERE last_name LIKE '%u%'
);

# case 5 查询所在部门的location_id为1700的部门工作的员工的员工号
SELECT DISTINCT department_id
FROM departments
WHERE location_id=1700;

# 使用in
SELECT employee_id
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id=1700
);

# 使用any
SELECT employee_id
FROM employees
WHERE department_id = ANY (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id=1700
);

# case 6 查询管理者为King的员工姓名和工资
# 查询姓名为King的员工编号
SELECT employee_id
FROM employees
WHERE last_name = 'K_ing';

SELECT last_name, salary
FROM employees
WHERE manager_id IN (
	SELECT employee_id
	FROM employees
	WHERE last_name = 'K_ing'
);

# case 7 查询工资最高的员工的姓名，要求first_name和last_name显示为一列，列名是姓名
SELECT MAX(salary) 
FROM employees;

SELECT CONCAT(first_name, last_name) AS "姓.名"
FROM employees
WHERE salary = (
	SELECT MAX(salary) 
	FROM employees
);

# 九 练习 
/*
已知表 stuinfo
id 学号
name 性名
email 邮箱 john@126.com
gradeId 年级编号
sex 性别 男 女
age 年纪

已知表 grade
id 年级编号
gradeName 年级名称
*/

# case 1 查询所有学院的邮箱的用户名（注意邮箱有@）
SELECT SUBSTR(email, 1, INSTR(email, '@') - 1) 用户名
FROM stuinfo;

# case 2 查询男生和女生的个数
SELECT COUNT(*), sex
FROM stuinfo
GROUP BY sex;

# case 3 查询年龄>18岁的所有学生的姓名和年级名称
SELECT `name`, gradeName
FROM stuinfo s
INNER JOIN grade g
ON s.gradeId = g.id
WHERE age > 18;

# case 4 查询哪个年级的学生的最小年龄>20岁
# 插叙每个年级最小年龄
SELECT MIN(age), gardeId
FROM stuinfo
GROUP BY gradeId;

SELECT MIN(age), gardeId
FROM stuinfo
GROUP BY gradeId
HAVING MIN(age) > 20;

# case 5 说出查询语句中设计到的所有的关键字，以及执行的先后顺序
/*
SELECT 查询列表     7
FROM 表             1
连接类型 JOIN 表2   2
ON 连接条件         3
WHERE 筛选条件      4
GROUP BY 分组列表   5
HAVING 分组后的筛选 6
ORDER BY 排序列表   8
LIMIT 偏移, 条目数; 9
*/