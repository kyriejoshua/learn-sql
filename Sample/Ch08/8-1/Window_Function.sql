-- 第八章 SQL 高级处理 8-1 窗口函数

/*
 * 窗口函数可以进行排序，生产序列号等一般的聚合函数无法实现的高级操作。
 * 理解 PARTITION BY 和 ORDER BY 这两个关键字的含义十分重要。
 */

-- 窗口函数（OLAP 函数）
-- OLAP 对数据库数据进行实时分析处理
-- 窗口函数是为了实现 OLAP 而添加的标准 SQL 功能

-- 能够作为窗口函数的函数
-- 1 能够作为窗口函数的聚合函数(SUM,AVG,COUNT,MAX,MIN)
-- 2 RANK, DENSE_RANK, ROW_NUMBER 等专用窗口函数

-- 使用 RANK 函数
SELECT product_name, product_type, sale_price,
  RANK() OVER (PARTITION BY product_type ORDER BY sale_price) AS ranking
  FROM Product;

-- 法则 8-1
-- 窗口函数兼具分组和排序两种功能
-- 法则 8-2
-- 通过 PARTITION BY 分组后的记录集合称为窗口，表示范围

-- 不指定 PARTITION BY 也是可以使用窗口函数的
SELECT product_name, product_type, sale_price,
  RANK() OVER (ORDER BY sale_price) AS ranking
  FROM Product;

-- DENSE_RANK 函数 即使有相同位次的记录，也不会跳过位数，例如 1, 2, 2, 3
SELECT product_name, product_type, sale_price,
  DENSE_RANK() OVER (ORDER BY sale_price) AS ranking,
  FROM Product;

-- ROW_NUMBER 函数，赋予唯一的连续位次
SELECT product_name, product_type, sale_price,
  ROW_NUMBER() OVER (ORDER BY sale_price) AS ranking
  FROM Product;

-- 可以同时使用三个函数，列在一起比较
SELECT product_name, product_type, sale_price,
  RANK() OVER (ORDER BY sale_price) AS ranking,
  DENSE_RANK() OVER (ORDER BY sale_price) AS dense_ranking,
  ROW_NUMBER() OVER (ORDER BY sale_price) AS row_ranking
  FROM Product;

-- 法则 8-3
-- 由于专用窗口函数无需参数，因此通常括号中都是空的

-- 窗口函数的适用范围
-- 法则 8-4
-- 原则上窗口函数只能在 SELECT 子句中使用

-- 作为窗口函数使用的聚合函数
SELECT product_name, product_id, sale_price,
  SUM(sale_price) OVER (ORDER BY product_id) AS current_num
  FROM Product;
-- 这里计算出的是累加值，按照 id 顺序的累加值

-- 累计平均值
SELECT product_name, product_id, sale_price,
  AVG(sale_price) OVER (ORDER BY product_id) AS avg_num
  FROM Product;

-- 计算移动平均
-- 指定框架（汇总范围）

-- 将汇总对象指定为最近的 3 行
SELECT product_id, product_name, sale_price,
  AVG(sale_price) OVER (ORDER BY product_id ROWS 2 PRECEDING) AS moving_avg
  FROM Product;
-- 截止到之前两行，也就是最靠近的三行
-- 这种统计方法成为移动平均，通常用来跟踪趋势，比如股市趋势的实时追踪

-- FOLLOWING 截止到之后的
SELECT product_id, product_name, sale_price,
  AVG(sale_price) OVER (ORDER BY product_id ROWS 2 FOLLOWING) AS moving_avg
  FROM Product;

-- 将当前记录的前后作为汇总对象
SELECT product_id, product_name, sale_price,
  AVG(sale_price) OVER (ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
  FROM Product;

-- 两个 ORDER BY

-- 窗口函数的 OVER 里面确保了按照什么顺序来计算，但是并没有对结果进行排序处理
-- 要确保结果按照顺序排列，可以在最后加上排序逻辑
SELECT product_id, product_name, sale_price,
  RANK() OVER (ORDER BY sale_price) AS ranking
  FROM Product
  ORDER BY ranking;

-- 法则 8-5
-- 将聚合函数作为窗口函数使用时，会以当前记录为基准来决定汇总对象的记录
