-- 第八章 SQL 高级处理 8-2 GROUPING 运算符

/*
 * 只使用 GROUP BY 子句和聚合函数是无法同时得出小计和合计的。如果想要同时得到，可以使用 GROUPING 运算符。
 * 理解 GROUPING 运算符中 CUBE 的关键在于形成”积木达成立方体“的印象。
 * 虽然 GROUPING 运算符是标准 SQL 的功能，但还是有些 DBMS 尚未支持这一功能。
 */

-- 同时得到合计行
-- 这个方式无法得到合计行
SELECT product_type, SUM(sale_price)
  FROM Product
  GROUP BY product_type;

-- 可以使用 UNION ALL 来曲线实现
-- UNION ALL 因为不用排序，因此性能比 UNION 要好
-- 而且这里确认不会出现重复行，因此得到的结果也是一样，所以可以互相用
SELECT '合计' AS product_type, SUM(sale_price)
  FROM Product
UNION ALL
SELECT product_type, SUM(sale_price)
  FROM Product
  GROUP BY product_type;

-- ROLLUP 同时得出合计和小计
-- GROUPING 运算符包括下面三种
  -- ROLLUP
  -- CUBE
  -- GROUPING SETS

-- 使用 ROLLUP 可以直接得出以上拥有合计的结果
SELECT product_type, SUM(sale_price) AS sum_price
  FROM Product
  GROUP BY ROLLUP(product_type);

-- 法则 8-6
-- 超级分组记录默认使用 NULL 来作为聚合键


-- 以下是区分了是否使用 ROLLUP 的效果
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
  FROM Product
  GROUP BY product_type, regist_date;

SELECT product_type, regist_date, SUM(sale_price) AS sum_price
  FROM Product
  GROUP BY ROLLUP(product_type, regist_date);
-- 上面这个结果等同于下面这三个 UNION
  -- GROUP BY()
  -- GROUP BY(product_type)
  -- GROUP BY(product_type, regist_date)

-- 法则 8-7
-- ROLLUP 可以同时得出合计和小计，是非常方便的工具

-- GROUPING 让 NULL 更加容易分辨
SELECT GROUPING(product_type) AS product_type,
  GROUPING(regist_date) AS regist_date,
  SUM(sale_price) AS sum_price,
  FROM Product
  GROUP BY ROLLUP(product_type, regist_date);

-- 在超级分组记录的键值中插入恰当的字符串
SELECT CASE WHEN GROUPING(product_type) = 1
  THEN '商品种类 合计'
    ELSE product_type END AS product_type,
  CASE WHEN GROUPING(regist_date) = 1
  THEN '登记日期 合计'
    ELSE CASE(regist_date AS VARCHAR(16)) END AS regist_date,
  FROM Product
  GROUP BY ROLLUP(product_type, regist_date);

-- 其中类型转换是为了让 CASE 返回的数据的类型始终一致

-- 法则 8-8
-- 使用 GROUPING 函数能够简单地分辨出原始数据中的 NULL 和超级分组记录中的 NULL

-- CUBE 用数据来搭积木
SELECT CASE WHEN GROUPING(product_type) = 1
  THEN '商品种类 合计'
    ELSE product_type END AS product_type,
  CASE WHEN GROUPING(regist_date) = 1
  THEN '登记日期 合计'
    ELSE CASE(regist_date AS VARCHAR(16)) END AS regist_date,
    FROM Product
    GROUP BY CUBE(product_type, regist_date);

-- 相当于是以下四个 UNION
  -- GROUP BY()
  -- GROUP BY(product_type)
  -- GROUP BY(regist_date)
  -- GROUP BY(product_type, regist_date)
-- 所有可能的组合

-- 法则 8-9
-- 可以把 CUBE 理解为将使用聚合键进行切割的模块堆积成一个立方体。

-- GROUPING SETS 取得期望的积木
-- 这个运算符可以从前两者中取得一部分的记录
SELECT CASE WHEN GROUPING(product_type) = 1
  THEN '商品种类 合计'
    ELSE product_type END AS product_type,
  CASE WHEN GROUPING(regist_date) = 1
  THEN '登记日期 合计'
    ELSE CASE(regist_date AS VARCHAR(16)) END AS regist_date,
    FROM Product
    GROUP BY GROUPING SETS(product_type, regist_date);

-- 但是这种取出一部分数据的场景比较少，因此使用 GROUPING SETS 的机会也比较少
