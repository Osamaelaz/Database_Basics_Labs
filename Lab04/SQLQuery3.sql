
use Company_SD

--1.	Display (Using Union Function)
--a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
--b.	 And the male dependence that depends on Male Employee.

select Distinct D.Dependent_name,D.Sex from Employee E,Dependent D
where E.Sex='F' and D.Sex='F'
union
select Distinct D.Dependent_name,D.Sex from Employee E,Dependent D
where E.Sex='M' and D.Sex='M'


-- 2. For each project, list the project name and the total hours per week (for all employees) spent on that project

 select P.Pname,sum(W.Hours) 'Total Hours'
 from Project P inner join Works_for W
 on w.Pno = P.Pnumber
 inner join Employee e
 on w.ESSn=e.SSN
 group by p.Pname


  -- 3. Display the data of the department which has the smallest employee ID over all employees' ID.
 select D.*
 from Departments D inner join Employee E
 on E.Dno = D.Dnum and E.SSN=(select min(ssn) from Employee)


 -- 4. For each department, retrieve the department name and the maximum,
 -- minimum and average salary of its employees

 select D.Dname,Max(E.Salary) 'Max Salary',Min(E.Salary) 'Min Salary',AVG(E.Salary) 'Average Salary'
 from Departments D left join Employee E
 on D.Dnum=E.Dno
 group by D.Dname


 -- 5.List the last name of all managers who have no dependents
select Distinct p.fname,p.Lname
from Employee  c inner join Employee p
on p.SSN = c.SuperSSN       
Left join Dependent AS d 
on d.ESSN = p.SSN     
where d.essn is null 

-- 6. For each department
-- if its average salary is less than the average salary of all employees 
-- display its number, name and number of its employees.

select d.Dnum, d.DName,count(e.Dno)  NumEmployees
from Departments  d inner join Employee  e
on e.Dno = d.Dnum
group by d.Dnum,d.DName
having avg(e.Salary) < ( select avg(Salary) from Employee)

 -- 7. Retrieve a list of employees and the projects they are working on ordered by
 --department and within each department, ordered alphabetically by last name, first name

 select E.* ,  P.* 
 From Employee E inner join Works_for W
 on W.ESSn=E.SSN
 inner join Project P 
 on W.Pno=P.Pnumber and e.Dno=p.Dnum -- works
 order by E.Dno , E.Lname,E.Fname

 -- 8. Try to get the max 2 salaries using subquery.

select max(salary) as max_2_salary
from employee
union
select max(salary)
from employee
where salary < (select max(salary) from employee);


select Distinct Top 2 Salary
    from Employee
    order by Salary Desc




--9. Get the full name of employees that is similar to any dependent name
select e.FName + ' ' + e.LName as EmployeeFullName,d.Dependent_name
from Employee e inner join Dependent d
on d.Dependent_name like '%' + e.FName + ' ' + e.LName + '%';



-- 10.Display the employee number and name if at least one of them have dependents (use exists keyword) self-study
select e.SSN,e.Fname,e.Lname
from Employee  e
where  exists (select d.* from Dependent  d where d.essn = e.SSN)


-- 11. In the department table insert a new department called "DEPT IT”, with id 100,
-- employee with SSN = 112233 as a manager for this department.
-- The start date for this manager is '1-11-2006'.

Insert into Departments Values('DEPT IT', 100 , 112233,'1-11-2006')

---------------------------------------------------------

--12. Do what is required if you know that: Mrs. Noha Mohamed (SSN=968574)
 --moved to be the manager of the new department (id = 100), and they give
 --you (your SSN =102672) her position (Dept. 20 manager)

 --a. First try to update her record in the department table.

 update Departments 
 set MGRSSN=968574
 where Dnum=100

 --b.Update your record to be department 20 manager. 
 --my SSN not in data of employee so i will add him

 insert into Employee(SSN,FName,LName,Sex,Salary) values (102672, 'Osama','Elazab','M',20000)

 update Departments 
 set MGRSSN=102672
 where Dnum=20

 --c.Update the data of employee number=102660 to be in your teamwork (he will be supervised by you)
 --(your SSN =102672)

 -- No employee Number =102660
 -- but i will do what the should commed if it exist

 update Employee
 set Superssn=102672
 where SSN=102660

 ----------------------------------
 -- 13. Unfortunately, the company ended the contract with Mr. Kamel Mohamed
 --(SSN=223344) so try to delete him from your database in case you know
 --that you will be temporarily in his position.
 --Hint: (Check if Mr. Kamel has dependents, works as a department manager,
 --supervises any employees or works in any projects and handles these cases).

 -- Handle in dependents Remove his dependence

 Delete  from Dependent 
 where ESSN=223344

 -- Handle in department replace him with my SSN

 update Departments
 set MGRSSN=102672
 where MGRSSN=223344

 -- Handle in Works_For replace him with my SSN

 update Works_for
 set ESSn=102672
 where ESSn=223344

  -- Handle in Employee by assign superssn to me and after that Remove him

 update Employee
 set Superssn=102672
 where Superssn=223344

 Delete from Employee where SSN=223344


 --14. Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30
update Employee
set Salary+=Salary* 0.3
from Works_for W inner join Employee E 
on E.SSN = W.ESSn
inner join Project P
on p.Pnumber = W.Pno  and P.Pname='Al Rawdah'