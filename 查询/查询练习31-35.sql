-- 31. 查询成绩比该课程平均分低的同学的成绩表
select course_no, avg(degree) from score2 GROUP BY course_no;

mysql> select course_no, avg(degree) from score2 GROUP BY course_no;
+-----------+-------------+
| course_no | avg(degree) |
+-----------+-------------+
| 3-105     |     87.6667 |
| 3-245     |     76.3333 |
| 6-166     |     81.6667 |
+-----------+-------------+
3 rows in set (0.10 sec)

-- 假装 score2 表有相同的 A表和 B表
select * from score2 A WHERE degree<(
select avg(degree) from score2 B WHERE A.course_no=B.course_no);

mysql> select * from score2 A WHERE degree<(
    -> select avg(degree) from score2 B WHERE A.course_no=B.course_no);
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 105        | 3-245     |     75 |
| 105        | 6-166     |     79 |
| 109        | 3-105     |     76 |
| 109        | 3-245     |     68 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
5 rows in set (0.10 sec)


-- 32. 查询所有任课老师的 teacher_name 和 depart
-- 课程表里有课的教师，都属于任课老师
select teacher_name, depart from teacher WHERE teacher_no IN (
select teacher_no from course);

mysql> select teacher_name, depart from teacher WHERE teacher_no IN (
    -> select teacher_no from course);
+--------------+------------+
| teacher_name | depart     |
+--------------+------------+
| 李诚         | 计算机系   |
| 王萍         | 计算机系   |
| 刘冰         | 电子工程系 |
| 张旭         | 电子工程系 |
+--------------+------------+
4 rows in set (0.08 sec)


-- 33. 查询至少有2名男生的班号
select class_no from student WHERE student_sex='男'
GROUP BY class_no HAVING COUNT(*) > 1;

mysql> select class_no from student WHERE student_sex='男'
    -> GROUP BY class_no HAVING COUNT(*) > 1;
+----------+
| class_no |
+----------+
| 95033    |
| 95031    |
+----------+
2 rows in set (0.00 sec)


-- 34. 查询 student 表中不姓王的同学记录
select * from student WHERE student_name NOT LIKE '王%';

mysql> select * from student WHERE student_name NOT LIKE '王%';
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | 曾华         | 男          | 1977-09-01 00:00:00 | 95033    |
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 104        | 李军         | 男          | 1976-02-20 00:00:00 | 95033    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
| 110        | 张飞         | 男          | 1974-06-03 00:00:00 | 95038    |
+------------+--------------+-------------+---------------------+----------+
7 rows in set (0.03 sec)


-- 35. 查询 student 表中每个学生的姓名和年龄
select YEAR(NOW());
mysql> select YEAR(NOW());
+-------------+
| YEAR(NOW()) |
+-------------+
|        2020 |
+-------------+
1 row in set (0.06 sec)

select YEAR(student_birth) from student;
mysql> select YEAR(student_birth) from student;
+---------------------+
| YEAR(student_birth) |
+---------------------+
|                1977 |
|                1975 |
|                1976 |
|                1976 |
|                1975 |
|                1974 |
|                1976 |
|                1975 |
|                1974 |
|                1974 |
+---------------------+
10 rows in set (0.00 sec)

select student_name, YEAR(NOW())-YEAR(student_birth) as age from student;

mysql> select student_name, YEAR(NOW())-YEAR(student_birth) as age from student;

+--------------+------+
| student_name | age  |
+--------------+------+
| 曾华         |   43 |
| 匡明         |   45 |
| 王丽         |   44 |
| 李军         |   44 |
| 王芳         |   45 |
| 陆君         |   46 |
| 王尼玛       |   44 |
| 张全蛋       |   45 |
| 赵铁柱       |   46 |
| 张飞         |   46 |
+--------------+------+
10 rows in set (0.06 sec)

