
-- This is a single line comment.
/*
    This is a multi-line comment spread over
    multiple lines.
*/

/*
	"USE" keyword is used to select a database from MySQL for which we want to
    write our queries.
    For example, below we wrote "USE sql_store". Which means, we are selecting a
    database named "sql_store" (because we want to work on table named
    "customers" in this database.)
    After executing the USE query you can see the sql_store database is
    highlighted in navigator panel on the left side of the MySQL Workbench.
*/
USE sql_store;

-- Semicolon is must at the end of each SQL statement.

SELECT
    *
FROM
    customers;

-- Now, select a record(row) from customers table where customer id is 1.
SELECT
    *
FROM
    customers
WHERE
    customer_id = 1;

/* 	Please note that, while working in SQL workbench, you need to select the SQL
    queries/statements you want to execute, otherwise all the queries written
    this whole SQL query file will also be executed one by one.
*/

SELECT
    *
FROM
    customers
WHERE
    customer_id <> 1
ORDER BY first_name;

/*
    Note: Except SELECT, all the above keywords (FROM, WHERE, ORDER BY) are
    optional. If present they must be in the same oder as shown in above query.
    (i.e. FROM, WHERE, OREDR BY).
    So, with only SELECT, below all statements are valid:
    (Please select each one of them and execute)
    (Shortcuts:
		Execute(All/Selection): Ctlr+Shift+Enter
        Execute current statement: Ctlr+Enter
    )
*/
SELECT 1, 2, 3;
SELECT 1 + 2 + 3;
SELECT 'ORANGES';

/*  Below query will fail with message:
        Error Code: 1054. Unknown column 'CUSTOMER' in 'field list'
*/
-- SELECT CUSTOMER;





/*
    ============================================================================
    ============================= SQL SELECT Clause ============================
    ============================================================================
*/

SELECT
    *
FROM
    customers;

/*
	Here we are selecting all the records from the customers table.
    Most of the time it is not required. Instead, most of the time we will be
    interested in getting only required columns from customers tables.
    Let us try to do that by selecting only first_name and last_name columns.
*/
SELECT
    first_name, last_name
FROM
    customers;

-- If we want to display first last_name and then first name:
SELECT
    last_name, first_name
FROM
    customers;


-- Looks at the below query:
SELECT
    last_name, first_name, points, points + 10
FROM
    customers;
/*	You can see that the above query has created a new column named "points+10"
    which contains the actual points + 10 calculated for each of the customer
    record displayed.
    You can do even more complex math on the points table and the result will be
    displayed according to that. See the below query:
*/
SELECT
    last_name, first_name, points, points * 10 + 1000 / 10
FROM
    customers;
/* 	You can see that the last column- "points * 10 + 1000 / 10" is calculated
    based on the points value and using normal mathematics execution order for
    operators using BODMAS rule.
    Also, note the value in the column is converted into decimal value. This is
    because we have used division operator in the calculation.
    It is always advised that, always use brackets to avoid any confusion and to
    show our intention clearly in the query.
    See the below query for example:
*/
SELECT
    last_name, first_name, points, (points + 10) * 100
FROM
    customers;

-- Let us now get rid of that weird column name using "AS" keyword:

SELECT
    last_name,
    first_name,
    points,
    ((points + 10) * 100) AS discount_factor
FROM
    customers;

/*  Now, you can see that the last column name makes sense.
    Note: "AS" keyword can be used to give alias to any of the existing columns
    of the table as well.
*/
SELECT
    last_name AS family_name,
    first_name,
    points,
    ((points + 10) * 100) AS discount_factor
FROM
    customers;
/*  After executing above query, you can see that "last_name" column name is
    displayed as "family_name".
    Note: If your alias name contains space(s) within it, you should surround it
    with double quotes. for example- "discount factor"
*/
SELECT
    last_name AS family_name,
    first_name,
    points,
    ((points + 10) * 100) AS 'discount factor'
FROM
    customers;


-- Looks at the below query, to display states for customers:
SELECT
    state
FROM
    customers;
/*
    You can see the FL state is repeated twice. As we are interested in getting
    to know about states, we should remove the duplicate state name from our
    result. In another word, we want to get all the unique/distinct states from
    the customers table. This can be done using "DISTINCT" keyword.
*/
SELECT DISTINCT
    state
FROM
    customers;

/*
    Let us display the count of above 2 queries to see how many non-distinct and
    distinct states are there in customers table.
*/
SELECT
    COUNT(state)
FROM
    customers;-- We got 10.
SELECT
    COUNT(DISTINCT state)
FROM
    customers; -- We got 9.



/*
    ============================== Exercise Time: ==============================
*/

/*
    Write a query to return all the products in the database. Show only the
    below columns for all the product records.
    - name
    - unit_price
    - new price (unit_price * 1.1)
*/

-- Solution:

USE products;
SELECT
    name,
    unit_price,
    unit_price * 1.1 AS 'new price'
FROM
    products;






/*
    ============================================================================
    ============================= SQL WHERE Clause =============================
    ============================================================================
*/

