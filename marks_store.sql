drop database practical;
create database practical;
use practical;


CREATE TABLE Stud_Marks (
    Rollno INT PRIMARY KEY,
    Name VARCHAR(255),
    Total_Marks INT
);


CREATE TABLE Result (
    Roll INT PRIMARY KEY,
    Name VARCHAR(255),
    Class VARCHAR(50)
);

INSERT INTO Stud_Marks (Rollno, Name, Total_Marks)
VALUES 
    (1, 'Alice', 1450),
    (2, 'Bob', 920),
    (3, 'Charlie', 880),
    (4, 'David', 850),
    (5, 'Eva', 760);
    
    
    DELIMITER $$

CREATE PROCEDURE proc_Grade()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE roll_no INT;
    DECLARE student_name VARCHAR(255);
    DECLARE marks INT;
    
    
    DECLARE student_cursor CURSOR FOR 
        SELECT Rollno, Name, Total_Marks FROM Stud_Marks;
    
  
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    

    OPEN student_cursor;
    

    read_loop: LOOP
        FETCH student_cursor INTO roll_no, student_name, marks;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF marks <= 1500 AND marks >= 990 THEN
            INSERT INTO Result (Roll, Name, Class) VALUES (roll_no, student_name, 'Distinction');
        ELSEIF marks BETWEEN 900 AND 989 THEN
            INSERT INTO Result (Roll, Name, Class) VALUES (roll_no, student_name, 'First Class');
        ELSEIF marks BETWEEN 825 AND 899 THEN
            INSERT INTO Result (Roll, Name, Class) VALUES (roll_no, student_name, 'Higher Second Class');
        ELSE
            INSERT INTO Result (Roll, Name, Class) VALUES (roll_no, student_name, 'No Category');
        END IF;
    END LOOP;
   
    CLOSE student_cursor;
END $$

DELIMITER ;

CALL proc_Grade();

SELECT * FROM Result;
