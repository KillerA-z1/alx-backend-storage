-- This script initializes the database by performing the following actions:
-- 1. Drops the 'items' and 'orders' tables if they already exist.
-- 2. Creates a new 'items' table with columns:
--    - 'name': a VARCHAR(255) that cannot be NULL.
--    - 'quantity': an integer that cannot be NULL and defaults to 10.
-- 3. Creates a new 'orders' table with columns:
--    - 'item_name': a VARCHAR(255) that cannot be NULL.
--    - 'number': an integer that cannot be NULL.
-- 4. Inserts initial data into the 'items' table with the following values:
--    - "apple"
--    - "pineapple"
--    - "pear"
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS orders;

CREATE TABLE IF NOT EXISTS items (
    name VARCHAR(255) NOT NULL,
    quantity int NOT NULL DEFAULT 10
);

CREATE TABLE IF NOT EXISTS orders (
    item_name VARCHAR(255) NOT NULL,
    number int NOT NULL
);

INSERT INTO items (name) VALUES ("apple"), ("pineapple"), ("pear");