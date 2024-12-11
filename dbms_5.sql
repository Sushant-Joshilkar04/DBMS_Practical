create database q5;
use q5;

-- Create tables for the student marks and results
CREATE TABLE Stud_Marks (
    Rollno INT PRIMARY KEY,
    Name VARCHAR(50),
    Total_Marks INT
);

CREATE TABLE Result (
    Rollno INT PRIMARY KEY,
    Name VARCHAR(50),
    Class VARCHAR(20)
);

-- Create the stored procedure for grade categorization
DELIMITER $$

CREATE PROCEDURE proc_Grade()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE stud_Rollno INT;
    DECLARE stud_Name VARCHAR(50);
    DECLARE stud_Total_Marks INT;
    DECLARE cur CURSOR FOR SELECT Rollno, Name, Total_Marks FROM Stud_Marks;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO stud_Rollno, stud_Name, stud_Total_Marks;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF stud_Total_Marks BETWEEN 990 AND 1500 THEN
            INSERT INTO Result (Rollno, Name, Class) VALUES (stud_Rollno, stud_Name, 'Distinction');
        ELSEIF stud_Total_Marks BETWEEN 900 AND 989 THEN
            INSERT INTO Result (Rollno, Name, Class) VALUES (stud_Rollno, stud_Name, 'First Class');
        ELSEIF stud_Total_Marks BETWEEN 825 AND 899 THEN
            INSERT INTO Result (Rollno, Name, Class) VALUES (stud_Rollno, stud_Name, 'Higher Second Class');
        ELSE
            INSERT INTO Result (Rollno, Name, Class) VALUES (stud_Rollno, stud_Name, 'No Category');
        END IF;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

-- Insert sample data into Stud_Marks table
INSERT INTO Stud_Marks (Rollno, Name, Total_Marks) VALUES (1, 'Alice', 1450);
INSERT INTO Stud_Marks (Rollno, Name, Total_Marks) VALUES (2, 'Bob', 970);
INSERT INTO Stud_Marks (Rollno, Name, Total_Marks) VALUES (3, 'Charlie', 860);
INSERT INTO Stud_Marks (Rollno, Name, Total_Marks) VALUES (4, 'David', 800);

-- Execute the procedure
CALL proc_Grade();

-- Query the Result table to view the categorized data
SELECT * FROM Result;
