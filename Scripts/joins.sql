--INNER JOIN
SELECT 
    s.sales_id,
    c.customer_name,
    p.product_name,
    s.sales_date,
    s.quantity
FROM sales s
INNER JOIN customers c 
    ON s.customer_id = c.customer_id
INNER JOIN products p 
    ON s.product_id = p.product_id;

--LEFT JOIN
SELECT 
    c.customer_id,
    c.customer_name,
    s.sales_id
FROM customers c
LEFT JOIN sales s 
    ON c.customer_id = s.customer_id
WHERE s.sales_id IS NULL;

--RIGHT JOIN
SELECT 
    p.product_id,
    p.product_name,
    s.sales_id
FROM sales s
RIGHT JOIN products p 
    ON s.product_id = p.product_id
WHERE s.sales_id IS NULL;

--FULL JOIN
SELECT 
    c.customer_name,
    s.sales_id
FROM customers c
FULL OUTER JOIN sales s 
    ON c.customer_id = s.customer_id;

--SELF JOIN
SELECT 
    c1.customer_name AS customer1,
    c2.customer_name AS customer2,
    c1.Place
FROM customers c1
JOIN customers c2
    ON c1.Place = c2.Place
   AND c1.customer_id <> c2.customer_id;
