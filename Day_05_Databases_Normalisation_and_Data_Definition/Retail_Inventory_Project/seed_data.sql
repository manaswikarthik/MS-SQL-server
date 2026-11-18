
USE RetailInventoryDB;

-- 1. Categories

INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Footwear'),
('Clothing'),
('Home Appliances'),
('Furniture'),
('Groceries'),
('Sports'),
('Beauty'),
('Books'),
('Accessories');


-- 2. Suppliers

INSERT INTO Suppliers (SupplierName, SupplierPhone) VALUES
('ABC Traders', '9876543210'),
('Global Distributors', '9876543211'),
('Prime Supplies', '9876543212'),
('Tech World', '9876543213'),
('Fashion Hub', '9876543214'),
('Metro Wholesale', '9876543215'),
('Digital Solutions', '9876543216'),
('Classic Suppliers', '9876543217'),
('Smart Retailers', '9876543218'),
('Universal Traders', '9876543219');


-- 3. Warehouses

INSERT INTO Warehouses (WarehouseName) VALUES
('Chennai Central'),
('Bangalore Hub'),
('Mumbai Storage'),
('Delhi Distribution'),
('Hyderabad Depot'),
('Kolkata Warehouse'),
('Pune Storage'),
('Coimbatore Hub'),
('Jaipur Distribution'),
('Kochi Warehouse');


-- 4. Products

INSERT INTO Products
(SKU, ProductName, CategoryID, SupplierID)
VALUES
('SKU1001', 'Samsung Galaxy M35', 1, 1),
('SKU1002', 'Boat Airdopes 141', 1, 2),
('SKU1003', 'Nike Running Shoes', 2, 3),
('SKU1004', 'Cotton Casual T-Shirt', 3, 4),
('SKU1005', 'LG Microwave Oven', 4, 5),
('SKU1006', 'Wooden Study Table', 5, 6),
('SKU1007', 'Organic Basmati Rice', 6, 7),
('SKU1008', 'Cricket Bat', 7, 8),
('SKU1009', 'Vitamin C Face Serum', 8, 9),
('SKU1010', 'Wireless Mouse', 10, 10);


-- 5. Inventory

INSERT INTO Inventory
(ProductID, WarehouseID, Quantity, ReorderLevel)
VALUES
(1, 1, 50, 10),
(2, 2, 75, 15),
(3, 3, 30, 8),
(4, 4, 100, 20),
(5, 5, 25, 5),
(6, 6, 15, 5),
(7, 7, 200, 30),
(8, 8, 40, 10),
(9, 9, 60, 12),
(10, 10, 90, 15);


-- 6. Verify inserted records

SELECT * FROM Categories;
SELECT * FROM Suppliers;
SELECT * FROM Warehouses;
SELECT * FROM Products;
SELECT * FROM Inventory;


-- 7. Deliberately failing INSERT statements

-- Duplicate SKU
INSERT INTO Products
(SKU, ProductName, CategoryID, SupplierID)
VALUES
('SKU1001', 'Duplicate Product', 1, 1);


-- Missing parent record
INSERT INTO Products
(SKU, ProductName, CategoryID, SupplierID)
VALUES
('SKU1011', 'Invalid Category Product', 999, 1);


-- Negative quantity
INSERT INTO Inventory
(ProductID, WarehouseID, Quantity, ReorderLevel)
VALUES
(1, 1, -10, 5);


-- NULL in mandatory column
INSERT INTO Suppliers
(SupplierName, SupplierPhone)
VALUES
(NULL, '9876543220');
