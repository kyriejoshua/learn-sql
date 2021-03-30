-- 第七章 集合运算 7-1 表的加减法

/*
 * 集合运算就是对满足同一规则的记录进行的加减等四则运算
 * 使用UNION（并集）、INTERSECT（交集）、EXCEPT（差集）等集合运算符来进行集合运算。
 * 集合运算可以去除重复行
 * 如果希望集合运算符保留重复行，就要使用ALL选项
 */

-- 集合运算
-- 对满足同一规则的记录进行的加减等四则运算。通过集合运算，可以得到两张表中记录的集合或者公共记录的集合，又或者其中某张表中的记录的集合。像这样用来进行集合运算的运算符称为集合运算符

-- DDL:创建表
CREATE TABLE Product2
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER,
purchase_price INTEGER,
regist_date DATE,
PRIMARY KEY (product_id));

-- DML 插入数据
BEGIN TRANSACTION;

INSERT INTO Product2 VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2009-12-12');
INSERT INTO Product2 VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-02-12');
INSERT INTO Product2 VALUES ('0003', '运动T恤衫', '衣服', 4000, 2800, '2019-12-12');
INSERT INTO Product2 VALUES ('0009', '手套', '衣服', 800, 500, '2009-12-02');
INSERT INTO Product2 VALUES ('0010', '水壶', '厨房用具', 2000, 1700, '2009-12-11');
COMMIT;

-- 表的加法 UNION 并集
SELECT product_id, product_type FROM Product UNION SELECT product_id, product_type FROM Product2;

-- 集合运算符会去除重复的记录

-- 列数（列的数量）必须一致，像下面这样不一致就会发生错误
SELECT product_id, product_type FROM Product UNION
SELECT product_id, product_type, sale_price FROM Product2;

-- 列的类型必须一致，像下面这样类型不一致就会发生错误
SELECT product_id, product_type FROM Product UNION
SELECT product_id, regist_date FROM Product2;

-- 之前学过的子句都可以使用，但是 order by 子句只能在最后使用一次
SELECT product_id, product_type FROM Product
WHERE product_type = '厨房用具'
UNION
SELECT product_id, product_type FROM Product2
WHERE product_type = '厨房用具'
ORDER BY product_id;

-- 想要把重复行也展示出来，可以加上 ALL
SELECT product_id, product_type FROM Product
UNION ALL
SELECT product_id, product_type FROM Product2;

-- 选出表中公共的部分 INTERSECT
SELECT product_id, product_type FROM Product
INTERSECT
SELECT product_id, product_type FROM Product2;

-- 需要保留重复行的话，加上 ALL
SELECT product_id, product_type FROM Product
INTERSECT ALL
SELECT product_id, product_type FROM Product2;

-- 记录的减法 EXCEPT
SELECT product_id, product_type FROM Product
EXCEPT
SELECT product_id, product_type FROM Product2;
-- 得到的是前者除去后者的剩余的部分

-- 前后交换位置的话，得到的结果也会有所不同
SELECT product_id, product_type FROM Product2
EXCEPT
SELECT product_id, product_type FROM Product;
