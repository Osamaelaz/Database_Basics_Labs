
use ITI

--1.Retrieve number of students who have a value in their age. 
select count(*) NumberOfStudents from Student where St_Age is not null

--2.Get all instructors Names without repetition
select distinct I.Ins_Name from Instructor I 

--3. Display student with the following Format (use is Null function)

 select S.St_id  [Student ID],isnull(S.St_FName, '') + ' ' + isnull(S.St_LName, '')  [Full Name]
 ,isnull(D.Dept_Name,' ')   [Department name]
from Student S inner join Department D
on D.Dept_id = S.Dept_id;

--4. Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not

select I.Ins_Name,D.Dept_Name from Instructor I left join Department D
on I.Dept_Id=D.Dept_Id

--5. Display student full name and the name of the course he is taking For only courses which have a grade  

select S.St_Fname+' '+S.St_Lname FullName, C.Crs_Name  from Stud_Course SC,Student S ,Course C 
where SC.St_Id=S.St_Id and SC.Crs_Id=C.Crs_Id and SC.Grade is not null


--6.Display number of courses for each topic name
select T.Top_Name,count(*)
from Course C inner join Topic T
on C.Top_Id=T.Top_Id
Group by T.Top_Name


--7. Display max and min salary for instructors
select min(i.Salary) [MinSalary],max(I.Salary) [MaxSalary]
from Instructor I


--8. Display instructors who have salaries less than the average salary of all instructors.

select * from Instructor 
where Salary < (select Avg(salary) from Instructor)

--9. Display the Department name that contains the instructor who receives the minimum salary.

select d.dept_name, min(i.salary)
from instructor i inner join department d
on i.dept_id = d.dept_id
group by d.dept_name
having min(i.salary) =(select min(salary) from Instructor)

select top 1  d.Dept_Name,i.Salary
from Department d,Instructor i 
where d.Dept_Id=i.Dept_Id and i.Salary is not null 
order by salary 

--10. Select max two salaries in instructor table. 
select Top 2 Salary from Instructor
order by Salary desc


--11. Select instructor name and his salary but if there is no salary display instructor bonus.
-- “use one of coalesce Function”

select Ins_Name, coalesce(cast(Salary as varchar), 'inst_bonus')
from Instructor;

--12. Select Average Salary for instructors 

Select avg(Salary) [Average Salary] from Instructor

--13.Select Student first name and the data of his supervisor 

select Y.St_Fname,x.*
from Student x ,Student y
where x.St_Id=y.St_super

--14. Write a query to select the highest two salaries in Each Department for instructors who have salaries.
-- “using one of Ranking Functions”
select * from (
select *,row_number() over(partition by I.Dept_Id order by salary desc)
as Rn from Instructor I where Salary is not null) As newTable
where Rn<=2

--15. Write a query to select a random  student from each department. 
-- “using one of Ranking Functions”
select * from (
    select s.*, row_number() over(partition by dept_id order by newid()) as rn
    from student s) as newtable
where rn = 1;


----------------------------------------

use AdventureWorks2012

--1.Display the SalesOrderID, ShipDate of the SalesOrderHeader table(Sales schema) to designate SalesOrders 
-- that occurred within the period ‘7/28/2002’ and ‘7/29/2014’

select SalesOrderID, ShipDate
from Sales.SalesOrderHeader
where ShipDate  between '2002-07-28' and '2014-07-29'


--2.Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)

select ProductID, Name
from Production.Product 
where StandardCost < 110


--3.Display ProductID, Name if its weight is unknown

select ProductID, Name
from Production.Product
where Weight is not null

--4.Display all Products with a Silver, Black, or Red Color

select * from Production.Product
where Color in('silver','black','red')

--5.Display any Product with a Name starting with the letter B

select * from Production.Product
where Name like 'B%'

--6.Run the following Query

update Production.ProductDescription
set Description = 'Chromoly steel_High of defects'
where ProductDescriptionID = 3

select *
from Production.ProductDescription
where Description like '%[_]%'


--7.Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table 
-- for the period between  '7/1/2001' and '7/31/2014'

select sum(TotalDue),OrderDate
from Sales.SalesOrderHeader
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate

--8.Display the Employees HireDate (note no repeated values are allowed)

select distinct HireDate
from HumanResources.Employee 

--9.Calculate the average of the unique ListPrices in the Product table

select avg(distinct ListPrice)
from Production.Product

--10.Display the Product Name and its ListPrice within the values of 100 and 120 the list should has the following 
-- format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)

select CONCAT('The ',Name,' is only!  ' , ListPrice)
from Production.Product
where ListPrice between 100 and 120
order by ListPrice 

--11. 
--a) Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table
-- in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?

select rowguid,Name,SalesPersonID,Demographics  into store_Archive
from Sales.Store


--b) Try the previous query but without transferring the data? 

select rowguid,Name,SalesPersonID,Demographics  into store_Archive
from Sales.Store where 1=2

--12. Using union statement, retrieve the today’s date in different styles using convert or format funtion. 

select format(getdate(), 'dd-mm-yyyy')  as today                 
union all
select format(getdate(), 'yyyy.mm.dd hh:mm')             
union all
select format(getdate(), 'dd mmm yyyy hh:mm tt');       
 

