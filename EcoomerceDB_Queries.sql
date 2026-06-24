-- GROUP BY Queries
-- 1. Total Orders Placed by Each Customer
SELECT
    u.user_id,
    u.name,
    COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.name LIMIT 15;

-- 2. Total Revenue Generated
SELECT
    SUM(amount) AS total_revenue
FROM payments
WHERE status = 'Completed';

-- 3. Product Wise Quantity Sold
SELECT
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name ORDER BY p.product_id;

-- JOIN Queries
-- 4. Customer Order Details
SELECT
    u.name,
    o.order_id,
    o.order_date
FROM users u
INNER JOIN orders o
ON u.user_id = o.user_id;

-- 5. Complete Order Information
SELECT
    o.order_id,
    u.name,
    p.name AS product_name,
    oi.quantity,
    pay.amount,
    pay.status
FROM orders o
JOIN users u
    ON o.user_id = u.user_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN payments pay
    ON o.order_id = pay.order_id LIMIT 15;

-- Nested Queries
-- 6. Customers Who Placed More Than One Order
SELECT *
FROM users
WHERE user_id IN
(
    SELECT user_id
    FROM orders
    GROUP BY user_id
    HAVING COUNT(order_id) > 1
);

-- 7. Products Never Ordered
SELECT *
FROM products
WHERE product_id NOT IN
(
    SELECT DISTINCT product_id
    FROM order_items
);

-- Common Table Expressions (CTE)
-- 8. Top Customers by Spending
WITH CustomerSpending AS
(
    SELECT
        o.user_id,
        SUM(p.amount) AS total_spent
    FROM orders o
    JOIN payments p
    ON o.order_id = p.order_id
    WHERE p.status = 'Completed'
    GROUP BY o.user_id
)
SELECT *
FROM CustomerSpending
ORDER BY total_spent DESC;

-- Recursive Common Table Expressions (CTE)
-- 9. Recursive Running Total Example
WITH RECURSIVE RevenueSeries AS
(
    SELECT
        payment_id,
        amount,
        amount AS running_total
    FROM payments
    WHERE payment_id = 1

    UNION ALL

    SELECT
        p.payment_id,
        p.amount,
        rs.running_total + p.amount
    FROM payments p
    JOIN RevenueSeries rs
        ON p.payment_id = rs.payment_id + 1
)
SELECT *
FROM RevenueSeries;

-- Window Functions
-- 10. Top Selling Products Ranking
SELECT
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_sold,
    RANK() OVER
    (
        ORDER BY SUM(oi.quantity) DESC
    ) AS ranking
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;

-- 11. Top Selling Products Ranking usnig DENSE_RANK()
WITH product_sales AS
(
    SELECT
        p.product_id,
        p.name,
        SUM(oi.quantity) AS total_sold
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name
)
SELECT
    product_id,
    name,
    total_sold,
    DENSE_RANK() OVER
    (
        ORDER BY total_sold DESC
    ) AS ranking
FROM product_sales;

-- LEAD() and LAG() Using PARTITION BY
-- 12. Previous Order Date Per Customer
SELECT
    user_id,
    order_id,
    order_date,

    LAG(order_date)
    OVER
    (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS previous_order

FROM orders;

-- 13. Next Order Date Per Customer
SELECT
    user_id,
    order_id,
    order_date,

    LEAD(order_date)
    OVER
    (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS next_order

FROM orders;

-- 14. Running Total Revenue by Payment Status using SUM()
SELECT
    payment_id,
    status,
    amount,

    SUM(amount)
    OVER
    (
        PARTITION BY status
        ORDER BY payment_id
    ) AS running_total

FROM payments LIMIT 10;

-- 15. Running Average Payment
SELECT
    payment_id,
    amount,

    AVG(amount)
    OVER
    (
        ORDER BY payment_id
    ) AS running_average

FROM payments;

-- 16. NTILE with PARTITION BY Status
SELECT
    payment_id,
    status,
    amount,

    NTILE(3)
    OVER
    (
        PARTITION BY status
        ORDER BY amount DESC
    ) AS payment_bucket

FROM payments;

-- Advanced Analytics Report
-- 17. Monthly Revenue Report
SELECT
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(p.amount) AS revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
WHERE p.status = 'Completed'
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY year, month;

-- 18. Top 5 Customers
SELECT
    u.user_id,
    u.name,
    SUM(pay.amount) AS total_spent
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
JOIN payments pay
    ON o.order_id = pay.order_id
WHERE pay.status = 'Completed'
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC
LIMIT 5;

-- 19. Low Stock Products
SELECT
    product_id,
    name,
    stock
FROM products
WHERE stock < 20;


