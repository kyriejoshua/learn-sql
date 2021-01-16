-- 第二章 查询基础 2-1
/*
 * 使用SELECT语句从表中选取数据。
 * 为列设定显示用的别名。
 * SELECT 语句中可以使用常数或者表达式。
 * 通过指定DISTINCT可以删除重复的行。
 * SQL 语句中可以使用注释。
* 可以通过WHERE语句从表中选取出符合查询条件的数据。
 */

SELECT * from Product;
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date from Product;

-- 设定汉语别名时需要使用双引号(")括起来。
-- 设定中文别名
SELECT product_id AS "商品编号", product_name AS "商品名称", purchase_price AS "进货单价" FROM Product;

SELECT product_name, product_type FROM Product
WHERE product_type = '衣服';
-- 更简约的写法
SELECT product_name FROM Product
WHERE product_type = '衣服';

-- 以下写法会报错，因为不能随意更改输入顺序
SELECT product_name, product_type WHERE product_type = '衣服'
FROM Product;

/* 本SELECT语句,
   会从结果中删除重复行。 */
SELECT DISTINCT product_id, purchase_price
FROM Product;

-- 在 SQL 语句中插入单行注释
SELECT DISTINCT product_id, purchase_price
-- 本SELECT语句会从结果中删除重复行。
FROM Product;
