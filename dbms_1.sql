
create database practical;
use practical;
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(100),
    salary DECIMAL(10, 2)
);


CREATE TABLE manager (
    eid INT PRIMARY KEY,
    ename VARCHAR(100),
    FOREIGN KEY (eid) REFERENCES employee(eid)
);


CREATE TABLE project (
    projectid INT PRIMARY KEY,
    project_name VARCHAR(100),
    manager INT,
    FOREIGN KEY (manager) REFERENCES manager(eid)
);


CREATE TABLE assignment (
    projectid INT,
    eid INT,
    PRIMARY KEY (projectid, eid),
    FOREIGN KEY (projectid) REFERENCES project(projectid),
    FOREIGN KEY (eid) REFERENCES employee(eid)
);

INSERT INTO employee (eid, ename, salary)
VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 55000);

INSERT INTO manager (eid, ename)
VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO project (projectid, project_name, manager)
VALUES
(101, 'Project A', 1),
(102, 'Project B', 2);

INSERT INTO project (projectid, project_name, manager)
VALUES
(103, 'Bank Management', 1),
(104, 'Bank Management', 2);

INSERT INTO assignment (projectid, eid)
VALUES
(101, 3),
(102, 2);
INSERT INTO assignment (projectid, eid)
VALUES
(103, 3),
(104, 2);

Alter table employee add column address varchar(50) not null;
desc employee;

select e.ename,a.projectid,p.project_name
from employee e
inner join 
assignment a
on e.eid = a.eid
inner join 
project p
on p.projectid = a.projectid;

SELECT p.projectid, p.project_name, m.ename 
FROM project p
JOIN manager m ON p.manager = m.eid;
 
 CREATE VIEW employees_on_bank_management AS
SELECT e.eid, e.ename, e.salary, e.address
FROM employee e
JOIN assignment a ON e.eid = a.eid
JOIN project p ON a.projectid = p.projectid
WHERE p.project_name = 'Bank Management';

select * from employees_on_bank_management;

select ename from employee where salary>40000;


SET SQL_SAFE_UPDATES = 0;

UPDATE employee
SET salary = salary + 2000;

SET SQL_SAFE_UPDATES = 1;

select * from employee;


