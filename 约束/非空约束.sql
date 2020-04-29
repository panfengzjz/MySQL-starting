-- 非空约束
-- 修饰的字段不能为空

CREATE TABLE user3 (
    id int,
	name VARCHAR(20) NOT NULL
);

mysql> CREATE TABLE user3 (
    ->  id int,
    ->  name VARCHAR(20) NOT NULL
    -> );
Query OK, 0 rows affected (0.34 sec)

mysql> desc user3
    -> ;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

INSERT INTO user3 (id) VALUES(1);
mysql> INSERT INTO user3 (id) VALUES(1);
ERROR 1364 (HY000): Field 'name' does not have a default value

mysql> INSERT INTO user3 VALUES(1, "zhangsan");
Query OK, 1 row affected (0.20 sec)

mysql> INSERT INTO user3 (name) VALUES("lisi");
Query OK, 1 row affected (0.08 sec)

mysql> select * from user3;
+------+----------+
| id   | name     |
+------+----------+
|    1 | zhangsan |
| NULL | lisi     |
+------+----------+
2 rows in set (0.00 sec)
