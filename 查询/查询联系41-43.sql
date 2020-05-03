-- 41. 查询和"李军"同性别且同班的同学的 student_name
select student_sex, class_no from student WHERE student_name='李军';

select student_name from student WHERE
student_sex=(select student_sex from student WHERE student_name='李军')
AND class_no=(select class_no from student WHERE student_name='李军');

mysql> select student_name from student WHERE
    -> student_sex=(select student_sex from student WHERE student_name='李军')
    -> AND class_no=(select class_no from student WHERE student_name='李军');
+--------------+
| student_name |
+--------------+
| 曾华         |
| 李军         |
| 王尼玛       |
+--------------+
3 rows in set (0.00 sec)


-- 42. 查询所有选修"计算机导论"的男同学成绩表
select student_no from student WHERE student_sex='男';

select * from score2 WHERE course_no=(select course_no from course WHERE course_name="计算机导论")
AND student_no IN (select student_no from student WHERE student_sex='男');

mysql> select * from score2 WHERE course_no=(select course_no from course WHERE course_name="计算机导论")
    -> AND student_no IN (select student_no from student WHERE student_sex='男');
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 101        | 3-105     |     90 |
| 102        | 3-105     |     91 |
| 104        | 3-105     |     89 |
| 109        | 3-105     |     76 |
+------------+-----------+--------+
4 rows in set (0.00 sec)


-- 43. 假设使用如下命令创建一个 grade 表
CREATE TABLE grade (
  low int(3),
  upp int(3),
  grade CHAR(1)
);

INSERT INTO grade VALUES(90, 100, 'A');
INSERT INTO grade VALUES(90, 89, 'B');
INSERT INTO grade VALUES(70, 79, 'C');
INSERT INTO grade VALUES(60, 69, 'D');
INSERT INTO grade VALUES(0, 59, 'E');

-- 查询所有学生的 student_no, course_no, grade 列
select student_no, course_no, grade from score2, grade 
WHERE degree BETWEEN low AND upp;

mysql> select student_no, course_no, grade from score2, grade
    -> WHERE degree BETWEEN low AND upp;
+------------+-----------+-------+
| student_no | course_no | grade |
+------------+-----------+-------+
| 101        | 3-105     | A     |
| 102        | 3-105     | A     |
| 103        | 3-105     | A     |
| 105        | 3-245     | C     |
| 105        | 6-166     | C     |
| 109        | 3-105     | C     |
| 109        | 3-245     | D     |
+------------+-----------+-------+
7 rows in set (0.00 sec)

