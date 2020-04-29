-- 36. 查询 student 表中最大和最小的 student_birth 日期
select MAX(student_birth) as '最大', MIN(student_birth) as '最小' from student;

mysql> select MAX(student_birth) as '最大', MIN(student_birth) as '最小' from student;
+---------------------+---------------------+
| 最大                | 最小                |
+---------------------+---------------------+
| 1977-09-01 00:00:00 | 1974-06-03 00:00:00 |
+---------------------+---------------------+
1 row in set (0.04 sec)


-- 37. 以班号和年龄从大到小的顺序查询 student 表中的所有记录
select * from student ORDER BY class_no DESC, student_birth;

mysql> select * from student ORDER BY class_no DESC, student_birth;
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 110        | 张飞         | 男          | 1974-06-03 00:00:00 | 95038    |
| 103        | 王丽         | 女          | 1976-01-23 00:00:00 | 95033    |
| 104        | 李军         | 男          | 1976-02-20 00:00:00 | 95033    |
| 107        | 王尼玛       | 男          | 1976-02-20 00:00:00 | 95033    |
| 101        | 曾华         | 男          | 1977-09-01 00:00:00 | 95033    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
10 rows in set (0.00 sec)


-- 38. 查询男教师及其所上的课程
select teacher_no from teacher WHERE teacher_sex='男';

select * from course WHERE teacher_no IN (
select teacher_no from teacher WHERE teacher_sex='男');

mysql> select * from course WHERE teacher_no IN (
    -> select teacher_no from teacher WHERE teacher_sex='男');
+-----------+-------------+------------+
| course_no | course_name | teacher_no |
+-----------+-------------+------------+
| 3-245     | 操作系统    | 804        |
| 6-166     | 数字电路    | 856        |
+-----------+-------------+------------+
2 rows in set (0.00 sec)


-- 39. 查询最高分同学的 student_no, course_no, degree
select MAX(degree) from score2;

-- 因为 score2 表中只有 student_no, course_no, degree 三列，所以可以 select *
select * from score2 WHERE degree IN (
select MAX(degree) from score2);

mysql> select * from score2 WHERE degree IN (
    -> select MAX(degree) from score2);
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
+------------+-----------+--------+
1 row in set (0.07 sec)


-- 40. 查询和李军同性别的所有同学的 student_name
select student_sex from student WHERE student_name='李军';

select student_name from student WHERE student_sex=(
select student_sex from student WHERE student_name='李军');

mysql> select student_name from student WHERE student_sex=(
    -> select student_sex from student WHERE student_name='李军');
+--------------+
| student_name |
+--------------+
| 曾华         |
| 匡明         |
| 李军         |
| 陆君         |
| 王尼玛       |
| 赵铁柱       |
| 张飞         |
+--------------+
7 rows in set (0.00 sec)