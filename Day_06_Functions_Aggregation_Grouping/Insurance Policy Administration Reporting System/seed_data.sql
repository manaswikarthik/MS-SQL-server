USE InsuranceManagementDB;

-- Customers
INSERT INTO Customers
(CustomerName, DateOfBirth, Phone, Email, Address, City) VALUES
('Arun Kumar', '1985-04-12', '9876502101', 'arun.kumar@example.com', '12 Anna Nagar', 'Chennai'),
('Priya Sharma', '1992-08-25', '9876502102', 'priya.sharma@example.com', '24 Indiranagar', 'Bengaluru'),
('Karthik Raj', '1978-11-03', '9876502103', 'karthik.raj@example.com', '8 Banjara Hills', 'Hyderabad'),
('Meena Iyer', '2000-02-14', '9876502104', 'meena.iyer@example.com', '17 T Nagar', 'Chennai'),
('Rahul Nair', '1989-06-30', '9876502105', 'rahul.nair@example.com', '5 Andheri East', 'Mumbai'),
('Divya Menon', '1995-09-18', '9876502106', 'divya.menon@example.com', '31 Whitefield', 'Bengaluru'),
('Sanjay Patel', '1968-01-22', '9876502107', 'sanjay.patel@example.com', '9 Koregaon Park', 'Pune'),
('Nisha Reddy', '1982-12-07', '9876502108', 'nisha.reddy@example.com', '42 Gachibowli', 'Hyderabad'),
('Vikram Das', '1998-03-11', '9876502109', 'vikram.das@example.com', '6 Velachery', 'Chennai'),
('Lakshmi Rao', '1973-07-29', '9876502110', 'lakshmi.rao@example.com', '19 Powai', 'Mumbai');

-- Insurance products
INSERT INTO Products (ProductName, ProductType, Description) VALUES
('SecureLife', 'Life', 'Individual life insurance'),
('HealthPlus', 'Health', 'Comprehensive health cover'),
('MotorShield', 'Motor', 'Private vehicle insurance'),
('HomeProtect', 'Property', 'Residential property insurance'),
('TravelCare', 'Travel', 'Domestic and international travel cover');

-- Agents
INSERT INTO Agents (AgentName, AgentCode, Phone, Email, City) VALUES
('Ramesh Kumar', 'AGT001', '9840012101', 'ramesh.kumar@example.com', 'Chennai'),
('Sneha Kapoor', 'AGT002', '9840012102', 'sneha.kapoor@example.com', 'Bengaluru'),
('Manoj Verma', 'AGT003', '9840012103', 'manoj.verma@example.com', 'Hyderabad'),
('Anita Joseph', 'AGT004', '9840012104', 'anita.joseph@example.com', 'Mumbai'),
('Suresh Nair', 'AGT005', '9840012105', 'suresh.nair@example.com', 'Pune'),
('Kavya Menon', 'AGT006', '9840012106', 'kavya.menon@example.com', 'Chennai');

-- Policies: multiple active policies for selected customers and varied expiry dates.
INSERT INTO Policies
(PolicyNumber, CustomerID, ProductID, AgentID, StartDate, ExpiryDate, PolicyStatus, SumInsured) VALUES
('POL-2026-1001', 1, 1, 1, '2025-12-01', '2026-12-05', 'Active', 1000000.00),
('POL-2026-1002', 1, 2, 1, '2026-01-15', '2027-01-14', 'Active', 500000.00),
('POL-2026-1003', 2, 3, 2, '2026-02-01', '2026-12-10', 'Active', 800000.00),
('POL-2026-1004', 2, 2, 2, '2025-11-20', '2026-11-25', 'Active', 600000.00),
('POL-2026-1005', 3, 4, 3, '2026-03-01', '2027-02-28', 'Active', 1500000.00),
('POL-2026-1006', 4, 2, 1, '2026-04-10', '2026-12-20', 'Active', 400000.00),
('POL-2026-1007', 5, 3, 4, '2025-10-01', '2026-11-30', 'Active', 700000.00),
('POL-2026-1008', 6, 1, 2, '2026-05-15', '2027-05-14', 'Active', 1200000.00),
('POL-2026-1009', 7, 4, 5, '2025-09-01', '2026-12-01', 'Active', 2000000.00),
('POL-2026-1010', 8, 5, 3, '2026-06-01', '2026-12-15', 'Active', 300000.00),
('POL-2026-1011', 9, 3, 6, '2026-07-01', '2027-06-30', 'Active', 900000.00),
('POL-2026-1012', 10, 1, 4, '2025-08-01', '2026-11-22', 'Expired', 1100000.00),
('POL-2026-1013', 3, 2, 3, '2026-08-01', '2027-07-31', 'Active', 750000.00),
('POL-2026-1014', 5, 5, 4, '2026-09-01', '2027-08-31', 'Active', 250000.00),
('POL-2026-1015', 1, 3, 1, '2026-10-01', '2027-09-30', 'Active', 650000.00);

-- Premium payments. Only Paid premiums are treated as collected in reports.
INSERT INTO Premiums
(PolicyID, PremiumDate, Amount, PaymentStatus, PaymentMethod, TransactionReference) VALUES
(1, '2026-01-01', 12000.00, 'Paid', 'UPI', 'PREM-5001'),
(1, '2026-07-01', 12000.00, 'Paid', 'UPI', 'PREM-5002'),
(2, '2026-01-15', 8500.00, 'Paid', 'Card', 'PREM-5003'),
(3, '2026-02-01', 15000.00, 'Paid', 'Net Banking', 'PREM-5004'),
(4, '2026-02-10', 9500.00, 'Paid', 'UPI', 'PREM-5005'),
(5, '2026-03-01', 18000.00, 'Paid', 'Card', 'PREM-5006'),
(6, '2026-04-10', 7000.00, 'Paid', 'UPI', 'PREM-5007'),
(7, '2026-05-01', 11000.00, 'Paid', 'Card', 'PREM-5008'),
(8, '2026-05-15', 14000.00, 'Paid', 'UPI', 'PREM-5009'),
(9, '2026-06-01', 22000.00, 'Paid', 'Net Banking', 'PREM-5010'),
(10, '2026-06-15', 6000.00, 'Paid', 'UPI', 'PREM-5011'),
(11, '2026-07-01', 13000.00, 'Paid', 'Card', 'PREM-5012'),
(12, '2026-08-01', 12500.00, 'Paid', 'UPI', 'PREM-5013'),
(13, '2026-08-01', 10500.00, 'Paid', 'Card', 'PREM-5014'),
(14, '2026-09-01', 5500.00, 'Paid', 'UPI', 'PREM-5015'),
(15, '2026-10-01', 10000.00, 'Pending', 'Card', 'PREM-5016');

-- Claims. Includes settled, approved, rejected and under-review examples.
INSERT INTO Claims
(PolicyID, ClaimNumber, ClaimDate, SettlementDate, ClaimAmount, ApprovedAmount, ClaimStatus, DamageCategory) VALUES
(1, 'CLM-7001', '2026-02-10', '2026-02-20', 50000.00, 45000.00, 'Settled', 'Accidental Damage'),
(2, 'CLM-7002', '2026-03-05', '2026-03-18', 30000.00, 25000.00, 'Settled', 'Hospitalisation'),
(3, 'CLM-7003', '2026-04-12', NULL, 75000.00, 0.00, 'Under Review', 'Vehicle Collision'),
(4, 'CLM-7004', '2026-05-01', '2026-05-12', 20000.00, 18000.00, 'Settled', 'Hospitalisation'),
(5, 'CLM-7005', '2026-05-20', '2026-06-02', 120000.00, 100000.00, 'Settled', 'Fire Damage'),
(6, 'CLM-7006', '2026-06-10', NULL, 15000.00, 0.00, 'Submitted', 'Hospitalisation'),
(7, 'CLM-7007', '2026-07-15', '2026-07-25', 40000.00, 35000.00, 'Settled', 'Vehicle Collision'),
(9, 'CLM-7008', '2026-08-05', '2026-08-25', 90000.00, 80000.00, 'Settled', 'Water Damage'),
(10, 'CLM-7009', '2026-09-10', NULL, 10000.00, 0.00, 'Rejected', 'Travel Delay'),
(11, 'CLM-7010', '2026-10-02', '2026-10-20', 55000.00, 50000.00, 'Settled', 'Vehicle Collision'),
(13, 'CLM-7011', '2026-10-10', NULL, 25000.00, 0.00, 'Submitted', 'Hospitalisation');

-- Verify sample record counts.
SELECT 'Customers' AS TableName, COUNT(*) AS TotalRecords FROM Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Agents', COUNT(*) FROM Agents
UNION ALL
SELECT 'Policies', COUNT(*) FROM Policies
UNION ALL
SELECT 'Premiums', COUNT(*) FROM Premiums
UNION ALL
SELECT 'Claims', COUNT(*) FROM Claims;
