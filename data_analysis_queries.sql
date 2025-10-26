
-- ============================================
-- SQL Data Analysis – DBeaver + SQLite
-- ============================================

-- Step 1: Create Tables
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    country TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 2: Insert Sample Data
INSERT INTO customers VALUES
(1, 'Aditi Sharma', 'aditi@gmail.com', 'India'),
(2, 'John Miller', 'john@gmail.com', 'USA'),
(3, 'Sara Khan', 'sara@gmail.com', 'India'),
(4, 'Emma Brown', 'emma@gmail.com', 'UK');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 75000),
(102, 'Headphones', 'Accessories', 3000),
(103, 'Smartwatch', 'Electronics', 12000),
(104, 'Shoes', 'Fashion', 4500);

INSERT INTO orders VALUES
(1, 1, '2024-01-15', 78000),
(2, 2, '2024-02-20', 3200),
(3, 3, '2024-03-05', 4500),
(4, 1, '2024-03-22', 15000);

INSERT INTO order_details VALUES
(1, 1, 101, 1),
(2, 1, 102, 1),
(3, 2, 102, 1),
(4, 3, 104, 1),
(5, 4, 103, 1);

-- Step 3: Queries for Data Analysis

-- 1. SELECT + WHERE + ORDER BY
SELECT name, country
FROM customers
WHERE country = 'India'
ORDER BY name ASC;

-- 2. GROUP BY + Aggregate Functions
SELECT customer_id, SUM(total_amount) AS total_spent, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

-- 3. INNER JOIN
SELECT c.name, p.product_name, o.order_date, p.price
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;

-- 4. LEFT JOIN
SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 5. Subquery
SELECT name 
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders WHERE total_amount > 10000
);

-- 6. Create a View
CREATE VIEW high_value_customers AS
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_spent > 20000;

-- 7. Handle NULL Values
UPDATE orders SET total_amount = NULL WHERE order_id = 3;

SELECT order_id, IFNULL(total_amount, 0) AS total_fixed
FROM orders;

-- 8. Create Index for Optimization
CREATE INDEX idx_customer_id ON orders(customer_id);

-- ============================================
-- End of Script
-- ============================================
