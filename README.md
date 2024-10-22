## What is Postgresql?

**PostgreSQL**, often referred to as **Postgres**, has been in active development since 1989 and has evolved into one of the most robust relational database management systems available today. Known for its **ACID compliance** (Atomicity, Consistency, Isolation, Durability), it ensures the reliability and integrity of your data. PostgreSQL is an open-source descendant of this original Berkeley code. Its advanced features like **complex queries**, **foreign keys**, **triggers**, **updatable views**, **transactional integrity**, and **multi-version concurrency control (MVCC)** make PostgreSQL a top choice for a wide range of applications, from small web apps to large enterprise systems.

And because of the liberal license, PostgreSQL can be used, modified, and distributed by anyone free of charge for any purpose, be it private, commercial, or academic.

## What is the purpose of a database schema in PostgreSQL?

Schema is a collection of logical structures of data.Basically, schemas are a way to group tables together.

There are several reasons why one might want to use schemas:

1. To allow many users to use one database without interfering with each other.

2. To organize database objects into logical groups to make them more manageable.

3. Third-party applications can be put into separate schemas so they do not collide with the names of other objects.

Schemas are analogous to directories at the operating system level, except that schemas cannot be nested.

## Explain the primary key and foreign key concepts in PostgreSQL.

A primary key is a column or a group of columns which is used to identify an unique row in a table.A primary key is one of the constraints that we define to restrict data input and validate.

It can be formed with:

- NOT NULL Constraint

- UNIQUE Constraint

Here is an example of how we can add primary key into our table

```bash
CREATE TABLE author (
  id integer PRIMARY KEY,
  name text,
);

```

If we want to add primary key after creating the table,then we need to see this example

```bash
ALTER TABLE author ADD PRIMARY KEY (id);
```

We can remove primary key from constraints too.Here is an example

```bash
ALTER TABLE author DROP CONSTRAINT author_pkey;
```

Whereas a foreign key is a column or group of columns in a relational database table that provides a link between data in two tables.A foreign key constraint specifies that the values in a column must match the values appearing in a row of another table.

We can make foreign key in a table like the following example

```bash
CREATE Table courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL
);

CREATE Table enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id)
);
```

We can add a foreign key to an existing table by using the ALTER TABLE statement.

```bash
ALTER TABLE enrollment
    ADD CONSTRAINT fk_courses FOREIGN KEY (course_id) REFERENCES courses(course_id);
```

And finally we can remove a foreign key constraint from a table

```bash
ALTER TABLE table_name
   DROP CONSTRAINT foreign_key_name;
```

## What is the difference between the VARCHAR and CHAR data types?

SQL has two primary character types:

- character varying(n),
- character(n)

Here n is a positive integer. Both of these types can store strings up to n characters (not bytes) in length.

The type name varchar is an alias for character varying and char are aliases for character.The main difference between char and varchar is that the char data type stores characters of a fixed length. On the other hand, the varchar data type stores characters of variable length.

Char is a data type in SQL that allows storing a character string of fixed length specified.

The storage size of the Char is n bytes. So, a CHAR(1000) field (or variable) takes up 1000 bytes on a disk, regardless of the string it holds. This data type is best used when you expect the data values in a column to be the same length.

Varchar is a data type in SQL that allows you to store character strings of variable length but a maximum of the set length specified.

Varchar only uses the space it needs to store the string and will not be padded with spaces, as was the case when using the Char data type. One of the main advantages of using VARCHAR over CHAR is that it can save space in the database because it only uses the amount needed to store the actual data and not a fixed amount of space for all rows, regardless of the length of the stored string.

Here are the key differences between Char and Varchar data types:

- Char has a fixed size, but varchar has a variable size.
- Char data type stores data of fixed length, whereas the Varchar data type stores variable format data.
- Varchar data type values are not padded with spaces; char values are padded with spaces to the specified length.
- Char uses a fixed amount of space for each value, regardless of the length of the stored string. In contrast, varchar only uses the space needed to store the data.
- Char is best used when you expect the data values in a column to be the same length. On the other hand, varchar is best used when you expect the data values in a column to be of variable length.

## Explain the purpose of the WHERE clause in a SELECT statement.

The WHERE clause in PostgreSQL is used to filter records based on a specified condition. It is one of the most commonly used clauses in SQL, enabling you to retrieve only those rows that meet the criteria defined in the condition.

We can filter by a single condition

```bash
SELECT id, name, department, salary
FROM employees
WHERE department = 'Engineering';

```

And we also can filter by multiple conditions

```bash
SELECT id, name, department, salary
FROM employees
WHERE department = 'Engineering' AND salary > 70000;
```

## What are the LIMIT and OFFSET clauses used for?

The LIMIT and OFFSET clauses in SQL are powerful tools for managing and manipulating data.The limit option allows you to limit the number of rows returned from a query, while offset allows you to omit a specified number of rows before the beginning of the result set.

We can implement pagination using LIMIT and OFFSET keyword.Here is an example:

```bash
SELECT * from students
LIMIT 10 OFFSET 10*0;
```

In order to see next page:

```bash
SELECT * from students
LIMIT 10 OFFSET 10*1;
```

## How can you perform data modification using UPDATE statements?

Update statement is used for modifying data of a table. You can update individual rows, all the rows in a table, or a subset of all rows. Each column can be updated separately; the other columns are not affected.

To update existing rows, use the UPDATE command. This requires three pieces of information:

1. The name of the table and column to update

2. The new value of the column

3. Which row(s) to update

Here is an example of updating a column

```bash
UPDATE users
SET email = 'newemail@example.com'
WHERE user_id = 101;
```

For updating multiple columns

```bash
UPDATE users
SET email = 'newemail@example.com', phone = '123-456-7890'
WHERE user_id = 101;
```

There are so many ways of using the UPDATE statement.The examples given above are the very basic implementation

## What is the significance of the JOIN operation, and how does it work in PostgreSQL?

Join operation gives us the combination of rows from two or more tables,based on a related column between them.

Postgresql supports many kinds of different joins including INNER JOIN, SELF JOIN, CROSS JOIN, and OUTER JOIN. In fact, each join type defines the way two tables are related in a query. OUTER JOINS can further be divided into LEFT OUTER JOINS, RIGHT OUTER JOINS, and FULL OUTER JOINS.

- INNER JOIN creates a result table by combining rows that have matching values in two or more tables.

```bash
SELECT orders.order_id, customers.name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id;
```

- LEFT OUTER JOIN includes in a result table unmatched rows from the table that is specified before the LEFT OUTER JOIN clause.

```bash
SELECT customers.name, orders.order_id
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;
```

- RIGHT OUTER JOIN creates a result table and includes into it all the records from the right table and only matching rows from the left table.

```bash
SELECT columns
FROM table1
FULL JOIN table2
ON table1.common_column = table2.common_column;
```

- SELF JOIN joins the table to itself and allows comparing rows within the same table.

```bash
SELECT e.first_name as employee_name, m.first_name as manager_name
FROM employee e JOIN employee m on e.department_id = m.employee_id
```

- CROSS JOIN creates a result table containing paired combination of each row of the first table with each row of the second table.

```bash
SELECT columns
FROM table1
CROSS JOIN table2;
```

## Explain the GROUP BY clause and its role in aggregation operations.

The GROUP BY clause is used to aggregate data based on one or more columns. The GROUP BY clause must appear after the FROM and WHERE clauses in a SQL query.It divides a table into sets.It is most often combined with aggregate functions that produce summary values for each of those sets.

Here is a basic example

```bash
SELECT customer_num FROM orders
GROUP BY customer_num;
```

The power of the GROUP BY clause is more apparent when you use it with aggregate functions.Here is some example given below

```bash
SELECT course_name, COUNT(student_id) AS students_enrolled
FROM courses
JOIN enrollment USING(course_id)
GROUP BY course_id;


SELECT department_name, count(*) FROM employees
    JOIN departments USING(department_id)
    GROUP BY department_name;

SELECT department_name, round(avg(salary)) FROM employees
    JOIN departments USING(department_id)
    GROUP BY department_name;


```

## How can you calculate aggregate functions like COUNT, SUM, and AVG in PostgreSQL?

Like most other relational database products, PostgreSQL supports aggregate functions. An aggregate function computes a single result from multiple input rows. For example, there are aggregates to compute the count, sum, and avg (average) over a set of rows.These functions are often used with the GROUP BY clause.

1. Count: Counts the number of rows in a column.

```bash
SELECT COUNT(*)
FROM students;
```

2. SUM: Calculates the total sum of a numeric column's values.

```bash
SELECT SUM(salary)
FROM employee;
```

3. AVG: Calculates the average (mean) value of a numeric column.

```bash
SELECT AVG(salary)
FROM employee;
```
