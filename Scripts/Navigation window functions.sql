--Period comparision and growth using  navigation window function
SELECT 
    s.sales_date,
    (s.quantity * p.product_price) AS current_sales,

    LAG(s.quantity * p.product_price) OVER (ORDER BY s.sales_date) AS previous_sales,

    (s.quantity * p.product_price) - 
    LAG(s.quantity * p.product_price) OVER (ORDER BY s.sales_date) AS growth

FROM sales s
JOIN products p 
    ON s.product_id = p.product_id
ORDER BY s.sales_date;