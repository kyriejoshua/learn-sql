-- 第三章 对表进行分组 3-2

/*
 * 使用 GROUP BY 子句可以像切蛋糕那样将表分割。通过使用聚合函数和 GROUP BY子句，可以根据“商品种类”或者“登记日期”等将表分割后再 进行汇总。
 * 聚合键中包含NULL时，在结果中会以“不确定”行(空行)的形式表现出来。
 * 使用聚合函数和GROUP BY子句时需要注意以下4点。
  1 只能写在SELECT子句之中
  2 GROUP BY子句中不能使用SELECT子句中列的别名 3 GROUP BY子句的聚合结果是无序的
  4 WHERE子句中不能使用聚合函数
 */

-- 按照商品总类获取条数
SELECT product_type, COUNT(*) FROM Product
  GROUP BY product_type;

-- SQL 子句的书写顺序是 SELECT FROM WHERE GROUP BY

-- 下面这段可以演示数据中含有 NULL 的情况
SELECT product_price, COUNT(*) FROM Product
  GROUP BY product_price;

-- 和 WHERE 组合
SELECT product_type, COUNT(*) FROM Product
  WHERE regist_date > '2019-01-01'
  GROUP BY product_type;

-- 执行顺序是这样的，
-- FROM WHERE GROUP BY SELECT

-- 这段语句是报错的， product_price 也要包括在 GROUP BY 中
-- 在 SELECT 子句中书写聚合键之外的列名会发生错误
SELECT product_type, product_price, COUNT(*) FROM Product
  GROUP BY product_type;

-- GROUP BY 使用别名也会报错，在某些环境里并不会报错，但这不是统一标准
SELECT product_type as pt, COUNT(*) FROM Product
  GROUP BY pt;

-- GROUP BY 获取的数据是随机的，不是排序的

-- 在 WHERE 子句中使用聚合函数会发生错误
-- 下面这样写是错误的
SELECT product_type, COUNT(*) FROM Product
  WHERE COUNT(*) = 2
  GROUP BY product_type;

-- 下面的语句是等价的
SELECT DISTINCT product_type
  FROM Product;

SELECT product_type FROM Product
  GROUP BY product_type;
