-- 第四章练习题

-- 4.1
-- B 显示查不到数据，因为前一个事务还未结束。他在其他的计算机上连接的数据库
-- 但是 A 先生在自己电脑上是能够看到的
-- 独立性

-- 4.2
-- 和原有的表一样数据的新表 错误
-- 正确答案： 因为商品编号违反了主键约束（不能存在主键重复的记录），所以会发生错误，一行也插入不了
-- 一致性

-- 4.3
-- INSERT INTO ProductMargin
-- (product_id, product_name, sale_price, product_price, margin)
-- VALUES ('0001', 'T恤', 1000, 500, 500);

-- 正确答案:
INSERT INTO ProductMargin
(product_id, product_name, sale_price, product_price, margin)
SELECT product_id, product_name, sale_price, product_price, sale_price - product_price FROM Product;

-- 4.4
BEGIN TRANSACTION
  UPDATE ProductMargin
    SET sale_price = sale_price - 1000
    WHERE product_name = '运动T恤';

  UPDATE ProductMargin
    SET margin = sale_price - product_price
    WHERE product_name = '运动T恤';

COMMIT;
