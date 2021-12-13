# 进阶5 分组查询

/*
select 分组函数, 列（要求出现在group by的后面）
from 表
【where 筛选条件】
group by 分组的列表
【order by 子句】

注意： 查询字段必须特殊，要求是分组函数和group by后出现的字段
1、分组查询的筛选条件分两类
	                  数据源          位置              关键字
	分组前筛选        原始表          group by前        where
	分组后筛选        分组后的结果集  group by后        having
	
	① 分组函数做条件一定放在having子句中
	② 能用分组前筛选的，优先使用
2、group by 子句支持单个字段、多个字段分组、表达式、函数
3、可以添加排序（排序放在分组查询最后）
*/

# case 1 查询每个部门的平均工资
SELECT AVG(salary), department_id FROM employees GROUP BY department_id;

# case 2 查询每个工种的最高工资
SELECT MAX(salary), job_id
FROM employees
GROUP BY job_id;

# case 3 查询每个位置的部门个数
SELECT COUNT(*), location_id
FROM departments
GROUP BY location_id;

# （一）分组前筛选
# case 4 添加筛选条件
# 查询邮箱中包含a字符的，每个部门的平均工资
SELECT AVG(salary), department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

# case 5 查询有奖金的每个领导手下员工的最高工资
SELECT
	MAX(salary), manager_id
FROM 
	employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

# case 6 添加复杂筛选条件
# 查询哪个部门的员工个数>2
# 步骤一 查询每个部门的员工个数

SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id;


# （二）分组后筛选
# 步骤二 根据1的结果进行筛选，查询哪个部门的员工个数>2

SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

# case 7 查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT MAX(salary), job_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary) > 12000;

# case 8 查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及其最低工资
SELECT 
	manager_id, MIN(salary)
FROM 
	employees
WHERE manager_id > 102
GROUP BY manager_id
HAVING MIN(salary) > 5000;

# （三） 按表达式或函数分组
# case 9 按员工姓名的长度分组，查询每一组得员工个数，筛选员工个数>5得有哪些
SELECT COUNT(*),LENGTH(last_name) AS len_name
FROM employees
GROUP BY LENGTH(last_name)
HAVING COUNT(*) > 5;

# （四）按多个字段分组
# case 10 查询每个部门的每个工种的员工的平均工资
SELECT AVG(salary), department_id, job_id
FROM employees
GROUP BY department_id, job_id;


# （五）添加排序
# case 10 查询每个部门的每个工种的员工的平均工资,并且按平均工资的高低显示
SELECT AVG(salary), department_id, job_id
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000
ORDER BY AVG(salary) DESC;



