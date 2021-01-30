-- 第四章 数据的更新 4-3

/*
 * 使用UPDATE语句可以更改(更新)表中的数据。
 * 更新部分数据行时可以使用WHERE来指定更新对象的条件。通过WHERE
子句指定更新对象的 UPDATE 语句称为搜索型 UPDATE 语句。
 * UPDATE 语句可以将列的值更新为 NULL。
 * 同时更新多列时，可以在UPDATE语句的SET子句中，使用逗号分隔更
新对象的多个列。
 */

-- 将登记日期全部更新
UPDATE Product
  SET regist_date = '2019-03-04';

-- 确认更新的内容
SELECT * FROM Product ORDER BY product_id;

-- 将厨房用具的价格更新为原来的10倍
UPDATE Product
  SET sale_price = sale_price * 10
  WHERE prodcut_type = '厨房用具';

-- 可以直接更新为 NULL
UPDATE Product
  SET regist_date = NULL
  WHERE product_id = '0007';

-- 合并更新多列，有两种方式
UPDATE Product
  SET regist_date = '2012-03-03', sale_price = sale_price / 10
  WHERE product_id = '0007';

-- 也可以使用括号
UPDATE Product
  SET (regist_date, sale_price) = ('2012-03-04', sale_price / 10)
  WHERE product_id = '0007';

-- 上述两种方式的第一种更为通用，第二种可能会存在不兼容情况
