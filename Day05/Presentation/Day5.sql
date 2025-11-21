select suser_name()

select db_name()


select * from Student

insert into Student(st_id,st_fname) values(4444,'ahmed')

update Student set st_age+=1

delete from Student where st_id =4444

--->configurations
------versions & editions
-----setup comp
-----types of instances
-----types of auth
------------------------------------------
--Transact_SQL Queries
--top    selectinto   newid   ranking   insertbasedonselect  bulkinsert

select * from Student

select * from Student
where St_Address='cairo'

select top(3)* 
from Student

select top(5) st_fname,st_age 
from Student

select top(1)* 
from Student

select top(1)* 
from Student
where St_Address='alex'

select max(Salary)
from instructor

select top(2) max(Salary)
from instructor

--execution:   from   select   order   top
select top(2) salary
from instructor
order by salary desc

--newid  --builtin function   --return  GUID
select newid()

select * , newid() as Xid
from Student
order by Xid

select top(1)*
from Student

select top(1)*
from Student
order by newid()

select top(10)*
from questions
order by newid()


create table mydata
(
 id int default newid(),
 ename varchar(20)
)

--full path [object]
--Servername.DBname.SchemaName.Objectname

select * from Student

select * from [Rami].[ITI].dbo.student

select * from Project --->[rami].[ITI].[dbo].Project

select * from Company_SD.dbo.Project

select dept_name from Department
union all
select dname from Company_SD.dbo.Departments

--select into
--DDL
--create table from existing one
select * into tab2
from Student

select * into tab3
from Student

select st_id,st_fname into tab5
from Student
where st_age>25

select * into DB4.dbo.student
from Student

select * into tab7
from Student
where 1=2   --false condition  age<0

--insert based on select
insert into tab5
values(55,'ahmed')

insert into tab5
values(550,'ahmed'),(66,'eslam'),(665,'ali')

insert into tab5
select ins_id,ins_name from Instructor where Salary>7000

--bulkinsert
--insert data from file
--txt file  [delimited]

bulk insert tab5
from 'e:\mydata.txt'
with(fieldterminator=',')

select *
from (select * ,Row_number() over(order by st_age desc) as RN
      from Student) as X
where RN=1

select *
from (select * ,Dense_Rank() over(order by st_age desc) as DR
      from Student) as X
where DR=1

select *
from (select * ,Ntile(3) over(order by st_age desc) as G
      from Student) as X
where G=1

select *
from (select * ,Row_number() over(Partition by dept_id order by st_age desc) as RN
      from Student) as X
where RN=1

select *
from (select * ,Dense_Rank() over(Partition by dept_id order by st_age desc) as DR
      from Student) as X
where DR=1


select *
from (select * ,Ntile(2) over(Partition by dept_id order by st_age desc) as G
      from Student) as X

select *
from (select * ,Ntile(2) over(Partition by dept_id order by st_age desc) as G
      from Student) as X
where g=1 and dept_id=10

select *
from (select * ,Ntile(2) over(Partition by dept_id order by st_age desc) as G
      from Student) as X
where g=1 

select *
from (select * ,Ntile(2) over(Partition by dept_id order by st_age desc) as G
      from Student) as X
where g=2 

select *
from (select * ,Ntile(2) over(order by st_age desc) as G
      from Student) as X

--->Transact_sqL
selectinto   bulkinsert   ranking   top   newid  insertbasedonselect   fullpath

--builtin functions
--Aggregate function   Ranking functions
--concat  concat_ws
--getdate()  year mont day  datediff

select st_fname,st_lname
from Student

select upper(st_fname),lower(st_lname)
from Student

select len(st_fname) ,st_fname
from Student

select SUBSTRING(st_fname,1,3)
from Student

select SUBSTRING(st_fname,3,3)
from Student

select SUBSTRING(st_fname,1,len(St_fname)-1)
from Student

select *
from Student
where len(St_fname)>4

select *
from Student
where SUBSTRING(st_fname,1,1)='a'

select trim('   ahmed   ')
select ltrim('   ahmed   ')
select Rtrim('   ahmed   ')

select REVERSE('ahmed')

select REPLICATE(st_fname,3)
from Student

select REPLICATE('ali',5)


select CHARINDEX('x','mohamed')

select CHARINDEX('m',st_lname)
from Student

select REPLACE('ahmed$gmail.com','$','@')

select STUFF('ahmedomarkhalid',6,4,'xxxxxxx')

select isdate('1/2000')
select isdate('1/3/2000')
select isdate('6/13/2000')

select ISNUMERIC('4343gg')
select ISNUMERIC('434')

-------------------------------------

use AdventureWorks2012

select * from Production.Productcategory


























