USE RetailInventoryDB;

-- 1. View supplier details before update

SELECT *
FROM Suppliers
WHERE SupplierID = 1;


-- 2. Update supplier phone number

UPDATE Suppliers
SET SupplierPhone = '9000010001'
WHERE SupplierID = 1;


-- 3. View supplier details after update

SELECT *
FROM Suppliers
WHERE SupplierID = 1;


-- 4. View discontinued product before deletion

SELECT 
    p.ProductID,
    p.SKU,
    p.ProductName,
    i.Quantity,
    w.WarehouseName
FROM Products p
LEFT JOIN Inventory i
    ON p.ProductID = i.ProductID
LEFT JOIN Warehouses w
    ON i.WarehouseID = w.WarehouseID
WHERE p.SKU = 'SKU1010';


-- 5. Delete associated inventory record

DELETE FROM Inventory
WHERE ProductID = (
    SELECT ProductID
    FROM Products
    WHERE SKU = 'SKU1010'
);


-- 6. Delete discontinued product

DELETE FROM Products
WHERE SKU = 'SKU1010';


-- 7. Verify product deletion

SELECT *
FROM Products
WHERE SKU = 'SKU1010';


-- 8. Verify inventory deletion

SELECT *
FROM Inventory
WHERE ProductID = 10;