-- 3NF
-- ����������ڶ���ʽ����Ҫ��������е������У������д���������ϵ

CREATE TABLE myorder (
  order_id int PRIMARY KEY,
  product_id int,
  customer_id int,
  customer_phone VARCHAR(15)
);
-- ������ customer_phone �������� customer_id���д���������ϵ
-- Ӧ�ý� customer_phone ������ customer table ��


CREATE TABLE customer (
  id int PRIMARY KEY,
  name VARCHAR(20)��
  phone VARCHAR(15),
);
