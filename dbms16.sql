create database q16;
use q16;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20)
);

INSERT INTO Customer (customer_name, email, phone_number)
VALUES
    ('John Doe', 'john.doe@example.com', '123-456-7890'),
    ('Jane Smith', 'jane.smith@example.com', '987-654-3210'),
    ('Alice Johnson', 'alice.johnson@example.com', '555-555-5555'),
    ('Bob Brown', 'bob.brown@example.com', '111-222-3333');

DELIMITER $$

CREATE PROCEDURE GetCustomerNames()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE customer_name VARCHAR(255);
    
    DECLARE customer_cursor CURSOR FOR 
        SELECT customer_name FROM Customer;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN customer_cursor;
    
    read_loop: LOOP
        FETCH customer_cursor INTO customer_name;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT customer_name;
    END LOOP;
    
    CLOSE customer_cursor;
END$$

DELIMITER ;

CALL GetCustomerNames();

SELECT customer_name FROM Customer;
