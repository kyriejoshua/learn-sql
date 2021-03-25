-- 第六章 函数、谓词、CASE表达式 6-2 CASE 表达式

/*
 * CASE表达式分为简单CASE表达式和搜索CASE表达式两种。搜索CASE表达式包含简单CASE表达式的全部功能。
 * 虽然CASE表达式中的ELSE子句可以省略，但为了让 SQL 语句更加容易理解，还是希望大家不要省略。
 * CASE表达式中的END不能省略
 * 使用CASE表达式能够将SELECT语句的结果进行组合。
 * 虽然有些DBMS提供了各自特有的CASE表达式的简化函数，例如 Oracle 中的 DECODE 和 MySQL 中的 IF 等等，但由于他们并非通用的函数，功能上也有些限制，因此有些场合无法使用。
 */

-- 搜索CASE表达式
SELECT product_name
  CASE WHEN product_type = '衣服' THEN 'A:' || product_type
       WHEN product_type = '厨具' THEN 'B:' || product_type
       WHEN product_type = '办公用品' THEN 'C:' || product_type
       ELSE NULL
    END AS abc_product_type
FROM Product;

SELECT product_type, SUM(sale_price) AS sum_sale_price
  FROM Product GROUP BY product_type;

SELECT
  SUM(CASE WHEN product_type = '衣服' THEN sale_price ELSE 0 END) AS sum_price_clothes,
  SUM(CASE WHEN product_type = '厨具' THEN sale_price ELSE 0 END) AS sum_price_kitchen,
  SUM(CASE WHEN product_type = '办公用品' THEN sale_price ELSE 0 END) AS sum_price_office
  FROM Product;

-- 简单CASE表达式
SELECT product_name
  CASE product_type
    WHEN '衣服' THEN 'A: ' || product_type
    WHEN '厨具' THEN 'B: ' || product_type
    WHEN '办公用品' THEN 'C: ' || product_type
    ELSE NULL
  END AS abc_product_type
FROM Product;

-- 特定的 CASE 表达式
-- 只能在特定的 DSMS 中使用
