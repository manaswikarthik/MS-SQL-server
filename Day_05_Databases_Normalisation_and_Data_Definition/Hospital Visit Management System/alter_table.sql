USE HospitalManagementDB;

-- 1. Add insurance_id to Patient.
ALTER TABLE Patient
ADD COLUMN insurance_id VARCHAR(30) NULL;

-- Verify the new column.
DESCRIBE Patient;

-- 2. Rename the Department table to HospitalDepartment.
RENAME TABLE Department TO HospitalDepartment;

-- Verify the renamed table.
SHOW TABLES LIKE 'HospitalDepartment';

-- 3. Drop the UNIQUE constraint on Patient.Email.
-- MySQL implements this UNIQUE constraint as an index named Email.
ALTER TABLE Patient
DROP INDEX Email;

-- Verify that the unique index has been removed.
SHOW INDEX FROM Patient;

-- Note:
-- Adding insurance_id creates a nullable column; existing patient rows receive NULL.
-- Renaming Department changes the table name. MySQL updates the foreign-key
-- reference from Doctor to the renamed table.
-- Dropping the Email unique index allows duplicate email values. The column
-- remains in the table and can still contain NULL.
