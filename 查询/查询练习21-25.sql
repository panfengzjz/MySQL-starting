-- 21. 查询"张旭"教师任课的学生成绩
-- 1). 找到"张旭"教师的 teacher_no
select teacher_no, teacher_name from teacher WHERE teacher_name='张旭';
mysql> select teacher_no, teacher_name from teacher WHERE teacher_name='张旭';
+------------+--------------+
| teacher_no | teacher_name |
+------------+--------------+
| 856        | 张旭         |
+------------+--------------+
1 row in set (0.07 sec)

-- 2). 根据 teacher_no 找到 course_no
select course_no from course WHERE teacher_no=(
select teacher_no from teacher WHERE teacher_name='张旭');
mysql> select course_no from course WHERE teacher_no=(
    -> select teacher_no from teacher WHERE teacher_name='张旭');
+-----------+
| course_no |
+-----------+
| 6-166     |
+-----------+
1 row in set (0.02 sec)

-- 3). 根据 course_no 在 score 表中找出学生成绩
select * from score WHERE course_no=(
select course_no from course WHERE teacher_no=(
select teacher_no from teacher WHERE teacher_name='张旭'));

mysql> select * from score WHERE course_no=(
    -> select course_no from course WHERE teacher_no=(
    -> select teacher_no from teacher WHERE teacher_name='张旭'));
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 6-166     |     85 |
| 105        | 6-166     |     79 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
3 rows in set (0.00 sec)


-- 22. 查询选修某课程的同学人数多于5人的教师姓名
-- 1). 查看 score 表中的内容发现，当前没有一门课的选修学生>5
mysql> select * from score;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 103        | 3-245     |     86 |
| 103        | 6-166     |     85 |
| 105        | 3-105     |     88 |
| 105        | 3-245     |     75 |
| 105        | 6-166     |     79 |
| 109        | 3-105     |     76 |
| 109        | 3-245     |     68 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
9 rows in set (0.00 sec)
-- 需要插入一些新的数据
-- 为了避免与之前的题目混淆，新建一个 score2 表格

INSERT INTO score2 VALUES ('103', '3-245', '86');
INSERT INTO score2 VALUES ('105', '3-245', '75');
INSERT INTO score2 VALUES ('109', '3-245', '68');
INSERT INTO score2 VALUES ('103', '3-105', '92');
INSERT INTO score2 VALUES ('105', '3-105', '88');
INSERT INTO score2 VALUES ('109', '3-105', '76');
INSERT INTO score2 VALUES ('103', '6-166', '85');
INSERT INTO score2 VALUES ('105', '6-166', '79');
INSERT INTO score2 VALUES ('109', '6-166', '81');

INSERT INTO score2 VALUES ('101', '3-105', '90');
INSERT INTO score2 VALUES ('102', '3-105', '91');
INSERT INTO score2 VALUES ('104', '3-105', '89');

-- 2). 现在在 score2 表格中查找选课人数大于5的课
select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5;
mysql> select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5;
+-----------+
| course_no |
+-----------+
| 3-105     |
+-----------+
1 row in set (0.00 sec)

-- 3). 根据已有的 course_no 在 course 表中查询 teacher_no
select teacher_no from course WHERE course_no=(
select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5);
mysql> select teacher_no from course WHERE course_no=(
    -> select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5);
+------------+
| teacher_no |
+------------+
| 825        |
+------------+
1 row in set (0.09 sec)

-- 4). 根据已有的 teacher_no 在 teacher 表中查询 teacher_name
select teacher_name from teacher WHERE teacher_no=(
select teacher_no from course WHERE course_no=(
select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5));

mysql> select teacher_name from teacher WHERE teacher_no=(
    -> select teacher_no from course WHERE course_no=(
    -> select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5));
+--------------+
| teacher_name |
+--------------+
| 王萍         |
+--------------+
1 row in set (0.00 sec)


-- 23. 查询 95033, 95031 班全体学生的记录
select * from student WHERE class_no IN ('95033', '95031');
mysql> select * from student WHERE class_no IN ('95033', '95031');
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | 曾华         | 男          | 1977-09-01 00:00:00 | 95033    |
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 103        | 王丽         | 女          | 1976-01-23 00:00:00 | 95033    |
| 104        | 李军         | 男          | 1976-02-20 00:00:00 | 95033    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 107        | 王尼玛       | 男          | 1976-02-20 00:00:00 | 95033    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
9 rows in set (0.03 sec)

-- 由于当前数据表中只有 95031, 95033 两个班，为了避免投机，再插入一条数据
INSERT INTO student VALUES ('110', '张飞', '男', '1974-06-03', '95038');


-- 24. 查询存在85分以上成绩的课程号
select course_no, degree from score2 WHERE degree>85;
mysql> select course_no, degree from score2 WHERE degree>85;
+-----------+--------+
| course_no | degree |
+-----------+--------+
| 3-105     |     90 |
| 3-105     |     91 |
| 3-105     |     92 |
| 3-245     |     86 |
| 3-105     |     89 |
| 3-105     |     88 |
+-----------+--------+
6 rows in set (0.00 sec)


-- 25. 查询"计算机系"教师所教课程的成绩表
-- 1) 根据"计算机系"找出 teacher_no
select teacher_no from teacher WHERE depart='计算机系'; 

-- 2) 根据 teacher_no 找出 course_no
select course_no from course WHERE teacher_no IN (
select teacher_no from teacher WHERE depart='计算机系');

-- 3) 根据 course_no 找出成绩表
select * from score WHERE course_no IN (
select course_no from course WHERE teacher_no IN (
select teacher_no from teacher WHERE depart='计算机系'));

mysql> select * from score WHERE course_no IN (
    -> select course_no from course WHERE teacher_no IN (
    -> select teacher_no from teacher WHERE depart='计算机系'));
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-245     |     86 |
| 105        | 3-245     |     75 |
| 109        | 3-245     |     68 |
| 103        | 3-105     |     92 |
| 105        | 3-105     |     88 |
| 109        | 3-105     |     76 |
+------------+-----------+--------+
6 rows in set (0.00 sec)