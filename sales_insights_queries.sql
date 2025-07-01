
-- 🧾 SALES & CUSTOMER INSIGHTS PROJECT
-- Author: K Praveen Kumar
-- Tool: MySQL Workbench
-- Data: customers.csv, orders.csv, order_details.csv

-- ✅ 1. Total Number of Customers
SELECT COUNT(DISTINCT customerNumber) AS total_customers
FROM customers;

-- ✅ 2. Total Number of Orders
SELECT COUNT(DISTINCT orderNumber) AS total_orders
FROM orders;

-- ✅ 3. Total Revenue
SELECT 
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS total_revenue
FROM order_details od;

-- ✅ 4. Average Order Value (AOV)
SELECT 
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_order_value
FROM orders o
JOIN order_details od ON o.orderNumber = od.orderNumber;

-- ✅ 5. Top 5 Customers by Revenue
SELECT 
    c.customerName,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN order_details od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY total_spent DESC
LIMIT 5;

-- ✅ 6. Revenue by Country
SELECT 
    c.country,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS revenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN order_details od ON o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY revenue DESC;

-- ✅ 7. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(o.orderDate, '%Y-%m') AS order_month,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS monthly_revenue
FROM orders o
JOIN order_details od ON o.orderNumber = od.orderNumber
GROUP BY order_month
ORDER BY order_month;

-- ✅ 8. Inactive Customers (No Orders)
SELECT 
    c.customerName,
    c.country
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL;
