PROBLEM DEFINITION
--
Business context: A retail company works across defferent places in Rwanda, selling various electronic products to the customers.

Data challenge: The shop has customer data, product data, and sales records, but it is hard to know which products sell most, how sales change over time, and which customers spend more money.

Expected Outcome: The company wants to see top products, sales trends, customer growth, and customer spending groups to make better business decisions.

SUCCESS CRITERIA
--
The company aims to achieve goals using: Top products per place using RANK(), running monthly sales totals using SUM() and OVER(), compare sales between time periods using LAG(), group customers into spending levels using NTILE(4), find average sales trends using AVG() and OVER().

DATABASE SCHEMA
--
Creating customer table and inserting data
--
Query: create table Customers(Customer_id varchar(21) primary key,customer_name varchar(21),Place varchar(21));
![customer table](https://github.com/user-attachments/assets/1303b73c-2a12-48e9-bed5-5fcc61dee3f1)

Creating table products and inserting data
--
Query: Create table Products (product_id varchar(21) primary key, product_name varchar(21),product_price number);
![products table](https://github.com/user-attachments/assets/a5a949af-2f49-47a5-ae1a-ae40f1318939)
