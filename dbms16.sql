drop database practical;
create database practical;
use practical;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

INSERT INTO Customer (customer_id, customer_name, email, phone_number) 
VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '555-555-5555');

DELIMITER $$

CREATE PROCEDURE GetCustomerNames()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE customer_name VARCHAR(100);
    DECLARE cur CURSOR FOR SELECT customer_name FROM Customer;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    

    OPEN cur;
    

    read_loop: LOOP
        FETCH cur INTO customer_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
      
        SELECT customer_name;
    END LOOP;
    
    
    CLOSE cur;
END $$

DELIMITER ;



CALL GetCustomerNames();

SELECT * FROM Customer;
