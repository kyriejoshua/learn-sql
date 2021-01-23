-- 第二章 算术运算符和比较运算符 2-2
/*
 * 运算符就是对其两边的列或者值进行运算(计算或者比较大小等)的符号。
 * 使用算术运算符可以进行四则运算。
 * 括号可以提升运算的优先顺序(优先进行运算)。
 * 包含NULL的运算，其结果也是NULL。
 * 比较运算符可以用来判断列或者值是否相等，还可以用来比较大小。
 * 判断是否为NULL，需要使用IS NULL或者IS NOT NULL运算符。
 */

-- 算术运算符
SELECT product_id, sale_price, sale_price * 2 AS 'sale_price x 2' FROM Product;

-- 语句中也是可以使用括号的，会提升优先级

-- 默认情况下，任何与 NULL 进行的算术运算，结果都是 NULL

-- 比较运算符
SELECT product_id, sale_price, product_name FROM Product WHERE sale_price = 600;

-- 不等于 <>
SELECT product_id, sale_price, product_name FROM Product WHERE sale_price <> 600;

-- 不推荐使用 != 来表示不等于，它不是标准的写法

-- 筛选价格大于等于 600 的数据
SELECT product_id, sale_price, product_name FROM Product WHERE sale_price >= 600;

-- 也可以对日期进行比较
SELECT product_id, regist_date, product_name FROM Product WHERE regist_date <= '2020-09-12';

-- DDL: 创建表
CREATE TABLE Chars
(chr CHAR(3) NOT Null
PRIMARY KEY (chr));

-- 选出大于 '2' 的语句
SELECT chr FROM Chars
WHERE chr > '2';

-- 字符串的排序类似字典中的排序，而不是单纯的类似数字去比较大小

-- 不能对 NULL 使用比较运算符
SELECT product_price FROM Product
WHERE product_price = 288;

-- 如果使用不等于的方式，会无法筛选值为 NULL 的参数
SELECT product_price FROM Product
WHERE product_price <> 288;

-- 下面这样写也是无效的
SELECT product_price FROM Product
WHERE product_price = NULL;

-- SQL 提供了专门的判断语句，如下
SELECT product_price FROM Product
WHERE product_price IS NULL;

-- 不等于 NULL 的情况
SELECT product_price FROM Product
WHERE product_price IS NOT NULL;

-- 理由在后续章节会补充
