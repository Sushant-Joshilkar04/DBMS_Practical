CREATE DATABASE Q1;
USE Q1;

-- Creating Tables

create table employee (
	eid int primary key,
    ename varchar(50),
    salary decimal(10,2)
);

create table manager (
	eid int primary key,
    ename varchar(50)
);

create table project (
	projectid int primary key,
    project_name varchar(50),
    manager int,
    foreign key(manager) references manager(eid)
);

create table assignment (
	projectid int,
    eid int,
    primary key (projectid, eid),
    foreign key(projectid) references project(projectid),
    foreign key(eid) references employee(eid)
);

-- inserting data in tables
INSERT INTO employee (eid, ename, salary, address) VALUES
(1, 'Alice', 45000, '123 Main St'),
(2, 'Bob', 35000, '456 Elm St'),
(3, 'Charlie', 50000, '789 Oak St'),
(4, 'Diana', 30000, '321 Pine St');

INSERT INTO manager (eid, ename) VALUES
(5, 'Eve'),
(6, 'Frank');

INSERT INTO project (projectid, project_name, manager) VALUES
(101, 'Bank Management', 5),
(102, 'E-Commerce', 6),
(103, 'Healthcare System', 5);

INSERT INTO assignment (projectid, eid) VALUES
(101, 1), -- Alice works on Bank Management
(101, 2), -- Bob works on Bank Management
(102, 3), -- Charlie works on E-Commerce
(103, 4), -- Diana works on Healthcare System
(103, 1); -- Alice works on Healthcare System

-- Queries
-- Alter table to add address in the employee table
alter table employee add address varchar(100);

-- Display employee name and projects on which they are working
select e.ename, p.project_name
from employee e 
join assignment a on e.eid = a.eid
join project p on a.projectid = p.projectid;

-- Display projectid, projectname, and their managers
select p.projectid, p.project_name, m.ename as manager_name
from project p 
join manager m on p.manager = m.eid;

-- Create view of employees working on 'Bank Management' project
create view bank_management_employees as
select e.eid, e.ename, e.salary
from employee e 
join assignment a on e.eid = a.eid
join project p on a.projectid = p.projectid
where p.project_name = 'Bank Management';

select * from bank_management_employees;

-- Print names of employees whose salary is greater than 40000
select e.ename from employee e
where e.salary > 40000;

-- Update salary of each employee with an increase of 2000

update employee
set salary = salary + 2000;

select * from employee;
