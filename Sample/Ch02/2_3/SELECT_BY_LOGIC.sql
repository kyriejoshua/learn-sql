-- 第二章 逻辑运算符 2-3

/*
 * 通过使用逻辑运算符，可以将多个查询条件进行组合。
 * 通过NOT运算符可以生成“不是~”这样的查询条件。
 * 两边条件都成立时，使用AND运算符的查询条件才成立。
 * 只要两边的条件中有一个成立，使用OR运算符的查询条件就可以成立。
 * 值可以归结为真(TRUE)和假(FALSE)其中之一的值称为真值。比较运
算符在比较成立时返回真，不成立时返回假。但是，在 SQL 中还存在另外
一个特定的真值——不确定(UNKNOWN)。
 * 将根据逻辑运算符对真值进行的操作及其结果汇总成的表称为真值表。
 * SQL 中的逻辑运算是包含对真、假和不确定进行运算的三值逻辑。
*/

SELECT product_price, product_id, product_type FROM Product
WHERE product_price >= 299;

-- NOT 的使用，类似于取反的效果
SELECT product_price, product_id, product_type FROM Product
WHERE NOT product_price >= 299;

-- 上面的语句等同于下面这条
SELECT product_price, product_id, product_type FROM Product
WHERE product_price < 299;

-- 在某些时候其实会增加理解成本， 在适当的时候进行使用 NOT

-- AND 和 OR 这两个运算符更常使用
SELECT product_price, product_name FROM Product
WHERE product_price < 299 AND product_name IS NOT NULL;

SELECT product_price, product_name FROM Product
WHERE product_name = '厨房用具' AND product_price > 299;

SELECT product_price, product_name
  FROM Product
WHERE product_name = '厨房用具'
  OR product_price > 299;

-- 书里的文氏图很生动形象的解释了两者的工作原理和不同

-- 下面是更加复杂的使用
-- 取出一个类别的不同生产日期的数据
SELECT product_name, product_id, product_type, product_price, regist_date
  FROM Product
WHERE product_name = '厨房用具'
  AND regist_date = '2020-02-02'
  OR regist_date = '2020-02-09';

-- 但是以上的语句并未达到期望的效果， 因为 AND 运算符的优先级会高于 OR
-- 因此 OR 并列的是 OR 前后的内容
-- 下面是正确的写法
SELECT product_name, product_id, product_type, product_price, regist_date
  FROM Product
WHERE product_name = '厨房用具'
  AND (regist_date = '2020-02-02'
  OR regist_date = '2020-02-09');

-- 创建真值表有助于理解复杂的条件

-- 使用 AND 运算符进行的逻辑运算称为逻辑积
-- 使用 OR 运算符进行的逻辑运算称为逻辑和

-- NULL 既不属于真，也不属于假
-- 创建表时使用 NOT NULL 就是为了避免更复杂的逻辑
