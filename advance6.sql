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
*/
USE girls;
SELECT * FROM beauty;
SELECT * FROM boys;

SELECT `name`, boyName FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;;