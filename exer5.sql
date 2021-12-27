# case 1 创建book表
/*
bid int 主键
bname 字符型 唯一非空
price 浮点 默认值10
btypeId 类型编号 要求引用bookType的id字段
*/

CREATE TABLE Book (
	bid INT PRIMARY KEY,
	bname VARCHAR(20) NOT NULL UNIQUE,
	price FLOAT DEFAULT 10,
	btypeId INT,
	CONSTRAINT fk FOREIGN KEY(btypeId) REFERENCES bookType(id)
);

# case 2 开启事务，向表中插入1行数据，并结束
/*
set autocommit = 0;
insert into Book(bid, bname, price, btypeId)
values(1, 'a', 100, 1);
rollback;
(commit);
*/

# case 3 创建视图，实现查询价格大于100的书名和类型名
CREATE OR REPLACE VIEW myview1
AS 
SELECT bname, price
FROM Book
WHERE price > 100;

# case 4 修改视图，实现查询价格在90-120之间的书名和价格
CREATE OR REPLACE VIEW myview1
AS 
SELECT bname, price
FROM Book
WHERE price BETWEEN 90 AND 120;

# case 5 删除刚才的视图
DROP VIEW myview1;