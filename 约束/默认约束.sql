-- 默认约束
-- 插入字段值的时候，如果没有值，则填入默认值

CREATE TABLE user4 (
  id int,
  name VARCHAR(20),
  age int DEFAULT 10
);

mysql> CREATE TABLE user4 (
    ->   id int,
    ->   name VARCHAR(20),
    ->   age int DEFAULT 10
    -> );
Query OK, 0 rows affected (0.23 sec)

mysql> desc user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
| age   | int(11)     | YES  |     | 10      |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

INSERT INTO user4 (id, name) VALUES (1, "zhangsan");
INSERT INTO user4 VALUES (2, "lisi", 15);

mysql> INSERT INTO user4 (id, name) VALUES (1, "zhangsan");
Query OK, 1 row affected (0.16 sec)

mysql> INSERT INTO user4 VALUES (2, "lisi", 15);
Query OK, 1 row affected (0.03 sec)

mysql> select * from user4;
+------+----------+------+
| id   | name     | age  |
+------+----------+------+
|    1 | zhangsan |   10 |
|    2 | lisi     |   15 |
+------+----------+------+
2 rows in set (0.00 sec)
