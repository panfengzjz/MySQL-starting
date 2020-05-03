-- 事物的隔离性
-- 1. READ UNCOMMITTED  读未提交的
-- 2. READ COMMITTED    读已经提交的
-- 3. REPEATABLE READ   可以重复读
-- 4. SERIALIZABLE      串行化

-- 1. READ UNCOMMITTED
-- 现有事务1和事务2
-- 事务1对数据进行操作，在操作的过程中，事务没有被提交
-- 不过事务2可以看到事务1操作的结果

INSERT INTO user VALUES(3, "小明", 1000);
INSERT INTO user VALUES(4, "淘宝店", 1000);


-- 如何查看数据库的隔离级别
select @@GLOBAL.TRANSACTION_ISOLATION; -- 系统级别
select @@TRANSACTION_ISOLATION;        -- 会话级别


mysql> select @@GLOBAL.TRANSACTION_ISOLATION;
+--------------------------------+
| @@GLOBAL.TRANSACTION_ISOLATION |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)

-- 如何修改数据库的隔离级别
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; -- 修改会失败
SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

mysql> SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@GLOBAL.TRANSACTION_ISOLATION;
+--------------------------------+
| @@GLOBAL.TRANSACTION_ISOLATION |
+--------------------------------+
| READ-UNCOMMITTED                 |
+--------------------------------+
1 row in set (0.00 sec)


-- 小明在淘宝店买鞋子，800块钱
-- 小明在成都ATM机转账，淘宝店在广州ATM机收钱

START TRANSACTION;
UPDATE user SET money=money-800 WHERE name="小明";
UPDATE user SET money=money+800 WHERE name="淘宝店";

-- 但是小明可以用 ROLLBACK 取消这次的交易
-- 广州的淘宝店却可能认为交易已经达成，他读到了未提交的数据（脏读）
-- 脏读：一个事务读到了另一个事务未提交的数据。实际开发不允许出现脏读



-- 2. READ COMMITTED
-- 修改隔离级别为 READ-COMMITTED
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- 两个银行柜员同时对一个数据库进行操作
-- 一旦柜员1做了些修改并提交，柜员2操作的时候也会出现一些问题
-- 因此 READ-COMMITTED 也会出现问题



-- 3. REPEATABLE READ
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- 幻读：事务1和事务2同时操作一张表，事务1提交的数据，不能被事务2读到，就造成幻读



-- 4. SERIALIZABLE
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- 在 user 表被另一个事务操作时，其他事务里的写操作无法进行
-- 进入排队状态，只有在前面的写操作结束时，才会从排队的写操作中继续执行
-- 串行化的问题是性能差
-- 隔离级别越高，性能越差


