-- 第七章 集合运算 7-2 联结（以列为单位对表进行联结）

/*
 * 联结（JOIN）就是将其他表中的列添加过来，进行”添加列“的集合运算。
 UNION是以行（纵向）作为单位进行操作，而联结则是以列（横向）为单位进行的。
 * 联结大体上分为内联结和外联结两种。首先请大家牢牢掌握这两种联结的使用方法。
 * 请大家一定要使用标准SQL的语法格式来写联结运算，对于那些过时的或者特定SQL中的写法，了解一下即可，不建议使用。
 */

-- 联结
-- 内联结 INNER JOIN 取共同的部分
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
  FROM ShopProduct AS SP INNER JOIN Product AS P
  ON SP.product_id = P.product_id;

-- 注意 FROM 子句
-- 上面使用别名只是为了加强可读性

-- 注意 ON 子句
-- 类似 WHERE 的效果
-- 必须使用 ON，而且一定要写在 FROM 和 WHERE 之间

-- 使用 <表的别名>.<列名> 的方式是为了区分那些在两张表中都有的列，如果列只在其中一张表，那么可以直接书写列名

-- 结合 WHERE 的使用
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
  FROM ShopProduct AS SP INNER JOIN Product AS P
  ON SP.product_id = P.product_id
  WHERE SP.shop_id = '000A';

-- 外联结 OUTER JOIN
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
  FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
  ON SP.product_id = P.product_id;

-- 它会选出单张表的所有内容
-- 使用 LEFT 或 RIGHT 来区分确认主表
-- 上一条语句可改写成下面的这样
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
  FROM ShopProduct AS SP LEFT OUTER JOIN Product AS P
  ON SP.product_id = P.product_id;

-- 三张表以上的联结

-- DDL:创建新的表
CREATE TABLE InventoryProduct
(inventory_id CHAR(4) NOT NULL,
product_id CHAR(4) NOT NULL,
inventory_quantity INTEGER NOT NULL,
PRIMARY KEY (inventory_id, product_id));

-- DML 插入数据
BEGIN TRANSACTION;

INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0001', 5);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0002', 50);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0003', 32);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P001', '0004', 20);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0005', 80);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0006', 0);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0007', 50);
INSERT INTO InventoryProduct (inventory_id, product_id, inventory_quantity) VALUES ('P002', '0008', 10);

COMMIT;

-- 联结三张表
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, IP.inventory_quantity
  FROM ShopProduct AS SP INNER JOIN Product AS P
  ON SP.product_id = P.product_id
    INNER JOIN InventoryProduct AS IP
      ON SP.product_id = IP.product_id;

-- 可以使用类似的方式继续添加表

-- 交叉联结
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, IP.inventory_quantity
  FROM ShopProduct AS SP CROSS JOIN Product AS P;

-- 交叉联结的使用场景并不多 主要是因为
-- 结果也没有实际价值
-- 数据量较大，比较耗费性能，可读性差

-- 联结的特定语法和过时语法
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
  FROM ShopProduct SP, Product P
  WHERE SP.product_id = P.product_id
  AND SP.shop_id = '000A';

-- 它目前还是支持在所有标准的 DBMS 中执行
-- 但是这个写法有三点不好
-- 使用这个写法无法直观判断出到底是内联结还是外联结
-- 联结条件写在 WHERE 里面无法判断哪些是联结条件，哪些是限制条件
-- 这个语法不知道未来还会支持多久
