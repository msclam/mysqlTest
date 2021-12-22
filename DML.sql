# DML语言
/*
数据操作语言
插入:insert
修改:update
删除:delete
*/

# 一、插入语句
/*
方式一（经典）
语法：
表名 列名 值
insert into 表名(列名, ...) values(值1, ...)

方式二
语法:
insert into 表名
set 列名=值, 列名=值, ...
*/

# 1 插入的值和类型与列的类型要一致
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES(14, '唐', '女', '1900-4-23', '10086', NULL, 2);

# 2 可以为null的列是如何插入值？
方式一
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES(14, '唐', '女', '1900-4-23', '10086', NULL, 2);

方式二
INSERT INTO beauty(id, NAME, sex, phone)
VALUES(15, '六', '女', '10010');

# 3 列的顺序是否可以调换
INSERT INTO beauty(NAME, sex, id, phone)
VALUES('蒋', '女', 16, '10010');

# 4 列数和值的个数必须一致

# 5 省略列名，默认所有列， 而且列的顺序和表的列顺序一致
INSERT INTO beauty
VALUES(17, '张', '女', NULL, '119', NULL, NULL);

# 6 方式二 插入数据
/*
insert into 表名
set 列名=值, 列名=值, ...
*/
INSERT INTO beauty
SET id = 18, NAME='刘', phone='123';

# 两种方式对比
/*
1 方式一支持多行插入，方式二不行
*/
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES(14, '唐', '女', '1900-4-23', '10086', NULL, 2),
(14, '唐', '女', '1900-4-23', '10086', NULL, 2),
(14, '唐', '女', '1900-4-23', '10086', NULL, 2);

# 2 方式一支持子查询，方式二不支持
INSERT INTO beauty(id, NAME, phone)
SELECT 19, '宋', '123';


# 二、修改语句
1、修改单表的记录
/*
update 表名
set 列名=值, 列名=值, ...
where 筛选条件
*/
UPDATE beauty
SET phone = '123456'
WHERE NAME='cx';

UPDATE boys
SET boyName='张飞', userCP=10
WHERE id=2;

2、修改多表的记录【补充】
/*
update 表1 别名
inner | left | right join 表2 别名
on 连接条件
set 列=值, ...
where 筛选条件;
*/
# case 1 修改张无忌的女朋友的手机号为114
UPDATE boys bo
INNER JOIN beauty b 
ON bo.id=b.boyfriend_id
SET b.phone=114
WHERE bo.boyName='张无忌';

# case 2 修改没有男朋友的女生的男朋友的编号为2
UPDATE boys bo
RIGHT JOIN beauty b 
ON bo.`id`=b.`boyfriend_id`
SET b.`boyfriend_id`=2
WHERE b.`id` IS NULL;


# 三 删除语句
/*
方式一
1 单表的删除
delete from 表名
where 筛选条件

2 多表的删除
truncate
语法: truncate table 表名;

delete 表1别名， 表2别名
from 表1 别名
inner | left | right join 表2 别名 
on 连接条件
where 筛选条件
*/

# 单表删除
DELETE FROM beauty
WHERE NAME LIKE 'cx';

# 多表删除
# case 1 删除张无忌的女朋友的信息
DELETE b
FROM beauty b 
INNER JOIN boys bo 
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName`='张无忌';

# case 2 删除黄晓明的信息以及他女朋友的信息
DELETE b, bo
FROM beauty b
INNER JOIN boys b 
ON b.`boyfriend_id`=bo.id
WHERE bo.boyName = '黄小明';

# 清空数据 不能加 where 【truncate】
TRUNCATE TABLE boys;
/*
1 delete可以加where truncate不能加

2 truncate删除的效率高一点

3 delete from 表名 和 truncate table 表名
对于自增长的表，再插入时，delete是从断点开始
但是truncate是从1开始

4 truncate删除没有返回值，但是delete删除有返回值

5 truncate删除不能回滚，delete删除可以回滚
*/


