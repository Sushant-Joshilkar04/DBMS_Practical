drop database practical;
create database practical;
use practical;

CREATE TABLE supplier (
    supplierid INT PRIMARY KEY,
    sname VARCHAR(50),
    saddress VARCHAR(100)
);

CREATE TABLE parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE catalog (
    supplierid INT,
    part_id INT,
    cost DECIMAL(10, 2),
    PRIMARY KEY (supplierid, part_id),
    FOREIGN KEY (supplierid) REFERENCES supplier(supplierid),
    FOREIGN KEY (part_id) REFERENCES parts(part_id)
);

INSERT INTO supplier (supplierid, sname, saddress) VALUES
(1, 'Supplier A', 'Address 1'),
(2, 'Supplier B', 'Address 2'),
(3, 'Supplier C', 'Address 3'),
(4, 'Supplier D', 'Address 4');

INSERT INTO parts (part_id, part_name, color) VALUES
(1, 'Part 1', 'green'),
(2, 'Part 2', 'blue'),
(3, 'Part 3', 'red'),
(4, 'Part 4', 'green'),
(5, 'Part 5', 'blue');

INSERT INTO catalog (supplierid, part_id, cost) VALUES
(1, 1, 100.00), 
(1, 2, 200.00), 
(2, 1, 150.00), 
(2, 3, 250.00),
(3, 2, 300.00),
(3, 4, 180.00), 
(4, 3, 100.00), 
(4, 4, 120.00); 

INSERT INTO catalog (supplierid, part_id, cost) VALUES (2, 4, 100.00);

SELECT DISTINCT s.sname
FROM supplier s
JOIN catalog c ON s.supplierid = c.supplierid
JOIN parts p ON c.part_id = p.part_id
WHERE p.color = 'green';

select s.sname
from supplier s
join catalog c1 on s.supplierid = c1.supplierid
join parts p1 on c1.part_id = p1.part_id
join catalog c2 on s.supplierid = c2.supplierid
join parts p2 on c2.part_id = p2.part_id
where p1.color = 'green' AND p2.color = 'blue'; 


SELECT s.sname
FROM supplier s
JOIN catalog c ON s.supplierid = c.supplierid
JOIN parts p ON c.part_id = p.part_id
GROUP BY s.supplierid, s.sname
HAVING COUNT(DISTINCT p.part_id) = (SELECT COUNT(part_id) FROM parts);



SELECT SUM(c.cost) AS total_cost
FROM catalog c
JOIN parts p ON c.part_id = p.part_id
WHERE p.color = 'red';

SELECT DISTINCT s.sname,c.cost
FROM supplier s
JOIN catalog c ON s.supplierid = c.supplierid
JOIN parts p ON c.part_id = p.part_id
WHERE p.color = 'green'
order by c.cost
limit 1 ;

select * from parts;
UPDATE parts
SET color = 'new_color_value'
WHERE part_id = 4
AND EXISTS (
    SELECT 1
    FROM catalog
    WHERE supplierid = 2 AND catalog.part_id = parts.part_id
);
