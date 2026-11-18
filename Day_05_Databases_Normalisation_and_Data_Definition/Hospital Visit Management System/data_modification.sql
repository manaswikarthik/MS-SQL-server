USE HospitalManagementDB;

-- 1. INSERT: add a new patient.
INSERT INTO Patient
(PatientName, DateOfBirth, Gender, Address, Phone, Email, insurance_id)
VALUES
('Ishita Rao', '1999-05-16', 'Female', '14 Green Park, Chennai',
 '9876501020', 'ishita.rao@example.com', 'INS-CHN-1020');

-- Display the inserted patient.
SELECT *
FROM Patient
WHERE PatientName = 'Ishita Rao'
  AND Phone = '9876501020';

-- 2. UPDATE: change the patient's phone number.
UPDATE Patient
SET Phone = '9876502020'
WHERE PatientName = 'Ishita Rao'
  AND Phone = '9876501020';

-- Verify the updated details.
SELECT PatientID, PatientName, Phone
FROM Patient
WHERE PatientName = 'Ishita Rao'
  AND Phone = '9876502020';

-- 3. DELETE: remove the test patient.
-- This patient has no visit records, so the foreign-key restriction is not violated.
DELETE FROM Patient
WHERE PatientName = 'Ishita Rao'
  AND Phone = '9876502020';

-- Verify that the test patient was deleted.
SELECT *
FROM Patient
WHERE PatientName = 'Ishita Rao'
  AND Phone = '9876502020';

-- 4. Retrieve patients who visited during November 2026.
SELECT DISTINCT
    p.PatientID,
    p.PatientName,
    v.VisitDate,
    v.Diagnosis
FROM Patient AS p
JOIN Visit AS v ON v.PatientID = p.PatientID
WHERE v.VisitDate >= '2026-11-01'
  AND v.VisitDate < '2026-12-01'
ORDER BY v.VisitDate;

-- 5. Retrieve doctors in departments whose names begin with 'Cardio'.
-- Department was renamed to HospitalDepartment in alter_table.sql.
SELECT
    d.DoctorID,
    d.DoctorName,
    d.Specialization,
    hd.DepartmentName
FROM Doctor AS d
JOIN HospitalDepartment AS hd
    ON hd.DepartmentID = d.DepartmentID
WHERE hd.DepartmentName LIKE 'Cardio%'
ORDER BY d.DoctorName;

-- 6. Example using LIKE to find doctors whose names contain 'Priya'.
SELECT DoctorID, DoctorName, Specialization
FROM Doctor
WHERE DoctorName LIKE '%Priya%';
