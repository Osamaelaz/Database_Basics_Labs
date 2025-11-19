
--============================ Part 01 =========================--
Create Database CompanyElazab
use CompanyElazab

Create Table Employee
(
SSN int Primary key Identity(1,1) 
,FName varchar(15) Not Null
,LName varchar(15) 
,[Address] varchar(20) default 'cairo'
,Salary money 
,Gender char(1)
,DNO int 
,SuperSSN int references Employee(SSN)
)

Create Table Department (
Number int primary key Identity(1,1)
,[Name] varchar(15) Not Null
,[Hiring Date] Date 
,MGRSSN int references Employee(SSN)
)

Create Table DeptLocations
(
Number int references Department(Number)
,[Location] varchar(20)
, primary key (Number,Location)
)

Create Table Project
(
PNum int Primary key identity(1,1)
,PName varchar(10)
,[Location] varchar(20)
,DNO int references Department(Number)
)

Create Table [Dependent]
(
[Name] varchar(20) Not Null
,Gender char(1)
,DOB date
,ESSN int references Employee(SSN)
,primary key (Name,ESSN)
)

Create Table Works_On
(
ESSN int references Employee(SSN)
,PNO int references Project (PNum)
,NumOfHours tinyint 
,primary key (ESSN,PNO)
)

Alter Table Employee 
Add Foreign key (DNO) references Department(Number)

insert into employee (fname, lname, salary, gender) values ('ahmed','ali',12000,'m'),
       ('sara','hassan',14000,'f');

insert into department ([name], [hiring date], mgrssn) values ('it','2022-03-15',1),
('hr','2023-01-10',2);

UPDATE Employee SET DNO=1 WHERE SSN=1;
UPDATE Employee SET DNO=2 WHERE SSN=2;


insert into deptlocations values (1,'nasr city'),(2,'dokki');

insert into project (pname, [location], dno)values ('OOP','cairo',1),('Database','giza',2);

insert into dependent values ('omar','m','2015-06-10',1),('maryem','f','2018-11-22',2);

insert into works_on values (1,1,20),(2,2,15);

--============================ Part 02 =========================--

use MyCompany
--1. Display all the employees Data

Select  * from Employee

-- 2. Display the employee First name, last name, Salary and Department number.

Select FName,LName,Salary,Dno From Employee

-- 3. Display all the projects names, locations and the department which is responsible for it

select Pname,plocation,Dnum from Project

-- 4. If you know that the company policy is to pay an annual commission for
 --each employee with specific percent equals 10% of his/her annual salary.
 --Display each employee full name and his annual commission in an ANNUAL
 --COMM column (alias).

select FName +' '+  LName  as FullName, Salary*12/10 as COMM  From Employee

--5. Display the employees Id, name who earns more than 1000 LE monthly

Select SSN, FName  From Employee where Salary > 1000

--6. Display the employees Id, name who earns more than 10000 LE annually.

Select SSN, FName  From Employee where Salary*12 > 10000

--7. Display the names and salaries of the female employees

select FName,Salary From Employee where Sex='F'

-- 8. Display each department id, name which is managed by a manager with id equals 968574

select Dnum,Dname from Departments where MGRSSN=968574

--9. Display the ids, names and locations of the projects which are controlled with department 10.

select Pnumber,Pname,Plocation from Project where Dnum=10