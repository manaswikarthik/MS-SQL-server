
CREATE DATABASE IF NOT EXISTS BankManagementDB;

USE BankManagementDB;


CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerNumber VARCHAR(20) NOT NULL,
    CustomerName VARCHAR(150) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(150),

    CONSTRAINT UQ_CustomerNumber UNIQUE (CustomerNumber),
    CONSTRAINT UQ_CustomerEmail UNIQUE (Email)
) ENGINE = InnoDB;


CREATE TABLE Branches (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchCode VARCHAR(15) NOT NULL,
    BranchName VARCHAR(150) NOT NULL,
    BranchAddress VARCHAR(255) NOT NULL,
    IFSCCode VARCHAR(15) NOT NULL,

    CONSTRAINT UQ_BranchCode UNIQUE (BranchCode),
    CONSTRAINT UQ_IFSCCode UNIQUE (IFSCCode)
) ENGINE = InnoDB;


CREATE TABLE RelationshipManagers (
    ManagerID INT AUTO_INCREMENT PRIMARY KEY,
    ManagerName VARCHAR(150) NOT NULL,
    Phone VARCHAR(15),
    BranchID INT NOT NULL,

    CONSTRAINT UQ_Manager_Branch UNIQUE (ManagerID, BranchID),

    CONSTRAINT FK_Manager_Branch
        FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


CREATE TABLE AccountTypes (
    AccountTypeID INT AUTO_INCREMENT PRIMARY KEY,
    AccountTypeName VARCHAR(50) NOT NULL,

    CONSTRAINT UQ_AccountTypeName UNIQUE (AccountTypeName)
) ENGINE = InnoDB;


CREATE TABLE Accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    AccountNumber VARCHAR(20) NOT NULL,
    CustomerID INT NOT NULL,
    AccountTypeID INT NOT NULL,
    BranchID INT NOT NULL,
    ManagerID INT NOT NULL,
    Balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    OpenedDate DATE NOT NULL,
    AccountStatus VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT UQ_AccountNumber UNIQUE (AccountNumber),

    CONSTRAINT CHK_AccountBalance
        CHECK (Balance >= 0),

    CONSTRAINT CHK_AccountStatus
        CHECK (AccountStatus IN ('Active', 'Inactive', 'Closed')),

    CONSTRAINT FK_Account_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Account_Type
        FOREIGN KEY (AccountTypeID)
        REFERENCES AccountTypes(AccountTypeID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Account_Branch
        FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Account_Manager_Branch
        FOREIGN KEY (ManagerID, BranchID)
        REFERENCES RelationshipManagers(ManagerID, BranchID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionReference VARCHAR(30) NOT NULL,
    TransactionDate DATETIME NOT NULL,
    TransactionType VARCHAR(30) NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    Description VARCHAR(255),

    CONSTRAINT UQ_Account_Transaction
        UNIQUE (AccountID, TransactionReference),

    CONSTRAINT CHK_TransactionAmount
        CHECK (Amount > 0),

    CONSTRAINT CHK_TransactionType
        CHECK (TransactionType IN ('Credit', 'Debit')),

    CONSTRAINT FK_Transaction_Account
        FOREIGN KEY (AccountID)
        REFERENCES Accounts(AccountID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;


CREATE INDEX IDX_Account_Customer
ON Accounts(CustomerID);

CREATE INDEX IDX_Account_Branch
ON Accounts(BranchID);

CREATE INDEX IDX_Transaction_Date
ON Transactions(TransactionDate);

CREATE INDEX IDX_Transaction_Account_Date
ON Transactions(AccountID, TransactionDate);


DELIMITER $$

CREATE TRIGGER TRG_Savings_Balance_Insert
BEFORE INSERT ON Accounts
FOR EACH ROW
BEGIN
    DECLARE account_type_name VARCHAR(50);

    SELECT AccountTypeName
    INTO account_type_name
    FROM AccountTypes
    WHERE AccountTypeID = NEW.AccountTypeID;

    IF account_type_name = 'Savings' AND NEW.Balance < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Savings account balance cannot be negative';
    END IF;
END$$


CREATE TRIGGER TRG_Savings_Balance_Update
BEFORE UPDATE ON Accounts
FOR EACH ROW
BEGIN
    DECLARE account_type_name VARCHAR(50);

    SELECT AccountTypeName
    INTO account_type_name
    FROM AccountTypes
    WHERE AccountTypeID = NEW.AccountTypeID;

    IF account_type_name = 'Savings' AND NEW.Balance < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Savings account balance cannot be negative';
    END IF;
END$$

DELIMITER ;


SHOW TABLES;
