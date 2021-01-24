-- 第三章 为聚合结果指定条件 3-3

/*
 * 使用COUNT函数等对表中数据进行汇总操作时，为其指定条件的不是 WHERE 子句，而是 HAVING 子句。
 * 聚合函数可以在SELECT子句、HAVING子句和ORDER BY子句中使用。
 * HAVING子句要写在GROUP BY子句之后。
 * WHERE 子句用来指定数据行的条件，HAVING 子句用来指定分组的条件。
 */

-- 书写顺序
-- SELECT FROM WHERE GROUP BY HAVING

-- 使用 HAVING 找出行数为两条的数据
SELECT product_type, COUNT(*) FROM Product
  GROUP BY product_type,
  HAVING COUNT(*) = 2;

-- 找出平均销售价格大于 2500 的商品类型分组数据
SELECT product_type, AVG(sale_price) FROM Product
  GROUP BY product_type
  HAVING AVG(sale_price) >= 2500;

-- 下面是不正确的写法,列名要在 SELECT 子句中包含
SELECT product_type, COUNT(*) FROM Product
  GROUP BY product_type
  HAVING product_name = '厨房用具';

-- 以下两个写法是等价的
SELECT product_name, product_type FROM Product
  WHERE product_name = '菜刀'
  GROUP BY product_type;

SELECT product_type, product_name FROM Product
  GROUP BY product_type
  HAVING product_name = '菜刀'；

-- WHERE 指定行所用的条件
-- HAVING 指定组对应的条件

-- 通常来说 WHERE 执行的比 HAVING 更快
