-- 21. ��ѯ"����"��ʦ�οε�ѧ���ɼ�
-- 1). �ҵ�"����"��ʦ�� teacher_no
select teacher_no, teacher_name from teacher WHERE teacher_name='����';
mysql> select teacher_no, teacher_name from teacher WHERE teacher_name='����';
+------------+--------------+
| teacher_no | teacher_name |
+------------+--------------+
| 856        | ����         |
+------------+--------------+
1 row in set (0.07 sec)

-- 2). ���� teacher_no �ҵ� course_no
select course_no from course WHERE teacher_no=(
select teacher_no from teacher WHERE teacher_name='����');
mysql> select course_no from course WHERE teacher_no=(
    -> select teacher_no from teacher WHERE teacher_name='����');
+-----------+
| course_no |
+-----------+
| 6-166     |
+-----------+
1 row in set (0.02 sec)

-- 3). ���� course_no �� score �����ҳ�ѧ���ɼ�
select * from score WHERE course_no=(
select course_no from course WHERE teacher_no=(
select teacher_no from teacher WHERE teacher_name='����'));

mysql> select * from score WHERE course_no=(
    -> select course_no from course WHERE teacher_no=(
    -> select teacher_no from teacher WHERE teacher_name='����'));
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 6-166     |     85 |
| 105        | 6-166     |     79 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
3 rows in set (0.00 sec)


-- 22. ��ѯѡ��ĳ�γ̵�ͬѧ��������5�˵Ľ�ʦ����
-- 1). �鿴 score ���е����ݷ��֣���ǰû��һ�ſε�ѡ��ѧ��>5
mysql> select * from score;
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-105     |     92 |
| 103        | 3-245     |     86 |
| 103        | 6-166     |     85 |
| 105        | 3-105     |     88 |
| 105        | 3-245     |     75 |
| 105        | 6-166     |     79 |
| 109        | 3-105     |     76 |
| 109        | 3-245     |     68 |
| 109        | 6-166     |     81 |
+------------+-----------+--------+
9 rows in set (0.00 sec)
-- ��Ҫ����һЩ�µ�����
-- Ϊ�˱�����֮ǰ����Ŀ�������½�һ�� score2 ���

INSERT INTO score2 VALUES ('103', '3-245', '86');
INSERT INTO score2 VALUES ('105', '3-245', '75');
INSERT INTO score2 VALUES ('109', '3-245', '68');
INSERT INTO score2 VALUES ('103', '3-105', '92');
INSERT INTO score2 VALUES ('105', '3-105', '88');
INSERT INTO score2 VALUES ('109', '3-105', '76');
INSERT INTO score2 VALUES ('103', '6-166', '85');
INSERT INTO score2 VALUES ('105', '6-166', '79');
INSERT INTO score2 VALUES ('109', '6-166', '81');

INSERT INTO score2 VALUES ('101', '3-105', '90');
INSERT INTO score2 VALUES ('102', '3-105', '91');
INSERT INTO score2 VALUES ('104', '3-105', '89');

-- 2). ������ score2 ����в���ѡ����������5�Ŀ�
select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5;
mysql> select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5;
+-----------+
| course_no |
+-----------+
| 3-105     |
+-----------+
1 row in set (0.00 sec)

-- 3). �������е� course_no �� course ���в�ѯ teacher_no
select teacher_no from course WHERE course_no=(
select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5);
mysql> select teacher_no from course WHERE course_no=(
    -> select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5);
+------------+
| teacher_no |
+------------+
| 825        |
+------------+
1 row in set (0.09 sec)

-- 4). �������е� teacher_no �� teacher ���в�ѯ teacher_name
select teacher_name from teacher WHERE teacher_no=(
select teacher_no from course WHERE course_no=(
select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5));

mysql> select teacher_name from teacher WHERE teacher_no=(
    -> select teacher_no from course WHERE course_no=(
    -> select course_no from score2 GROUP BY course_no HAVING COUNT(*)>5));
+--------------+
| teacher_name |
+--------------+
| ��Ƽ         |
+--------------+
1 row in set (0.00 sec)


-- 23. ��ѯ 95033, 95031 ��ȫ��ѧ���ļ�¼
select * from student WHERE class_no IN ('95033', '95031');
mysql> select * from student WHERE class_no IN ('95033', '95031');
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
9 rows in set (0.03 sec)

-- ���ڵ�ǰ���ݱ���ֻ�� 95031, 95033 �����࣬Ϊ�˱���Ͷ�����ٲ���һ������
INSERT INTO student VALUES ('110', '�ŷ�', '��', '1974-06-03', '95038');


-- 24. ��ѯ����85�����ϳɼ��Ŀγ̺�
select course_no, degree from score2 WHERE degree>85;
mysql> select course_no, degree from score2 WHERE degree>85;
+-----------+--------+
| course_no | degree |
+-----------+--------+
| 3-105     |     90 |
| 3-105     |     91 |
| 3-105     |     92 |
| 3-245     |     86 |
| 3-105     |     89 |
| 3-105     |     88 |
+-----------+--------+
6 rows in set (0.00 sec)


-- 25. ��ѯ"�����ϵ"��ʦ���̿γ̵ĳɼ���
-- 1) ����"�����ϵ"�ҳ� teacher_no
select teacher_no from teacher WHERE depart='�����ϵ'; 

-- 2) ���� teacher_no �ҳ� course_no
select course_no from course WHERE teacher_no IN (
select teacher_no from teacher WHERE depart='�����ϵ');

-- 3) ���� course_no �ҳ��ɼ���
select * from score WHERE course_no IN (
select course_no from course WHERE teacher_no IN (
select teacher_no from teacher WHERE depart='�����ϵ'));

mysql> select * from score WHERE course_no IN (
    -> select course_no from course WHERE teacher_no IN (
    -> select teacher_no from teacher WHERE depart='�����ϵ'));
+------------+-----------+--------+
| student_no | course_no | degree |
+------------+-----------+--------+
| 103        | 3-245     |     86 |
| 105        | 3-245     |     75 |
| 109        | 3-245     |     68 |
| 103        | 3-105     |     92 |
| 105        | 3-105     |     88 |
| 109        | 3-105     |     76 |
+------------+-----------+--------+
6 rows in set (0.00 sec)