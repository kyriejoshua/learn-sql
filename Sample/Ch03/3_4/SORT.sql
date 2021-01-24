-- 第三章 对查询结果进行排序 3-4

/*
 * 使用ORDER BY子句对查询结果进行排序。
 * 在ORDER BY子句中列名的后面使用关键字ASC可以进行升序排序，使
用 DESC 关键字可以进行降序排序。
 * ORDER BY子句中可以指定多个排序键。
 * 排序健中包含NULL时，会在开头或末尾进行汇总。
 * ORDER BY子句中可以使用SELECT子句中定义的列的别名。
 * ORDER BY子句中可以使用SELECT子句中未出现的列或者聚合函数。
 * ORDER BY子句中不能使用列的编号。
 */

-- 句子的书写顺序
-- SELECT FROM WHERE GROUP BY HAVING ORDER BY

-- 升序排列
SELECT product_name, product_price, product_type, sale_price FROM Product
  ORDER BY sale_price;

-- 指定降序排列 使用 DESC 关键字
SELECT product_type, product_price, product_name, sale_price FROM Product
  ORDER BY sale_price DESC;

-- 默认升序，关键字是 ASC

-- 指定多个排序键
SELECT product_name, product_price, product_type, sale_price FROM Product
  ORDER BY sale_price, product_price;

-- 如果查询的结果中含有 NULL， 那么它始终会在开头或者末尾汇总展示
SELECT product_name, product_price, product_type, sale_price FROM Product
  ORDER BY product_price;

-- 和 GROUP BY 不同， ORDER BY 是可以使用别名的
SELECT product_name, product_price AS pp, product_type AS pt, sale_price FROM Product
  ORDER BY pt, pp;

-- 为什么会这样，是因为执行顺序时， ORDER BY 是在 SELECT 之后
-- FROM WHERE GROUP BY SELECT ORDER BY
-- 在执行 GROUP BY 的时候， SELECT 的语句还没有执行，也就无法识别别名

-- 可以使用存在于表中，但并不在 SELECT 子句中的列用来排序
SELECT product_name, product_type FROM Product
  ORDER BY sale_price, product_price;

-- 也可以使用聚合函数来排序
SELECT product_type, COUNT(*) FROM Product
  GROUP BY product_type
  ORDER BY COUNT(*);

-- 还可以使用列编号来排序 但是可读性会很不友好，而且未来这个功能会被标准删除
SELECT product_type FROM Product
  GROUP BY product_type
  ORDER BY 1 DESC;
