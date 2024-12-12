drop database practical;
create database practical;
use practical;

CREATE TABLE Customer (
    Cid INT PRIMARY KEY,
    CustName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Product (
    Pid INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Qty INT
);

CREATE TABLE `Order` (
    Oid INT PRIMARY KEY,
    Cid INT,
    Pid INT,
    Qty INT,
    FOREIGN KEY (Cid) REFERENCES Customer(Cid),
    FOREIGN KEY (Pid) REFERENCES Product(Pid)
);


INSERT INTO Customer (Cid, CustName, City) 
VALUES (1, 'John Doe', 'New York'),
       (2, 'Jane Smith', 'Los Angeles'),
       (3, 'Robert Johnson', 'Chicago');

INSERT INTO Product (Pid, ProductName, Qty) 
VALUES (101, 'Laptop', 50),
       (102, 'Smartphone', 100),
       (103, 'Headphones', 150);


INSERT INTO `Order` (Oid, Cid, Pid, Qty) 
VALUES (1, 1, 101, 2),
       (2, 2, 102, 3),
       (3, 3, 103, 1);


DELIMITER //

CREATE TRIGGER UpdateProductQtyAfterOrder
AFTER INSERT ON `Order`
FOR EACH ROW
BEGIN
    UPDATE Product
    SET Qty = Qty - NEW.Qty
    WHERE Pid = NEW.Pid;
END //

DELIMITER ;


SELECT * FROM Product;


INSERT INTO `Order` (Oid, Cid, Pid, Qty) 
VALUES (4, 2, 101, 2);

SELECT * FROM Product;

INSERT INTO `Order` (Oid, Cid, Pid, Qty) 
VALUES (5, 3, 102, 3);

SELECT * FROM Product;

