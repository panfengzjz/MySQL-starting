-- 创建学生表
-- 包括学号、姓名、性别、生日、所在班级
CREATE TABLE student (
  student_no VARCHAR(20) PRIMARY KEY,
  student_name VARCHAR(20) NOT NULL,
  student_sex VARCHAR(10) NOT NULL,
  student_birth datetime,
  class_no VARCHAR(20)
);

-- 创建教师表
-- 包括教师编号、姓名、性别、生日、职称、所在部门
CREATE TABLE teacher (
  teacher_no VARCHAR(20) PRIMARY KEY,
  teacher_name VARCHAR(20) NOT NULL,
  teacher_sex VARCHAR(10) NOT NULL,
  teacher_birth datetime,
  prof VARCHAR(20) NOT NULL,
  depart VARCHAR(20) NOT NULL
);


-- 创建课程表
-- 包括课程号、课程名、教师编号
CREATE TABLE course (
  course_no VARCHAR(20) PRIMARY KEY,
  course_name VARCHAR(20) NOT NULL,
  teacher_no VARCHAR(20) NOT NULL,
  FOREIGN KEY(teacher_no) REFERENCES teacher(teacher_no)
);

-- 创建成绩表
-- 包括学号、课程号、成绩
CREATE TABLE score (
  student_no VARCHAR(20) NOT NULL,
  course_no VARCHAR(20) NOT NULL,
  degree DECIMAL,
  FOREIGN KEY(student_no) REFERENCES student(student_no),
  FOREIGN KEY(course_no) REFERENCES course(course_no),
  PRIMARY KEY(student_no, course_no)
);


-- 往数据表中添加数据
-- 学生表
INSERT INTO student VALUES ('101', '曾华', '男', '1977-09-01', '95033');
INSERT INTO student VALUES ('102', '匡明', '男', '1975-10-02', '95031');
INSERT INTO student VALUES ('103', '王丽', '女', '1976-01-23', '95033');
INSERT INTO student VALUES ('104', '李军', '男', '1976-02-20', '95033');
INSERT INTO student VALUES ('105', '王芳', '女', '1975-02-10', '95031');
INSERT INTO student VALUES ('106', '陆君', '男', '1974-06-03', '95031');
INSERT INTO student VALUES ('107', '王尼玛', '男', '1976-02-20', '95033');
INSERT INTO student VALUES ('108', '张全蛋', '女', '1975-02-10', '95031');
INSERT INTO student VALUES ('109', '赵铁柱', '男', '1974-06-03', '95031');

mysql> select * from student;
+------------+--------------+-------------+---------------------+----------+
| student_no | student_name | student_sex | student_birth       | class_no |
+------------+--------------+-------------+---------------------+----------+
| 101        | 曾华         | 男          | 1977-09-01 00:00:00 | 95033    |
| 102        | 匡明         | 男          | 1975-10-02 00:00:00 | 95031    |
| 103        | 王丽         | 女          | 1976-01-23 00:00:00 | 95033    |
| 104        | 李军         | 男          | 1976-02-20 00:00:00 | 95033    |
| 105        | 王芳         | 女          | 1975-02-10 00:00:00 | 95031    |
| 106        | 陆君         | 男          | 1974-06-03 00:00:00 | 95031    |
| 107        | 王尼玛       | 男          | 1976-02-20 00:00:00 | 95033    |
| 108        | 张全蛋       | 女          | 1975-02-10 00:00:00 | 95031    |
| 109        | 赵铁柱       | 男          | 1974-06-03 00:00:00 | 95031    |
+------------+--------------+-------------+---------------------+----------+
9 rows in set (0.08 sec)

-- 教师表
INSERT INTO teacher VALUES ('804', '李诚', '男', '1958-12-02', '副教授', '计算机系');
INSERT INTO teacher VALUES ('856', '张旭', '男', '1969-03-12', '讲师', '电子工程系');
INSERT INTO teacher VALUES ('825', '王萍', '女', '1972-05-05', '助教', '计算机系');
INSERT INTO teacher VALUES ('831', '刘冰', '女', '1977-08-14', '助教', '电子工程系');

mysql> select * from teacher;
+------------+--------------+-------------+---------------------+--------+------------+
| teacher_no | teacher_name | teacher_sex | teacher_birth       | prof   | depart     |
+------------+--------------+-------------+---------------------+--------+------------+
| 804        | 李诚         | 男          | 1958-12-02 00:00:00 | 副教授 | 计算机系   |
| 825        | 王萍         | 女          | 1972-05-05 00:00:00 | 助教   | 计算机系   |
| 831        | 刘冰         | 女          | 1977-08-14 00:00:00 | 助教   | 电子工程系 |
| 856        | 张旭         | 男          | 1969-03-12 00:00:00 | 讲师   | 电子工程系 |
+------------+--------------+-------------+---------------------+--------+------------+
4 rows in set (0.00 sec)

-- 课程表
INSERT INTO course VALUES ('3-105', '计算机导论', '825');
INSERT INTO course VALUES ('3-245', '操作系统', '804');
INSERT INTO course VALUES ('6-166', '数字电路', '856');
INSERT INTO course VALUES ('9-888', '高等数学', '831');

mysql> select * from course;
+-----------+-------------+------------+
| course_no | course_name | teacher_no |
+-----------+-------------+------------+
| 3-105     | 计算机导论  | 825        |
| 3-245     | 操作系统    | 804        |
| 6-166     | 数字电路    | 856        |
| 9-888     | 高等数学    | 831        |
+-----------+-------------+------------+
4 rows in set (0.07 sec)

-- 成绩表
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

