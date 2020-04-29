-- 3NF
-- 必须先满足第二范式，再要求除主键列的其他列，不能有传递依赖关系

CREATE TABLE myorder (
  order_id int PRIMARY KEY,
  product_id int,
  customer_id int,
  customer_phone VARCHAR(15)
);
-- 本例中 customer_phone 还依赖于 customer_id，有传递依赖关系
-- 应该将 customer_phone 放置于 customer table 中


CREATE TABLE customer (
  id int PRIMARY KEY,
  name VARCHAR(20)，
  phone VARCHAR(15),
);
