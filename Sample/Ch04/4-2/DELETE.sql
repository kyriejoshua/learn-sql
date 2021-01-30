-- 第四章 数据的删除 4-2

/*
 * 如果想将整个表全部删除，可以使用 DROP TABLE 语句，如果只想删除 表中全部数据，需使用 DELETE 语句。
 * 如果想删除部分数据行，只需在WHERE子句中书写对象数据的条件即可。 通过 WHERE 子句指定删除对象的 DELETE 语句称为搜索型 DELETE 语句。
 */

-- DROP TABLE 可以删除整个表
-- DELETE 用于删除行，而不是列

-- 仅仅保留数据表，而删除全部数据行，相当于清空
DELETE FROM ProductCopy;

-- 指定删除对象的 DELETE 语句
-- 搜索型 DELETE
DELETE FROM ProductCopy WHERE product_id = '0007';
-- 删除销售价格大于 4000 的数据
DELETE FROM ProductCopy WHERE sale_price >= 4000;

-- 确认删除后的结果
SELECT * FROM ProductCopy;

-- DELETE 语句中不能使用 ORDER BY HAVING GROUP BY 等子句
-- 他们都是对数据的处理，这里对数据做了删除，因此即使对数据处理也毫无意义
