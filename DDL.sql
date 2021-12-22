# DDL
/*
数据定义语言
库和表的管理
一、库的管理
创建、修改、删除

二、表的管理
创建、修改、删除

创建：create
修改：alter
删除：drop
*/

# 一、库的管理
# 1 库的创建
/*
create database 库名;
*/

# 创建books
CREATE DATABASE 
IF NOT EXISTS books;

# 2 库的修改
RENAME DATABASE books TO new_name;

# 更改库的字符集
ALTER DATABASE books CHARACTER SET utf8;

# 3 库的删除
DROP DATABASE books IF EXISTS books;

# 二、表的管理
# 1 表的创建
/*
create table 表名 (
	列名 列的类型【长度】,
	...
);
*/
# 创建book表
CREATE TABLE book (
	id INT, # 编号
	bName VARCHAR(20), # 图书名
	authorId VARCHAR(20), # 作者编号
	publishDate DATETIME # 出版日期
);

DESC book;

# 创建author
CREATE TABLE author(
	id INT,
	au_name VARCHAR(20),
	nation VARCHAR(10)
);
DESC author;

# 2 表的修改
/*
语法：
alter table 表名 add | drop | modify | change column
*/

① 改列名
ALTER TABLE book CHANGE COLUMN publishDate pubDate DATETIME;

② 改列类型或约束
ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;

DESC book;

③ 添加列
ALTER TABLE book ADD COLUMN annual DOUBLE;

④ 删除列
ALTER TABLE book DROP COLUMN annual;

⑤ 修改表名
ALTER TABLE author RENAME TO book_author;


DESC book_author;

# 3 表的删除
DROP TABLE IF EXISTS book_author;
SHOW TABLES;

# 通用写法
DROP DATABASE IF EXISTS 旧库名;
CREATE DATABASE 新库名;

DROP TABLE IF EXISTS 旧表名;
CREATE TABLE 新表名;

# 4 表的复制
INSERT INTO author VALUES
(1, '村上', '日本'),
(2, '莫言', '中国'),
(3, '冯唐', '中国'),
(4, '金融', '中国') 

# 仅仅复制表的结构（没有复制数据）
CREATE TABLE copy LIKE book_author;

# 复制表的结构和数据
CREATE TABLE copy2
SELECT * FROM book_author;

# 只复制部分数据
CREATE TABLE copy3
SELECT id au_name 
FROM book_author
WHERE nation='中国';

# 只复制部分结构
CREATE TABLE copy4
SELECT id au_name 
FROM book_author
WHERE 0;
