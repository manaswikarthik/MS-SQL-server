USE RetailSalesDB;

-- Report 1: Top 5 products by revenue.
SELECT
    p.ProductID,
    p.ProductName,
    ROUND(SUM(oi.Quantity * oi.UnitPrice), 2) AS TotalRevenue
FROM Products AS p
JOIN Order_Items AS oi ON oi.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = oi.OrderID
WHERE o.OrderStatus <> 'Cancelled'
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Report 2: Month-wise sales.
SELECT
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS SalesMonth,
    ROUND(SUM(oi.Quantity * oi.UnitPrice), 2) AS MonthlySales
FROM Orders AS o
JOIN Order_Items AS oi ON oi.OrderID = o.OrderID
WHERE o.OrderStatus <> 'Cancelled'
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
ORDER BY SalesMonth;

-- Report 3: Customers with more than three orders (HAVING).
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 3
ORDER BY OrderCount DESC;

-- Report 4: Average basket value per city.
-- First calculate each order's basket value, then average those order values by city.
SELECT
    c.City,
    ROUND(AVG(order_totals.BasketValue), 2) AS AverageBasketValue
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN (
    SELECT
        oi.OrderID,
        SUM(oi.Quantity * oi.UnitPrice) AS BasketValue
    FROM Order_Items AS oi
    GROUP BY oi.OrderID
) AS order_totals ON order_totals.OrderID = o.OrderID
WHERE o.OrderStatus <> 'Cancelled'
GROUP BY c.City
ORDER BY AverageBasketValue DESC;

-- Report 5: Orders without a payment record (LEFT JOIN).
SELECT
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    o.OrderStatus
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
LEFT JOIN Payments AS p ON p.OrderID = o.OrderID
WHERE p.PaymentID IS NULL
ORDER BY o.OrderID;

-- Report 6: Customers who have never placed an order.
SELECT
    c.CustomerID,
    c.CustomerName,
    c.City
FROM Customers AS c
LEFT JOIN Orders AS o ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL
ORDER BY c.CustomerID;

-- Report 7: Product-category revenue share.
SELECT
    p.Category,
    ROUND(SUM(oi.Quantity * oi.UnitPrice), 2) AS CategoryRevenue,
    ROUND(
        100.0 * SUM(oi.Quantity * oi.UnitPrice) /
        (SELECT SUM(oi2.Quantity * oi2.UnitPrice)
         FROM Order_Items AS oi2
         JOIN Orders AS o2 ON o2.OrderID = oi2.OrderID
         WHERE o2.OrderStatus <> 'Cancelled'),
        2
    ) AS RevenueSharePercent
FROM Products AS p
JOIN Order_Items AS oi ON oi.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = oi.OrderID
WHERE o.OrderStatus <> 'Cancelled'
GROUP BY p.Category
ORDER BY CategoryRevenue DESC;

-- Report 8: Day with the highest sales.