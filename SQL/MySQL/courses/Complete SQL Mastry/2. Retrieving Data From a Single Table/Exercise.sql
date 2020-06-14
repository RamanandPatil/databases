# 1.
/*
Write a query to return all the products in the database. Show only the
below columns for all the product records.
    - name
    - unit_price
    - new price (unit_price * 1.1)
*/

# Solution:
USE sql_store;
SELECT name,
       unit_price,
       unit_price * 1.1 AS "new price"
FROM products;

