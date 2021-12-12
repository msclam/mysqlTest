# 练习1
# 显示表中全部列，各列使用逗号连接，列头为out put
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

# 查询没有奖金，且工资小于18000的salary，last_name
SELECT 
	salary, last_name
FROM 
	employees
WHERE commission_pct IS NULL AND salary < 180000;


# 查询job_id不为"IT"或者工资为12000的员工信息
SELECT * FROM employees WHERE job_id <> "IT" OR salary = 12000;

# 经典面试题
SELECT * FROM employees;
# 上面和下 相同
SELECT * FROM employees WHERE commission_pct LIKE '%%' OR last_name LIKE '%%';
# 上面和下 不同
SELECT * FROM employees WHERE commission_pct LIKE '%%' AND last_name LIKE '%%';