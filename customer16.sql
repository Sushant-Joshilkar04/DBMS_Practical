drop database practical;
create database practical;
use practical;


CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT
);

INSERT INTO Customer (CustomerName, ContactNumber, Email, Address)
VALUES
('John Doe', '1234567890', 'john.doe@example.com', '123 Elm Street'),
('Jane Smith', '9876543210', 'jane.smith@example.com', '456 Oak Avenue'),
('Michael Brown', '5551234567', 'michael.brown@example.com', '789 Pine Lane');


DELIMITER $$

CREATE PROCEDURE GetCustomerNames()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE custName VARCHAR(100);
    
    DECLARE cur CURSOR FOR 
    SELECT CustomerName FROM Customer;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    
    OPEN cur;


    read_loop: LOOP
        FETCH cur INTO custName;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT custName;
    END LOOP;


    CLOSE cur;
END $$

DELIMITER ;


CALL GetCustomerNames();
