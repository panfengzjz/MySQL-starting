-- 1. ��ѯ student ������м�¼
select * from student;
mysql> select * from student;
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | ����         | ��          | 1977-09-01 00:00:00 | 95033    |
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
| 103        | ����         | Ů          | 1976-01-23 00:00:00 | 95033    |
| 104        | ���         | ��          | 1976-02-20 00:00:00 | 95033    |
| 105        | ����         | Ů          | 1975-02-10 00:00:00 | 95031    |
| 106        | ½��         | ��          | 1974-06-03 00:00:00 | 95031    |
| 107        | ������       | ��          | 1976-02-20 00:00:00 | 95033    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
| 109        | ������       | ��          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
9 rows in set (0.00 sec)

-- 2. ��ѯ student �������м�¼�� student_name, student_sex, class_no ��
select student_name, student_sex, class_no from student;
mysql> select student_name, student_sex, class_no from student;
+--------------+-------------+----------+
| student_name | student_sex | class_no |
+--------------+-------------+----------+
| ����         | ��          | 95033    |
| ����         | ��          | 95031    |
| ����         | Ů          | 95033    |
| ���         | ��          | 95033    |
| ����         | Ů          | 95031    |
| ½��         | ��          | 95031    |
| ������       | ��          | 95033    |
| ��ȫ��       | Ů          | 95031    |
| ������       | ��          | 95031    |
+--------------+-------------+----------+
9 rows in set (0.00 sec)

-- 3. ��ѯ��ʦ���еĵ�λ�����ظ��� depart ��
-- DISTINCT: �ų��ظ�
select DISTINCT depart from teacher;
mysql> select DISTINCT depart from teacher;
+------------+
| depart     |
+------------+
| �����ϵ   |
| ���ӹ���ϵ |
+------------+
2 rows in set (0.07 sec)

-- 4. ��ѯ score ���гɼ��� 60-80 ֮������м�¼
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

-- Ҳ���������������ʾ��Χ
select * from score WHERE degree>=60 AND degree<=80;

-- 5. ��ѯ score ���гɼ�Ϊ 85,86,88 �ļ�¼
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

-- 6. ��ѯ student ���� "95031" �༶���Ա�ΪŮ��ͬѧ��¼
select * from student WHERE class_no='95031' OR student_sex='Ů';
mysql> select * from student WHERE class_no='95031' OR student_sex='Ů';
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
| 103        | ����         | Ů          | 1976-01-23 00:00:00 | 95033    |
| 105        | ����         | Ů          | 1975-02-10 00:00:00 | 95031    |
| 106        | ½��         | ��          | 1974-06-03 00:00:00 | 95031    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
| 109        | ������       | ��          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
6 rows in set (0.00 sec)

-- 7. �� class_no �����ѯ student ������м�¼
select * from student ORDER BY class_no DESC;
mysql> select * from student ORDER BY class_no DESC;
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | ����         | ��          | 1977-09-01 00:00:00 | 95033    |
| 103        | ����         | Ů          | 1976-01-23 00:00:00 | 95033    |
| 104        | ���         | ��          | 1976-02-20 00:00:00 | 95033    |
| 107        | ������       | ��          | 1976-02-20 00:00:00 | 95033    |
| 102        | ����         | ��          | 1975-10-02 00:00:00 | 95031    |
| 105        | ����         | Ů          | 1975-02-10 00:00:00 | 95031    |
| 106        | ½��         | ��          | 1974-06-03 00:00:00 | 95031    |
| 108        | ��ȫ��       | Ů          | 1975-02-10 00:00:00 | 95031    |
| 109        | ������       | ��          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
9 rows in set (0.06 sec)

-- ����Ĭ������������
select * from student ORDER BY class_no ASC;

-- 8. �� course_no ����degree �����ѯ score ������м�¼
-- ������ course_no ����������֮��ͬ�� course_no ���� degree ��������
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

-- 9. ��ѯ "95031" ��ѧ��������
select COUNT(*) from student WHERE class_no='95031';
mysql> select COUNT(*) from student WHERE class_no='95031';
+----------+
| COUNT(*) |
+----------+
|        5 |
+----------+
1 row in set (0.10 sec)

-- 10. ��ѯ score ������߷ֵ�ѧ��ѧ����γ̺�
-- �Ӳ�ѯ
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

-- ��ֵ�10��
-- 1). �ҵ���߷�
select MAX(degree) from score;

-- 2). ����߷ֵ� student_no, course_no
select student_no, course_no from score WHERE degree=(
  select MAX(degree) from score
);

-- �����������
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

-- limit ����������ʾ�� n ����ʼ�� m ������
-- limit 0,1����ʾ��0����ʼ��1������
mysql> select student_no, course_no, degree from score ORDER BY degree limit 0,1;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 109        | 3-245     |     68 |
+------------+-----------+--------+
1 row in set (0.00 sec)

-- limit 3,7����ʾ��3����ʼ��7������
-- �����ܹ�ֻ��0-8�����ݣ����Դӵ�3����ʼֻ��6������
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
