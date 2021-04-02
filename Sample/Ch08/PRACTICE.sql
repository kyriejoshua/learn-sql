-- 第八章练习题

-- 8.1
SELECT product_id, product_name, sale_price,
  MAX (sale_price) OVER (ORDER BY product_id) AS current_max_price
  FROM Product;
-- 会找出按 product_id 升序的累计历史单价里销售单价最高的那一列
-- 按照商品编号(product_id)的升序进行排序， 计算出截至当前行的最高销售单价

-- 8.2 重点题目 ×
SELECT sale_price, regist_date,
  SUM(sale_price) OVER (PARTITION BY regist_date ORDER BY regist_date) AS current_sum_price
  FROM Product
  ORDER BY ROLLUP(regist_date);

-- 正确的✅ 以下两种都可以实现
SELECT sale_price, product_name, regist_date
  SUM(sale_price) OVER(ORDER BY COALESCE(regist_date, CASE('0001-01-01' AS DATE))) AS current_sum_price
    FROM Product;

-- 这个不是标准 SQL 支持的实现，但在大多数 DBMS 中可以实现
SELECT sale_price, product_name, regist_date
  SUM(sale_price) OVER(ORDER BY regist_date NULLS FIRST) AS current_sum_price
  FROM Product;
