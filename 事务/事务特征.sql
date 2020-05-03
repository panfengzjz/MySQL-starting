-- MYSQL 事务
-- 事务是一个最小不可分割的工作单元。事务能保证一个业务的完整性
-- 比如银行转账
-- a -> -100
-- UPDATE user SET money=money-100 WHERE name='a';
-- b -> +100
-- UPDATE user SET money=money+100 WHERE name='b';

-- 实际程序中，如果只有一条语句执行成功而另一条没成功，可能会出现前后数据不一致
-- 多条语句要么同时成功，要么同时失败

-- MYSQL 中如何控制事务
-- 1. MYSQL 默认开启事务
mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)

-- 默认开启事务的作用是什么？
-- 执行 SQL 语句的时候，效果会立即体现出来，且不能回滚

CREATE DATABASE bank;

CREATE TABLE user (
  id int PRIMARY KEY,
  name VARCHAR(20),
  money int
);

INSERT INTO user VALUES(1, "a", 1000);

-- 事务回滚，即撤销 SQL 语句执行效果
-- 但是由于 autocommit=1，每一次执行的效果均已经产生，不能回滚
ROLLBACK;

mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)

-- 想要让回滚有效，autocommit 需要为0
SET autocommit=0;

mysql> SET autocommit=0;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            0 |
+--------------+
1 row in set (0.00 sec)

-- 再插入一条新的数据
INSERT INTO user VALUES(2, "b", 1000);

mysql> INSERT INTO user VALUES(2, "b", 1000);
Query OK, 1 row affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.07 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)


-- 在插入数据之后，手动提交数据，ROLLBACK 才会无效
COMMIT;



-- 手动开启事务
BEGIN-END;
START TRANSACTION;

UPDATE user SET money=money-100 WHERE name='a';
UPDATE user SET money=money+100 WHERE name='b';

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)


-- 如果执行之前选择 BEGIN 再执行
-- START TRANSACTION 效果也一样
-- 要让数据生效，输入 COMMIT 就行
BEGIN;
UPDATE user SET money=money-100 WHERE name='a';
UPDATE user SET money=money+100 WHERE name='b';

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.04 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)




-- 事务的四大特征：
-- A 原子性：事务是最小单位，不可分割
-- C 一致性：事务要求同一事务中的 SQL 语句，必须保证同时成功或失败
-- I 隔离性：事务1和事务2之间是具有隔离性的
-- D 持久性：事务一旦结束（COMMIT, ROLLBACK），就不可以返回

-- 事务开启：
-- 1. 修改默认提交 SET autocommit=0;
-- 2. BEGIN;
-- 3. START TRANSACTION;

-- 事务手动提交
-- COMMENT;
-- 事务手动回滚
-- ROLLBACK;