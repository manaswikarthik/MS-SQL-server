

CREATE DATABASE Retail_Returns_Refunds;

USE Retail_Returns_Refunds;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT NULL,
    store_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    store_id INT,
    employee_id INT,
    quantity INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Returns (
    return_id INT PRIMARY KEY,
    sale_id INT,
    product_id INT,
    customer_id INT,
    store_id INT,
    return_quantity INT,
    return_reason VARCHAR(100),
    return_date DATE,
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

CREATE TABLE Refunds (
    refund_id INT PRIMARY KEY,
    return_id INT NULL,
    refund_amount DECIMAL(10,2),
    refund_date DATE,
    refund_status VARCHAR(30),
    FOREIGN KEY (return_id) REFERENCES Returns(return_id)
);

CREATE TABLE Return_Feedback (
    feedback_id INT PRIMARY KEY,
    return_id INT,
    customer_id INT,
    feedback_text VARCHAR(255),
    rating INT,
    feedback_date DATE,
    FOREIGN KEY (return_id) REFERENCES Returns(return_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);



INSERT INTO Customers VALUES
(101, 'Arun Kumar', 'Chennai'),
(102, 'Priya Sharma', 'Coimbatore'),
(103, 'Rahul Verma', 'Bangalore'),
(104, 'Divya Raj', 'Chennai'),
(105, 'Karthik Kumar', 'Mumbai'),
(106, 'Sneha Patel', 'Hyderabad'),
(107, 'Vijay Anand', 'Coimbatore'),
(108, 'Meera Nair', 'Bangalore'),
(109, 'Rohan Das', 'Mumbai'),
(110, 'Ananya Rao', 'Hyderabad');


INSERT INTO Products VALUES
(201, 'Laptop', 'Electronics', 55000),
(202, 'Smartphone', 'Electronics', 25000),
(203, 'Headphones', 'Electronics', 3000),
(204, 'Office Chair', 'Furniture', 8000),
(205, 'Table', 'Furniture', 12000),
(206, 'Shoes', 'Fashion', 4000),
(207, 'T-Shirt', 'Fashion', 1000),
(208, 'Watch', 'Accessories', 5000),
(209, 'Backpack', 'Accessories', 2500),
(210, 'Printer', 'Electronics', 15000);


INSERT INTO Stores VALUES
(1, 'Chennai Central', 'Chennai', 'South'),
(2, 'Coimbatore Mall', 'Coimbatore', 'South'),
(3, 'Bangalore City', 'Bangalore', 'South'),
(4, 'Mumbai Central', 'Mumbai', 'West'),
(5, 'Hyderabad Plaza', 'Hyderabad', 'South'),
(6, 'Delhi Outlet', 'Delhi', 'North');


INSERT INTO Employees VALUES
(301, 'Manager Ravi', NULL, 1),
(302, 'Manager Priya', NULL, 2),
(303, 'Manager Kiran', NULL, 3),
(304, 'Manager Amit', NULL, 4),
(305, 'Manager Suresh', NULL, 5);

INSERT INTO Employees VALUES
(306, 'Salesperson Arun', 301, 1),
(307, 'Salesperson Divya', 301, 1),
(308, 'Salesperson Kumar', 302, 2),
(309, 'Salesperson Sneha', 302, 2),
(310, 'Salesperson Rahul', 303, 3),
(311, 'Salesperson Meera', 303, 3),
(312, 'Salesperson Vijay', 304, 4),
(313, 'Salesperson Ananya', 304, 4),
(314, 'Salesperson Karthik', 305, 5),
(315, 'Salesperson Rohan', 305, 5);


INSERT INTO Sales VALUES
(1001, 101, 201, 1, 306, 1, '2026-01-05', 55000),
(1002, 102, 202, 2, 308, 2, '2026-01-10', 50000),
(1003, 103, 203, 3, 310, 1, '2026-01-15', 3000),
(1004, 104, 204, 1, 307, 1, '2026-01-20', 8000),
(1005, 105, 205, 4, 312, 1, '2026-02-01', 12000),
(1006, 106, 206, 5, 314, 2, '2026-02-05', 8000),
(1007, 107, 207, 2, 309, 3, '2026-02-10', 3000),
(1008, 108, 208, 3, 311, 1, '2026-02-15', 5000),
(1009, 109, 209, 4, 313, 2, '2026-02-20', 5000),
(1010, 110, 210, 5, 315, 1, '2026-02-25', 15000),
(1011, 101, 202, 1, 306, 1, '2026-03-01', 25000),
(1012, 102, 203, 2, 308, 2, '2026-03-05', 6000),
(1013, 103, 204, 3, 310, 1, '2026-03-10', 8000),
(1014, 104, 206, 1, 307, 1, '2026-03-15', 4000),
(1015, 105, 207, 4, 312, 2, '2026-03-20', 2000),
(1016, 106, 208, 5, 314, 1, '2026-03-25', 5000),
(1017, 107, 201, 2, 309, 1, '2026-04-01', 55000),
(1018, 108, 202, 3, 311, 1, '2026-04-05', 25000),
(1019, 109, 203, 4, 313, 1, '2026-04-10', 3000),
(1020, 110, 204, 5, 315, 2, '2026-04-15', 16000);


INSERT INTO Returns VALUES
(501, 1001, 201, 101, 1, 1, 'Defective Product', '2026-01-15'),
(502, 1002, 202, 102, 2, 1, 'Damaged Product', '2026-01-20'),
(503, 1003, 203, 103, 3, 1, 'Wrong Product', '2026-01-25'),
(504, 1004, 204, 104, 1, 1, 'Quality Issue', '2026-02-01'),
(505, 1005, 205, 105, 4, 1, 'Damaged Product', '2026-02-10'),
(506, 1006, 206, 106, 1, 1, 'Size Issue', '2026-02-15'),
(507, 1007, 207, 107, 1, 1, 'Quality Issue', '2026-02-20'),
(508, 1008, 208, 108, 3, 1, 'Wrong Product', '2026-02-25'),
(509, 1009, 209, 109, 1, 1, 'Damaged Product', '2026-03-01'),
(510, 1010, 210, 110, 5, 1, 'Defective Product', '2026-03-05'),
(511, 1011, 202, 101, 1, 1, 'Quality Issue', '2026-03-10'),
(512, 1012, 203, 102, 1, 1, 'Wrong Product', '2026-03-15'),
(513, 1013, 204, 103, 1, 1, 'Damaged Product', '2026-03-20'),
(514, 1014, 206, 104, 1, 1, 'Size Issue', '2026-03-25'),
(515, 1015, 207, 105, 1, 1, 'Quality Issue', '2026-04-01');


INSERT INTO Refunds VALUES
(601, 501, 55000, '2026-01-16', 'Completed'),
(602, 502, 25000, '2026-01-21', 'Completed'),
(603, 503, 3000, '2026-01-26', 'Completed'),
(604, 504, 8000, '2026-02-02', 'Completed'),
(605, 505, 12000, '2026-02-11', 'Completed'),
(606, 506, 4000, '2026-02-16', 'Completed'),
(607, 507, 1000, '2026-02-21', 'Completed'),
(608, 508, 5000, '2026-02-26', 'Completed'),
(609, 509, 2500, '2026-03-02', 'Completed'),
(610, 510, 15000, '2026-03-06', 'Completed'),
(611, 511, 25000, '2026-03-11', 'Completed'),
(612, 512, 3000, '2026-03-16', 'Completed'),
(613, 513, 8000, '2026-03-21', 'Pending'),
(614, 514, 4000, '2026-03-26', 'Completed');


INSERT INTO Return_Feedback VALUES
(701, 501, 101, 'Product was defective but refund was quick', 4, '2026-01-17'),
(702, 502, 102, 'Damaged packaging', 3, '2026-01-22'),
(703, 503, 103, 'Received wrong item', 2, '2026-01-27'),
(704, 504, 104, 'Quality was poor', 2, '2026-02-03'),
(705, 505, 105, 'Refund process was smooth', 5, '2026-02-12'),
(706, 506, 106, 'Wrong size delivered', 3, '2026-02-17'),
(707, 507, 107, 'Material quality issue', 2, '2026-02-22'),
(708, 508, 108, 'Wrong product received', 1, '2026-02-27'),
(709, 509, 109, 'Product damaged during delivery', 2, '2026-03-03'),
(710, 510, 110, 'Printer was defective', 3, '2026-03-07');


-- UPDATE
UPDATE Products
SET price = 57000
WHERE product_id = 201;

UPDATE Refunds
SET refund_status = 'Completed'
WHERE refund_id = 613;

-- DELETE
DELETE FROM Return_Feedback
WHERE feedback_id = 710;

-- ALTER
ALTER TABLE Returns
ADD return_channel VARCHAR(30) DEFAULT 'Store';

ALTER TABLE Customers;



-- Q1. Products with return rate above 10%

SELECT
    p.product_id,
    p.product_name,
    COUNT(s.sale_id) AS total_sales,
    COUNT(r.return_id) AS total_returns,
    CAST(COUNT(r.return_id) * 100.0 /
         NULLIF(COUNT(s.sale_id), 0) AS DECIMAL(10,2)) AS return_rate
FROM Products p
LEFT JOIN Sales s ON p.product_id = s.product_id
LEFT JOIN Returns r ON s.sale_id = r.sale_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.return_id) * 100.0 /
       NULLIF(COUNT(s.sale_id), 0) > 10;

-- Q2. Customers with returns but no refund

SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM Customers c
JOIN Returns r ON c.customer_id = r.customer_id
LEFT JOIN Refunds f ON r.return_id = f.return_id
WHERE f.refund_id IS NULL;

-- Q3. Stores with the highest refund value

SELECT
    s.store_id,
    s.store_name,
    SUM(f.refund_amount) AS total_refunds
FROM Stores s
JOIN Returns r ON s.store_id = r.store_id
JOIN Refunds f ON r.return_id = f.return_id
GROUP BY s.store_id, s.store_name
ORDER BY total_refunds DESC;

-- Q4. Employees and their managers

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM Employees e
LEFT JOIN Employees m
ON e.manager_id = m.employee_id;

-- Q5. Products with no returns

SELECT
    p.product_id,
    p.product_name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Returns r
    WHERE r.product_id = p.product_id
);

-- Q6. Total refund amount by region

SELECT
    s.region,
    SUM(f.refund_amount) AS total_refunds
FROM Stores s
JOIN Returns r ON s.store_id = r.store_id
JOIN Refunds f ON r.return_id = f.return_id
GROUP BY s.region;

-- Q7. Customers with more than one return

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(r.return_id) AS return_count
FROM Customers c
JOIN Returns r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(r.return_id) > 1;

-- Q8. Return reasons and their counts

SELECT
    return_reason,
    COUNT(*) AS return_count
FROM Returns
GROUP BY return_reason
ORDER BY return_count DESC;

-- Q9. Stores with no returns

SELECT
    s.store_id,
    s.store_name
FROM Stores s
LEFT JOIN Returns r ON s.store_id = r.store_id
WHERE r.return_id IS NULL;

-- Q10. Return details with customer, product and refund

SELECT
    r.return_id,
    c.customer_name,
    p.product_name,
    r.return_reason,
    f.refund_amount,
    f.refund_status
FROM Returns r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Products p ON r.product_id = p.product_id
LEFT JOIN Refunds f ON r.return_id = f.return_id;

-- ============================================================
-- TASK 2: IN / NOT IN / NULL PITFALL / NOT EXISTS
-- ============================================================

-- IN: Customers who have made returns

SELECT customer_id, customer_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Returns
);

-- NOT IN: Customers who have not made returns

SELECT customer_id, customer_name
FROM Customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM Returns
    WHERE customer_id IS NOT NULL
);

-- Demonstration of NULL PITFALL

SELECT customer_id, customer_name
FROM Customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM Returns
    UNION
    SELECT NULL
);


SELECT c.customer_id, c.customer_name
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Returns r
    WHERE r.customer_id = c.customer_id
);





SELECT
    s.store_name,
    COUNT(r.return_id) AS total_returns,
    SUM(f.refund_amount) AS total_refund
FROM Stores s
LEFT JOIN Returns r ON s.store_id = r.store_id
LEFT JOIN Refunds f ON r.return_id = f.return_id
GROUP BY s.store_name;
