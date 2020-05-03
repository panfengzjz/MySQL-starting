-- SQL 的四种连接查询

-- 内连接
-- INNER JOIN 或者 JOIN

-- 外连接
-- 左连接 LEFT JOIN 或者 LEFT OUTER JOIN
-- 右连接 RIGHT JOIN 或者 RIGHT OUTER JOIN
-- 完全外连接 FULL JOIN 或者 FULL OUTER JOIN

CREATE TABLE person (
  id int,
  name VARCHAR(20),
  cardId int
);

CREATE TABLE card (
  id int,
  name VARCHAR(20)
);

-- 插入 card 表数据
INSERT INTO card VALUES (1, "饭卡");
INSERT INTO card VALUES (2, "建行卡");
INSERT INTO card VALUES (3, "农行卡");
INSERT INTO card VALUES (4, "工商卡");
INSERT INTO card VALUES (5, "邮政卡");

-- 插入 person 表数据
INSERT INTO person VALUES (1, "张三", 1);
INSERT INTO person VALUES (2, "李四", 3);
INSERT INTO person VALUES (3, "王五", 6);

-- INNER JOIN 查询（内联查询）
-- 内联查询，就是两张表中的数据，通过某个字段相等，查询出相关记录的数据
select * from person INNER JOIN card ON person.cardId=card.id;
select * from person JOIN card ON person.cardId=card.id;

mysql> select * from person INNER JOIN card ON person.cardId=card.id;
+------+------+--------+------+--------+
| id   | name | cardId | id   | name   |
+------+------+--------+------+--------+
|    1 | 张三 |      1 |    1 | 饭卡   |
|    2 | 李四 |      3 |    3 | 农行卡 |
+------+------+--------+------+--------+
2 rows in set (0.00 sec)

-- LEFT JOIN（左外连接）
-- 左外连接会将左表所有数据取出来，右表有数据就填入，没数据就显示NULL
select * from person LEFT JOIN card ON person.cardId=card.id;
select * from person LEFT OUTER JOIN card ON person.cardId=card.id;

mysql> select * from person LEFT JOIN card ON person.cardId=card.id;
+------+------+--------+------+--------+
| id   | name | cardId | id   | name   |
+------+------+--------+------+--------+
|    1 | 张三 |      1 |    1 | 饭卡   |
|    2 | 李四 |      3 |    3 | 农行卡 |
|    3 | 王五 |      6 | NULL | NULL   |
+------+------+--------+------+--------+
3 rows in set (0.00 sec)

-- RIGHT JOIN（右外连接）
-- 右外连接会将右表所有数据取出来，左表有数据就填入，没数据就显示NULL
select * from person RIGHT JOIN card ON person.cardId=card.id;
select * from person RIGHT OUTER JOIN card ON person.cardId=card.id;

mysql> select * from person RIGHT JOIN card ON person.cardId=card.id;
+------+------+--------+------+--------+
| id   | name | cardId | id   | name   |
+------+------+--------+------+--------+
|    1 | 张三 |      1 |    1 | 饭卡   |
|    2 | 李四 |      3 |    3 | 农行卡 |
| NULL | NULL |   NULL |    2 | 建行卡 |
| NULL | NULL |   NULL |    4 | 工商卡 |
| NULL | NULL |   NULL |    5 | 邮政卡 |
+------+------+--------+------+--------+
5 rows in set (0.00 sec)

-- FULL JOIN（全外连接）
select * from person FULL JOIN card ON person.cardId=card.id;

-- MYSQL 不支持 FULL JOIN
mysql> select * from person FULL JOIN card ON person.cardId=card.id;
ERROR 1054 (42S22): Unknown column 'person.cardId' in 'on clause'

-- 要实现 FULL JOIN，要通过 UNION
select * from person LEFT JOIN card ON person.cardId=card.id
UNION
select * from person RIGHT JOIN card ON person.cardId=card.id;

mysql> select * from person LEFT JOIN card ON person.cardId=card.id
    -> UNION
    -> select * from person RIGHT JOIN card ON person.cardId=card.id;
+------+------+--------+------+--------+
| id   | name | cardId | id   | name   |
+------+------+--------+------+--------+
|    1 | 张三 |      1 |    1 | 饭卡   |
|    2 | 李四 |      3 |    3 | 农行卡 |
|    3 | 王五 |      6 | NULL | NULL   |
| NULL | NULL |   NULL |    2 | 建行卡 |
| NULL | NULL |   NULL |    4 | 工商卡 |
| NULL | NULL |   NULL |    5 | 邮政卡 |
+------+------+--------+------+--------+
6 rows in set (0.01 sec)
