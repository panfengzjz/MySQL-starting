-- 16. 查询所有学生的 student_name, course_name, degree 列
select student_name, course_name, degree from student, course, score
WHERE student.student_no=score.student_no 
AND course.course_no=score.course_no;

mysql> select student_name, course_name, degree from student, course, score
    -> WHERE student.student_no=score.student_no
    -> AND course.course_no=score.course_no;
+--------------+-------------+--------+
| student_name | course_name | degree |
+--------------+-------------+--------+
| 王丽         | 计算机导论  |     92 |
| 王丽         | 操作系统    |     86 |
| 王丽         | 数字电路    |     85 |
| 王芳         | 计算机导论  |     88 |
| 王芳         | 操作系统    |     75 |
| 王芳         | 数字电路    |     79 |
| 赵铁柱       | 计算机导论  |     76 |
| 赵铁柱       | 操作系统    |     68 |
| 赵铁柱       | 数字电路    |     81 |
+--------------+-------------+--------+
9 rows in set (0.00 sec)


-- 17. 查询 '95031' 班学生每门课的平均分
-- 1). 首先查看 '95031' 班有那些学生
select * from student WHERE class_no='95031';
mysql> select * from student WHERE class_no='95031';
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
5 rows in set (0.00 sec)

-- 2). 根据学生名字，去 score 表中找出对应的 degree
-- student_no 直接用第一步得到的数据
select * from score WHERE student_no IN
(select student_no from student WHERE class_no='95031');
mysql> select * from score WHERE student_no IN
    -> (select student_no from student WHERE class_no='95031');
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 105        | 3-105     |     88 |
| 105        | 3-245     |     75 |
| 105        | 6-166     |     79 |
| 109        | 3-105     |     76 |
| 109        | 3-245     |     68 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
6 rows in set (0.08 sec)

-- 3). 用 GROUP BY 计算课程的平均值
select course_no, AVG(degree) from score WHERE student_no IN
(select student_no from student WHERE class_no='95031')
GROUP BY course_no;
mysql> select course_no, AVG(degree) from score WHERE student_no IN
    -> (select student_no from student WHERE class_no='95031')
    -> GROUP BY course_no;
+-----------+-------------+
| course_no | AVG(degree) |
+-----------+-------------+
| 3-105     |     82.0000 |
| 3-245     |     71.5000 |
| 6-166     |     80.0000 |
+-----------+-------------+
3 rows in set (0.04 sec)


-- 18. 查询选修 "3-105" 课程的成绩高于学号109同学 "3-105" 成绩的所有同学记录
-- 1). 首先拿出109号同学 "3-105" 课程成绩
select degree from score WHERE student_no='109' AND course_no='3-105';
mysql> select degree from score WHERE student_no='109' AND course_no='3-105';
+--------+
| degree |
+--------+
|     76 |
+--------+
1 row in set (0.00 sec)

-- 2). 再找出 score 表中所有成绩大于76的记录
select * from score WHERE course_no='3-105' AND degree >
(select degree from score WHERE student_no='109' AND course_no='3-105');

mysql> select * from score WHERE course_no='3-105' AND degree >
    -> (select degree from score WHERE student_no='109' AND course_no='3-105');
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 105        | 3-105     |     88 |
+------------+-----------+--------+
2 rows in set (0.00 sec)


-- 19. 查询成绩高于学号109、课程号 "3-105" 成绩的所有记录
-- 将18题的 course_no="3-105" 条件去掉即可
select * from score WHERE degree >
(select degree from score WHERE student_no='109' AND course_no='3-105');
mysql> select * from score WHERE degree >
    -> (select degree from score WHERE student_no='109' AND course_no='3-105');
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 103        | 3-245     |     86 |
| 103        | 6-166     |     85 |
| 105        | 3-105     |     88 |
| 105        | 6-166     |     79 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
6 rows in set (0.00 sec)


-- 20. 查询和学号108、101同学同年出生的所有学生的 student_no, student_name, student_birth 列
select YEAR(student_birth) from student WHERE student_no IN ('101', '108');
mysql> select YEAR(student_birth) from student WHERE student_no IN ('101', '108');
+---------------------+
| YEAR(student_birth) |
+---------------------+
|                1977 |
|                1975 |
+---------------------+
2 rows in set (0.03 sec)

select * from student WHERE YEAR(student_birth) IN (
select YEAR(student_birth) from student WHERE student_no IN ('101', '108'));
mysql> select * from student WHERE YEAR(student_birth) IN (
    -> select YEAR(student_birth) from student WHERE student_no IN ('101', '108'));
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | 曾华         | 男          | 1977-09-01 00:00:00 | 95033    |
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
4 rows in set (0.00 sec)