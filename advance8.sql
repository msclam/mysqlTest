# 进阶8 分页查询
/*                执行顺序
select 查询列表      7
from 表              1
【join type】 表2    2
on 连接条件          3
where 筛选条件       4
group by 分组字段    5
having 分组后的筛选  6
order by 排序字段    8
limit offset, size;  9

offset: 要显示条目的起始索引（索引0开始）
size: 显示的条目个数

特点：
① limit语句是放在查询的最后

②  要显示的页数 page, 每页的条目数目size
   select 查询列表
   from 表
   limit (page - 1) * size, size
   
   size=10
   page   size
   1      0
   2      10
   3      20
*/

# case 1 查询前五条员工信息
SELECT * FROM employees 
LIMIT 0, 5;

SELECT * FROM employees 
LIMIT 5;

# case 2 查询11~15条员工信息
SELECT *
FROM employees 
LIMIT 10, 15;


# case 3 有奖金的员工信息，并工资较高的前10名显示出来
SELECT 
  * 
FROM
  employees 
WHERE commission_pct IS NOT NULL 
ORDER BY salary DESC 
LIMIT 10 ;

