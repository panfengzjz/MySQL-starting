-- 26. ��ѯ"�����ϵ"��"���ӹ���ϵ"����ְͬ�ƽ�ʦ�� teacher_name �� prof
-- ���ⲻ�Ǻ���������ⲻǿ��
select * from teacher WHERE depart="�����ϵ" AND prof NOT IN (
select prof from teacher WHERE depart="���ӹ���ϵ");

mysql> select * from teacher WHERE depart="�����ϵ" AND prof NOT IN (
    -> select prof from teacher WHERE depart="���ӹ���ϵ");
+------------+--------------+-------------+---------------------+--------+----------+
| teacher_no | teacher_name | teacher_sex | teacher_birth       | prof   | depart   |
+------------+--------------+-------------+---------------------+--------+----------+
| 804        | ���         | ��          | 1958-12-02 00:00:00 | ������ | �����ϵ |
+------------+--------------+-------------+---------------------+--------+----------+
1 row in set (0.12 sec)

-- 27. ��ѯ�γ̺� "3-105" �ȿγ̺� "3-245" �ɼ��ߵ�ͬѧ��
-- course_no, student_no, degree�������� degree �Ӹߵ�������
-- 1). �ȹ۲� "3-105", "3-245" ѧ���ĵ÷����
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

-- 2). "3-105" ���� "3-245" ������һ����������
select * from score2 WHERE course_no='3-105' AND degree>
ANY(select degree from score2 WHERE course_no='3-245');


-- 3). �Ӹߵ�������
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


-- 28. ��ѯѡ�޿γ� "3-105" �ҳɼ����ڿγ� "3-245" ��ͬѧ�� course_no, student_no, degree
-- �ң��� "3-245" ���κ�һ��������ô��������˵�ɣ�
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


-- 29. ��ѯ���н�ʦ��ͬѧ�� name, sex, birth
select teacher_name, teacher_sex, teacher_birth from teacher;
select student_name, student_sex, student_birth from student;

-- �� UNION �����������һ��
select teacher_name, teacher_sex, teacher_birth from teacher
UNION
select student_name, student_sex, student_birth from student;

mysql> select teacher_name, teacher_sex, teacher_birth from teacher
    -> UNION
    -> select student_name, student_sex, student_birth from student;
+--------------+-------------+---------------------+
| teacher_name | teacher_sex | teacher_birth       |
+--------------+-------------+---------------------+
| ���         | ��          | 1958-12-02 00:00:00 |
| ��Ƽ         | Ů          | 1972-05-05 00:00:00 |
| ����         | Ů          | 1977-08-14 00:00:00 |
| ����         | ��          | 1969-03-12 00:00:00 |
| ����         | ��          | 1977-09-01 00:00:00 |
| ����         | ��          | 1975-10-02 00:00:00 |
| ����         | Ů          | 1976-01-23 00:00:00 |
| ���         | ��          | 1976-02-20 00:00:00 |
| ����         | Ů          | 1975-02-10 00:00:00 |
| ½��         | ��          | 1974-06-03 00:00:00 |
| ������       | ��          | 1976-02-20 00:00:00 |
| ��ȫ��       | Ů          | 1975-02-10 00:00:00 |
| ������       | ��          | 1974-06-03 00:00:00 |
| �ŷ�         | ��          | 1974-06-03 00:00:00 |
+--------------+-------------+---------------------+
14 rows in set (0.08 sec)

-- ����������������� teacher ��أ���Ҫ����������as
select teacher_name as name, teacher_sex as sex, teacher_birth as birth from teacher
UNION select student_name, student_sex, student_birth from student;

mysql> select teacher_name as name, teacher_sex as sex, teacher_birth as birth from teacher
    -> UNION select student_name, student_sex, student_birth from student;
+--------+-----+---------------------+
| name   | sex | birth               |
+--------+-----+---------------------+
| ���   | ��  | 1958-12-02 00:00:00 |
| ��Ƽ   | Ů  | 1972-05-05 00:00:00 |
| ����   | Ů  | 1977-08-14 00:00:00 |
| ����   | ��  | 1969-03-12 00:00:00 |
| ����   | ��  | 1977-09-01 00:00:00 |
| ����   | ��  | 1975-10-02 00:00:00 |
| ����   | Ů  | 1976-01-23 00:00:00 |
| ���   | ��  | 1976-02-20 00:00:00 |
| ����   | Ů  | 1975-02-10 00:00:00 |
| ½��   | ��  | 1974-06-03 00:00:00 |
| ������ | ��  | 1976-02-20 00:00:00 |
| ��ȫ�� | Ů  | 1975-02-10 00:00:00 |
| ������ | ��  | 1974-06-03 00:00:00 |
| �ŷ�   | ��  | 1974-06-03 00:00:00 |
+--------+-----+---------------------+
14 rows in set (0.00 sec)


-- 30. ��ѯ����Ů��ʦ��Ůͬѧ�� name, sex, birth
select teacher_name as name, teacher_sex as sex, teacher_birth as birth 
from teacher WHERE teacher_sex='Ů'
UNION select student_name, student_sex, student_birth 
from student WHERE student_sex='Ů';

mysql> select teacher_name as name, teacher_sex as sex, teacher_birth as birth
    -> from teacher WHERE teacher_sex='Ů'
    -> UNION select student_name, student_sex, student_birth
    -> from student WHERE student_sex='Ů';
+--------+-----+---------------------+
| name   | sex | birth               |
+--------+-----+---------------------+
| ��Ƽ   | Ů  | 1972-05-05 00:00:00 |
| ����   | Ů  | 1977-08-14 00:00:00 |
| ����   | Ů  | 1976-01-23 00:00:00 |
| ����   | Ů  | 1975-02-10 00:00:00 |
| ��ȫ�� | Ů  | 1975-02-10 00:00:00 |
+--------+-----+---------------------+
5 rows in set (0.00 sec)