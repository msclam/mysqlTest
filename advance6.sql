# 进阶6 连接查询
/*
多表查询，连接查询
笛卡尔乘积现象: 表1有m行，表2有n行，结果m*n行（没有有效的连接条件）

分类：
	内连接
		等值连接
		非等值连接
		自连接
	外连接
		左外连接
		右外连接
		全外连接
	交叉连接

1、多表等值连接的结果为多表的交集部分
2、n表连接，至少需要n-1个连接条件
3、多表的顺序无要求
4、一般需要为表起别名
5、可以和筛选where、分组group by、排序order by组合使用
*/
USE girls;
SELECT * FROM beauty;
SELECT * FROM boys;


# 一 等值连接（两个表的交集部分）
# 查询女名字和对应的男名字
SELECT `name`, boyName FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id; # 有效连接条件

USE myemployees;
# 查询员工名和对于的部门名
SELECT last_name, department_name
FROM departments, employees
WHERE departments.`department_id` = employees.`department_id`;

# 2 为表起别名（之前是字段起别名）提高表的简洁度
# 表起了别名，查询字段中必须使用别名的表
# 查询员工名、工种号、工种名
SELECT last_name, e.job_id, job_title
FROM employees AS e, jobs
WHERE e.`job_id` = jobs.`job_id`;

# 3 两个表的顺序是否可以调换（可以）
SELECT last_name, e.job_id, job_title
FROM employees AS e, jobs AS j 
WHERE e.`job_id` = j.`job_id`;

# 4 加筛选
# case 1 查询有奖金的员工名和部门名
SELECT 
	last_name, department_name, commission_pct
FROM 
	employees e,departments d
WHERE 
	e.`department_id` = d.`department_id`
AND e.`commission_pct` IS NOT NULL;


# case 2 查询城市名字中第二个字符为o的部门名和城市名
SELECT
	department_name, city
FROM 
	departments d, locations l

WHERE d.`location_id` = l.`location_id`
AND city LIKE '_o%';

# 5 加分组
# case 查询每个城市的部门个数
SELECT 
	COUNT(*) AS 个数, city
FROM 
	departments d, locations l
WHERE
	d.`location_id` = l.`location_id`
GROUP BY city;

# 查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT 
	department_name, d.manager_id, MIN(salary)
FROM 
	departments d, employees e
WHERE 
	d.`department_id` = e.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name, d.`manager_id`;

# 6 加排序
# 查询每个工种名和员工个数，并且按员工个数降序
SELECT 
	job_title, COUNT(*)
FROM 	
	employees e, jobs j 
WHERE 
	e.`job_id` = j.`job_id`
GROUP BY 
	job_title
ORDER BY 
	COUNT(*) DESC;

# 7 实现三表连接
# 查询员工名、部门名和所在城市
SELECT
	last_name, department_name, city
FROM 	
	employees e, departments d, locations l
WHERE 
	e.`department_id` = d.`department_id`
AND 
	d.`location_id` = l.`location_id`
AND
	city LIKE '%s%'
ORDER BY department_name DESC;
	

# 二 非等值连接
CREATE TABLE job_grades
(grade_level VARCHAR(3),
 lowest_sal  INT,
 highest_sal INT);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);

# case 1 查询员工工资和工资级别
SELECT * FROM job_grades;

SELECT 
	salary, grade_level
FROM 
	employees e, job_grades g
WHERE 
	salary >= g.`lowest_sal` AND salary <= g.`highest_sal`;
#	salary between g.`lowest_sal` and g.`highest_sal`;
# and g.`grade_level`='A';


# 三 自连接（自己等值连接）
# 查询员工和员工的上级的名字

SELECT 
	e.last_name, e.employee_id, m.last_name, m.employee_id
FROM 
	employees e, employees m
WHERE 
	e.`employee_id` = m.`employee_id`;



# sql 99语法
/*
select 查询列表
from 表1 别名【连接类型】
join 表2 别名
on 连接条件
【where 筛选条件】
【group by 分组】
【having 筛选条件】
【order by 排序列表】

分类
内连接：inner
外连接:
	左外:left[outer]
	右外:right[outer]
	全外:full[outer]
交叉连接: cross
*/


 #一、 内连接
 /*
select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件

分类：等值 、非等值 、 自连接
特点:
① 添加排序、分组、筛选
② inner可以省略
③ 筛选条件放在where后面，连接条件放在on后面
④ inner join和92语法的等值连接效果一样，都是查询多表的交集
 */
 # 一） 等值
 # case 1 查询员工名、部门名
 SELECT last_name, department_name
 FROM employees e
 INNER JOIN departments d
 ON e.`department_id`=d.`department_id`
 
 # case 2 查询名字中包含e的员工名和工种名
SELECT last_name, job_title
FROM employees e
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`
WHERE e.`last_name` LIKE '%e%';

# case 3 查询部门个数>3的城市名和部门个数（添加分组+筛选）
SELECT city, COUNT(*)
FROM departments d
INNER JOIN locations l
ON d.`location_id`=l.`location_id`
GROUP BY city
HAVING COUNT(*) > 3;


# case 4 查询哪个部门的员工个数>3的部门名和员工数，并按个数降序（添加排序）
SELECT  COUNT(*), department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
GROUP BY department_name
HAVING COUNT(*) > 3
ORDER BY COUNT(*) DESC;

# case 5 查询员工名、部门名、工种名，并按部门名降序(三表连接)
SELECT last_name,department_name, job_title
FROM employees e
INNER JOIN departments d ON e.`department_id`=d.`department_id`
INNER JOIN jobs j ON e.`job_id`=j.`job_id`
ORDER BY department_name DESC;


# 二）非等值连接
# 查询员工的工资级别
SELECT salary, grade_level
FROM employees e
INNER JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`;


# 查询每个工资级别的个数>2的个数并且按工资级别降序
SELECT COUNT(*), grade_level
FROM employees e
INNER JOIN job_grades g
ON e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY grade_level
HAVING COUNT(*) > 2
ORDER BY grade_level DESC;


# 三） 自连接
# 查询员工的名字、上级的名字
SELECT e.last_name, m.last_name
FROM employees e
INNER JOIN employees m
ON e.`manager_id`=m.`employee_id`;

# 查询姓名中含有k的员工的名字、上级的名字
SELECT e.last_name, m.last_name
FROM employees e
INNER JOIN employees m
ON e.`manager_id`=m.`employee_id`
WHERE e.`last_name` LIKE '%k%';



# 二、外连接
/*
用于一个表中有，另一个表没有的记录

1、外连接的查询结果为主表的所有记录
	如果从表有和它匹配的，则先显示匹配的值
	如果从表没有匹配的，则显示null
	外连接 = 内连接结果 + 主表有而从表没有的记录
2、左外连接：left join 左边是主表
   右外连接：right join 右边是主表
3、左外和右外交换两表顺序，可以实现同样的效果 
4、全外连接 = 内连接 + 表1有表2没有+表2有但表1没有
*/
# case 1 查询男朋友名字不在男生表中的女名字
USE girls;
SELECT b.name, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`;

USE girls;
SELECT b.name
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`=bo.`id`
WHERE bo.`id` IS NULL;


# case 2 查询哪个部门没有员工
# 左外
SELECT d.*, e.employee_id
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;

# 右外
SELECT d.*, e.employee_id
FROM employees e
LEFT OUTER JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;

# 全外
USE girls;
SELECT b.*, bo.*
FROM beauty b
FULL OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.id;


# 交叉连接(笛卡尔乘积)
USE girls;
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;




