create database q12;
use q12;

CREATE TABLE supplier (
    supplierid INT PRIMARY KEY,
    sname VARCHAR(100),
    saddress VARCHAR(200)
);

CREATE TABLE parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    color VARCHAR(50)
);

CREATE TABLE catalog (
    supplierid INT,
    part_id INT,
    cost DECIMAL(10, 2),
    PRIMARY KEY (supplierid, part_id),
    FOREIGN KEY (supplierid) REFERENCES supplier(supplierid),
    FOREIGN KEY (part_id) REFERENCES parts(part_id)
);
-- Inserting data into the supplier table
INSERT INTO supplier (supplierid, sname, saddress) VALUES
(1, 'Supplier A', '1234 Elm St'),
(2, 'Supplier B', '5678 Oak Ave'),
(3, 'Supplier C', '91011 Pine Rd');

-- Inserting data into the parts table
INSERT INTO parts (part_id, part_name, color) VALUES
(1, 'Part X', 'green'),
(2, 'Part Y', 'blue'),
(3, 'Part Z', 'green'),
(4, 'Part W', 'red'),
(5, 'Part V', 'blue');

-- Inserting data into the catalog table
INSERT INTO catalog (supplierid, part_id, cost) VALUES
(1, 1, 50.00),
(1, 2, 60.00),
(2, 3, 40.00),
(2, 4, 30.00),
(3, 5, 70.00),
(3, 1, 55.00);

SELECT DISTINCT s.sname
FROM supplier s
JOIN catalog c ON s.supplierid = c.supplierid
JOIN parts p ON c.part_id = p.part_id
WHERE p.color = 'green';

SELECT DISTINCT s.sname
FROM supplier s
JOIN catalog c ON s.supplierid = c.supplierid
JOIN parts p ON c.part_id = p.part_id
WHERE p.color IN ('blue', 'green')
GROUP BY s.supplierid
HAVING COUNT(DISTINCT p.color) = 2;

SELECT s.sname
FROM supplier s
WHERE NOT EXISTS (
    SELECT p.part_id
    FROM parts p
    WHERE NOT EXISTS (
        SELECT c.supplierid
        FROM catalog c
        WHERE c.supplierid = s.supplierid
        AND c.part_id = p.part_id
    )
);

SELECT SUM(c.cost) AS total_cost_of_red_parts
FROM catalog c
JOIN parts p ON c.part_id = p.part_id
WHERE p.color = 'red';

SELECT s.sname
FROM supplier s
JOIN catalog c ON s.supplierid = c.supplierid
JOIN parts p ON c.part_id = p.part_id
WHERE p.color = 'green'
AND c.cost = (
    SELECT MIN(c1.cost)
    FROM catalog c1
    JOIN parts p1 ON c1.part_id = p1.part_id
    WHERE p1.color = 'green'
);

UPDATE parts
SET color = 'yellow'
WHERE part_id = 4;
