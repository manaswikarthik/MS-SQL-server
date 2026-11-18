USE RetailSalesDB;

-- Customers: 10 records across five cities.
INSERT INTO Customers (CustomerName, Email, Phone, City, CreatedAt) VALUES
('Aarav Mehta', 'aarav.mehta@example.com', '9876501101', 'Chennai', '2025-12-10'),
('Diya Sharma', 'diya.sharma@example.com', '9876501102', 'Bengaluru', '2025-12-15'),
('Rohan Iyer', 'rohan.iyer@example.com', '9876501103', 'Chennai', '2026-01-05'),
('Ananya Das', 'ananya.das@example.com', '9876501104', 'Hyderabad', '2026-01-12'),
('Kabir Nair', 'kabir.nair@example.com', '9876501105', 'Mumbai', '2026-01-20'),
('Meera Rao', 'meera.rao@example.com', '9876501106', 'Bengaluru', '2026-02-02'),
('Ishaan Gupta', 'ishaan.gupta@example.com', '9876501107', 'Pune', '2026-02-14'),
('Sana Khan', 'sana.khan@example.com', '9876501108', 'Chennai', '2026-03-01'),
('Vikram Patel', 'vikram.patel@example.com', '9876501109', 'Hyderabad', '2026-03-11'),
('Nila Krishnan', 'nila.krishnan@example.com', '9876501110', 'Mumbai', '2026-03-20');

-- Products: 10 records across five categories.
INSERT INTO Products (ProductName, Category, UnitPrice, IsActive) VALUES
('Wireless Mouse', 'Electronics', 799.00, TRUE),
('Bluetooth Headphones', 'Electronics', 2499.00, TRUE),
('USB-C Hub', 'Electronics', 1899.00, TRUE),
('Cotton T-Shirt', 'Fashion', 599.00, TRUE),
('Running Shoes', 'Fashion', 2999.00, TRUE),
('Travel Backpack', 'Accessories', 1599.00, TRUE),
('Water Bottle', 'Home & Kitchen', 399.00, TRUE),
('Coffee Maker', 'Home & Kitchen', 3499.00, TRUE),
('Desk Lamp', 'Home & Kitchen', 1199.00, TRUE),
('Notebook Set', 'Stationery', 249.00, TRUE);

-- Orders: customer 1 has more than three orders; some orders have no payment.
INSERT INTO Orders (CustomerID, OrderDate, OrderStatus) VALUES
(1, '2026-01-05', 'Delivered'),
(1, '2026-01-18', 'Delivered'),
(1, '2026-02-10', 'Delivered'),
(1, '2026-03-12', 'Shipped'),
(2, '2026-01-08', 'Delivered'),
(2, '2026-02-15', 'Delivered'),
(3, '2026-01-20', 'Delivered'),
(3, '2026-03-05', 'Processing'),
(4, '2026-02-02', 'Delivered'),
(4, '2026-03-18', 'Placed'),
(5, '2026-02-21', 'Delivered'),
(6, '2026-03-02', 'Delivered'),
(7, '2026-03-10', 'Shipped'),
(8, '2026-03-15', 'Delivered'),
(9, '2026-03-20', 'Placed'),
(10, '2026-03-25', 'Delivered');

-- Order items: UnitPrice is the price charged at the time of sale.
INSERT INTO Order_Items (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 2, 799.00),
(1, 4, 1, 599.00),
(2, 2, 1, 2499.00),
(2, 10, 2, 249.00),
(3, 5, 1, 2999.00),
(3, 7, 2, 399.00),
(4, 3, 1, 1899.00),
(4, 6, 1, 1599.00),
(5, 8, 1, 3499.00),
(5, 10, 3, 249.00),
(6, 1, 1, 799.00),
(6, 9, 1, 1199.00),
(7, 2, 2, 2499.00),
(7, 4, 2, 599.00),
(8, 5, 1, 2999.00),
(8, 6, 1, 1599.00),
(9, 8, 1, 3499.00),
(9, 7, 3, 399.00),
(10, 3, 2, 1899.00),
(10, 10, 4, 249.00),
(11, 5, 2, 2999.00),
(11, 1, 1, 799.00),
(12, 2, 1, 2499.00),
(12, 9, 2, 1199.00),
(13, 6, 2, 1599.00),
(13, 4, 1, 599.00),
(14, 8, 1, 3499.00),
(14, 3, 1, 1899.00),
(15, 7, 2, 399.00),
(15, 10, 5, 249.00),
(16, 1, 3, 799.00),
(16, 5, 1, 2999.00);

-- Payments: orders 4, 8, 10 and 15 intentionally have no payment record.
INSERT INTO Payments
(OrderID, PaymentDate, PaymentMethod, PaymentStatus, Amount, TransactionReference) VALUES
(1, '2026-01-05', 'UPI', 'Paid', 2197.00, 'TXN-10001'),
(2, '2026-01-18', 'Card', 'Paid', 2997.00, 'TXN-10002'),
(3, '2026-02-10', 'UPI', 'Paid', 3797.00, 'TXN-10003'),
(5, '2026-01-08', 'Net Banking', 'Paid', 4246.00, 'TXN-10005'),
(6, '2026-02-15', 'UPI', 'Paid', 1998.00, 'TXN-10006'),
(7, '2026-01-20', 'Card', 'Paid', 6196.00, 'TXN-10007'),
(9, '2026-02-02', 'UPI', 'Paid', 4696.00, 'TXN-10009'),
(11, '2026-02-21', 'Card', 'Paid', 6797.00, 'TXN-10011'),
(12, '2026-03-02', 'UPI', 'Paid', 4897.00, 'TXN-10012'),
(13, '2026-03-10', 'Net Banking', 'Paid', 3797.00, 'TXN-10013'),
(14, '2026-03-15', 'UPI', 'Paid', 5398.00, 'TXN-10014'),
(16, '2026-03-25', 'Card', 'Paid', 5396.00, 'TXN-10016');

-- Verify inserted row counts.
SELECT 'Customers' AS TableName, COUNT(*) AS TotalRecords FROM Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Order_Items', COUNT(*) FROM Order_Items
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments;

-- Confirm orders that currently have no payment record.
SELECT o.OrderID, o.OrderDate, o.OrderStatus
FROM Orders AS o
LEFT JOIN Payments AS p ON p.OrderID = o.OrderID
WHERE p.PaymentID IS NULL
ORDER BY o.OrderID;
