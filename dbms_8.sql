create database q8;
use q8;

-- Create Customer table
CREATE TABLE Customer (
    Cid INT PRIMARY KEY,
    CustName VARCHAR(100),
    City VARCHAR(100)
);

-- Create Product table
CREATE TABLE Product (
    Pid INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Qty INT
);

-- Create Order table
CREATE TABLE Orders (
    Oid INT PRIMARY KEY,
    Cid INT,
    Pid INT,
    Qty INT,
    FOREIGN KEY (Cid) REFERENCES Customer(Cid),
    FOREIGN KEY (Pid) REFERENCES Product(Pid)
);

-- Insert data into Customer table
INSERT INTO Customer (Cid, CustName, City)
VALUES
(1, 'John Doe', 'New York'),
(2, 'Alice Smith', 'Los Angeles'),
(3, 'Bob Brown', 'Chicago');

-- Insert data into Product table
INSERT INTO Product (Pid, ProductName, Qty)
VALUES
(101, 'Laptop', 50),
(102, 'Phone', 100),
(103, 'Tablet', 30);

DELIMITER $$

CREATE TRIGGER update_product_qty_after_order
AFTER INSERT ON `Orders`
FOR EACH ROW
BEGIN
    UPDATE Product
    SET Qty = Qty - NEW.Qty
    WHERE Pid = NEW.Pid;
END $$

DELIMITER ;

SELECT * FROM Product;

-- Insert data into Order table
INSERT INTO Orders (Oid, Cid, Pid, Qty)
VALUES
(1, 1, 101, 2),  -- John Doe ordered 2 Laptops
(2, 2, 102, 1),  -- Alice Smith ordered 1 Phone
(3, 3, 103, 3);  -- Bob Brown ordered 3 Tablets

SELECT * FROM Orders;
