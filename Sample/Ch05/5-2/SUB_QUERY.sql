-- 第五章 复杂查询 5-2 子查询

/*
 * 一言以蔽之，子查询就是一次性视图(SELECT语句)。与视图不同，子查询在 SELECT 语句执行完毕之后就会消失。
 * 由于子查询需要命名，因此需要根据处理内容来指定恰当的名称。
 * 标量子查询就是只能返回一行一列的子查询。
 */

-- 子查询就是一次性视图

-- 这是常规的视图
CREATE VIEW ProductSumJim (product_type, cnt_product)
  AS
  SELECT product_type, COUNT(*)
  FROM Product
  GROUP BY product_type;

-- 子查询
SELECT product_type, cnt_product
  FROM (SELECT product_type, COUNT(*) AS cnt_product FROM Product GROUP BY product_type) AS ProductSumJim;

-- 上述两种方式得到的答案完全相同
-- 子查询的内层查询会首先执行

-- 增加子查询的层数
SELECT product_type, cnt_product FROM
  (SELECT * FROM
    (SELECT product_type, COUNT(*) AS cnt_product FROM Product GROUP BY product_type) AS ProductSum
  WHERE cnt_product = 4) AS ProductSum2;

-- 支持子查询，但是可读性差，平时的使用中应当尽量避免

-- 必须设定子查询的名称，且尽可能可读性高

-- 标量子查询就是返回单一值的子查询
-- 尝试查出销售单价大于平均单价的商品
SELECT AVG(sale_price) FROM Product;

-- 这是错误写法
SELECT product_id, product_name FROM
  (SELECT AVG(sale_price) AS avg_sale_price FROM Product) AS ProductAvg
  WHERE sale_price > avg_sale_price;

-- 选出销售单价高于全部商品的平均单价的商品
SELECT product_id, product_name, sale_price FROM Product
  WHERE sale_price > (SELECT AVG(sale_price) FROM Product);

-- 标量子查询的书写位置
-- 能用常数或者列名的地方，无论是 SELECT、GROUP BY、ORDER BY、HAVING

-- 在 SELECT 中使用标量子查询
SELECT product_id, product_name, sale_price, (SELECT AVG(sale_price) FROM Product) AS avg_sale_price
FROM Product;

-- 在 HAVING 子句中使用标量子查询
SELECT product_type, AVG(sale_price)
FROM Product
GROUP BY product_type
HAVING AVG(sale_price) > (SELECT AVG(sale_price) FROM Product);
-- 该查询的含义是想要选取出按照商品种类计算出的销售单价高于全部 商品的平均销售单价的商品种类

-- 使用该子查询的时候绝对不能返回多行结果
-- 否则会发生错误，下面是错误示例
-- 这是子查询，不再是标量子查询
SELECT product_id, product_type,sale_price (SELECT AVG(sale_price) FROM Product GROUP BY product_type) AS avg_sale_price
FROM Product;
