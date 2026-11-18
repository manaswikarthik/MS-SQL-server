CREATE DATABASE banking_loan_analytics;
USE banking_loan_analytics;
CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_date DATE,
    loan_status VARCHAR(30),
    total_installments INT,
    paid_installments INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);
CREATE TABLE repayments (
    repayment_id INT PRIMARY KEY,
    loan_id INT,
    repayment_amount DECIMAL(12,2),
    repayment_date DATE,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
CREATE TABLE guarantors (
    guarantor_id INT PRIMARY KEY,
    guarantor_name VARCHAR(100),
    borrower_customer_id INT,
    loan_id INT,
    FOREIGN KEY (borrower_customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
INSERT INTO branches VALUES
(1, 'Chennai Main Branch', 'Chennai'),
(2, 'Coimbatore Branch', 'Coimbatore'),
(3, 'Bangalore Branch', 'Bangalore'),
(4, 'Mumbai Branch', 'Mumbai'),
(5, 'Hyderabad Branch', 'Hyderabad');
INSERT INTO customers VALUES
(101, 'Arun Kumar', 'Chennai'),
(102, 'Priya Sharma', 'Coimbatore'),
(103, 'Rahul Verma', 'Bangalore'),
(104, 'Divya Raj', 'Chennai'),
(105, 'Karthik Kumar', 'Mumbai'),
(106, 'Sneha Patel', 'Hyderabad'),
(107, 'Vijay Anand', 'Coimbatore'),
(108, 'Meera Nair', 'Bangalore');
INSERT INTO loans VALUES
(1001, 101, 1, 500000, 8.5, '2025-01-10', 'Active', 24, 18),
(1002, 102, 2, 300000, 9.0, '2025-02-15', 'Active', 36, 20),
(1003, 103, 3, 750000, 8.0, '2025-03-20', 'Active', 48, 30),
(1004, 104, 1, 200000, 10.0, '2025-04-10', 'Active', 24, 10),
(1005, 105, 4, 900000, 7.5, '2025-05-15', 'Active', 60, 35),
(1006, 101, 2, 250000, 9.5, '2025-06-20', 'Active', 24, 12),
(1007, 106, 3, 400000, 8.8, '2025-07-10', 'Active', 36, 15),
(1008, 107, 1, 150000, 11.0, '2025-08-15', 'Active', 12, 4),
(1009, 108, 4, 600000, 8.2, '2025-09-20', 'Active', 48, 28),
(1010, 103, 2, 350000, 9.0, '2025-10-10', 'Active', 36, 22);
INSERT INTO repayments VALUES
(1, 1001, 25000, '2026-09-01'),
(2, 1001, 25000, '2026-10-01'),
(3, 1001, 25000, '2026-11-01'),

(4, 1002, 15000, '2026-08-15'),
(5, 1002, 15000, '2026-09-15'),

(6, 1003, 30000, '2026-10-10'),
(7, 1003, 30000, '2026-11-10'),

(8, 1004, 10000, '2026-07-01'),
(9, 1004, 10000, '2026-08-01'),

(10, 1005, 40000, '2026-10-05'),
(11, 1005, 40000, '2026-11-05'),

(12, 1006, 12000, '2026-08-20'),
(13, 1006, 12000, '2026-09-20'),

(14, 1007, 18000, '2026-10-15'),
(15, 1007, 18000, '2026-11-15'),

(16, 1008, 8000, '2026-07-15'),

(17, 1009, 25000, '2026-10-20'),
(18, 1009, 25000, '2026-11-20'),

(19, 1010, 16000, '2026-08-25'),
(20, 1010, 16000, '2026-09-25');
INSERT INTO guarantors VALUES
(201, 'Priya Sharma', 102, 1001),
(202, 'Rahul Verma', 103, 1002),
(203, 'Arun Kumar', 101, 1003),
(204, 'Meera Nair', 108, 1004),
(205, 'Karthik Kumar', 105, 1005),
(206, 'Divya Raj', 104, 1006),
(207, 'Sneha Patel', 106, 1007),
(208, 'Vijay Anand', 107, 1008);
UPDATE loans
SET interest_rate = 9.25
WHERE loan_id = 1001;
UPDATE loans
SET loan_status = 'Closed'
WHERE loan_id = 1004;
UPDATE loans
SET paid_installments = paid_installments + 1
WHERE loan_id = 1002;
DELETE FROM repayments
WHERE repayment_id = 20;
ALTER TABLE loans
ADD COLUMN loan_type VARCHAR(50) DEFAULT 'Personal Loan';
ALTER TABLE customers
MODIFY customer_name VARCHAR(150);
SELECT l.loan_id,
       c.customer_name,
       l.loan_amount
FROM loans l
INNER JOIN customers c
ON l.customer_id = c.customer_id;
SELECT l.loan_id,
       b.branch_name,
       b.city,
       l.loan_amount
FROM loans l
INNER JOIN branches b
ON l.branch_id = b.branch_id;
SELECT l.loan_id,
       c.customer_name,
       l.total_installments,
       l.paid_installments,
       (l.total_installments - l.paid_installments) AS pending_installments
FROM loans l
INNER JOIN customers c
ON l.customer_id = c.customer_id
WHERE (l.total_installments - l.paid_installments) > 3;
SELECT c.customer_id,
       c.customer_name,
       COUNT(DISTINCT l.branch_id) AS branch_count
FROM customers c
INNER JOIN loans l
ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT l.branch_id) > 1;
SELECT g.guarantor_name,
       c.customer_name AS borrower,
       g.loan_id
FROM guarantors g
INNER JOIN customers c
ON g.borrower_customer_id = c.customer_id;
SELECT b.branch_id,
       b.branch_name
FROM branches b
LEFT JOIN loans l
ON b.branch_id = l.branch_id
WHERE l.loan_id IS NULL;
SELECT c.customer_name,
       l.loan_id,
       l.loan_amount
FROM customers c
LEFT JOIN loans l
ON c.customer_id = l.customer_id;
SELECT l.loan_id,
       c.customer_name,
       r.repayment_amount,
       r.repayment_date
FROM loans l
INNER JOIN customers c
ON l.customer_id = c.customer_id
INNER JOIN repayments r
ON l.loan_id = r.loan_id;
SELECT c.customer_name AS borrower,
       g.guarantor_name AS guarantor
FROM customers c
LEFT JOIN guarantors g
ON c.customer_id = g.borrower_customer_id;

SELECT b.branch_name,
       SUM(l.loan_amount) AS total_loan_amount
FROM branches b
LEFT JOIN loans l
ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name;
SELECT customer_id,
       customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM loans
    GROUP BY customer_id
    HAVING SUM(loan_amount) > (
        SELECT AVG(loan_amount)
        FROM loans
    )
);
SELECT DISTINCT c.customer_id,
       c.customer_name
FROM customers c
INNER JOIN loans l
ON c.customer_id = l.customer_id
WHERE l.loan_amount > (
    SELECT AVG(l2.loan_amount)
    FROM loans l2
    WHERE l2.branch_id = l.branch_id
);
SELECT c.customer_id,
       c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.customer_id = c.customer_id
);
SELECT DISTINCT c.customer_id,
       c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM loans l
    INNER JOIN repayments r
    ON l.loan_id = r.loan_id
    WHERE l.customer_id = c.customer_id
      AND r.repayment_date >= DATE_SUB(CURDATE(), INTERVAL 60 DAY)
);
SELECT b.branch_id,
       b.branch_name,
       MAX(l.loan_amount) AS highest_loan
FROM branches b
INNER JOIN loans l
ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name
HAVING MAX(l.loan_amount) > (
    SELECT AVG(branch_maximum)
    FROM (
        SELECT MAX(loan_amount) AS branch_maximum
        FROM loans
        GROUP BY branch_id
    ) AS branch_avg
);
SELECT b.branch_name,
       COUNT(l.loan_id) AS total_loans
FROM branches b
LEFT JOIN loans l
ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name;
SELECT AVG(loan_amount) AS average_loan_amount
FROM loans;
SELECT loan_id,
       SUM(repayment_amount) AS total_repaid
FROM repayments
GROUP BY loan_id;
SELECT l.loan_id,
       c.customer_name,
       l.loan_amount,
       COALESCE(SUM(r.repayment_amount), 0) AS total_repaid,
       l.loan_amount - COALESCE(SUM(r.repayment_amount), 0) AS outstanding_amount
FROM loans l
INNER JOIN customers c
ON l.customer_id = c.customer_id
LEFT JOIN repayments r
ON l.loan_id = r.loan_id
GROUP BY l.loan_id, c.customer_name, l.loan_amount;
SELECT * FROM branches;
SELECT * FROM customers;
SELECT * FROM loans;
SELECT * FROM repayments;
SELECT * FROM guarantors;