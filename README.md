# E-Commerce-Sales-Customer-Insights-
E-commerce sales and customer insights project using Power BI and SQL
# 📊 E-Commerce Sales & Customer Insights Dashboard (Power BI + SQL)

This project showcases a fully interactive sales and customer analysis dashboard built using **Power BI** and **SQL**. The dataset is based on customer orders and product sales, and insights are derived by writing SQL queries and building professional visuals in Power BI.

---

## 🔧 Tools & Technologies Used

- 💻 **SQL (MySQL Workbench)** – Data analysis and querying
- 📊 **Power BI** – Dashboard design and DAX measures
- 📁 **CSV files** – Source data exported from SQL
- 📈 **DAX** – Measures for KPIs and trend analysis

---

## 📁 Dataset Tables

- `customers.csv` – Customer information (name, country, credit, etc.)
- `orders.csv` – Order details with order dates and status
- `order_details.csv` – Product-level order data (quantity, price, etc.)

---

## 📊 Dashboard Insights

- ✅ **Total Revenue, Orders, Customers, and AOV**
- 📈 **Monthly Revenue Trend**
- 👥 **Top 5 Customers by Revenue**
- 📦 **Top Products by Revenue**
- 🌍 **Revenue by Country**
- 🔍 **Slicers** for Country, Customer Name, and Month

---

## 🧠 Business Questions Answered

- What is the overall revenue and AOV?
- Who are the top 5 revenue-generating customers?
- Which countries contribute the most to total revenue?
- What is the trend of monthly revenue?
- What are the top-selling products by revenue?

---

## 🧾 SQL Queries
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
