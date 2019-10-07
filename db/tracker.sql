DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE merchants (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE tags (
  id SERIAL8 PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE,
  amount DECIMAL(18, 2)
);
