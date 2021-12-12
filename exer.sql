# 练习1
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


# 练习2 
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