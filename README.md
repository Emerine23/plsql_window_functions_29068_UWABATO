PROBLEM DEFINITION
--
Business context: A retail sales company works across defferent places in Rwanda, selling various electronic products to the customers.

Data challenge: The shop has customer data, product data, and sales records, but it is hard to know which products sell most, how sales change over time, and which customers spend more money.

Expected Outcome: The company wants to see top products, sales trends, customer growth, and customer spending groups to make better business decisions.

SUCCESS CRITERIA
--
The company aims to achieve goals using: Top products per place using RANK(), running monthly sales totals using SUM() and OVER(), compare sales between time periods using LAG(), group customers into spending levels using NTILE(4), find average sales trends using AVG() and OVER().

DATABASE SCHEMA
--
Creating customer table and inserting data
--

    create table Customers(
    Customer_id varchar(21) primary key,
    customer_name varchar(21),
    Place varchar(21));

![customer table](https://github.com/user-attachments/assets/1303b73c-2a12-48e9-bed5-5fcc61dee3f1)

Creating table products and inserting data
--
Query: Create table Products (product_id varchar(21) primary key, product_name varchar(21),product_price number);

![products table](https://github.com/user-attachments/assets/a5a949af-2f49-47a5-ae1a-ae40f1318939)

Creating table sales and inserting data
--
Query: Create table Sales (sales_id varchar(21) primary key, Customer_id varchar(21),product_id varchar(21),sales_date DATE, quantity INT, 
foreign key (Customer_id) references Customers(Customer_id),foreign key(product_id) references Products(product_id));
![sales table](https://github.com/user-attachments/assets/d4cc5ee8-360b-494d-a91d-70199bf00708)

ER diagram of a retail sales company

<img width="727" height="547" alt="ERD" src="https://github.com/user-attachments/assets/14a45f0f-7101-43b5-acd7-9fd6bca90445" />

Top products per revenue 
--

    SELECT p.product_name, SUM(s.quantity * p.product_price) AS total_sales, ROW_NUMBER() OVER (ORDER BY SUM(s.quantity * p.product_price) DESC) AS row_no, RANK() OVER (ORDER BY SUM(s.quantity * p.product_price) DESC) AS rank_no, DENSE_RANK() OVER (ORDER BY SUM(s.quantity * p.product_price) DESC) AS dense_rank_no, PERCENT_RANK() OVER (ORDER BY SUM(s.quantity * p.product_price)) AS percent_rank FROM sales s JOIN products p ON s.product_id = p.product_id GROUP BY p.product_name;

![Ranking functions](https://github.com/user-attachments/assets/bd76a939-7149-438d-983b-1a61d3c4e8da)

WINDOW FUNCTIONS
--

Running total trends
--

    SELECT s.sales_date,(s.quantity * p.product_price) AS sale_amount, SUM(s.quantity * p.product_price) OVER (ORDER BY s.sales_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total, AVG(s.quantity * p.product_price) OVER (ORDER BY s.sales_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg, MIN(s.quantity * p.product_price) OVER (ORDER BY s.sales_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS min_so_far, MAX(s.quantity * p.product_price) OVER (ORDER BY s.sales_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS max_so_far FROM sales s JOIN products p ON s.product_id = p.product_id ORDER BY s.sales_date;

<img width="835" height="210" alt="aggregate functions" src="https://github.com/user-attachments/assets/9c88519b-1129-42f8-a153-2383c60bfacb" />

Comparing sales over time
--

    SELECT s.sales_date, (s.quantity * p.product_price) AS current_sales, LAG(s.quantity * p.product_price) OVER (ORDER BY s.sales_date) AS previous_sales, (s.quantity * p.product_price) - LAG(s.quantity * p.product_price) OVER (ORDER BY s.sales_date) AS growth FROM sales s JOIN products p ON s.product_id = p.product_id ORDER BY s.sales_date;

<img width="843" height="216" alt="navigation window function" src="https://github.com/user-attachments/assets/b6b333df-2a4b-4cea-9f70-6310ff7bfd5d" />

Customer segmentation
--

    SELECT c.customer_name, SUM(s.quantity * p.product_price) AS total_spent,  NTILE(4) OVER (ORDER BY SUM(s.quantity * p.product_price)) AS spending_group, CUME_DIST() OVER (ORDER BY SUM(s.quantity * p.product_price)) AS spending_distribution FROM customers c JOIN sales s  ON c.customer_id = s.customer_id JOIN products p ON s.product_id = p.product_id GROUP BY c.customer_name;

<img width="678" height="213" alt="distribution function" src="https://github.com/user-attachments/assets/e6b91dc5-2140-448f-a504-daa106d3d830" />

SQL Joins
--

INNER JOIN
--

    SELECT s.sales_id, c.customer_name, p.product_name, s.sales_date, s.quantity FROM sales s INNER JOIN customers c ON s.customer_id = c.customer_id INNER JOIN products p  ON s.product_id = p.product_id;

<img width="747" height="199" alt="inner join" src="https://github.com/user-attachments/assets/ef8ce61b-96b9-43fb-bce0-1871c87b29ef" />

It shows valid sales with customers and products.

LEFT JOIN
-- 

    SELECT c.customer_id, c.customer_name, s.sales_id FROM customers c LEFT JOIN sales s ON c.customer_id = s.customer_id WHERE s.sales_id IS NULL;

<img width="434" height="157" alt="left join" src="https://github.com/user-attachments/assets/e70a0ce5-14b0-4724-9008-92169dec1a9c" />

Shows customers with no sales

RIGHT JOIN
--

    SELECT p.product_id,  p.product_name, s.sales_id FROM sales s RIGHT JOIN products p ON s.product_id = p.product_id WHERE s.sales_id IS NULL;

<img width="585" height="197" alt="Right join" src="https://github.com/user-attachments/assets/e7dcc439-1445-4940-be49-06c41f8800e8" />

Shows products with no sales records

FULL JOIN
--

    SELECT c.customer_name, s.sales_id FROM customers c FULL OUTER JOIN sales s ON c.customer_id = s.customer_id;

<img width="691" height="223" alt="full join" src="https://github.com/user-attachments/assets/1fad6882-4327-468c-ae3d-3deac6f8667d" />

includes customers with sales and customers without sales

SELF JOIN
--

    SELECT c1.customer_name AS customer1, c2.customer_name AS customer2, c1.Place FROM customers c1 JOIN customers c2 ON c1.Place = c2.Place AND c1.customer_id <> c2.customer_id;
<img width="666" height="180" alt="self join" src="https://github.com/user-attachments/assets/b489b3b4-3b41-48a5-b321-2d8fae36cc34" />

Shows customers who lives in the same place

REFERENCES
--
[] https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/index.html

[] https://www.postgresql.org/docs/current

[] https://www.w3schools.com/sql

[] : https://mode.com/sql-tutorial/sql-window-functions

[] https://www.geeksforgeeks.org/sql-window-functions

[] s6 Computer science book

