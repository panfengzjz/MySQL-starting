-- 2NF
-- 必须满足第一范式，再要求每一列除主键外，必须完全依赖主键
-- 不完全依赖，则只可能发生在联合主键的情况下

CREATE TABLE myorder(
  product_id int,
  customer_id int,
  product_name VARCHAR(20),
  customer_name VARCHAR(20),
  PRIMARY KEY(product_id, customer_id)
);
-- 本例中主键包括 product_id, customer_id
-- 其他列例如 product_name 只依赖于主键的部分字段，因此不符合第二范式
-- 需要通过拆表（？）来实现第二范式

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
-- 经过将上表拆成这样三张表之后，其他列完全依赖主键
-- 满足第二范式要求
