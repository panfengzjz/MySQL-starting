-- ����ѧ����
-- ����ѧ�š��������Ա����ա����ڰ༶
CREATE TABLE student (
  student_no VARCHAR(20) PRIMARY KEY,
  student_name VARCHAR(20) NOT NULL,
  student_sex VARCHAR(10) NOT NULL,
  student_birth datetime,
  class_no VARCHAR(20)
);

-- ������ʦ��
-- ������ʦ��š��������Ա����ա�ְ�ơ����ڲ���
CREATE TABLE teacher (
  teacher_no VARCHAR(20) PRIMARY KEY,
  teacher_name VARCHAR(20) NOT NULL,
  teacher_sex VARCHAR(10) NOT NULL,
  teacher_birth datetime,
  prof VARCHAR(20) NOT NULL,
  depart VARCHAR(20) NOT NULL
);


-- �����γ̱�
-- �����γ̺š��γ�������ʦ���
CREATE TABLE course (
  course_no VARCHAR(20) PRIMARY KEY,
  course_name VARCHAR(20) NOT NULL,
  teacher_no VARCHAR(20) NOT NULL,
  FOREIGN KEY(teacher_no) REFERENCES teacher(teacher_no)
);

-- �����ɼ���
-- ����ѧ�š��γ̺š��ɼ�
CREATE TABLE score (
  student_no VARCHAR(20) NOT NULL,
  course_no VARCHAR(20) NOT NULL,
  degree DECIMAL,
  FOREIGN KEY(student_no) REFERENCES student(student_no),
  FOREIGN KEY(course_no) REFERENCES course(course_no),
  PRIMARY KEY(student_no, course_no)
);


-- �����ݱ����������
-- ѧ����
INSERT INTO student VALUES ('101', '����', '��', '1977-09-01', '95033');
INSERT INTO student VALUES ('102', '����', '��', '1975-10-02', '95031');
INSERT INTO student VALUES ('103', '����', 'Ů', '1976-01-23', '95033');
INSERT INTO student VALUES ('104', '���', '��', '1976-02-20', '95033');
INSERT INTO student VALUES ('105', '����', 'Ů', '1975-02-10', '95031');
INSERT INTO student VALUES ('106', '½��', '��', '1974-06-03', '95031');
INSERT INTO student VALUES ('107', '������', '��', '1976-02-20', '95033');
INSERT INTO student VALUES ('108', '��ȫ��', 'Ů', '1975-02-10', '95031');
INSERT INTO student VALUES ('109', '������', '��', '1974-06-03', '95031');

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
9 rows in set (0.08 sec)

-- ��ʦ��
INSERT INTO teacher VALUES ('804', '���', '��', '1958-12-02', '������', '�����ϵ');
INSERT INTO teacher VALUES ('856', '����', '��', '1969-03-12', '��ʦ', '���ӹ���ϵ');
INSERT INTO teacher VALUES ('825', '��Ƽ', 'Ů', '1972-05-05', '����', '�����ϵ');
INSERT INTO teacher VALUES ('831', '����', 'Ů', '1977-08-14', '����', '���ӹ���ϵ');

mysql> select * from teacher;
+------------+--------------+-------------+---------------------+--------+------------+
| teacher_no | teacher_name | teacher_sex | teacher_birth       | prof   | depart     |
+------------+--------------+-------------+---------------------+--------+------------+
| 804        | ���         | ��          | 1958-12-02 00:00:00 | ������ | �����ϵ   |
| 825        | ��Ƽ         | Ů          | 1972-05-05 00:00:00 | ����   | �����ϵ   |
| 831        | ����         | Ů          | 1977-08-14 00:00:00 | ����   | ���ӹ���ϵ |
| 856        | ����         | ��          | 1969-03-12 00:00:00 | ��ʦ   | ���ӹ���ϵ |
+------------+--------------+-------------+---------------------+--------+------------+
4 rows in set (0.00 sec)

-- �γ̱�
INSERT INTO course VALUES ('3-105', '���������', '825');
INSERT INTO course VALUES ('3-245', '����ϵͳ', '804');
INSERT INTO course VALUES ('6-166', '���ֵ�·', '856');
INSERT INTO course VALUES ('9-888', '�ߵ���ѧ', '831');

mysql> select * from course;
+-----------+-------------+------------+
| course_no | course_name | teacher_no |
+-----------+-------------+------------+
| 3-105     | ���������  | 825        |
| 3-245     | ����ϵͳ    | 804        |
| 6-166     | ���ֵ�·    | 856        |
| 9-888     | �ߵ���ѧ    | 831        |
+-----------+-------------+------------+
4 rows in set (0.07 sec)

-- �ɼ���
INSERT INTO score VALUES ('103', '3-245', '86');
INSERT INTO score VALUES ('105', '3-245', '75');
INSERT INTO score VALUES ('109', '3-245', '68');
INSERT INTO score VALUES ('103', '3-105', '92');
INSERT INTO score VALUES ('105', '3-105', '88');
INSERT INTO score VALUES ('109', '3-105', '76');
INSERT INTO score VALUES ('103', '6-166', '85');
INSERT INTO score VALUES ('105', '6-166', '79');
INSERT INTO score VALUES ('109', '6-166', '81');

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

