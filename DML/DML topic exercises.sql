/* Perform Insert */


create table emp_copy
as select * from EMPLOYEES;
 
create table dept_copy 
as select * from DEPARTMENTS;




--1 Insert a new department with the following details: Department ID = 50, Department Name = 'Marketing', Manager ID = 200, 
--and Location ID = 1700.
insert into DEPT_COPY values(50, 'Marketing', 200, 1700);

--2 Add a new employee with the following details: Employee ID = 101, First Name = 'John', Last Name = 'Doe', Email = 
--'johndoe@example.com', Phone Number = '1234567890', Hire Date = '2023-01-01', Job ID = 'SA_REP', Salary = 5000, 
--Commission Percentage = 0.05, Manager ID = 100, and Department ID = 20.
insert into EMP_COPY values(101, 'John', 'Doe', 'johndoe@example.com', '1234567890', '01-JAN-23', 'SA_REP', 5000, 0.5, 100, 20);
select * from EMP_COPY;
commit;
select * from V$NLS_PARAMETERS;


--3 Insert a new job with the following details: Job ID = 'PROG', Job Title = 'Programmer', 
--Minimum Salary = 4000, and Maximum Salary = 8000.
create table job_copy
as select * from jobs;

insert into job_copy(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)values('PROG', 'Programmer', 4000, 8000);


--4 Add a new location with the following details: Location ID = 3000, Street Address = '123 Main St', Postal Code = '12345', 
--City = 'New York', State Province = 'NY', and Country ID = 'US'.
create table location_copy
as select * from LOCATIONS;

insert into LOCATION_COPY(LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
                    values(3000, '123 Main St', '12345', 'New York', 'NY', 'US');




--5 Insert a new employee by selecting data from another table. Insert the employee with Employee ID = 102 
--and retrieve the First Name, Last Name, Email, Phone Number, and Hire Date from the employees table for the employee with 
--Employee ID = 101.


insert INTO EMP_COPY(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID)
select 102, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID
from EMPLOYEES where EMPLOYEE_ID=101;

select * from EMP_COPY where EMPLOYEE_ID=102;
select * from EMPLOYEES
where EMPLOYEE_ID=101;


--6 Add a new job history for an employee. Insert a new record with Employee ID = 105, Start Date = '2022-06-01', 
--End Date = '2023-06-01', Job ID = 'IT_PROG', Department ID = 60.
create table jh_copy
as select * from JOB_HISTORY;

insert into JH_COPY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
            values  (105,         '01-JUNE-2022', '01-JUNE-2023', 'IT_PROG', 60);

select * from JH_COPY;
commit;



--7 Insert multiple records into a table using a single INSERT statement. 
--Add two new employees with Employee ID = 103 and Employee ID = 104, along with their respective details.
insert into EMP_COPY
select * from EMPLOYEES where EMPLOYEE_ID in(103, 104);








--8 Insert data into a table from a subquery. Insert all employees from the employees table into a new table called "backup_employees".
create table backup_employees
select * from EMPLOYEES; 



--9 Add a new department by selecting data from another table. Insert a new department with Department ID = 60 and retrieve 
--the Department Name, Manager ID, and Location ID from the departments table for the department with Department ID = 50.
insert into DEPT_COPY(DEPARTMENT_ID, DEPARTMENT_NAME,MANAGER_ID, LOCATION_ID)
        select 60, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
        from DEPARTMENTS where DEPARTMENT_ID=50;


        select * from DEPT_COPY;

        select * from DEPARTMENTS where DEPARTMENT_ID=50; 



--10 Insert a new record into a table with default values. Insert a new employee into the employees table with only the required columns, and let the default values be assigned for other columns.
commit;
ROLLBACK;

--first way:
insert into EMP_COPY values(1001, null, 'Kewal', 'Kewal@test.com', null, '20-MAY-02', 'IT_PROG', null, null, null, null);

--2nd way:
insert into EMP_COPY(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
values(1001, 'Kewal', 'kewal@test.com', '20-MAY-02', 'IT_PROG');


select * from emp_copy where EMPLOYEE_ID=1001;


--Employees heeft geen default values, as seen below:


CREATE TABLE "HR"."EMPLOYEES" 
   (	"EMPLOYEE_ID" NUMBER(6,0), 
	"FIRST_NAME" VARCHAR2(20), 
	"LAST_NAME" VARCHAR2(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE, 
	"PHONE_NUMBER" VARCHAR2(20), 
	"HIRE_DATE" DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE, 
	"JOB_ID" VARCHAR2(10) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE, 
	"SALARY" NUMBER(8,2), 
	"COMMISSION_PCT" NUMBER(2,2), 
	"MANAGER_ID" NUMBER(6,0), 
	"DEPARTMENT_ID" NUMBER(4,0), 
	 CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE, 
	 CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL")
  USING INDEX  ENABLE, 
	 CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "HR"."DEPARTMENTS" ("DEPARTMENT_ID") ENABLE, 
	 CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID")
	  REFERENCES "HR"."JOBS" ("JOB_ID") ENABLE, 
	 CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES "HR"."EMPLOYEES" ("EMPLOYEE_ID") ENABLE
   ) ;



   









/* Perform Update */
--1 Update the salary of employee with Employee ID = 101 to 6000.
truncate table emp_copy;

insert into EMP_COPY
select * from EMPLOYEES;

update emp_copy set SALARY=6000 where EMPLOYEE_ID=101;
commit;

--2 Set the job ID of employee with Employee ID = 102 to 'IT_PROG' and the department ID to 60.
update EMP_COPY set JOB_ID='IT_PROG', DEPARTMENT_ID=60 where EMPLOYEE_ID=102;

select * from EMP_COPY where EMPLOYEE_ID=102;




--3 Increase the salary of all employees in the 'SA_REP' job by 10%.
rollback;
select * from EMP_COPY;

update EMP_COPY set salary=salary*1.10 where JOB_ID='SA_REP';



--4 Update the commission percentage of all employees in the 'SA_REP' job to 0.1.
update EMP_COPY set COMMISSION_PCT=0.1 where JOB_ID = 'SA_REP';


--5 Change the manager ID of the employee with Employee ID = 105 to 110.
rollback;

update emp_copy set MANAGER_ID=110 where EMPLOYEE_ID=105;

select * from EMP_COPY where EMPLOYEE_ID=105;

--6 Update the job title of all employees in the 'HR_REP' job to 'HR Representative'.
update JOB_COPY set JOB_TITLE='HR Representative' where JOB_ID='HR_REP';

select * from JOB_COPY;

--7 Set the department ID of all employees in department 30 to null.
select * from EMP_COPY where DEPARTMENT_ID is null;

update EMP_COPY set DEPARTMENT_ID=null where DEPARTMENT_ID=30;





--8 Increase the salary of all employees in department 50 by 5%.
update EMP_COPY set salary = salary*1.05 where DEPARTMENT_ID=50;


--9 Update the hire date of all employees in department 20 to the current date.
select * from EMP_COPY order by HIRE_DATE;
update EMP_COPY set HIRE_DATE=sysdate where DEPARTMENT_ID=20;

--10 Modify the email addresses of all employees by appending '@company.com' to their existing email addresses.
update EMP_COPY set EMAIL = concat(email, '@company.com');

select * from EMP_COPY;
commit;

/* Perform Delete */
--1 Delete the employee with Employee ID = 101 from the employees table.
delete from EMP_COPY where EMPLOYEE_ID=101;

--2 Remove all employees in the department with Department ID = 50.
delete EMP_COPY where DEPARTMENT_ID=50;

select * from EMP_COPY where DEPARTMENT_ID=50;

--3 Delete the job history records for the employee with Employee ID = 102.
delete from JH_COPY where EMPLOYEE_ID=102;



--4 Remove all employees with a hire date earlier than '01-JAN-2005'.
delete from EMP_COPY where HIRE_DATE<to_date('01-JAN-2005', 'DD-MON-YYYY');

--5 Delete the department with Department ID = 60 from the departments table.
delete from DEPT_COPY where DEPARTMENT_ID=60;

--6 Remove all employees who have a job title of 'Programmer'.

delete from EMP_COPY where EMPLOYEE_ID in(
select EMPLOYEE_ID
from EMPLOYEES emp join
jobs j on emp.JOB_ID=j.JOB_ID where J.JOB_TITLE='Programmer');


--7 Delete all employees who have a salary greater than 10000.
delete EMP_COPY where SALARY>10000;


--8 Remove all job history records where the end date is before '01-JAN-2010'.

delete from JH_COPY where END_DATE<to_date('01-JAN-2010', 'DD-MON-yyyy');

select * from JH_COPY;


--9 Delete the location with Location ID = 3000 from the locations table.
delete LOCATION_COPY where LOCATION_ID=3000;


--10 Remove all employees whose last name starts with the letter 'S'.
delete from EMP_COPY where LAST_NAME like 'S%';



/* Performing multi table Inserts */
--1 Insert a new department and an associated employee into the departments and employees tables. 
--The department details are Department ID = 80, Department Name = 'Quality Assurance', Manager ID = 103, and Location ID = 2000. 
--The employee details are Employee ID = 107, First Name = 'David', Last Name = 'Johnson', Email = 'davidjohnson@example.com', 
--Phone Number = '8765432109', Hire Date = '2023-06-01', Job ID = 'QA_ANALYST', Salary = 5500, Commission Percentage = NULL, 
--Manager ID = 103, and Department ID = 80.

insert ALL
into dept_copy(DEPARTMENT_ID,DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) values(80, 'Quality Assurance', 103, 2000)
into EMP_COPY values(107, 'David', 'Johnson', 'davidjohnson@example.com', '8765432109', '01-JUNE-23', 'QA_ANALYST', 5500, null, 103, 80)
select 1 from dual;


select EMP.FIRST_NAME, EMP.LAST_NAME, DEPT.DEPARTMENT_NAME from
 EMP_COPY emp join dept_copy dept on emp.DEPARTMENT_ID=dept.DEPARTMENT_ID;


--2 Add a new employee into the employees and job_history tables. 
--Insert an employee with Employee ID = 108, First Name = 'Amy', Last Name = 'Brown', Email = 'amybrown@example.com', 
--Phone Number = '7654321098', Hire Date = '2023-06-01', Job ID = 'IT_PROG', Salary = 4500, Commission Percentage = NULL, 
--Manager ID = 102, and Department ID = 60. Also, insert a job history record for the employee with Start Date = '2023-06-01', 
--End Date = NULL, Job ID = 'IT_PROG', Department ID = 60.

insert all 
into EMP_COPY values(108, 'Amy', 'Brown', 'amybrown@example.com', '7654321098', '01-JUNE-2023', 'IT_PROG', 4500, null, 102, 60)
into JH_COPY values(108, '01-JUNE-23', '01-DECEMBER-49', 'IT_PROG', 60)
select 1 from dual; 

select * from EMP_COPY;
select * from jh_COPY;


--3 Insert a new employee into the employees and job_history tables, selecting data from existing employees.
-- Insert an employee with Employee ID = 109, retrieving the First Name, Last Name, Email, Phone Number, 
--Hire Date, Job ID, Salary, Commission Percentage, Manager ID, and Department ID from an existing employee with Employee ID = 106.
-- Also, insert a job history record for the new employee with Start Date = '2023-06-01', End Date = NULL, Job ID = 
--(same as the new employee), and Department ID = (same as the new employee).
insert ALL
into EMP_COPY values (109, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
into JH_COPY  values (109, '01-JUNE-2023', '01-DECEMBER-49', JOB_ID, DEPARTMENT_ID)
select FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
from EMPLOYEES where EMPLOYEE_ID=106;

select * from EMP_COPY;
select * from EMPLOYEES where EMPLOYEE_ID=106;
select * from JH_COPY;



--4 Add a new department into the departments and locations tables, selecting data from existing departments. 
--Insert a new department with Department ID = 90, retrieving the Department Name, Manager ID, 
--and Location ID from an existing department with Department ID = 80.
insert ALL
into DEPT_COPY values(90, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
select DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID from DEPARTMENTS where DEPARTMENT_ID=80;

select * from DEPT_COPY where DEPARTMENT_ID=90;

select * from DEPARTMENTS where DEPARTMENT_ID=80;


--5 Insert multiple employees into the employees and job_history tables using a single INSERT statement. 
--Add two new employees with Employee ID = 110 and Employee ID = 111, along with their respective details. 
--Also, insert job history records for the new employees with Start Date = '2023-06-01', End Date = NULL, Job ID = 
--(same as the new employees), and Department ID = (same as the new employees).

insert ALL
into 	EMP_COPY(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID) 
		values(110, 'Sameer', 'Kewal', 'skewal@test.com', '115', '1-JUNE-23', 'IT_PROG', 80000, 0, 60)
into EMP_COPY(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID) 
		values(111, 'Jennifer', 'Aamir', 'jamir@test.com', 115, '1-JUNE-23', 'FI_MGR', 80000, 0, 100)
into JH_COPY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
		values(110, '01-JUNE-23', '01-DECEMBER-49', 'IT_PROG', 60)
into JH_COPY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
		values(111, '01-JUNE-23', '01-DECEMBER-49', 'FI_MGR', 100)
select 1 from dual;








select * from jobs;
select * from DEPARTMENTS;





select * from EMP_COPY where EMPLOYEE_ID=101;

rollback;

insert all
into EMP_COPY(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID) 
			values(78, fname1, lname1, mail1, number1, hiredate1, jid1, slry1, cmt1, mgrid1)
select FIRST_NAME as fname1, LAST_NAME as lname1, EMAIL as mail1, PHONE_NUMBER as number1, HIRE_DATE as hiredate1, JOB_ID as jid1,
SALARY as slry1, COMMISSION_PCT as cmt1, MANAGER_ID as mgrid1
from EMPLOYEES where EMPLOYEE_ID=101;









select FIRST_NAME as FIRST_NAME1 from EMPLOYEES;

/* Performing Merge statements
Perform the following command for making the questions:
create table employees_staging as select * from  employees;
create table departments_staging as select * from  departments; */


select * from DEPT_COPY;
select * from EMP_COPY;


--1 Merge the data from the employees_staging table into the employees table. 
--Match the records based on the employee_id column. If a match is found, update the existing record in the employees table 
--with the values from the employees_staging table. If a match is not found, insert the record from the employees_staging table 
--into the employees table.


merge into EMPLOYEES a
using(select * from EMP_COPY)b
on(a.employee_id=b.employee_id)
when matched THEN
	update set a.first_name=b.first_name
when not matched THEN
	insert(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID)values
	(b.employee_id, b.first_name, b.LAST_NAME, b.email, b.PHONE_NUMBER, b.hire_date, b.job_id, b.salary, b.manager_id, b.department_id);







--2 Merge the data from the employees_staging table into the employees table, 
-- but only for employees who belong to department_id = 50. Match the records based on the employee_id column. 
-- If a match is found, update the existing record in the employees table with the values from the employees_staging table. 
-- If a match is not found, insert the record from the employees_staging table into the employees table.
merge into EMPLOYEES a
using(select * from EMP_COPY)b
on(a.employee_id=b.employee_id)
when matched then
	update set a.first_name=b.first_name
when not matched THEN
	insert (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID)
	values(b.employee_id, b.first_name, b.last_name, b.email, b.PHONE_NUMBER, b.hire_date, b.job_id, b.salary, b.manager_id, b.department_Id);
where DEPARTMENT_ID=50;

--3 Merge the data from the employees_staging table into the employees table, but only for employees who have a salary greater than 5000. 
-- Match the records based on the employee_id column. 
-- If a match is found, update the existing record in the employees 
-- table with the values from the employees_staging table. 
-- If a match is not found, insert the record from the employees_staging table into the employees table.
merge into EMPLOYEES a
using(select * from EMP_COPY)b
on(a.employee_id=b.employee_id)
when matched then
update set a.first_name=b.first_name
when not matched THEN
insert(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID)
values(b.employee_id, b.first_name, b.last_name, b.email, b.phone_number, b.hire_date, b.job_id,b.salary, b.manager_id, b.department_id);


--4 Merge the data from the departments_staging table into the departments table. 
--Match the records based on the department_id column. If a match is found, update the existing record in the departments table 
--with the values from the departments_staging table. 
--If a match is not found, insert the record from the departments_staging table into the departments table.

create table dept_copy
select * from departments;

merge into DEPARTMENTS a
using(select * from DEPT_COPY) b
on(a.department_id=b.department_id)
when matched THEN
update set a.department_name=b.department_name
when not matched then
insert(department_id, department_name, MANAGER_ID, location_id)
values(b.department_id, b.department_name, b.manager_id, b.location_id);




--5 Merge the data from the departments_staging table into the departments table, but only for departments located in region_id = 1. 
--Match the records based on the department_id column. If a match is found, 
--update the existing record in the departments table with the values from the departments_staging table. 
--If a match is not found, insert the record from the departments_staging table into the departments table.

create table dept_copy
as select * from departments;

merge into dept_copy a
using(select * from dept_copy)b
on(a.department_id=b.department_id)
when matched then
update set a.department_name=b.department_name
when not matched THEN
insert(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
	values(b.department_id, b.department_name, b.manager_id, b.location_id);

	commit;




/* Use the USING clause to specify the source of the data to be updated or inserted. 
The source can be a table, view, or the result of a subquery.
 */