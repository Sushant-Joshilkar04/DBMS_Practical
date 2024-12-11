create database q6;
use q6;

CREATE TABLE Library (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Published_Year INT,
    Genre VARCHAR(100)
);

CREATE TABLE Library_Audit (
    Audit_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_ID INT,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Published_Year INT,
    Genre VARCHAR(100),
    Action_Type VARCHAR(10),  -- 'UPDATE' or 'DELETE'
    Action_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER Library_Audit_Trigger_Update
AFTER UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Title, Author, Published_Year, Genre, Action_Type)
    VALUES (OLD.Book_ID, OLD.Title, OLD.Author, OLD.Published_Year, OLD.Genre, 'UPDATE');
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER Library_Audit_Trigger_Delete
AFTER DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Title, Author, Published_Year, Genre, Action_Type)
    VALUES (OLD.Book_ID, OLD.Title, OLD.Author, OLD.Published_Year, OLD.Genre, 'DELETE');
END $$

DELIMITER ;


INSERT INTO Library (Book_ID, Title, Author, Published_Year, Genre)
VALUES
(1, '1984', 'George Orwell', 1949, 'Dystopian'),
(2, 'To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction'),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic');

UPDATE Library
SET Title = '1984 (Updated)', Author = 'G. Orwell', Published_Year = 1950
WHERE Book_ID = 1;

DELETE FROM Library
WHERE Book_ID = 2;

SELECT * FROM Library_Audit;
