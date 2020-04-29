-- 1NF
-- 数据表中的所有字段都是不可分割的原子值

CREATE TABLE students2 (
  id int PRIMARY KEY,
  name VARCHAR(20),
  address VARCHAR(50)
);

INSERT INTO students2 VALUES(1, "ZHANGSAN", "Rd1 Block1");
INSERT INTO students2 VALUES(2, "LISI", "Rd2 Block2");
INSERT INTO students2 VALUES(3, "WANGWU", "Rd3 Block3");

mysql> select * from students2;
+----+----------+------------+
| id | name     | address    |
+----+----------+------------+
|  1 | ZHANGSAN | Rd1 Block1 |
|  2 | LISI     | Rd2 Block2 |
|  3 | WANGWU   | Rd3 Block3 |
+----+----------+------------+
3 rows in set (0.00 sec)

-- 字段值还可以继续拆分的，就不满足第一范式
CREATE TABLE students3 (
  id int PRIMARY KEY,
  name VARCHAR(20),
  country VARCHAR(30),
  provience VARCHAR(30),
  city VARCHAR(30),
  remark VARCHAR(30)
);

INSERT INTO students3 VALUES(1, "ZHANGSAN", "CHINA", "SICHUAN PROVIENCE", "CHENGDU", "Rd1 Block1");
INSERT INTO students3 VALUES(2, "LISI", "CHINA", "SICHUAN PROVIENCE", "CHENGDU", "Rd2 Block2");
INSERT INTO students3 VALUES(3, "WANGWU", "CHINA", "SICHUAN PROVIENCE", "CHENGDU", "Rd3 Block3");

mysql> select * from students3;
+----+----------+---------+-------------------+---------+------------+
| id | name     | country | provience         | city    | remark     |
+----+----------+---------+-------------------+---------+------------+
|  1 | ZHANGSAN | CHINA   | SICHUAN PROVIENCE | CHENGDU | Rd1 Block1 |
|  2 | LISI     | CHINA   | SICHUAN PROVIENCE | CHENGDU | Rd2 Block2 |
|  3 | WANGWU   | CHINA   | SICHUAN PROVIENCE | CHENGDU | Rd3 Block3 |
+----+----------+---------+-------------------+---------+------------+
3 rows in set (0.00 sec)

-- 范式设计的越详细，对于某些实际操作有好有坏，根据需求来定

