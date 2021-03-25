-- 第六章 函数、谓词、CASE表达式 6-1 各种各样的函数

/*
 * 根据用途，函数可以大致分为算数函数、字符串函数、日期函数、转换函数和聚合函数。
 * 函数的种类很多，无需全都记住，只需要记住具有代表性的函数就可以了，其他的可以在使用时再进行查询。
 */

-- 函数的种类
-- 算数函数、字符串函数、日期函数、转换函数、聚合函数
-- 算数函数， 就是加减乘除

-- DDL:创建表
CREATE TABLE SampleMath (m NUMERIC (10,3), n INTEGER, p INTEGER);

-- DML 插入数据
BEGIN TRANSACTION;

INSERT INTO SampleMath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555,2, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT;

SELECT * FROM SampleMath;

-- ABS 绝对值
SELECT m, ABS(m) AS abs_col FROM SampleMath;

-- MOD 求余
SELECT n, p, MOD(n, p) AS mod_col FROM SampleMath;
-- 主流 DBMS 只有 MOD 函数 SQL Server 不支持这个函数
-- 这样来实现一样的效果
SELECT n, p, n % p AS mod_col FROM SampleMath;

-- ROUND 四舍五入函数 接收两个参数来确认
-- 对象数值和保留小数的位数
SELECT m, ROUND(m, n) AS round_col FROM SampleMath;

-- 字符串函数

-- DDL 创建表
CREATE TABLE SampleStr (str1 VARCHAR(40), str2 VARCHAR(40), str3 VARCHAR(40));

-- DML 插入数据
BEGIN TRANSACTION;

INSERT INTO SampleStr(str1, str2, str3) VALUES ('opx', 'rx', NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('Abc', 'def', NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('山田', '太郎', '是你');
INSERT INTO SampleStr(str1, str2, str3) VALUES ('aaa', NULL, NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES (NULL, 'xyz', NULL);

COMMIT;

SELECT * FROM SampleStr;

-- || 拼接函数
SELECT str1, str2, str1 || str2 AS str_concat FROM SampleStr;
-- 其中含 NULL，那么结果也含 NULL

-- 拼接三个字符串
SELECT str1, str2, str3, str1 || str2 || str3 AS str_concat FROM SampleStr;

-- MYSQL 中， 使用 + 来拼接字符串
SELECT str1, str2, str3, str1 + str2 + str3 AS str_concat FROM SampleStr;

-- SQL Server 的写法
SELECT str1, str2, str3, CONCAT(str1, str2, str3) AS str_concat FROM SampleStr;

-- LENGTH 获取字符串长度
SELECT str1, LENGTH(str1) AS str_length FROM SampleStr;

-- SQL Server 的写法
SELECT str1, LEN(str1) AS str_length FROM SampleStr;

-- LOWER  小写转换
SELECT str1, LOWER(str1) AS str_lower FROM SampleStr
  WHERE str1 IN ('Abc', '山田', 'aaa');

-- UPPER 大写转换
SELECT str1, UPPER(str1) AS str_lower FROM SampleStr
  WHERE str1 IN ('Abc', '山田', 'aaa');

-- REPLACE （对象字符串，要被替换的字符串，替换后的字符串）
SELECT str1, str2, str3, REPLACE(str1, str2, str3) AS str_replace FROM SampleStr;

-- SUBSTRING 截取字符串 （对象字符串，FROM 开始位置 FOR 截取的字符数）
SELECT str1, SUBSTRING(str1, FROM 1 FOR 3) AS str_substring FROM SampleStr;

-- 这是标准语法，但是实现的 DBMS只有postgreSQL 和 MYSQL
-- 其他实现
SELECT str1, SUBSTRING(str1, 1, 3) AS str_substring FROM SampleStr;

-- 日期函数
-- CURRENT_DATE 获取当前日期
SELECT CURRENT_DATE;

-- 不同 SQL 对这一方法定义的使用方式不一样

-- CURRENT_TIME 获取当前时间
SELECT CURRENT_TIME;

-- CURRENT_TIMESTAMP 获取当前日期和时间
SELECT CURRENT_TIMESTAMP;
-- 注意这里返回的不是时间戳，是日期加时间

-- EXTRACT 截取日期函数（日期元素 FROM 日期）
SELECT CURRENT_TIMESTAMP
  EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
  EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
  EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
  EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
  EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
  EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;
-- 获取年，月，日，时，分，秒
-- SQL SERVER 不能使用这个函数

-- 转换函数
-- 类型转换和值的转换
-- CAST 类型转换（转换前的值 AS 想要转换的数据类型）
SELECT CAST('0001' AS INTEGER) AS int_col;

SELECT CAST('2019-10-21' AS DATE) AS date_col;

-- 类型转换其实并不是为了方便用户使用而开发 的功能，而是为了方便 DBMS 内部处理而开发的功能。

-- COALESCE 将 NULL 转为其他值(数据1， 数据2， 数据3) 返回参数中第一个不是 NULL 的值
SELECT COALESCE(NULL, 'abc') AS col_1,
  COALESCE(NULL, '123', NULL) AS col_2,
  COALESCE(NULL, NULL, '2012-02-12') AS col_3;

-- 实际应用中，可以找出一并含有 NULL 的列
SELECT COALESCE(str2, 'NULL') AS str_col FROM SampleStr;
