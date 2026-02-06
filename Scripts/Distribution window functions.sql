--Customer segmentation using distribution functions
SELECT 
    c.customer_name,
    SUM(s.quantity * p.product_price) AS total_spent,

    NTILE(4) OVER (ORDER BY SUM(s.quantity * p.product_price)) AS spending_group,

    CUME_DIST() OVER (ORDER BY SUM(s.quantity * p.product_price)) AS spending_distribution

FROM customers c
JOIN sales s 
    ON c.customer_id = s.customer_id
JOIN products p 
    ON s.product_id = p.product_id
GROUP BY c.customer_name;