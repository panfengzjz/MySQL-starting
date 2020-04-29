-- 16. ��ѯ����ѧ���� student_name, course_name, degree ��
select student_name, course_name, degree from student, course, score
WHERE student.student_no=score.student_no 
AND course.course_no=score.course_no;

mysql> select student_name, course_name, degree from student, course, score
    -> WHERE student.student_no=score.student_no
    -> AND course.course_no=score.course_no;
+--------------+-------------+--------+
| student_name | course_name | degree |
+--------------+-------------+--------+
| ����         | ���������  |     92 |
| ����         | ����ϵͳ    |     86 |
| ����         | ���ֵ�·    |     85 |
| ����         | ���������  |     88 |
| ����         | ����ϵͳ    |     75 |
| ����         | ���ֵ�·    |     79 |
| ������       | ���������  |     76 |
| ������       | ����ϵͳ    |     68 |
| ������       | ���ֵ�·    |     81 |
+--------------+-------------+--------+
9 rows in set (0.00 sec)


-- 17. ��ѯ '95031' ��ѧ��ÿ�ſε�ƽ����
-- 1). ���Ȳ鿴 '95031' ������Щѧ��
select * from student WHERE class_no='95031';
mysql> select * from student WHERE class_no='95031';
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
| 105        | ����         | Ů          | 1975-02-10 00:00:00 | 95031    |
| 106        | ½��         | ��          | 1974-06-03 00:00:00 | 95031    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
| 109        | ������       | ��          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
5 rows in set (0.00 sec)

-- 2). ����ѧ�����֣�ȥ score �����ҳ���Ӧ�� degree
-- student_no ֱ���õ�һ���õ�������
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

-- 3). �� GROUP BY ����γ̵�ƽ��ֵ
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


-- 18. ��ѯѡ�� "3-105" �γ̵ĳɼ�����ѧ��109ͬѧ "3-105" �ɼ�������ͬѧ��¼
-- 1). �����ó�109��ͬѧ "3-105" �γ̳ɼ�
select degree from score WHERE student_no='109' AND course_no='3-105';
mysql> select degree from score WHERE student_no='109' AND course_no='3-105';
+--------+
| degree |
+--------+
|     76 |
+--------+
1 row in set (0.00 sec)

-- 2). ���ҳ� score �������гɼ�����76�ļ�¼
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


-- 19. ��ѯ�ɼ�����ѧ��109���γ̺� "3-105" �ɼ������м�¼
-- ��18��� course_no="3-105" ����ȥ������
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


-- 20. ��ѯ��ѧ��108��101ͬѧͬ�����������ѧ���� student_no, student_name, student_birth ��
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
| 101        | ����         | ��          | 1977-09-01 00:00:00 | 95033    |
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
| 105        | ����         | Ů          | 1975-02-10 00:00:00 | 95031    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
4 rows in set (0.00 sec)