-- 31. ��ѯ�ɼ��ȸÿγ�ƽ���ֵ͵�ͬѧ�ĳɼ���
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

-- ��װ score2 ������ͬ�� A��� B��
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


-- 32. ��ѯ�����ο���ʦ�� teacher_name �� depart
-- �γ̱����пεĽ�ʦ���������ο���ʦ
select teacher_name, depart from teacher WHERE teacher_no IN (
select teacher_no from course);

mysql> select teacher_name, depart from teacher WHERE teacher_no IN (
    -> select teacher_no from course);
+--------------+------------+
| teacher_name | depart     |
+--------------+------------+
| ���         | �����ϵ   |
| ��Ƽ         | �����ϵ   |
| ����         | ���ӹ���ϵ |
| ����         | ���ӹ���ϵ |
+--------------+------------+
4 rows in set (0.08 sec)


-- 33. ��ѯ������2�������İ��
select class_no from student WHERE student_sex='��'
GROUP BY class_no HAVING COUNT(*) > 1;

mysql> select class_no from student WHERE student_sex='��'
    -> GROUP BY class_no HAVING COUNT(*) > 1;
+----------+
| class_no |
+----------+
| 95033    |
| 95031    |
+----------+
2 rows in set (0.00 sec)


-- 34. ��ѯ student ���в�������ͬѧ��¼
select * from student WHERE student_name NOT LIKE '��%';

mysql> select * from student WHERE student_name NOT LIKE '��%';
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | ����         | ��          | 1977-09-01 00:00:00 | 95033    |
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
| 104        | ���         | ��          | 1976-02-20 00:00:00 | 95033    |
| 106        | ½��         | ��          | 1974-06-03 00:00:00 | 95031    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
| 109        | ������       | ��          | 1974-06-03 00:00:00 | 95031    |
| 110        | �ŷ�         | ��          | 1974-06-03 00:00:00 | 95038    |
+------------+--------------+-------------+---------------------+----------+
7 rows in set (0.03 sec)


-- 35. ��ѯ student ����ÿ��ѧ��������������
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
| ����         |   43 |
| ����         |   45 |
| ����         |   44 |
| ���         |   44 |
| ����         |   45 |
| ½��         |   46 |
| ������       |   44 |
| ��ȫ��       |   45 |
| ������       |   46 |
| �ŷ�         |   46 |
+--------------+------+
10 rows in set (0.06 sec)

