--Running totals and trends using aggregate window function
SELECT 
    s.sales_date,
    (s.quantity * p.product_price) AS sale_amount,

    SUM(s.quantity * p.product_price) OVER (
        ORDER BY s.sales_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,

    AVG(s.quantity * p.product_price) OVER (
        ORDER BY s.sales_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_avg,

    MIN(s.quantity * p.product_price) OVER (
        ORDER BY s.sales_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS min_so_far,

    MAX(s.quantity * p.product_price) OVER (
        ORDER BY s.sales_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS max_so_far

FROM sales s
JOIN products p ON s.product_id = p.product_id
ORDER BY s.sales_date;