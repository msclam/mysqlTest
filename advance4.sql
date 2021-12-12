# 进阶4 常见函数
/*
select 函数名(实参列表) from 表
分类：
    1 单行函数: concat、length、ifnull
    2 分组函数：
	做统计使用，又称统计函数、聚合函数、组函数
	多个输入，输出一个
*/
# 一 字符函数
# 1、length 获取参数值的字节数
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
