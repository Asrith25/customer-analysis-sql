-- Customer Analysis Project
-- Created using MySQL
-- Purpose: Analyze customer registrations by city and date

CREATE DATABASE IF NOT EXISTS customer_analysis;
USE customer_analysis;
-- Create customers table

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(30),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(30),
    registration_date DATE
);
-- Insert customer data

INSERT IGNORE INTO customers
(customer_id, name, phone_number, email, city, registration_date)
VALUES
(1, 'Arjun', '9876543210', 'arjun@gmail.com', 'Vizag', '2026-02-10'),
(2, 'Priya', '9876543211', 'priya@gmail.com', 'Hyderabad', '2026-02-15'),
(3, 'Rahul', '9876543212', 'rahul@gmail.com', 'Chennai', '2026-02-20'),
(4, 'Neha', '9876543213', 'neha@gmail.com', 'Vizag', '2026-03-05'),
(5, 'Kiran', '9876543214', 'kiran@gmail.com', 'Hyderabad', '2026-03-12'),
(6, 'Anjali', '9876543215', 'anjali@gmail.com', 'Vizag', '2026-03-18'),
(7, 'Vijay', '9876543216', 'vijay@gmail.com', 'Chennai', '2026-04-02'),
(8, 'Ravi', '9876543217', 'ravi@gmail.com', 'Vizag', '2026-04-10'),
(9, 'Meena', '9876543218', 'meena@gmail.com', 'Hyderabad', '2026-04-22'),
(10, 'Suresh', '9876543219', 'suresh@gmail.com', 'Vizag', '2026-05-08');
-- 1. View all customers
SELECT * FROM customers;

-- 2. Customers by city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- 3. Monthly registrations
SELECT 
    MONTHNAME(registration_date) AS month,
    COUNT(*) AS total_customers
FROM customers
GROUP BY MONTHNAME(registration_date), MONTH(registration_date)
ORDER BY MONTH(registration_date);

-- 4. Customers by city, highest to lowest
SELECT 
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- 5. Customers registered after March 1
SELECT *
FROM customers
WHERE registration_date > '2026-03-01'
ORDER BY registration_date;

-- 6. Classify customers by location
SELECT
    name,
    city,
    CASE
        WHEN city = 'Vizag' THEN 'Local'
        ELSE 'Other City'
    END AS customer_type
FROM customers;

-- 7. Local vs Other City customers
SELECT
    CASE
        WHEN city = 'Vizag' THEN 'Local'
        ELSE 'Other City'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_type;

-- 8. Latest registered customer
SELECT *
FROM customers
ORDER BY registration_date DESC
LIMIT 1;

-- 9. City-wise registrations after March 1
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
WHERE registration_date > '2026-03-01'
GROUP BY city
ORDER BY total_customers DESC;

-- 10. Project summary
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT city) AS total_cities,
    MIN(registration_date) AS first_registration,
    MAX(registration_date) AS latest_registration
FROM customers;