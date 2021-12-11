# 练习1
# 显示表中全部列，各列使用逗号连接，列头为out put
SELECT IFNULL(commission_pct, 0) AS 奖金率,
	commission_pct
FROM employees;

SELECT CONCAT(`first_name`,',',`last_name`,',',IFNULL(commission_pct, 0)) AS "out put"
FROM employees;