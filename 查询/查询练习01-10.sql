-- 1. 查询 student 表的所有记录
select * from student;
mysql> select * from student;
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
9 rows in set (0.00 sec)

-- 2. 查询 student 表中所有记录的 student_name, student_sex, class_no 列
select student_name, student_sex, class_no from student;
mysql> select student_name, student_sex, class_no from student;
+--------------+-------------+----------+
| student_name | student_sex | class_no |
+--------------+-------------+----------+
| 曾华         | 男          | 95033    |
| 匡明         | 男          | 95031    |
| 王丽         | 女          | 95033    |
| 李军         | 男          | 95033    |
| 王芳         | 女          | 95031    |
| 陆君         | 男          | 95031    |
| 王尼玛       | 男          | 95033    |
| 张全蛋       | 女          | 95031    |
| 赵铁柱       | 男          | 95031    |
+--------------+-------------+----------+
9 rows in set (0.00 sec)

-- 3. 查询教师所有的单位即不重复的 depart 列
-- DISTINCT: 排除重复
select DISTINCT depart from teacher;
mysql> select DISTINCT depart from teacher;
+------------+
| depart     |
+------------+
| 计算机系   |
| 电子工程系 |
+------------+
2 rows in set (0.07 sec)

-- 4. 查询 score 表中成绩在 60-80 之间的所有记录
select * from score WHERE degree BETWEEN 60 AND 80;
mysql> select * from score WHERE degree BETWEEN 60 AND 80;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 105        | 3-245     |     75 |
| 105        | 6-166     |     79 |
| 109        | 3-105     |     76 |
| 109        | 3-245     |     68 |
+------------+-----------+--------+
4 rows in set (0.08 sec)

-- 也可以用运算符来表示范围
select * from score WHERE degree>=60 AND degree<=80;

-- 5. 查询 score 表中成绩为 85,86,88 的记录
select * from score WHERE degree IN (85,86,88);
mysql> select * from score WHERE degree IN (85,86,88);
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-245     |     86 |
| 103        | 6-166     |     85 |
| 105        | 3-105     |     88 |
+------------+-----------+--------+
3 rows in set (0.00 sec)

-- 6. 查询 student 表中 "95031" 班级或性别为女的同学记录
select * from student WHERE class_no='95031' OR student_sex='女';
mysql> select * from student WHERE class_no='95031' OR student_sex='女';
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 103        | 王丽         | 女          | 1976-01-23 00:00:00 | 95033    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
6 rows in set (0.00 sec)

-- 7. 以 class_no 降序查询 student 表的所有记录
select * from student ORDER BY class_no DESC;
mysql> select * from student ORDER BY class_no DESC;
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | 曾华         | 男          | 1977-09-01 00:00:00 | 95033    |
| 103        | 王丽         | 女          | 1976-01-23 00:00:00 | 95033    |
| 104        | 李军         | 男          | 1976-02-20 00:00:00 | 95033    |
| 107        | 王尼玛       | 男          | 1976-02-20 00:00:00 | 95033    |
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
9 rows in set (0.06 sec)

-- 升序（默认排序是升序）
select * from student ORDER BY class_no ASC;

-- 8. 以 course_no 升序，degree 降序查询 score 表的所有记录
-- 首先以 course_no 升序，排序完之后，同样 course_no 再以 degree 降序排序
select * from score ORDER BY course_no ASC, degree DESC;
mysql> select * from score ORDER BY course_no ASC, degree DESC;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 105        | 3-105     |     88 |
| 109        | 3-105     |     76 |
| 103        | 3-245     |     86 |
| 105        | 3-245     |     75 |
| 109        | 3-245     |     68 |
| 103        | 6-166     |     85 |
| 109        | 6-166     |     81 |
| 105        | 6-166     |     79 |
+------------+-----------+--------+
9 rows in set (0.00 sec)

-- 9. 查询 "95031" 班学生的人数
select COUNT(*) from student WHERE class_no='95031';
mysql> select COUNT(*) from student WHERE class_no='95031';
+----------+
| COUNT(*) |
+----------+
|        5 |
+----------+
1 row in set (0.10 sec)

-- 10. 查询 score 表中最高分的学生学号与课程号
-- 子查询
select student_no, course_no from score WHERE degree=(
  select MAX(degree) from score
);
mysql> select student_no, course_no from score WHERE degree=(
    ->   select MAX(degree) from score
    -> );
+------------+-----------+
| student_no | course_no |
+------------+-----------+
| 103        | 3-105     |
+------------+-----------+
1 row in set (0.00 sec)

-- 拆分第10题
-- 1). 找到最高分
select MAX(degree) from score;

-- 2). 找最高分的 student_no, course_no
select student_no, course_no from score WHERE degree=(
  select MAX(degree) from score
);

-- 用排序的做法
select student_no, course_no, degree from score ORDER BY degree;
mysql> select student_no, course_no, degree from score ORDER BY degree;
mysql> select student_no, course_no, degree from score ORDER BY degree;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 109        | 3-245     |     68 |
| 105        | 3-245     |     75 |
| 109        | 3-105     |     76 |
| 105        | 6-166     |     79 |
| 109        | 6-166     |     81 |
| 103        | 6-166     |     85 |
| 103        | 3-245     |     86 |
| 105        | 3-105     |     88 |
| 103        | 3-105     |     92 |
+------------+-----------+--------+
9 rows in set (0.00 sec)

-- limit 的作用是显示第 n 条开始的 m 条数据
-- limit 0,1：显示第0条开始的1条数据
mysql> select student_no, course_no, degree from score ORDER BY degree limit 0,1;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 109        | 3-245     |     68 |
+------------+-----------+--------+
1 row in set (0.00 sec)

-- limit 3,7：显示第3条开始的7条数据
-- 由于总共只有0-8条数据，所以从第3条开始只有6条数据
mysql> select student_no, course_no, degree from score ORDER BY degree DESC limit 3,7;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 6-166     |     85 |
| 109        | 6-166     |     81 |
| 105        | 6-166     |     79 |
| 109        | 3-105     |     76 |
| 105        | 3-245     |     75 |
| 109        | 3-245     |     68 |
+------------+-----------+--------+
6 rows in set (0.00 sec)
