
USE BankManagementDB;

-- 1. Customers

INSERT INTO Customers
(CustomerNumber, CustomerName, Address, Phone, Email)
VALUES
('CUST1001', 'Arun Kumar', 'Anna Nagar, Chennai', '9876501001', 'arun@gmail.com'),
('CUST1002', 'Priya Sharma', 'T Nagar, Chennai', '9876501002', 'priya@gmail.com'),
('CUST1003', 'Rahul Verma', 'Adyar, Chennai', '9876501003', 'rahul@gmail.com'),
('CUST1004', 'Divya Nair', 'Velachery, Chennai', '9876501004', 'divya@gmail.com'),
('CUST1005', 'Karthik Raj', 'Tambaram, Chennai', '9876501005', 'karthik@gmail.com'),
('CUST1006', 'Meena Iyer', 'Indiranagar, Bangalore', '9876501006', 'meena@gmail.com'),
('CUST1007', 'Vijay Kumar', 'Whitefield, Bangalore', '9876501007', 'vijay@gmail.com'),
('CUST1008', 'Sneha Reddy', 'Banjara Hills, Hyderabad', '9876501008', 'sneha@gmail.com'),
('CUST1009', 'Rohit Mehta', 'Andheri, Mumbai', '9876501009', 'rohit@gmail.com'),
('CUST1010', 'Ananya Das', 'Salt Lake, Kolkata', '9876501010', 'ananya@gmail.com');


-- 2. Branches

INSERT INTO Branches
(BranchCode, BranchName, BranchAddress, IFSCCode)
VALUES
('BR001', 'Anna Nagar Branch', 'Anna Nagar, Chennai', 'BANK0001001'),
('BR002', 'T Nagar Branch', 'T Nagar, Chennai', 'BANK0001002'),
('BR003', 'Adyar Branch', 'Adyar, Chennai', 'BANK0001003'),
('BR004', 'Indiranagar Branch', 'Indiranagar, Bangalore', 'BANK0001004'),
('BR005', 'Banjara Hills Branch', 'Banjara Hills, Hyderabad', 'BANK0001005');


-- 3. Relationship Managers

INSERT INTO RelationshipManagers
(ManagerName, Phone, BranchID)
VALUES
('Suresh Menon', '9000010001', 1),
('Lakshmi Devi', '9000010002', 1),
('Ramesh Gupta', '9000010003', 2),
('Anita Rao', '9000010004', 2),
('Prakash Nair', '9000010005', 3),
('Deepa Krishnan', '9000010006', 3),
('Manoj Kumar', '9000010007', 4),
('Swathi Reddy', '9000010008', 4),
('Ajay Sharma', '9000010009', 5),
('Neha Das', '9000010010', 5);


-- 4. Account Types

INSERT INTO AccountTypes
(AccountTypeName)
VALUES
('Savings'),
('Current'),
('Salary'),
('Fixed Deposit');


-- 5. Accounts

INSERT INTO Accounts
(AccountNumber, CustomerID, AccountTypeID, BranchID,
 ManagerID, Balance, OpenedDate, AccountStatus)
VALUES
('AC10000001', 1, 1, 1, 1, 45000.00, '2026-07-05', 'Active'),
('AC10000002', 2, 1, 1, 2, 78000.00, '2026-07-12', 'Active'),
('AC10000003', 3, 2, 2, 3, 125000.00, '2026-08-03', 'Active'),
('AC10000004', 4, 3, 2, 4, 32000.00, '2026-08-18', 'Active'),
('AC10000005', 5, 1, 3, 5, 56000.00, '2026-09-02', 'Active'),
('AC10000006', 6, 4, 3, 6, 200000.00, '2026-09-15', 'Active'),
('AC10000007', 7, 2, 4, 7, 95000.00, '2026-10-10', 'Active'),
('AC10000008', 8, 1, 4, 8, 67000.00, '2026-10-22', 'Active'),
('AC10000009', 9, 3, 5, 9, 41000.00, '2026-11-02', 'Active'),
('AC10000010', 10, 1, 5, 10, 89000.00, '2026-11-05', 'Active');


-- 6. Transactions

INSERT INTO Transactions
(AccountID, TransactionReference, TransactionDate,
 TransactionType, Amount, Description)
VALUES
(1, 'TXN10001', '2026-07-06 09:30:00', 'Credit', 5000.00, 'Salary credit'),
(1, 'TXN10002', '2026-07-08 11:15:00', 'Debit', 1200.00, 'Utility payment'),
(2, 'TXN10003', '2026-07-13 10:00:00', 'Credit', 10000.00, 'Cash deposit'),
(2, 'TXN10004', '2026-07-16 14:20:00', 'Debit', 2500.00, 'Online transfer'),
(3, 'TXN10005', '2026-08-04 09:45:00', 'Credit', 25000.00, 'Business deposit'),
(3, 'TXN10006', '2026-08-07 12:30:00', 'Debit', 5000.00, 'Vendor payment'),
(4, 'TXN10007', '2026-08-19 10:10:00', 'Credit', 8000.00, 'Salary credit'),
(4, 'TXN10008', '2026-08-21 16:00:00', 'Debit', 1500.00, 'ATM withdrawal'),
(5, 'TXN10009', '2026-09-03 09:00:00', 'Credit', 12000.00, 'Cash deposit'),
(5, 'TXN10010', '2026-09-05 13:15:00', 'Debit', 3000.00, 'Bill payment'),
(6, 'TXN10011', '2026-09-16 11:00:00', 'Credit', 50000.00, 'Fixed deposit funding'),
(6, 'TXN10012', '2026-09-20 15:30:00', 'Debit', 10000.00, 'Account transfer'),
(7, 'TXN10013', '2026-10-11 10:20:00', 'Credit', 15000.00, 'Business receipt'),
(7, 'TXN10014', '2026-10-14 12:00:00', 'Debit', 4000.00, 'Cheque payment'),
(8, 'TXN10015', '2026-10-23 09:30:00', 'Credit', 7000.00, 'Salary credit'),
(8, 'TXN10016', '2026-10-25 14:45:00', 'Debit', 2000.00, 'Online purchase'),
(9, 'TXN10017', '2026-11-03 10:00:00', 'Credit', 9000.00, 'Cash deposit'),
(9, 'TXN10018', '2026-11-04 16:15:00', 'Debit', 1800.00, 'Utility payment'),
(10, 'TXN10019', '2026-11-06 09:15:00', 'Credit', 11000.00, 'Salary credit'),
(10, 'TXN10020', '2026-11-07 13:30:00', 'Debit', 3500.00, 'Online transfer');


-- 7. Verify inserted records

SELECT * FROM Customers;
SELECT * FROM Branches;
SELECT * FROM RelationshipManagers;
SELECT * FROM AccountTypes;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
