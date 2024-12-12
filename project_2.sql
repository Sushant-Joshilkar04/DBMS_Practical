drop database practical;
create database practical;
use practical;

CREATE TABLE employee (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    ename VARCHAR(100),
    salary DECIMAL(10, 2)
);


CREATE TABLE project (
    projectid INT PRIMARY KEY,
    project_name VARCHAR(100),
    manager INT,
    FOREIGN KEY (manager) REFERENCES manager(eid)
);


CREATE TABLE manager (
    eid INT PRIMARY KEY,
    ename VARCHAR(100)
);

CREATE TABLE assignment (
    projectid INT,
    eid INT,
    PRIMARY KEY (projectid, eid),
    FOREIGN KEY (projectid) REFERENCES project(projectid),
    FOREIGN KEY (eid) REFERENCES employee(eid)
);
select * from assignment;

INSERT INTO employee (ename, salary) VALUES ('John Doe', 50000), ('Jane Smith', 60000), ('Alice Johnson', 70000);
INSERT INTO project (projectid, project_name, manager) VALUES (1, 'Bank Management', 1), (2, 'Content Management', 2);
INSERT INTO manager (eid, ename) VALUES (1, 'John Doe'), (2, 'Jane Smith');
INSERT INTO assignment (projectid, eid) VALUES (1, 1), (1, 2), (2, 1), (2, 3);

SELECT e.ename 
FROM employee e
JOIN assignment a1 ON e.eid = a1.eid
JOIN project p1 ON a1.projectid = p1.projectid
JOIN assignment a2 ON e.eid = a2.eid
JOIN project p2 ON a2.projectid = p2.projectid
WHERE p1.project_name = 'Bank Management' AND p2.project_name = 'Content Management';

SELECT AVG(salary) AS average_salary FROM employee;

SELECT e.ename 
FROM employee e
WHERE e.eid NOT IN (
    SELECT a.eid
    FROM assignment a
    JOIN project p ON a.projectid = p.projectid
    WHERE p.project_name = 'Bank Management'
);

DELETE FROM employee WHERE eid = 5;

SELECT ename, salary 
FROM employee 
WHERE salary = (SELECT MAX(salary) FROM employee);
select * from employee;
-- OR
SELECT ename ,salary
FROM employee 
ORDER BY salary DESC 
LIMIT 1;
