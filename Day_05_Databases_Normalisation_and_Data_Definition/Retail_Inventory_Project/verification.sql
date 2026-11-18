USE RetailInventoryDB;

SELECT 'Categories' AS TableName, COUNT(*) AS TotalRecords
FROM Categories

UNION ALL

SELECT 'Suppliers', COUNT(*) FROM Suppliers

UNION ALL

SELECT 'Warehouses', COUNT(*) FROM Warehouses

UNION ALL

SELECT 'Products', COUNT(*) FROM Products

UNION ALL

SELECT 'Inventory', COUNT(*) FROM Inventory;