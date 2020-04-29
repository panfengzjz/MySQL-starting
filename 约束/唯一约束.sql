-- ΨһԼ��
mysql> use test
Database changed
mysql> CREATE TABLE user (
    ->  id int,
    ->  name VARCHAR(20)
    -> );
Query OK, 0 rows affected (0.40 sec)

mysql> ALTER TABLE user add UNIQUE(name);
Query OK, 0 rows affected (0.38 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.13 sec)

INSERT INTO user VALUES(1,"����");
INSERT INTO user VALUES(2,"����");

mysql> INSERT INTO user VALUES(1,"����");
Query OK, 1 row affected (0.20 sec)

mysql> INSERT INTO user VALUES(2,"����");
ERROR 1062 (23000): Duplicate entry '����' for key 'name'

CREATE TABLE user2 (
    id int,
    name VARCHAR(20),
	UNIQUE(id, name)
);
CREATE TABLE user2 (
    id int,
    name VARCHAR(20) UNIQUE
);

-- ΨһԼ������Ϊ�գ�����Լ������
-- ɾ��ΨһԼ��
ALTER TABLE user2 DROP INDEX name;
-- ���ΨһԼ��
ALTER TABLE user2 MODIFY name VARCHAR(20) UNIQUE;


