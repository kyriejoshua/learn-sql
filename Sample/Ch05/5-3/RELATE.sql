-- 第五章 复杂查询 5-3 关联子查询

/*
 * 关联子查询会在细分的组内进行比较时使用。
 * 关联子查询和GROUP BY子句一样，也可以对表中的数据进行切分。
 * 关联子查询的结合条件如果未出现在子查询之中就会发生错误。
 */

-- 通过关联子查询进行查询比较
SELECT product_type, product_name, sale_price FROM Product AS P1
WHERE sale_price >
  (SELECT AVG(sale_price) FROM Product AS P2
    WHERE P1.product_type = P2.product_type GROUP BY product_type);

-- 该查询不适用于 Oracle
-- 法则：在细分的组内进行比较时，需要使用关联子查询
-- 结合条件一定要写在子查询中
-- 关联名称存在一个有效范围的限制 子查询内部设定的关联名称，只能在子查询内部使用

