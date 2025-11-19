
use Company_SD

 --1. Display the Department id, name and id and the name of its manager.

 select D.Dnum,D.Dname ,E.SSN, E.FName+ ' '+E.LName as [Name] 
 From Employee E inner join Departments D
 on E.SSN = D.MGRSSN

 -- 2. Display the name of the departments and the name of the projects under its control
 select D.Dname ,P.Pname
 from Departments D inner join Project p
 on D.Dnum =P.Dnum

 -- 3. Display the full data about all the dependence associated with the name of the employee they depend on him or her

 select D.*, E.FName+ ' ' + E.LName as [Name] 
 From [Dependent] D inner join Employee E
 on E.SSN = D.ESSN

 -- 4. Display the Id, name, and location of the projects in Cairo or Alex city

 select Pnumber,Pname,plocation 
 From Project
 where City in('Alex','Cairo')

 --  5. Display the Projects full data of the projects with a name starting with "a" letter.

 select * from Project where Pname like 'a%'

 -- 6. display all the employees in department 30 whose salary from 1000 to 2000 LE monthly

select * from Employee 
where Dno=30 and Salary between 1000 and 2000


-- 7. Retrieve the names of all employees in department 10 who work more than
-- or equal 10 hours per week on the "AL Rabwah" project.

select  E.FName +' '+ E.LName  [Name]
from Employee E inner join works_for W
on E.SSN = W.ESSn and E.Dno=10 and W.Hours >= 10
inner join Project P 
on P.Pnumber=W.Pno and P.Pname='AL Rabwah' 

--8. Find the names of the employees who were directly supervised by Kamel Mohamed

select X.FName +' '+X.LName [Name]
from Employee x , Employee y
where y.SSN=x.Superssn and y.Fname +' ' +Y.LName like 'Kamel Mohamed'

--9.Retrieve the names of all employees and the names of the projects
--   they are working on, sorted by the project name

select E.FName +' '+ E.LName  [Name] , P.Pname
From Employee E inner join Works_for W
on E.SSN=W.ESSn 
inner join Project P 
on W.Pno=P.Pnumber
order by p.Pname

-- 10.For each project located in Cairo City, find the project number, the
--controlling department name, the department manager’s last name, address and birthdate

select P.PNumber,D.Dname,M.LName,M.Address,M.Bdate
from project p inner join Departments D
on P.Dnum = D.Dnum and P.City='Cairo'
inner join Employee M
on D.MGRSSN=M.SSN

--11. Display All Data of the managers

select Distinct  x.* 
From Employee x , Employee y  --x:Parent , y:Child
where x.SSN=y.Superssn  -- parent.id==child.superId ==> Depand on PK=> Parent , FK=> Child


-- 12.Display All Employees data and the data of their dependents even if they have no dependents.

select E.* , D.*
from Employee E left outer join [Dependent] D
on E.SSN = D.ESSN 

--13.Insert your personal data to the employee table as a new employee in department number 30,
-- SSN = 102672, Superssn = 112233, salary=3000.

insert into Employee values('Osama','Elazab',102672,GETDATE(),'Al Mansoura','M',3000,112233,30)

--14.Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660,
-- but don’t enter any value for salary or supervisor number to him.

insert into Employee(Fname,LName,SSN,Bdate,Address,Sex,Dno)
values('Ahmed','Nabil',102660,GETDATE(),'Al Mansoura','M',30)

-- 15.Upgrade Your Salary by 20% of its last value

update Employee 
set salary+=salary*0.2
where SSN=102672