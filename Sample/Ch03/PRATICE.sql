-- 第三章 练习题

-- 3.1 指出错误
-- 一共四处错误
SELECT product_id, SUM(product_name) -- 使用了字符串类型的数据作为求和函数的参数
  -- 本SELECT语句中存在错误。 不要在这里添加注释，会降低可读性
  FROM Product
  GROUP BY product_type -- 这里需要使用在 SELECT 子句中使用的列
  WHERE regist_date > '2009-09-01'; -- WHERE 语句不能写在 GROUP BY 之后

-- 3.2
SELECT SUM(product_price), SUM(sale_price), product_type FROM Product
  GROUP BY product_type
  HAVING sum(sale_price) > sum(product_price) * 1.5;

-- 3.3
-- 是根据 regist_date 来降序排序的
SELECT * FROM Product
  ORDER BY regist_date DESC, sale_price;
