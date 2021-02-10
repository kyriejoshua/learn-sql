-- 第五章练习题

-- 5.1
CREATE VIEW ViewPractice5_1 -- (product_name, sale_price, regist_date) 不需要写这些
AS
SELECT product_name, sale_price, regist_date FROM Product
WHERE regist_date = '2009-09-20' AND sale_price >= 1000;

-- 5.2 可以正常的插入数据 ❌ 错误
-- 对视图的更新归根结底是对视图所对应的表进行更新。因此，该 INSERT 语句实质上和下面的 INSERT 语句相同。
INSERT INTO Product (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
VALUES (NULL, '刀子', NULL, 300, NULL, '2009-11-02');
-- 因为有 NOT NULL 的约束，所以会发生错误

-- 5.3
SELECT product_id, product_name, product_type, sale_price,
  (SELECT AVG(sale_price) FROM Product) AS sale_price_all
  FROM Product;

-- 5.4 ❌ 错误
CREATE VIEW AvgPriceByType (product_id, product_name, product_type, sale_price, avg_sale_price)
AS
SELECT product_id, product_name, product_type, sale_price,
  (SELECT AVG(sale_price) FROM Product GROUP BY product_type) AS avg_sale_price FROM Product

-- 正确如下
CREATE VIEW AvgPriceByType
AS
SELECT product_id, product_name, product_type, sale_price,
  (SELECT AVG(sale_price) FROM Product P2 WHERE P1.product_type = P2.product_type GROUP BY P2.product_type) AS avg_sale_price
  FROM Product P1;

-- 删除视图
DROP VIEW AvgPriceByType;
