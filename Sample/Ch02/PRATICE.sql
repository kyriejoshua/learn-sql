-- 第二章 练习题

-- 2.1
SELECT product_name, regist_date
  FROM Product
  WHERE regist_date >= '2019-02-28';

-- 2.2
-- 无法取出任何结果
-- NULL 不适用于运算符，需要使用 IS 来判断
SELECT * FROM Product
  WHERE product_price IS NULL;

SELECT * FROM Product
  WHERE product_price IS NOT NULL;

-- 2.3 需要两种写法
SELECT product_price, product_name, sale_price
  FROM Product
  WHERE product_price > 500
  AND (sale_price - product_price) > 500;

SELECT product_price, product_name, sale_price
  FROM Product
  WHERE product_price > 500
  AND sale_price > 500 + product_price;

-- 下面这个写法也可以
SELECT product_price, product_name, sale_price
  FROM Product
  WHERE product_price > 500
  AND NOT (sale_price - product_price) <= 500;

-- 2.4
SELECT product_name, product_type, sale_price, product_price, (sale_price * 0.9 - product_price) AS profit
  FROM Product
  WHERE sale_price * 0.9 - product_price > 100
  AND (product_type = '厨房用具' OR product_type = '办公用品');
