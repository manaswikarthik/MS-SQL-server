-- Insurance Policy Administration Database
-- MySQL 8.0.16+
-- The assignment mentions SQL Server functions such as DATEADD.
-- This schema is written for MySQL Workbench, consistent with the earlier projects.

CREATE DATABASE IF NOT EXISTS InsuranceManagementDB;
USE InsuranceManagementDB;

-- Drop child tables before parent tables so the script can be rerun.
DROP TABLE IF EXISTS Claims;
DROP TABLE IF EXISTS Premiums;
DROP TABLE IF EXISTS Policies;
DROP TABLE IF EXISTS Agents;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(120) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(150) UNIQUE,
    Address VARCHAR(255),
    City VARCHAR(80)
) ENGINE=InnoDB;

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(120) NOT NULL UNIQUE,
    ProductType VARCHAR(80) NOT NULL,
    Description VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Agents (
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    AgentName VARCHAR(120) NOT NULL,
    AgentCode VARCHAR(30) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Email VARCHAR(150) UNIQUE,
    City VARCHAR(80)
) ENGINE=InnoDB;

CREATE TABLE Policies (
    PolicyID INT AUTO_INCREMENT PRIMARY KEY,
    PolicyNumber VARCHAR(40) NOT NULL UNIQUE,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    AgentID INT NOT NULL,
    StartDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    PolicyStatus VARCHAR(20) NOT NULL DEFAULT 'Active',
    SumInsured DECIMAL(12,2) NOT NULL,
    CONSTRAINT CHK_Policies_Dates CHECK (ExpiryDate >= StartDate),
    CONSTRAINT CHK_Policies_Status
        CHECK (PolicyStatus IN ('Active', 'Expired', 'Cancelled', 'Lapsed')),
    CONSTRAINT CHK_Policies_SumInsured CHECK (SumInsured >= 0),
    CONSTRAINT FK_Policies_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_Policies_Products
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_Policies_Agents
        FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX IDX_Policies_ExpiryDate (ExpiryDate),
    INDEX IDX_Policies_CustomerID (CustomerID),
    INDEX IDX_Policies_ProductID (ProductID),
    INDEX IDX_Policies_AgentID (AgentID),
    INDEX IDX_Policies_Status (PolicyStatus)
) ENGINE=InnoDB;

CREATE TABLE Premiums (
    PremiumID INT AUTO_INCREMENT PRIMARY KEY,
    PolicyID INT NOT NULL,
    PremiumDate DATE NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL DEFAULT 'Paid',
    PaymentMethod VARCHAR(30),
    TransactionReference VARCHAR(80) UNIQUE,
    CONSTRAINT CHK_Premiums_Amount CHECK (Amount >= 0),
    CONSTRAINT CHK_Premiums_Status
        CHECK (PaymentStatus IN ('Paid', 'Pending', 'Failed', 'Refunded')),
    CONSTRAINT FK_Premiums_Policies
        FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX IDX_Premiums_PolicyID (PolicyID),
    INDEX IDX_Premiums_PremiumDate (PremiumDate),
    INDEX IDX_Premiums_PaymentStatus (PaymentStatus)
) ENGINE=InnoDB;

CREATE TABLE Claims (
    ClaimID INT AUTO_INCREMENT PRIMARY KEY,
    PolicyID INT NOT NULL,
    ClaimNumber VARCHAR(40) NOT NULL UNIQUE,
    ClaimDate DATE NOT NULL,
    SettlementDate DATE NULL,
    ClaimAmount DECIMAL(12,2) NOT NULL,
    ApprovedAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    ClaimStatus VARCHAR(20) NOT NULL DEFAULT 'Submitted',
    DamageCategory VARCHAR(100),
    CONSTRAINT CHK_Claims_Amount CHECK (ClaimAmount >= 0),
    CONSTRAINT CHK_Claims_ApprovedAmount CHECK (ApprovedAmount >= 0),
    CONSTRAINT CHK_Claims_Status
        CHECK (ClaimStatus IN ('Submitted', 'Under Review', 'Approved', 'Rejected', 'Settled')),
    CONSTRAINT CHK_Claims_SettlementDate
        CHECK (SettlementDate IS NULL OR SettlementDate >= ClaimDate),
    CONSTRAINT FK_Claims_Policies
        FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX IDX_Claims_PolicyID (PolicyID),
    INDEX IDX_Claims_Status (ClaimStatus),
    INDEX IDX_Claims_ClaimDate (ClaimDate),
    INDEX IDX_Claims_DamageCategory (DamageCategory)
) ENGINE=InnoDB;

-- Relationships:
-- Customers 1 --- many Policies
-- Products  1 --- many Policies
-- Agents    1 --- many Policies
-- Policies  1 --- many Premiums
-- Policies  1 --- many Claims
--
-- Premiums.PaymentStatus = 'Paid' identifies collected premium.
-- Claim ratio in reports can be defined as approved/settled claim amount
-- divided by collected premium, multiplied by 100.
