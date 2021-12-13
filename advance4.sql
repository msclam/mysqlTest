# 进阶4 常见函数
/*
select 函数名(实参列表) from 表
分类：
    1 单行函数: concat、length、ifnull
    2 分组函数：
	做统计使用，又称统计函数、聚合函数、组函数
	多个输入，输出一个

常见函数
    一 单行函数
	字符函数
		length
		concat
		substr
		instr
		trim
		upper
		lower
		lpad
		rpad
		replace
	数学函数
		round
		ceil
		floor
		truncate
		mod
	日期函数
		now
		curdate
		curtime
		year
		month
		day
		hour
		minute
		second
		str_to_date
		date_format
	其他函数
		version
		database
		user
	控制函数
		if
		case
     二 分组函数
     	
*/
# 【单行函数】
# 一 字符函数
# 1、length 获取参数值的字节数

USE myemployees;

SELECT LENGTH('john');
SELECT LENGTH('中国人ababab'); # 汉字三个字节
SHOW VARIABLES LIKE '%char%';

# 2、concat 拼接字符串
SELECT CONCAT(last_name, '_', first_name) AS 'name' FROM employees;

# 3、upper 、lower
SELECT UPPER('abc');
SELECT LOWER('ABC');

# case 姓大写，名小写，然后拼接
SELECT CONCAT(UPPER(last_name), LOWER(first_name)) AS 姓名 FROM employees;

# 4 截取substr substring
# 索引从1开始 idx
# 索引从idx,len
SELECT SUBSTR('abcdef', 3) AS 'out put';

SELECT SUBSTR('abcdef', 3, 4) AS 'out put';

# case 姓名首字母大写，其他字母小写用_拼接
SELECT CONCAT(UPPER(SUBSTR(last_name, 1, 1)), '_', LOWER(SUBSTR(first_name, 2))) AS out_put
FROM employees;

# 5 instr 返回子串第一次出现的索引，如果找不到就是0
SELECT INSTR('abcdefabc', 'abc') AS output;
 
# 6 trim  去前后字符
SELECT LENGTH(TRIM('  acwing  ')) AS output;

SELECT TRIM('a' FROM 'aaahelloaaaworldaaa') AS output;

# 7 lpad  用指定字符左填充指定长度
SELECT LPAD('abc', 10, '*') AS output;

# 8 rpad 用指定字符填充指定长度
SELECT RPAD('abc', 10, '*') AS output;

# 9 replace(str, scrStr, destStr)
SELECT REPLACE('i love me me', 'me', 'you') AS output;


# 二 数学函数
# 1 四舍五入
SELECT ROUND(-1.55); # 先绝对值四舍五入再加符号
SELECT ROUND(1.567, 2); # 小数点后两位

# 2 ceil向上取整 >= 该参数的最小整数
SELECT CEIL(-1.02);

# 3 floor
SELECT FLOOR(-9.99);

# 4 truncate 截断
SELECT TRUNCATE(1.6900, 1);

# 5 mod 取余 被除数为正就是正，为负数就负数
# mod => a-a/b*b
SELECT MOD(-10, 3);
 
# 三 日记函数
# 1 now 返回当前系统日期+时间
SELECT NOW(); 

# 2 curdate 返回系统日期，不包含时间
SELECT CURDATE();

# 3 curtime 返回当前时间，不包含日期
SELECT CURTIME();

# 4 可以获取指定的部分年月日时分秒
SELECT YEAR(NOW()) 年;
SELECT YEAR('1998-1-1') 年;
SELECT YEAR(hiredate) AS 年 FROM employees;

SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月;

# 5 str_to_date 将字符转为日期
SELECT STR_TO_DATE('1998-3-2', '%Y-%m-%d') AS out_put;
SELECT STR_TO_DATE('4-3 1992', '%c-%d %Y') AS out_put;

# 查询入职日期为1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992', '%c-%d %Y');


# date_format 将日期转换为字符
SELECT DATE_FORMAT(NOW(), '%y年%m月%d日') AS out_put;

# 查询有奖金的员工名和入职日期(xx月/xx日 xx年)
SELECT last_name, DATE_FORMAT(hiredate, '%m月/%d日 %y年') AS 入职日期
FROM employees
WHERE commission_pct IS NOT NULL;

# 6 datediff 求日期差值
SELECT DATEDIFF('2018-03-01', '2018-02-01');

# 四、其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();


# 五 流程控制函数
# 1 if 函数
SELECT IF(10<5,'大','小');

SELECT last_name, commission_pct, IF(commission_pct IS NULL, '无奖金', '有奖金') AS 备注
FROM employees;

# 2 case 函数 (当表达式，显示值)适合处理等值判断
/*
case 判断的字段和表达式
when 常量1  then 要显示的值1或语句1;
when 常量2  then 要显示的值2或语句2;
else 要显示的值n或语句n;
end
*/

/*
查询员工工资，要求
部门号=30,显示工资为1.1倍
部门号=40,显示工资为1.2倍
部门号=50,显示工资为1.3倍
其他部门，显示原工资
*/
SELECT salary AS 原始工资, department_id, 
CASE department_id
WHEN 30 THEN salary * 1.1
WHEN 40 THEN salary * 1.2
WHEN 50 THEN salary * 1.3
ELSE salary
END AS 新工资
FROM employees;

# 3 case 函数 多重if（处理区间判断）
/*
case 
when 常量1  then 要显示的值1或语句1;
when 常量2  then 要显示的值2或语句2;
else 要显示的值n或语句n;
end
*/

/*
查询员工的工资情况
如果>20000,显示A级别
如果>15000,显示B级别
如果>10000,显示C级别
否则，显示D
*/
SELECT salary,
CASE
WHEN salary > 20000 THEN 'A'
WHEN salary > 15000 THEN 'B'
WHEN salary > 10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;


# 【分组函数】组函数，聚合函数，统计函数
/*
分类
sum求和 、avg 均值 、max最大值、 min最小值 、count 计算个数(not null)

特点
1 sum avg 一般处理数值型
  max min count 处理任何类型
  
2 是否忽略null值
  所有都忽略null值
  
3 和distinct结合使用

4 一般使用count(*)统计行数
*/ 
# 1 简单使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees;


SELECT 
	SUM(salary) AS 和, 
	ROUND(AVG(salary), 2) AS 平均, 
	MAX(salary) AS 最大值, 
	MIN(salary) AS 最小值, 
	COUNT(salary) AS 非空个数 
FROM 
	employees;
	
# 2 参数支持什么类型
SELECT SUM(last_name), AVG(last_name) FROM employees;
SELECT SUM(hiredate), AVG(hiredate) FROM employees;
SELECT MAX(last_name), MIN(last_name) FROM employees;
SELECT MAX(hiredate), MIN(hiredate) FROM employees;

# 4 和distinct结合使用
SELECT SUM(DISTINCT salary), SUM(salary) FROM employees;
SELECT COUNT(DISTINCT salary), COUNT(salary) FROM employees;

# 5 count 函数的详细介绍
SELECT COUNT(*) FROM employees;  # 统计总行数
SELECT COUNT(1) FROM employees; 

/*
MYISAM 存储引擎 count(*) 效率高
INNODB 存储引擎 count(*) 和 count(1) 效率差不多，比count(字段)要高一些
*/

# 6 和分组函数一同查询的字段有限制（一般是group by后的字段）
SELECT AVG(salary), last_name FROM employees;
