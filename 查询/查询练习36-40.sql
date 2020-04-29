-- 36. ��ѯ student ����������С�� student_birth ����
select MAX(student_birth) as '���', MIN(student_birth) as '��С' from student;

mysql> select MAX(student_birth) as '���', MIN(student_birth) as '��С' from student;
+---------------------+---------------------+
| ���                | ��С                |
+---------------------+---------------------+
| 1977-09-01 00:00:00 | 1974-06-03 00:00:00 |
+---------------------+---------------------+
1 row in set (0.04 sec)


-- 37. �԰�ź�����Ӵ�С��˳���ѯ student ���е����м�¼
select * from student ORDER BY class_no DESC, student_birth;

mysql> select * from student ORDER BY class_no DESC, student_birth;
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 110        | �ŷ�         | ��          | 1974-06-03 00:00:00 | 95038    |
| 103        | ����         | Ů          | 1976-01-23 00:00:00 | 95033    |
| 104        | ���         | ��          | 1976-02-20 00:00:00 | 95033    |
| 107        | ������       | ��          | 1976-02-20 00:00:00 | 95033    |
| 101        | ����         | ��          | 1977-09-01 00:00:00 | 95033    |
| 106        | ½��         | ��          | 1974-06-03 00:00:00 | 95031    |
| 109        | ������       | ��          | 1974-06-03 00:00:00 | 95031    |
| 105        | ����         | Ů          | 1975-02-10 00:00:00 | 95031    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
10 rows in set (0.00 sec)


-- 38. ��ѯ�н�ʦ�������ϵĿγ�
select teacher_no from teacher WHERE teacher_sex='��';

select * from course WHERE teacher_no IN (
select teacher_no from teacher WHERE teacher_sex='��');

mysql> select * from course WHERE teacher_no IN (
    -> select teacher_no from teacher WHERE teacher_sex='��');
+-----------+-------------+------------+
| course_no | course_name | teacher_no |
+-----------+-------------+------------+
| 3-245     | ����ϵͳ    | 804        |
| 6-166     | ���ֵ�·    | 856        |
+-----------+-------------+------------+
2 rows in set (0.00 sec)


-- 39. ��ѯ��߷�ͬѧ�� student_no, course_no, degree
select MAX(degree) from score2;

-- ��Ϊ score2 ����ֻ�� student_no, course_no, degree ���У����Կ��� select *
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


-- 40. ��ѯ�����ͬ�Ա������ͬѧ�� student_name
select student_sex from student WHERE student_name='���';

select student_name from student WHERE student_sex=(
select student_sex from student WHERE student_name='���');

mysql> select student_name from student WHERE student_sex=(
    -> select student_sex from student WHERE student_name='���');
+--------------+
| student_name |
+--------------+
| ����         |
| ����         |
| ���         |
| ½��         |
| ������       |
| ������       |
| �ŷ�         |
+--------------+
7 rows in set (0.00 sec)