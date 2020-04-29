-- 11. 查询每门课的平均成绩
-- 1). 查看所有课程
select * from course;

-- 2). 用 avg() 计算一门课平均成绩
select AVG(degree) FROM score WHERE course_no='3-105';
mysql> select AVG(degree) FROM score WHERE course_no='3-105';
+-------------+
| AVG(degree) |
+-------------+
|     85.3333 |
+-------------+
1 row in set (0.09 sec)

-- 3). 用分组计算每门课的平均成绩
select course_no, AVG(degree) FROM score GROUP BY course_no;
mysql> select course_no, AVG(degree) FROM score GROUP BY course_no;
+-----------+-------------+
| course_no | AVG(degree) |
+-----------+-------------+
| 3-105     |     85.3333 |
| 3-245     |     76.3333 |
| 6-166     |     81.6667 |
+-----------+-------------+
3 rows in set (0.04 sec)


-- 12. 查询 score 表中至少两名学生选修的，且以3开头的课程平均分数
select course_no from score GROUP BY course_no;
mysql> select course_no from score GROUP BY course_no;
+-----------+
| course_no |
+-----------+
| 3-105     |
| 3-245     |
| 6-166     |
+-----------+
3 rows in set (0.00 sec)

select course_no from score GROUP BY course_no 
HAVING COUNT(course_no) >= 2 AND course_no LIKE '3%';
mysql> select course_no from score GROUP BY course_no
    -> HAVING COUNT(course_no) >= 2 AND course_no LIKE '3%';
+-----------+
| course_no |
+-----------+
| 3-105     |
| 3-245     |
+-----------+
2 rows in set (0.02 sec)

-- GROUP BY 分组查询
-- HAVING 加条件
-- LIKE 字符串匹配
select course_no, AVG(degree) from score GROUP BY course_no 
HAVING COUNT(course_no) >= 2 AND course_no LIKE '3%';
mysql> select course_no, AVG(degree) from score GROUP BY course_no
    -> HAVING COUNT(course_no) >= 2 AND course_no LIKE '3%';
+-----------+-------------+
| course_no | AVG(degree) |
+-----------+-------------+
| 3-105     |     85.3333 |
| 3-245     |     76.3333 |
+-----------+-------------+
2 rows in set (0.00 sec)


-- 13. 查询分数大于70，小于90的 student_no 列
select student_no, degree from score WHERE degree>70 AND degree<90;
mysql> select student_no, degree from score WHERE degree>70 AND degree<90;
+------------+--------+
| student_no | degree |
+------------+--------+
| 103        |     86 |
| 103        |     85 |
| 105        |     88 |
| 105        |     75 |
| 105        |     79 |
| 109        |     76 |
| 109        |     81 |
+------------+--------+
7 rows in set (0.00 sec)


-- 14. 查询所有学生的 student_name, course_no, degree 列
-- 这三个字段来自不同的表，因此直接用下面这个命令会报错
select student_name, course_no, degree from student;

select student_name from student;
select course_no, degree from score;
-- 至少要遍历 student, score 两张表才能找到需要的列
-- 要做到跨表查询，一定要有表中的某列有关系才可以
-- 在这两个表中，student_no 是共有的

select student_name, course_no, degree from student, score
WHERE student.student_no=score.student_no;
mysql> select student_name, course_no, degree from student, score
    -> WHERE student.student_no=score.student_no;
+--------------+-----------+--------+
| student_name | course_no | degree |
+--------------+-----------+--------+
| 王丽         | 3-105     |     92 |
| 王丽         | 3-245     |     86 |
| 王丽         | 6-166     |     85 |
| 王芳         | 3-105     |     88 |
| 王芳         | 3-245     |     75 |
| 王芳         | 6-166     |     79 |
| 赵铁柱       | 3-105     |     76 |
| 赵铁柱       | 3-245     |     68 |
| 赵铁柱       | 6-166     |     81 |
+--------------+-----------+--------+
9 rows in set (0.00 sec)


-- 15. 查询所有学生的 student_no, course_name, degree 列
-- 依然是跨表查询
-- student_no 在 student, score 表；
-- course_name 在 course 表；
-- degree 在 score 表；
select course_no, course_name from course;
mysql> select course_no, course_name from course;
+-----------+-------------+
| course_no | course_name |
+-----------+-------------+
| 3-105     | 计算机导论  |
| 3-245     | 操作系统    |
| 6-166     | 数字电路    |
| 9-888     | 高等数学    |
+-----------+-------------+
4 rows in set (0.00 sec)

select course_no, student_no, degree from score;
mysql> select course_no, student_no, degree from score;
+-----------+------------+--------+
| course_no | student_no | degree |
+-----------+------------+--------+
| 3-105     | 103        |     92 |
| 3-245     | 103        |     86 |
| 6-166     | 103        |     85 |
| 3-105     | 105        |     88 |
| 3-245     | 105        |     75 |
| 6-166     | 105        |     79 |
| 3-105     | 109        |     76 |
| 3-245     | 109        |     68 |
| 6-166     | 109        |     81 |
+-----------+------------+--------+
9 rows in set (0.00 sec)

-- 将表中的 course_no 替换成 course_no 即可
select student_no, course_name, degree from course, score
WHERE course.course_no=score.course_no;
mysql> select student_no, course_name, degree from course, score
    -> WHERE course.course_no=score.course_no;
+------------+-------------+--------+
| student_no | course_name | degree |
+------------+-------------+--------+
| 103        | 计算机导论  |     92 |
| 105        | 计算机导论  |     88 |
| 109        | 计算机导论  |     76 |
| 103        | 操作系统    |     86 |
| 105        | 操作系统    |     75 |
| 109        | 操作系统    |     68 |
| 103        | 数字电路    |     85 |
| 105        | 数字电路    |     79 |
| 109        | 数字电路    |     81 |
+------------+-------------+--------+
9 rows in set (0.00 sec)




