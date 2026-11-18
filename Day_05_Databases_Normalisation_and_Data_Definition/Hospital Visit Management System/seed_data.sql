USE HospitalManagementDB;

-- Department records
INSERT INTO Department (DepartmentName, Location) VALUES
('Cardiology', 'Block A - Floor 2'),
('Neurology', 'Block B - Floor 3'),
('Orthopedics', 'Block A - Floor 1'),
('Pediatrics', 'Block C - Floor 2'),
('Dermatology', 'Block B - Floor 1');

-- Patient records
INSERT INTO Patient
(PatientName, DateOfBirth, Gender, Address, Phone, Email) VALUES
('Ananya Kumar', '1998-04-12', 'Female', '12 Lake View Road, Chennai', '9876501001', 'ananya.kumar@example.com'),
('Rahul Sharma', '1987-09-23', 'Male', '24 Park Street, Chennai', '9876501002', 'rahul.sharma@example.com'),
('Meera Krishnan', '2001-01-15', 'Female', '8 Gandhi Nagar, Chennai', '9876501003', 'meera.krishnan@example.com'),
('Arjun Patel', '1979-06-30', 'Male', '17 Anna Nagar, Chennai', '9876501004', 'arjun.patel@example.com'),
('Divya Nair', '1995-11-08', 'Female', '5 Velachery Main Road, Chennai', '9876501005', 'divya.nair@example.com'),
('Karthik Raj', '1968-03-19', 'Male', '31 Adyar, Chennai', '9876501006', 'karthik.raj@example.com'),
('Sneha Iyer', '2004-07-25', 'Female', '9 T Nagar, Chennai', '9876501007', 'sneha.iyer@example.com'),
('Vikram Singh', '1990-12-02', 'Male', '42 Porur, Chennai', '9876501008', 'vikram.singh@example.com'),
('Lakshmi Menon', '1958-02-14', 'Female', '6 Mylapore, Chennai', '9876501009', 'lakshmi.menon@example.com'),
('Naveen Kumar', '1983-08-17', 'Male', '19 Tambaram, Chennai', '9876501010', 'naveen.kumar@example.com');

-- Doctor records
INSERT INTO Doctor (DoctorName, Specialization, Phone, DepartmentID) VALUES
('Dr. S. Prakash', 'Interventional Cardiology', '9840012001', 1),
('Dr. R. Malini', 'Clinical Neurology', '9840012002', 2),
('Dr. A. Kannan', 'Joint Replacement', '9840012003', 3),
('Dr. P. Kavitha', 'Child Healthcare', '9840012004', 4),
('Dr. M. Joseph', 'Skin Diseases', '9840012005', 5),
('Dr. V. Anand', 'Cardiac Electrophysiology', '9840012006', 1),
('Dr. N. Revathi', 'Stroke Neurology', '9840012007', 2),
('Dr. G. Suresh', 'Sports Orthopedics', '9840012008', 3),
('Dr. L. Priya', 'Pediatric Medicine', '9840012009', 4),
('Dr. T. Aravind', 'Dermatology', '9840012010', 5);

-- Visit records
INSERT INTO Visit
(PatientID, DoctorID, VisitDate, Diagnosis, Prescription) VALUES
(1, 1, '2026-10-03', 'Hypertension', 'Amlodipine 5 mg once daily'),
(2, 2, '2026-10-08', 'Migraine', 'Prescribed migraine management medication'),
(3, 4, '2026-10-12', 'Seasonal viral fever', 'Rest, fluids and fever medication'),
(4, 3, '2026-10-19', 'Knee osteoarthritis', 'Pain management and physiotherapy'),
(5, 5, '2026-11-02', 'Eczema', 'Topical moisturizer and prescribed cream'),
(6, 6, '2026-11-05', 'Arrhythmia', 'Cardiac evaluation and follow-up'),
(7, 9, '2026-11-07', 'Upper respiratory infection', 'Supportive care and follow-up if needed'),
(8, 8, '2026-11-10', 'Ankle sprain', 'Rest, ice and ankle support'),
(9, 7, '2026-09-22', 'Tension headache', 'Hydration and prescribed medication'),
(10, 10, '2026-09-28', 'Contact dermatitis', 'Avoid irritant and apply prescribed cream');

-- Billing records
-- Status is omitted for selected rows to demonstrate the default value 'Open'.
INSERT INTO Billing (VisitID, BillAmount, BillDate) VALUES
(1, 1800.00, '2026-10-03'),
(2, 1250.00, '2026-10-08'),
(3, 900.00, '2026-10-12'),
(4, 2400.00, '2026-10-19'),
(5, 1100.00, '2026-11-02'),
(6, 3200.00, '2026-11-05'),
(7, 750.00, '2026-11-07'),
(8, 1500.00, '2026-11-10'),
(9, 1000.00, '2026-09-22'),
(10, 950.00, '2026-09-28');

-- Verify the number of records in each table.
SELECT 'Department' AS TableName, COUNT(*) AS TotalRecords FROM Department
UNION ALL
SELECT 'Patient', COUNT(*) FROM Patient
UNION ALL
SELECT 'Doctor', COUNT(*) FROM Doctor
UNION ALL
SELECT 'Visit', COUNT(*) FROM Visit
UNION ALL
SELECT 'Billing', COUNT(*) FROM Billing;

-- Check that the default billing status was applied.
SELECT BillingID, VisitID, BillAmount, Status
FROM Billing
ORDER BY BillingID;
