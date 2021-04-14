-- 第六章练习题

-- 6.1
-- ①得到进货价格不再 500， 2800， 5000 的商品名称和进货价格
-- ②得到和上面一样的数据 ❌

-- ②无法得到任何结果，NOT IN 的陷阱，不可以在其中加入 NULL

-- 6.2
-- ❌
SELECT sale_price
  SUM(CASE WHEN sale_price < 1000 THEN sale_price ELSE 0 END) AS low_price
  SUM(CASE WHEN sale_price > 1000 AND sale_price < 3000 THEN sale_price ELSE 0 END) AS mid_price
  SUM(CASE WHEN sale_price > 3000 THEN sale_price ELSE 0 END) AS high_price
  FROM Product

-- 正确的✅
SELECT
  SUM(CASE WHEN sale_price <= 1000 THEN 1 ELSE 0 END) AS low_price,
  SUM(CASE WHEN sale_price BETWEEN(1001 AND 3000) THEN 1 ELSE 0 END) AS mid_price,
  SUM(CASE WHEN sale_price >= 3001 THEN 1 ELSE 0 END) AS high_price,
  FROM Product
