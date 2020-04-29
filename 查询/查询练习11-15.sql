-- 11. ��ѯÿ�ſε�ƽ���ɼ�
-- 1). �鿴���пγ�
select * from course;

-- 2). �� avg() ����һ�ſ�ƽ���ɼ�
select AVG(degree) FROM score WHERE course_no='3-105';
mysql> select AVG(degree) FROM score WHERE course_no='3-105';
+-------------+
| AVG(degree) |
+-------------+
|     85.3333 |
+-------------+
1 row in set (0.09 sec)

-- 3). �÷������ÿ�ſε�ƽ���ɼ�
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


-- 12. ��ѯ score ������������ѧ��ѡ�޵ģ�����3��ͷ�Ŀγ�ƽ������
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

-- GROUP BY �����ѯ
-- HAVING ������
-- LIKE �ַ���ƥ��
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


-- 13. ��ѯ��������70��С��90�� student_no ��
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


-- 14. ��ѯ����ѧ���� student_name, course_no, degree ��
-- �������ֶ����Բ�ͬ�ı����ֱ���������������ᱨ��
select student_name, course_no, degree from student;

select student_name from student;
select course_no, degree from score;
-- ����Ҫ���� student, score ���ű�����ҵ���Ҫ����
-- Ҫ��������ѯ��һ��Ҫ�б��е�ĳ���й�ϵ�ſ���
-- �����������У�student_no �ǹ��е�

select student_name, course_no, degree from student, score
WHERE student.student_no=score.student_no;
mysql> select student_name, course_no, degree from student, score
    -> WHERE student.student_no=score.student_no;
+--------------+-----------+--------+
| student_name | course_no | degree |
+--------------+-----------+--------+
| ����         | 3-105     |     92 |
| ����         | 3-245     |     86 |
| ����         | 6-166     |     85 |
| ����         | 3-105     |     88 |
| ����         | 3-245     |     75 |
| ����         | 6-166     |     79 |
| ������       | 3-105     |     76 |
| ������       | 3-245     |     68 |
| ������       | 6-166     |     81 |
+--------------+-----------+--------+
9 rows in set (0.00 sec)


-- 15. ��ѯ����ѧ���� student_no, course_name, degree ��
-- ��Ȼ�ǿ���ѯ
-- student_no �� student, score ��
-- course_name �� course ��
-- degree �� score ��
select course_no, course_name from course;
mysql> select course_no, course_name from course;
+-----------+-------------+
| course_no | course_name |
+-----------+-------------+
| 3-105     | ���������  |
| 3-245     | ����ϵͳ    |
| 6-166     | ���ֵ�·    |
| 9-888     | �ߵ���ѧ    |
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

-- �����е� course_no �滻�� course_no ����
select student_no, course_name, degree from course, score
WHERE course.course_no=score.course_no;
mysql> select student_no, course_name, degree from course, score
    -> WHERE course.course_no=score.course_no;
+------------+-------------+--------+
| student_no | course_name | degree |
+------------+-------------+--------+
| 103        | ���������  |     92 |
| 105        | ���������  |     88 |
| 109        | ���������  |     76 |
| 103        | ����ϵͳ    |     86 |
| 105        | ����ϵͳ    |     75 |
| 109        | ����ϵͳ    |     68 |
| 103        | ���ֵ�·    |     85 |
| 105        | ���ֵ�·    |     79 |
| 109        | ���ֵ�·    |     81 |
+------------+-------------+--------+
9 rows in set (0.00 sec)




