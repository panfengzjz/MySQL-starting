-- 2NF
-- ���������һ��ʽ����Ҫ��ÿһ�г������⣬������ȫ��������
-- ����ȫ��������ֻ���ܷ��������������������

CREATE TABLE myorder(
  product_id int,
  customer_id int,
  product_name VARCHAR(20),
  customer_name VARCHAR(20),
  PRIMARY KEY(product_id, customer_id)
);
-- �������������� product_id, customer_id
-- ���������� product_name ֻ�����������Ĳ����ֶΣ���˲����ϵڶ���ʽ
-- ��Ҫͨ�����������ʵ�ֵڶ���ʽ

CREATE TABLE myorder (
  order_id int PRIMARY KEY,
  product_id int,
  customer_id int
);

CREATE TABLE product (
  id int PRIMARY KEY,
  name VARCHAR(20)
);

CREATE TABLE customer (
  id int PRIMARY KEY,
  name VARCHAR(20)
);
-- �������ϱ����������ű�֮����������ȫ��������
-- ����ڶ���ʽҪ��
