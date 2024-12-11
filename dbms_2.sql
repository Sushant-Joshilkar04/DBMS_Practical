create database q2;
use q2;

create table employee (
	eid int auto_increment primary key,
    ename varchar(255),
    salary decimal(10,2)
);

create table manager (
	eid int primary key,
    ename varchar(255),
    foreign key(eid) references employee(eid)
);

create table project (
	projectid int primary key,
    project_name varchar(255),
    manager int,
    foreign key(manager) references manager(eid)
);

create table assignment (
	projectid int,
    eid int,
    primary key(projectid, eid),
    foreign key(projectid) references project(projectid),
    foreign key(eid) references employee(eid)
);

-- Inserting data
INSERT INTO employee (ename, salary) VALUES
('Alice', 50000),
('Bob', 60000),
('Charlie', 55000),
('David', 48000),
('Eve', 70000);

INSERT INTO manager (eid, ename) VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO project (projectid, project_name, manager) VALUES
(101, 'Bank Management', 1),
(102, 'Content Management', 2),
(103, 'Inventory Management', 1);

INSERT INTO assignment (projectid, eid) VALUES
(101, 1), -- Alice works on Bank Management
(101, 2), -- Bob works on Bank Management
(102, 1), -- Alice works on Content Management
(102, 3), -- Charlie works on Content Management
(103, 4), -- David works on Inventory Management
(101, 5); -- Eve works on Bank Management


-- Queries

-- Modify eid to use auto_increment
alter table employee modify eid int auto_increment;

-- Display employees working in both projects 'Bank Management' and 'Conent Management'
SELECT e.eid, e.ename
FROM employee e
JOIN assignment a1 ON e.eid = a1.eid
JOIN project p1 ON a1.projectid = p1.projectid
JOIN assignment a2 ON e.eid = a2.eid
JOIN project p2 ON a2.projectid = p2.projectid
WHERE p1.project_name = 'Bank Management' AND p2.project_name = 'Content Management';

-- Display average salary of the organization
select avg(salary) as average_salary from employee;

-- Employees who do not work in 'Bank Management'
select e.eid, e.ename
from employee e
where e.eid not in (
	select a.eid
    from assignment a
    join project p on a.projectid = p.projectid
    where p.project_name = 'Bank Management'
);

DELETE FROM assignment WHERE eid = 5;
DELETE FROM manager WHERE eid = 5;
delete from employee where eid = 5;

select eid, ename, salary from employee
where salary = (select max(salary) from employee);
