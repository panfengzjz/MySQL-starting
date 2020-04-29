-- 外键约束
-- 涉及到两个表：父表&子表

CREATE TABLE classes (
  id int PRIMARY KEY,
  name VARCHAR(20)
);

CREATE TABLE students (
  id int PRIMARY KEY,
  name VARCHAR(20),
  class_id int,
  FOREIGN KEY(class_id) REFERENCES classes(id)
);

mysql> CREATE TABLE classes (
    ->   id int PRIMARY KEY,
    ->   name VARCHAR(20)
    -> );
Query OK, 0 rows affected (0.28 sec)

mysql> CREATE TABLE students (
    ->   id int PRIMARY KEY,
    ->   name VARCHAR(20),
    ->   class_id int,
    ->   FOREIGN KEY(class_id) REFERENCES classes(id)
    -> );
Query OK, 0 rows affected (0.25 sec)

mysql> desc classes;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> desc students;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int(11)     | NO   | PRI | NULL    |       |
| name     | varchar(20) | YES  |     | NULL    |       |
| class_id | int(11)     | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

INSERT INTO classes VALUES (1, "class one");
INSERT INTO classes VALUES (2, "class two");
INSERT INTO classes VALUES (3, "class three");
INSERT INTO classes VALUES (4, "class four");

mysql> select * from classes;
+----+-------------+
| id | name        |
+----+-------------+
|  1 | class one   |
|  2 | class two   |
|  3 | class three |
|  4 | class four  |
+----+-------------+
4 rows in set (0.00 sec)

INSERT INTO students VALUES (1001, "ZHANGSAN", 1);
INSERT INTO students VALUES (2001, "ZHANGSAN", 2);
INSERT INTO students VALUES (3001, "ZHANGSAN", 3);
INSERT INTO students VALUES (4001, "ZHANGSAN", 4);
-- 以上均能顺利插入

-- 五班在 classes 表中不存在，插入会报错
INSERT INTO students VALUES (5001, "ZHANGSAN", 5);

mysql> INSERT INTO students VALUES (5001, "ZHANGSAN", 5);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))

-- 父表中被子表引用的记录，是不可以被删除的
DELETE FROM classes WHERE id=4;

mysql> DELETE FROM classes WHERE id=4;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))


