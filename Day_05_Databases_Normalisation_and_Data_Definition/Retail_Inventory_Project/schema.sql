```sql
CREATE DATABASE IF NOT EXISTS RetailInventoryDB;

USE RetailInventoryDB;

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_CategoryName UNIQUE (CategoryName)
) ENGINE=InnoDB;


CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(150) NOT NULL,
    SupplierPhone VARCHAR(15) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE Warehouses (
    WarehouseID INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_WarehouseName UNIQUE (WarehouseName)
) ENGINE=InnoDB;


CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    SKU VARCHAR(30) NOT NULL,
    ProductName VARCHAR(150) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,

    CONSTRAINT UQ_ProductSKU UNIQUE (SKU),

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Product_Supplier
        FOREIGN KEY (SupplierID)
        REFERENCES Suppliers(SupplierID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    WarehouseID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    ReorderLevel INT NOT NULL DEFAULT 5,

    CONSTRAINT UQ_Product_Warehouse
        UNIQUE (ProductID, WarehouseID),

    CONSTRAINT CHK_Quantity
        CHECK (Quantity >= 0),

    CONSTRAINT CHK_ReorderLevel
        CHECK (ReorderLevel >= 0),

    CONSTRAINT FK_Inventory_Product
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Inventory_Warehouse
        FOREIGN KEY (WarehouseID)
        REFERENCES Warehouses(WarehouseID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


SHOW TABLES;
```