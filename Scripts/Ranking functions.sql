-- Top products per revenue using ranking window functions
SELECT 
    p.product_name,
    SUM(s.quantity * p.product_price) AS total_sales,

    ROW_NUMBER() OVER (ORDER BY SUM(s.quantity * p.product_price) DESC) AS row_no,

    RANK() OVER (ORDER BY SUM(s.quantity * p.product_price) DESC) AS rank_no,

    DENSE_RANK() OVER (ORDER BY SUM(s.quantity * p.product_price) DESC) AS dense_rank_no,

    PERCENT_RANK() OVER (ORDER BY SUM(s.quantity * p.product_price)) AS percent_rank

FROM sales s
JOIN products p 
    ON s.product_id = p.product_id
GROUP BY p.product_name;
