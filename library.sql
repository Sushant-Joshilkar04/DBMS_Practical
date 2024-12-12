drop database practical;
create database practical;
use practical;

CREATE TABLE Library (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    published_year INT
);

INSERT INTO Library (title, author, genre, published_year)
VALUES
    ('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951),
    ('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
    ('1984', 'George Orwell', 'Dystopian', 1949),
    ('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925),
    ('Moby Dick', 'Herman Melville', 'Adventure', 1851);


CREATE TABLE Library_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(10),  
    book_id INT,
    old_title VARCHAR(255),
    old_author VARCHAR(255),
    old_genre VARCHAR(100),
    old_published_year INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER before_update_library
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (action_type, book_id, old_title, old_author, old_genre, old_published_year, timestamp)
    VALUES ('UPDATE', OLD.book_id, OLD.title, OLD.author, OLD.genre, OLD.published_year, CURRENT_TIMESTAMP);
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER before_delete_library
after DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (action_type, book_id, old_title, old_author, old_genre, old_published_year, timestamp)
    VALUES ('DELETE', OLD.book_id, OLD.title, OLD.author, OLD.genre, OLD.published_year, CURRENT_TIMESTAMP);
END;
//
DELIMITER ;


UPDATE Library
SET title = 'The Catcher in the Rye - Updated', 
    author = 'J.D. Salinger Updated', 
    genre = 'Literature', 
    published_year = 1952
WHERE book_id = 1;

DELETE FROM Library
WHERE book_id = 2;

select * from Library_Audit;
