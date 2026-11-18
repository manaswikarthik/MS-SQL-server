USE InsuranceManagementDB;

-- Report 1: Policies expiring in the next 30 days.
SELECT
    PolicyID,
    CONCAT('****', RIGHT(PolicyNumber, 4)) AS MaskedPolicyNumber,
    ExpiryDate,
    DATEDIFF(ExpiryDate, CURDATE()) AS DaysUntilExpiry,
    PolicyStatus
FROM Policies
WHERE PolicyStatus = 'Active'
  AND ExpiryDate >= CURDATE()
  AND ExpiryDate <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY ExpiryDate;

-- Report 2: Premium collected per insurance product.
-- Only payments with Paid status are treated as collected premium.
SELECT
    pr.ProductID,
    pr.ProductName,
    ROUND(COALESCE(SUM(CASE WHEN pm.PaymentStatus = 'Paid'
                            THEN pm.Amount ELSE 0 END), 0), 2) AS PremiumCollected
FROM Products AS pr
LEFT JOIN Policies AS po ON po.ProductID = pr.ProductID
LEFT JOIN Premiums AS pm ON pm.PolicyID = po.PolicyID
GROUP BY pr.ProductID, pr.ProductName
ORDER BY PremiumCollected DESC;

-- Report 3: Customers with more than one active policy.
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(po.PolicyID) AS ActivePolicyCount
FROM Customers AS c
JOIN Policies AS po ON po.CustomerID = c.CustomerID
WHERE po.PolicyStatus = 'Active'
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(po.PolicyID) > 1
ORDER BY ActivePolicyCount DESC, c.CustomerName;

-- Report 4: Claim ratio per product.
-- Definition used: total approved claim amount / total collected premium * 100.
SELECT
    pr.ProductID,
    pr.ProductName,
    ROUND(COALESCE(claim_totals.ApprovedClaims, 0), 2) AS ApprovedClaims,
    ROUND(COALESCE(premium_totals.CollectedPremium, 0), 2) AS CollectedPremium,
    CASE
        WHEN COALESCE(premium_totals.CollectedPremium, 0) = 0 THEN 0
        ELSE ROUND(
            100.0 * COALESCE(claim_totals.ApprovedClaims, 0)
            / premium_totals.CollectedPremium, 2
        )
    END AS ClaimRatioPercent
FROM Products AS pr
LEFT JOIN (
    SELECT po.ProductID, SUM(cl.ApprovedAmount) AS ApprovedClaims
    FROM Policies AS po
    JOIN Claims AS cl ON cl.PolicyID = po.PolicyID
    GROUP BY po.ProductID
) AS claim_totals ON claim_totals.ProductID = pr.ProductID
LEFT JOIN (
    SELECT po.ProductID, SUM(pm.Amount) AS CollectedPremium
    FROM Policies AS po
    JOIN Premiums AS pm ON pm.PolicyID = po.PolicyID
    WHERE pm.PaymentStatus = 'Paid'
    GROUP BY po.ProductID
) AS premium_totals ON premium_totals.ProductID = pr.ProductID
ORDER BY ClaimRatioPercent DESC;

-- Report 5: Policies without claims.
SELECT
    po.PolicyID,
    CONCAT('****', RIGHT(po.PolicyNumber, 4)) AS MaskedPolicyNumber,
    c.CustomerName,
    pr.ProductName,
    po.PolicyStatus
FROM Policies AS po
JOIN Customers AS c ON c.CustomerID = po.CustomerID
JOIN Products AS pr ON pr.ProductID = po.ProductID
LEFT JOIN Claims AS cl ON cl.PolicyID = po.PolicyID
WHERE cl.ClaimID IS NULL
ORDER BY po.PolicyID;

-- Report 6: Average premium by customer age band.
-- Customer age is calculated in completed years as of the query execution date.
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) < 25 THEN 'Under 25'
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
        WHEN TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END AS AgeBand,
    ROUND(AVG(pm.Amount), 2) AS AveragePremium
FROM Customers AS c