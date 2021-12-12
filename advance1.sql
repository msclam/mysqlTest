/*
进阶1 基础查询
语法：
select 查询列表 from 表名

查询列表是： 表中字段、常量值、表达式、函数
类似 System.out.println()
*/
USE myemployees;

# 0 显示表结构
DESC departments;

# 1 查询表中单个字段
SELECT last_name FROM employees;

# 2 查询表中多个字段
SELECT department_name, department_id FROM departments;

# 3 查询表中所有字段 f12格式化代码
SELECT * FROM departments;
SELECT `department_name` FROM departments;

# 4 查询常量值
SELECT 100 AS 结果;
SELECT 'abc';

# 5 查询表达式
SELECT 100%98

# 6 查询函数
SELECT VERSION();

# 7 为字段起别名
# 方式一 as
SELECT last_name AS 性, first_name AS 名 FROM employees;

# 方式二 空格代替as
SELECT last_name 性, first_name 名 FROM employees;

# 案例： 有空格的别名要加""或者''
SELECT salary AS "out put" FROM employees;

# 8 去重复 distinct
SELECT DISTINCT department_id FROM employees;

# 9 +的作用(mysql的+只有运算作用)
/*
select 100+90
select '90'+100 字符转为数字
select 'john'+90 字符无法转，直接为0
select null + 10 只要有一个为null，结果为null
*/
SELECT NULL + 100;

# 性和名合并显示？
# select last_name+first_name as 姓名
# from employees;

SELECT CONCAT(last_name, first_name) AS 姓名
FROM employees;