-- 第四章 数据的插入 4-1

/*
 * 使用INSERT语句可以向表中插入数据(行)。原则上，INSERT语句每 次执行一行数据的插入。
 * 将列名和值用逗号隔开，分别括在()内，这种形式称为清单。
 * 对表中所有列进行INSERT操作时可以省略表名后的列清单。
 * 插入NULL时需要在VALUES子句的值清单中写入NULL。
 * 可以为表中的列设定默认值(初始值)，默认值可以通过在CREATE TABLE
语句中为列设置 DEFAULT 约束来设定。
 * 插入默认值可以通过两种方式实现，即在INSERT语句的VALUES子句
中指定 DEFAULT 关键字(显式方法)，或省略列清单(隐式方法)。
 * 使用INSERT...SELECT可以从其他表中复制数据。
 */

-- 向表中插入一行数据
INSERT INTO ProductIns (product_id, product_name, product_type,
  sale_price, product_price, regist_date) VALUES ('001', 'T恤衫',
  '衣服', 1000, 500, '2019-02-03');

-- 上面有列清单，也有值清单，而两者必须保持一致
-- 原则上，执行一次 INSERT 语句会插入一条数据
-- 要插入多条数据的时候需要使用循环

-- 对表进行全列的操作时，可以省略列清单，值清单会从左右到一一插入到每一列
INSERT INTO ProductIns VALUES ('001', 'T恤衫', '衣服', 1000, 500, '2019-02-03');

-- 插入 NULL 直接把数据替换成 NULL 就可以
INSERT INTO ProductIns VALUES ('001', 'T恤衫', '衣服', 1000, NULL, '2019-02-03');

-- 插入默认值
CREATE TABLE ProductIns (product_id CAHR(4) NOT NULL,
  sale_price INTEGER DEFAULT 0, -- 销售单价的默认值设定为 0;
  PRIMARY KEY (product_id));

-- 显式方法插入默认值
INSERT INTO ProductIns (product_id, product_name, product_type, sale_price, product_price, regist_date)
  VALUES('0007', '擦菜板', '厨房用具', DEFAULT, 790, '2019-02-12');

-- 确认插入的数据行
SELECT * FROM ProductIns WHERE product_id = '0007';

-- 通过隐式方法插入默认值 列清单和值清单中都省略
INSERT INTO ProductIns (product_id, product_name, product_type, product_price, regist_date)
  VALUES('0007', '擦菜板'， '厨房用具', 790, '2019-03-12');

-- 推荐显式的方式，因为可读性更友好
-- 如果未设定默认值，默认值就是 NULL
-- 如如果设置了 NOT NULL，那么插入语句就会报错
-- 最后一列 regist_date 省略，就会报错
INSERT INTO ProductIns (product_id, product_name, product_type, product_price)
  VALUES('0007', '擦菜板'， '厨房用具', 790);

-- 从其他表中复制数据
-- 首先新建一张表
CREATE TABLE ProductCopy
(product_id CHAR(4) NOT NULL,
product_name, VARCHAR(100) NOT NULL,
product_type VARCHAR(100) NOT NULL,
sale_price INTEGER,
product_price INTEGER,
regist_date DATE,
PRIMARY KEY (product_id));

-- 复制表 INSERT...SELECT 语句
INSERT INTO ProductCopy (product_id, product_name, product_type, sale_price, product_price, regist_date)
SELECT product_id, product_name, product_type, sale_price, product_price, regist_date FROM Product;

-- 根据商品种类进行汇总的表
CREATE TABLE ProductType
(product_type VARCHAR(32) NOT NULL,
sum_sale_price INTEGER,
sum_product_price INTEGER,
PRIMARY KEY (product_type));

INSERT INTO ProductCopy (product_type, sum_product_price, sum_sale_price)
  SELECT product_type, sum(product_price), sum(sale_price)
  FROM Product
  GROUP BY product_type;
