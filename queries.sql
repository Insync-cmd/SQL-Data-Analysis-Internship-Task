-- ============================================
-- SQL Data Analyst Internship Task
-- Dataset: Ecommerce_SQL_Database
-- ============================================

------------------------------------------------
-- Task 3: Interview Questions
------------------------------------------------

-- 1. Difference between WHERE and HAVING
-- WHERE filters rows before aggregation
-- HAVING filters groups after aggregation
SELECT country, COUNT(*) AS user_count
FROM users
WHERE country IS NOT NULL
GROUP BY country
HAVING COUNT(*) > 1;


-- 2. Types of Joins
-- INNER JOIN: only matching rows
SELECT u.user_id, u.name, o.order_id, o.revenue
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id;

-- LEFT JOIN: all users, even without orders
SELECT u.user_id, u.name, o.order_id, o.revenue
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;

-- RIGHT JOIN (not supported in SQLite, works in MySQL/Postgres)
SELECT u.user_id, u.name, o.order_id, o.revenue
FROM users u
RIGHT JOIN orders o ON u.user_id = o.user_id;


-- 3. Average Revenue per User
SELECT AVG(user_total) AS avg_revenue_per_user
FROM (
    SELECT user_id, SUM(revenue) AS user_total
    FROM orders
    GROUP BY user_id
) t;


-- 4. Subqueries
-- Find users who spent more than 1000
SELECT name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    HAVING SUM(revenue) > 1000
);


-- 5. Optimizing Queries
-- Example: Indexes (MySQL/Postgres)
CREATE INDEX idx_orders_userid ON orders(user_id);
CREATE INDEX idx_products_category ON products(category);


-- 6. Views
CREATE VIEW user_revenue AS
SELECT u.user_id, u.name, SUM(o.revenue) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name;


-- 7. Handling NULL values
SELECT COALESCE(country, 'Unknown') AS country_name, COUNT(*) AS users
FROM users
GROUP BY country;


------------------------------------------------
-- Task 4: SQL for Data Analysis
------------------------------------------------

-- a) SELECT, WHERE, ORDER BY
SELECT *
FROM orders
WHERE revenue > 500
ORDER BY revenue DESC;


-- b) Joins
SELECT u.name, p.category, o.revenue, o.order_date
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id;


-- c) Subquery
-- Products that cost more than avg price
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);


-- d) Aggregate Functions
-- Sales by category
SELECT p.category, SUM(o.revenue) AS total_sales, AVG(o.revenue) AS avg_sale
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;


-- e) Create Views
CREATE VIEW high_value_orders AS
SELECT order_id, user_id, revenue
FROM orders
WHERE revenue > 1000;


-- f) Optimization
-- Indexes already shown above (products.category, orders.user_id)

------------------------------------------------
-- END OF FILE
------------------------------------------------
