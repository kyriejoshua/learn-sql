-- 第七章练习题

-- 7.1
-- 得到 Product 表的所有结果

-- 7.2 重点题目
SELECT COALESCE(SP.shop_id, '不确定') AS shop_id,
  COALESCE(SP.shop_name, '不确定') AS shop_name,
  P.product_id, P.product_name, P.sale_price
  FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
  ON SP.product_id = P.product_id
  ORDER BY shop_id;
