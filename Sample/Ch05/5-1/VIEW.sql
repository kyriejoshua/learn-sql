-- 第五章 复杂查询 5-1 视图

/*
 * 从SQL的角度来看，视图和表是相同的，两者的区别在于表中保存的是实际的数据，而视图中保存的是 SELECT 语句(视图本身并不存储数据)。
 * 使用视图，可以轻松完成跨多表查询数据等复杂操作。
 * 可以将常用的SELECT语句做成视图来使用。
 * 创建视图需要使用CREATE VIEW语句。
 * 视图包含“不能使用ORDER BY”和“可对其进行有限制的更新”两项限制。
 * 删除视图需要使用DROP VIEW语句。
 */

-- 两大优点
  -- 节约存储设备的容量
  -- 将频繁使用的 SELECT 居于保存成视图，避免每次书写

-- 表中存储的是实际数据，而视图中保存的是从表中取出数据所使用的 SELECT 语句。
-- 应该将经常使用的 SELECT 语句做成视图。

-- 创建视图的方法 牢记 AS 一定不能省略
CREATE VIEW ProductSum (product_type, cnt_product)
  AS
  SELECT product_type, COUNT(*)
    FROM Product
  GROUP BY product_type;

-- 当成常规的表来查询
SELECT product_type, cnt_product FROM ProductSum;

-- 应该避免在视图的基础上创建视图。 虽然可以这么做，但最好还是避免，因为会影响性能
CREATE VIEW ProductSumJim (product_type, cnt_product)
  AS
  SELECT product_type, cnt_product
  FROM ProductSum
  WHERE product_type = '办公用品';

-- 视图的限制 定义视图时不能使用 ORDER BY 子句
  -- 对视图进行更新 有严格的限制
    -- 如果原来的表可以更新，那么视图中的数据也可以更新
-- 法则：定义视图时不要使用ORDER BY子句。
-- 法则：视图和表需要同时进行更新，因此通过汇总得到的视图无法进行更新。

-- 这个视图是可以更新的
CREATE VIEW ProductJim (product_id, product_name, product_type, sale_price, product_price, regist_date)
  AS
  SELECT * FROM Product
    WHERE product_type = '办公用品';

SELECT * FROM ProductJim;

-- 插入行
INSERT INTO ProductJim VALUES('0009', '印章', '办公用品', 95， 10， '2019-11-30');

-- 查看是否插入成功
SELECT * FROM Product;

-- 删除视图
DROP VIEW ProductSumJim;

-- PostgreSQL 删除多重视图里的基础视图，由于存在关联，会发生报错
