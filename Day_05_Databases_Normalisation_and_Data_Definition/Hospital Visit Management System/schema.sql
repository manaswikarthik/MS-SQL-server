-- Hospital Visit Management System
-- MySQL 8.0.16+
-- Note: This script uses MySQL syntax. The assignment mentions SQL Server,
-- whose syntax differs (for example, IDENTITY instead of AUTO_INCREMENT).

CREATE DATABASE IF NOT EXISTS HospitalManagementDB;
USE HospitalManagementDB;

-- Remove dependent tables first so the script can be rerun.
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    PatientName VARCHAR(120) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(20),
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(120) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorName VARCHAR(120) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(20),
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Doctor_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Visit (
    VisitID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    VisitDate DATE NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,
    Prescription TEXT,
    CONSTRAINT CHK_Visit_VisitDate
        CHECK (VisitDate >= '2000-01-01' AND VisitDate <= '2099-12-31'),
    CONSTRAINT FK_Visit_Patient
        FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Visit_Doctor
        FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    INDEX IDX_Visit_VisitDate (VisitDate),
    INDEX IDX_Visit_PatientID (PatientID),
    INDEX IDX_Visit_DoctorID (DoctorID)
) ENGINE=InnoDB;

CREATE TABLE Billing (
    BillingID INT AUTO_INCREMENT PRIMARY KEY,
    VisitID INT NOT NULL UNIQUE,
    BillAmount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Status VARCHAR(20) NOT NULL DEFAULT 'Open',
    BillDate DATE NOT NULL,
    CONSTRAINT CHK_Billing_BillAmount CHECK (BillAmount >= 0),
    CONSTRAINT CHK_Billing_Status
        CHECK (Status IN ('Open', 'Paid', 'Partially Paid', 'Cancelled')),
    CONSTRAINT FK_Billing_Visit
        FOREIGN KEY (VisitID)
        REFERENCES Visit(VisitID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Table overview:
-- Patient   : one row per patient.
-- Department: one row per hospital department.
-- Doctor    : each doctor is assigned to one department.
-- Visit     : each visit belongs to one patient and one doctor.
-- Billing   : one billing record per visit; status defaults to 'Open'.
