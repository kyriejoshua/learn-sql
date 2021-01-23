-- 第三章 对表进行聚合查询 3-1

/*
 * 使用聚合函数对表中的列进行计算合计值或者平均值等的汇总操作。
 * 通常，聚合函数会对NULL以外的对象进行汇总。但是只有COUNT函数
 例外，使用 COUNT(*)可以查出包含 NULL 在内的全部数据的行数。
 * 使用DISTINCT关键字删除重复值。
*/

-- 五个常用函数
-- MIN, MAX, COUNT, SUM, AVG

-- 计算全部数据的行数
SELECT COUNT(*) FROM Product;

-- 计算 NULL 之外的数据的行数
SELECT COUNT(product_price) FROM Product;

-- 其他函数并不能使用 * 作为参数，这是 COUNT 所特有的

-- 使用 SUM
SELECT SUM(sale_price) FROM Product;
SELECT SUM(sale_price), SUM(product_price) FROM Product;

-- 聚合函数会把 NULL 排除在外，而 COUNT 会包括 NULL。

-- 使用 AVG 也会自动过滤掉 NULL 的数据
SELECT AVG(sale_price) FROM Product;
SELECT AVG(sale_price), AVG(product_price) FROM Product;

-- 使用 MAX MIN
SELECT MAX(sale_price) FROM Product;
SELECT MAX(sale_price), MIN(product_price) FROM Product;

-- MAX 可以用来判断日期 日期不适用于求和或者平均
SELECT MAX(regist_date), MIN(regist_date) FROM Product;

-- 字符串类型也是可以取出最大最小，但无法求和或者取平均数
-- SUM 只适用于数值类型的列

-- 使用聚合函数删除重复的值
SELECT COUNT(DISTINCT product_name)
  FROM Product;

-- 剔除重复数据以后的求和，结果可能会略微不同
SELECT SUM(DISTINCT sale_price), SUM(sale_price)
  FROM Product;
