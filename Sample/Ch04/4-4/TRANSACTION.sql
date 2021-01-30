-- 第四章 事务 4-4

/*
 * 事务是需要在同一个处理单元中执行的一系列更新处理的集合。通过使用 事务，可以对数据库中的数据更新处理的提交和取消进行管理。
 * 事务处理的终止指令包括COMMIT(提交处理)和ROLLBACK(取消处 理)两种。
 * DBMS的事务具有原子性(Atomicity)、一致性(Consistency)、隔离性 (Isolation)和持久性(Durability)四种特性。通常将这四种特性的首字母
结合起来，统称为 ACID 特性。
 */

UPDATE Product
  SET sale_price = sale_price - 1000
  WHERE prodcut_name = '运动T';

UPDATE Product
  SET sale_price = sale_price + 1000
  WHERE prodcut_name = 'T恤';

-- 事务是需要在同一个处理单元中执行的一系列更新处理的集合

-- 开始事务的语句目前并不通用，不过大致有以下几种
-- BEGIN TRANSACTION
-- START TRANSACTION

-- PostgreSQL/ SQL Server
BEGIN TRANSACTION

  UPDATE Product
    SET sale_price = sale_price - 1000
    WHERE prodcut_name = '运动T';

  UPDATE Product
    SET sale_price = sale_price + 1000
    WHERE prodcut_name = 'T恤';

COMMIT;

-- MySQL
START TRANSACTION

  UPDATE Product
    SET sale_price = sale_price - 1000
    WHERE prodcut_name = '运动T';

  UPDATE Product
    SET sale_price = sale_price + 1000
    WHERE prodcut_name = 'T恤';

COMMIT;

-- DB2/Oracle
UPDATE Product
  SET sale_price = sale_price - 1000
  WHERE prodcut_name = '运动T';

UPDATE Product
  SET sale_price = sale_price + 1000
  WHERE prodcut_name = 'T恤';

COMMIT;

-- 而结束的语句是通用的 使用 COMMIT

-- ROLLBACK 取消处理

-- PostgreSQL/ SQL Server
BEGIN TRANSACTION

  UPDATE Product
    SET sale_price = sale_price - 1000
    WHERE prodcut_name = '运动T';

  UPDATE Product
    SET sale_price = sale_price + 1000
    WHERE prodcut_name = 'T恤';

ROLLBACK;

-- ACID 特性
-- 原子性
-- 事务的所有内容要么全部执行，要么全部不执行
-- 一致性(完整性)
-- 事务中执行的语句要满足数据库所设置的约束,如主键约束或者 NOT NULL 约束
-- 隔离性
-- 不同事务时间互不干扰
-- 如果有一个事务插入了记录，但在该事务结束之前，其他事务是不可见这条记录的
-- 持久性（耐久性）
-- 事务在不管提交还是回滚结束后，DBMS 能够保证该时间点的数据状态会被保存的特性
-- 通过不同手段来保证事务的准确性，例如保存到硬盘
