# 常见约束
/*
分类:六大约束
NOT NULL： 非空 姓名，学号
default:默认
primary key 主键，唯一性且非空
unique: 唯一，但是可以为空
check: 检查约束【mysql中不支持】
foreign key: 外键，用于限制两个表的关系【保证该字段的值必须来自主表的关联列的值】
从表添加外键的约束，用于引用主表中某列的值

添加约束的时间：
	1 创建表
	2 修改表
约束分类：
	列级约束：
		外键约束没有效果
	表级约束：
		除了非空和默认，其他都支持
		
主键和唯一的大对比：

		保证唯一性  是否允许为空    一个表中可以有多少个   是否允许组合
	主键	√		×		至多有1个           √，但不推荐
	唯一	√		√(不许多个null)	可以有多个          √，但不推荐
外键：
	1、要求在从表设置外键关系
	2、从表的外键列的类型和主表的关联列的类型要求一致或兼容，名称无要求
	3、主表的关联列必须是一个key（一般是主键或唯一）
	4、插入数据时，先插入主表，再插入从表
	   删除数据时，先删除从表，再删除主表		

*/
CREATE TABLE 表名(
	字段名 字段类型 列级约束,
	字段名 字段类型,
	表级约束
);

# 一 创建表时添加约束
# 1 添加列级约束
/*
只支持主键,默认，非空，唯一
*/
CREATE DATABASE students;

USE students;

CREATE TABLE stuinfo(
	id INT PRIMARY KEY, # 主键
	stuName VARCHAR(20) NOT NULL, # 非空
	gender CHAR(1) CHECK(gender='男' OR gender='女'),  # 检查
	seat INT UNIQUE, # 唯一
	age INT DEFAULT 18, # 默认约束
	majorId INT REFERENCES major(id) # 外键
);

CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);

DESC stuinfo;

SHOW INDEX FROM stuinfo;

# 2 添加表级约束
/*
constraint 约束名 约束类型(字段)
*/
DROP TABLE IF EXISTS stuinfo;

CREATE TABLE stuinfo(
	id INT, # 主键
	stuName VARCHAR(20), # 非空
	gender CHAR(1),  # 检查
	seat INT, # 唯一
	age INT, # 默认约束
	majorId INT, # 外键
	
	CONSTRAINT pk PRIMARY KEY(id),
	CONSTRAINT uq UNIQUE(seat),
	CONSTRAINT ck CHECK(gender='男' OR gender='女'),
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorId) REFERENCES major(id)
);

SHOW INDEX FROM stuinfo;
/*
通用写法:
create table if exists stuinfo (
	id int primary key,
	stuname varchar(20) not null,
	age int default 18,
	seat int unique,
	majorid int,
	constraint fk foreign key(majorid) references major(id)
);
*/

# 二 修改表时添加约束
/*
列级约束:
alter table 表名 modify column 字段名 类型 新约束

表级约束:
alter table 表名 【constraint 约束名】 add 约束(字段名)
*/
# 1 添加非空约束
DROP TABLE IF EXISTS stuinfo;

CREATE TABLE stuinfo(
	id INT, # 主键
	stuName VARCHAR(20), # 非空
	gender CHAR(1),  # 检查
	seat INT, # 唯一
	age INT, # 默认约束
	majorId INT # 外键
);

DESC stuinfo;
ALTER TABLE stuinfo MODIFY COLUMN stuName VARCHAR(20) NOT NULL;

# 2 添加默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;

# 3 添加主键
# ① 列级约束
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY;

# ② 表级约束
ALTER TABLE stuinfo ADD PRIMARY KEY(id);

# 4 添加唯一
ALTER TABLE stuinfo ADD UNIQUE(seat);

# 5 添加外键
ALTER TABLE stuinfo ADD CONSTRAINT fk FOREIGN KEY(majorId) REFERENCES major(id);

# 三 修改表时删除约束
# 1 删除非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NULL;

# 2 删除默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT;

# 3 删除主键
ALTER TABLE stuinfo DROP PRIMARY KEY;

# 4 删除唯一
ALTER TABLE stuinfo DROP INDEX seat;

SHOW INDEX FROM stuinfo;

# 5 删除外键
ALTER TABLE stuinfo DROP FOREIGN KEY fk;


# 案例
#case 1.向表emp2的id列中添加PRIMARY KEY约束（my_emp_id_pk）
ALTER TABLE emp2 MODIFY COLUMN id INT PRIMARY KEY;
ALTER TABLE emp2 ADD CONSTRAINT my_emp_id_pk PRIMARY KEY(id);

#case 2.向表dept2的id列中添加PRIMARY KEY约束（my_dept_id_pk）


#case 3.向表emp2中添加列dept_id，并在其中定义FOREIGN KEY约束，与之相关联的列是dept2表中的id列。
ALTER TABLE emp2 ADD COLUMN dept_id INT;
ALTER TABLE emp2 ADD CONSTRAINT fk_emp2_dept2 FOREIGN KEY(dept_id) REFERENCES dept2(id);

		位置		支持的约束类型			是否可以起约束名
列级约束：	列的后面	语法都支持，但外键没有效果	不可以
表级约束：	所有列的下面	默认和非空不支持，其他支持	可以（主键没有效果）