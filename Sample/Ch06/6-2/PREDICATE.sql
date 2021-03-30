-- 第六章 函数、谓词、CASE表达式 6-2 谓词

/*
 * 谓词就是返回值为真值的函数
 * 掌握 LIKE 的三种使用方法（前方一致，中间一致，后方一致）
 * 需要注意 BETWEEN 包含三个参数
 * 想要取得 NULL 数据时必须使用 IS NULL
 * 可以将子查询作为 IN 和 EXISTS 的参数
 */

-- LIKE 谓词，字符串的部分一致查询

-- DDL:创建表
CREATE TABLE SampleLike (strcol VARCHAR(6) NOT NULL, PRIMARY KEY (strcol));

-- DML 插入数据
BEGIN TRANSACTION;

INSERT INTO SampleLike(strcol) VALUES ('dddfj');
INSERT INTO SampleLike(strcol) VALUES ('dddk');
INSERT INTO SampleLike(strcol) VALUES ('dddkk');
INSERT INTO SampleLike(strcol) VALUES ('fjdfddd');
INSERT INTO SampleLike(strcol) VALUES ('ffjddd');
INSERT INTO SampleLike(strcol) VALUES ('jdddfjj');
INSERT INTO SampleLike(strcol) VALUES ('kkfj');

COMMIT;

SELECT * FROM SampleLike;

-- LIKE 前方一致查询，匹配字符串的最左侧数据
SELECT * FROM SampleLike WHERE strcol LIKE 'ddd%';
-- % 代表 0 字符以上的任意字符串

-- 中间一致查询
SELECT * FROM SampleLike WHERE strcol LIKE '%ddd%';

-- 后方一致查询
SELECT * FROM SampleLike WHERE strcol LIKE '%ddd';

-- _ 表示任意 1 个字符，以下的查询查到的确认只能是 6 个字符
SELECT * FROM SampleLike WHERE strcol LIKE 'ddd___';

-- BETWEEN 谓词 范围查询
-- 查出 product_name 的 sale_price 在 100 和 1000 之间的数据，包含 100 和 1000
SELECT product_name, sale_price FROM Product WHERE sale_price BETWEEN 100 AND 1000;

-- 如果不需要包含首末，就只能用其他运算符
SELECT product_name, sale_price FROM Product WHERE sale_price > 100 AND sale_price < 1000;

-- IS NULL, IS NOT NULL 判断是否为 NULL
SELECT product_name, sale_price FROM Product WHERE sale_price IS NULL;
SELECT product_name, sale_price FROM Product WHERE sale_price IS NOT NULL;

-- IN 谓词， OR 的简便用法
-- 查找售价为 320 500 和 1000 的商品名称
SELECT product_name, sale_price FROM Product
  WHERE sale_price = 320 OR sale_price = 500 OR sale_price = 1000;

-- 简便的写法
SELECT product_name, sale_price FROM Product
  WHERE sale_price IN (320, 500, 1000);

-- 还可以取反，反之则可以这样写
SELECT product_name, sale_price FROM Product
  WHERE sale_price NOT IN (320, 500, 1000);

-- 使用子查询作为IN谓词的参数

-- 首先创建一张表来作为案例
CREATE TABLE ShopProduct
(shop_id CHAR(4) NOT NULL,
 shop_name VARCHAR(200) NOT NULL,
 product_id CHAR(4) NOT NULL,
 quantity INTEGER NOT NULL,
 PRIMARY KEY (shop_id, product_id));

-- 获取某一商店的在售商品 id
SELECT product_id FROM ShopProduct WHERE shop_id = '000C';

-- 获取这些商品的售价和名称
-- 注意这里是不同的表
SELECT product_name, sale_price FROM Product
  WHERE product_id IN (SELECT product_id FROM ShopProduct WHERE shop_id = '000C');

-- 使用子查询的方式是动态的，易维护的
-- 使用 IN ('0003', '0004') 也能在这次查询中得到正确的结果，但数据库中的数据不是一成不变的，会导致每次变动都要修改 SQL
-- 使用子查询可以避免每次修改，这就是它的作用

-- 反之也可以使用
SELECT product_name, sale_price FROM Product
  WHERE product_id NOT IN (SELECT product_id FROM ShopProduct WHERE shop_id = '000A');

-- EXIST 谓词
-- 谓词的作用就是“判断是否存在满足某种条件的记录”。
-- 下面实现的是和上面一样的效果
SELECT product_name, sale_price FROM Product AS P
  WHERE EXISTS (SELECT * FROM ShopProduct AS SP
    WHERE SP.shop_id = '000C' AND SP.product_id = P.product_id);

-- 通常会指定关联子查询作为 EXIST 的参数

-- EXIST 中的子查询的 SELECT * 是一种习惯，写成别的比如常数也能返回预期的结果
SELECT product_name, sale_price FROM Product AS P
  WHERE EXISTS (SELECT 1 FROM ShopProduct AS SP
    WHERE SP.shop_id = '000C' AND SP.product_id = P.product_id);

-- 不过会习惯写成 SELECT *

-- EXIST 也可以取反来使用
SELECT product_name, sale_price FROM Product AS P
  WHERE NOT EXISTS (SELECT * FROM ShopProduct AS SP
    WHERE SP.shop_id = '000A' AND SP.product_id = P.product_id);
