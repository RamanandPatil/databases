
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

/*
    Where clause is used to filter the data from database.
    For example if I want to filter only the customers who have points > 3000.
*/

SELECT
    *
FROM
    customers
WHERE
    points > 3000;

/* Comparison Operators:
    >       Greater than
    >=      Greater than OR Equal to
    <       Less than
    <=      Less than OR Equal to
    =       Equal to (Equality operator)
    !=      Not Equal to
    <>      Not Equal to
*/

-- Example 1: Find all the customers not in the state of Virginia(VA);
SELECT
    *
FROM
    customers
WHERE
    state != 'VA';


-- OR

SELECT
    *
FROM
    customers
WHERE
    state <> 'VA';
    -- state <> 'va'; -- this will also work because MySQL strings are
                      -- not case sensitive.


-- Example 2: Find all the customers who are born after January 1st 1990.
SELECT
    *
FROM
    customers
WHERE
    birth_date > '1990-01-01'; -- Date is represented as yyyy-mm-dd' format.



/*
    ============================== Exercise Time: ==============================
*/

-- Get orders placed this year/current year:
SELECT
    *
FROM
    orders
WHERE
    order_date >= '2019-01-01';




/*
    ============================================================================
    ==================== The AND, OR and NOT Operators =========================
    ============================================================================
*/

/*
    AND: use when both conditions should be true for the result.
    OR: Either(any one) condition should be true for the result.
    NOT: When the condition should not be true for the result.
*/

/*
    AND Example:
        Find customers born after 1st Jan 1990 and have more than 1000 points.
*/
SELECT
    *
FROM
    customers
WHERE
    birth_date > '1990-01-01'
        AND points > 1000;

/*
    OR Example:
        Find customers born after 1st Jan 1990 or have more than 1000 points.
*/
SELECT
    *
FROM
    customers
WHERE
    birth_date > '1990-01-01'
        OR points > 1000;

/*
    OR and AND Example:
        Find customers either born after 1st Jan 1990 or have more than 1000
        points and who live in Virginia.
*/
SELECT
    *
FROM
    customers
WHERE
    birth_date > '1990-01-01'
        OR (points > 1000 AND state = 'VA');

/*
    -- AND operator has higher precedence then OR.
    -- OR has higher precedence than NOT.
    -- NOT has lowest precedence.
*/
/*
    NOT Example:
        Find customers not born after 1st Jan 1990 or doesn't have more than
        1000 points.
    From the statement it is very clear that this is the NOT of our above
    OR example. So, we can just use not on the condition of that example.
*/
SELECT
    *
FROM
    customers
WHERE
    NOT (birth_date > '1990-01-01'
        OR points > 1000);

/*
    The above example actually lists the customers who are born on or before 1st
    January 1990 and have points less than or equal to 1000.
    To confirm compare the result of the above query with this one:
*/
SELECT
    *
FROM
    customers
WHERE
    birth_date <= '1990-01-01'
        AND points <= 1000;

/*
    This means below 2 statements are same:
    NOT (birth_date > '1990-01-01' OR points > 1000);
    birth_date <= '1990-01-01' AND points <= 1000;

    i.e. After removing NOT, > became <= and OR because AND.
*/


/*
    ============================== Exercise Time: ==============================
*/

/*
    From the order_items table, get the items for order no. 6 where the total
    price is greater than 30
*/

SELECT
    *
FROM
    order_items
WHERE
    order_id = 6
        AND (quantity * unit_price) > 30;



/*
    ============================================================================
    ========================== The IN Operator =================================
    ============================================================================
*/

-- Notes: TODO


/*
    ============================== Exercise Time: ==============================
*/

/*
    Return products with quantity in stock equal to 49, 38, 72.
*/
SELECT
    *
FROM
    sql_store.products
WHERE
    quantity_in_stock IN (49 , 38, 72);


/*
    ============================================================================
    ========================== The BETWEEN Operator =================================
    ============================================================================
*/

-- Notes: TODO


/*
    ============================== Exercise Time: ==============================
*/

/*
    Return CUSTOMERS BORN BETWEEN 1/1/1990 AND 1/1/200
*/
SELECT
    *
FROM
    sql_store.customers
WHERE
    birth_date BETWEEN '1990-01-01' AND '2000-01-01';



/*
    ============================================================================
    ========================== The LIKE Operator =================================
    ============================================================================
*/

/*
    %   Matches with any number of characters.(0 or more).
    _   Matches with a single character.(any one character).

-- Notes: TODO


/*
    ============================== Exercise Time: ==============================
*/

/*
    1. Get the customers whose address contains TRAIL or AVENUE
*/
SELECT
    *
FROM
    sql_store.customers
WHERE
    address LIKE '%TRAIL%'
        OR address LIKE '%AVENUE%';

/*
    2. Get the customers whose phone numbers end with 9.
*/
SELECT
    *
FROM
    sql_store.customers
WHERE
    phone LIKE '%9';



/*
    ============================================================================
    ========================== The REGEXP Operator =================================
    ============================================================================
*/

/*
    ^   Start(beginning) of the string
    $   End of the string
    |   logical OR operator in regex
    []  Any one of the character in the square brackets
    -   To match the range. e.g. [a-d] matches to a or b or c or d.

*/



/*
    ============================== Exercise Time: ==============================
*/

/*
    Write 4 separate queries for the below exercise:
    Get the customers whose:
        - first names are ELKA OR AMBUR
        - last names end with EY or ON
        - last names start with MY or contains SE
        - last names contain B followed by R or U.
*/

-- Solutions:
-- 1.
SELECT
    *
FROM
    customers
WHERE
    first_name REGEXP 'elka|ambur';


-- 2.
SELECT
    *
FROM
    customers
WHERE
    last_name REGEXP 'ey$|on$';

-- 3.
SELECT
    *
FROM
    customers
WHERE
    last_name REGEXP '^my|se';

-- 4.
SELECT
    *
FROM
    customers
WHERE
    last_name REGEXP 'b[ru]';
    -- last_name REGEXP 'br|bu'; -- this is also correct





/*
    ============================================================================
    ========================== The IS NULL Operator ============================
    ============================================================================
*/
