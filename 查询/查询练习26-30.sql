-- 26. 查询"计算机系"与"电子工程系"不相同职称教师的 teacher_name 和 prof
-- 题意不是很清楚，这题不强求
select * from teacher WHERE depart="计算机系" AND prof NOT IN (
select prof from teacher WHERE depart="电子工程系");

mysql> select * from teacher WHERE depart="计算机系" AND prof NOT IN (
    -> select prof from teacher WHERE depart="电子工程系");
+------------+--------------+-------------+---------------------+--------+----------+
| teacher_no | teacher_name | teacher_sex | teacher_birth       | prof   | depart   |
+------------+--------------+-------------+---------------------+--------+----------+
| 804        | 李诚         | 男          | 1958-12-02 00:00:00 | 副教授 | 计算机系 |
+------------+--------------+-------------+---------------------+--------+----------+
1 row in set (0.12 sec)

-- 27. 查询课程号 "3-105" 比课程号 "3-245" 成绩高的同学的
-- course_no, student_no, degree，并按照 degree 从高到低排序
-- 1). 先观察 "3-105", "3-245" 学生的得分情况
select * from score2 WHERE course_no IN ('3-245', '3-105');

mysql> select * from score2 WHERE course_no IN ('3-245', '3-105');
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 101        | 3-105     |     90 |
| 102        | 3-105     |     91 |
| 103        | 3-105     |     92 |
| 103        | 3-245     |     86 |
| 104        | 3-105     |     89 |
| 105        | 3-105     |     88 |
| 105        | 3-245     |     75 |
| 109        | 3-105     |     76 |
| 109        | 3-245     |     68 |
+------------+-----------+--------+
9 rows in set (0.00 sec)

-- 2). "3-105" 大于 "3-245" 中任意一个分数就行
select * from score2 WHERE course_no='3-105' AND degree>
ANY(select degree from score2 WHERE course_no='3-245');


-- 3). 从高到低排序
select * from score2 WHERE course_no='3-105' AND degree>
ANY(select degree from score2 WHERE course_no='3-245')
ORDER BY degree DESC;

mysql> select * from score2 WHERE course_no='3-105' AND degree>
    -> ANY(select degree from score2 WHERE course_no='3-245')
    -> ORDER BY degree DESC;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 102        | 3-105     |     91 |
| 101        | 3-105     |     90 |
| 104        | 3-105     |     89 |
| 105        | 3-105     |     88 |
| 109        | 3-105     |     76 |
+------------+-----------+--------+
6 rows in set (0.00 sec)


-- 28. 查询选修课程 "3-105" 且成绩高于课程 "3-245" 的同学的 course_no, student_no, degree
-- 且：比 "3-245" 中任何一个都大（怎么解释随他说吧）
select * from score2 WHERE course_no='3-105' AND degree>
ALL(select degree from score2 WHERE course_no='3-245')
ORDER BY degree DESC;

mysql> select * from score2 WHERE course_no='3-105' AND degree>
    -> ALL(select degree from score2 WHERE course_no='3-245')
    -> ORDER BY degree DESC;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 102        | 3-105     |     91 |
| 101        | 3-105     |     90 |
| 104        | 3-105     |     89 |
| 105        | 3-105     |     88 |
+------------+-----------+--------+
5 rows in set (0.00 sec)


-- 29. 查询所有教师和同学的 name, sex, birth
select teacher_name, teacher_sex, teacher_birth from teacher;
select student_name, student_sex, student_birth from student;

-- 用 UNION 将两个表合在一起
select teacher_name, teacher_sex, teacher_birth from teacher
UNION
select student_name, student_sex, student_birth from student;

mysql> select teacher_name, teacher_sex, teacher_birth from teacher
    -> UNION
    -> select student_name, student_sex, student_birth from student;
+--------------+-------------+---------------------+
| teacher_name | teacher_sex | teacher_birth       |
+--------------+-------------+---------------------+
| 李诚         | 男          | 1958-12-02 00:00:00 |
| 王萍         | 女          | 1972-05-05 00:00:00 |
| 刘冰         | 女          | 1977-08-14 00:00:00 |
| 张旭         | 男          | 1969-03-12 00:00:00 |
| 曾华         | 男          | 1977-09-01 00:00:00 |
| 匡明         | 男          | 1975-10-02 00:00:00 |
| 王丽         | 女          | 1976-01-23 00:00:00 |
| 李军         | 男          | 1976-02-20 00:00:00 |
| 王芳         | 女          | 1975-02-10 00:00:00 |
| 陆君         | 男          | 1974-06-03 00:00:00 |
| 王尼玛       | 男          | 1976-02-20 00:00:00 |
| 张全蛋       | 女          | 1975-02-10 00:00:00 |
| 赵铁柱       | 男          | 1974-06-03 00:00:00 |
| 张飞         | 男          | 1974-06-03 00:00:00 |
+--------------+-------------+---------------------+
14 rows in set (0.08 sec)

-- 由于上面的类名都是 teacher 相关，需要重命名，用as
select teacher_name as name, teacher_sex as sex, teacher_birth as birth from teacher
UNION select student_name, student_sex, student_birth from student;

mysql> select teacher_name as name, teacher_sex as sex, teacher_birth as birth from teacher
    -> UNION select student_name, student_sex, student_birth from student;
+--------+-----+---------------------+
| name   | sex | birth               |
+--------+-----+---------------------+
| 李诚   | 男  | 1958-12-02 00:00:00 |
| 王萍   | 女  | 1972-05-05 00:00:00 |
| 刘冰   | 女  | 1977-08-14 00:00:00 |
| 张旭   | 男  | 1969-03-12 00:00:00 |
| 曾华   | 男  | 1977-09-01 00:00:00 |
| 匡明   | 男  | 1975-10-02 00:00:00 |
| 王丽   | 女  | 1976-01-23 00:00:00 |
| 李军   | 男  | 1976-02-20 00:00:00 |
| 王芳   | 女  | 1975-02-10 00:00:00 |
| 陆君   | 男  | 1974-06-03 00:00:00 |
| 王尼玛 | 男  | 1976-02-20 00:00:00 |
| 张全蛋 | 女  | 1975-02-10 00:00:00 |
| 赵铁柱 | 男  | 1974-06-03 00:00:00 |
| 张飞   | 男  | 1974-06-03 00:00:00 |
+--------+-----+---------------------+
14 rows in set (0.00 sec)


-- 30. 查询所有女教师和女同学的 name, sex, birth
select teacher_name as name, teacher_sex as sex, teacher_birth as birth 
from teacher WHERE teacher_sex='女'
UNION select student_name, student_sex, student_birth 
from student WHERE student_sex='女';

mysql> select teacher_name as name, teacher_sex as sex, teacher_birth as birth
    -> from teacher WHERE teacher_sex='女'
    -> UNION select student_name, student_sex, student_birth
    -> from student WHERE student_sex='女';
+--------+-----+---------------------+
| name   | sex | birth               |
+--------+-----+---------------------+
| 王萍   | 女  | 1972-05-05 00:00:00 |
| 刘冰   | 女  | 1977-08-14 00:00:00 |
| 王丽   | 女  | 1976-01-23 00:00:00 |
| 王芳   | 女  | 1975-02-10 00:00:00 |
| 张全蛋 | 女  | 1975-02-10 00:00:00 |
+--------+-----+---------------------+
5 rows in set (0.00 sec)