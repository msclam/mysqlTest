# 进阶9 联合查询
/*
union 将多条查询语句的结果合并成一个结果
查询的结果来自多个表且多个表没有直接关系
但是查询的信息一致

特点：
1 要求多条查询语句的查询列数一致
2 要求多条查询语句的查询的每一列的类型和顺序最好一致
3 union默认结果是去重，但是可以加union all不去重
*/
# case 查询部门编号>90或邮箱包含a的员工信息
SELECT *
FROM employees
WHERE email LIKE '%a%'
UNION 
SELECT *
FROM employees
WHERE department_id > 90;


SELECT *
FROM employees
WHERE email LIKE '%a%'
OR department_id > 90;

# 查询中国用户中性别为男性的信息以及外国用户中男性的用户信息
SELECT id, cname, csex
FROM t_ca 
WHERE c_sex = '男'
UNION 
SELECT t_id, tName, tGender
FROM t_ua 
WHERE tGender = 'male';
