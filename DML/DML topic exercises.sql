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





insert into EMP_COPY(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID)
                    select from EMPLOYEES



--8 Insert data into a table from a subquery. Insert all employees from the employees table into a new table called "backup_employees".
--9 Add a new department by selecting data from another table. Insert a new department with Department ID = 60 and retrieve the Department Name, Manager ID, and Location ID from the departments table for the department with Department ID = 50.
--10 Insert a new record into a table with default values. Insert a new employee into the employees table with only the required columns, and let the default values be assigned for other columns.



/* Perform Update */
--1 Update the salary of employee with Employee ID = 101 to 6000.
--2 Set the job ID of employee with Employee ID = 102 to 'IT_PROG' and the department ID to 60.
--3 Increase the salary of all employees in the 'SA_REP' job by 10%.
--4 Update the commission percentage of all employees in the 'SA_REP' job to 0.1.
--5 Change the manager ID of the employee with Employee ID = 105 to 110.
--6 Update the job title of all employees in the 'HR_REP' job to 'HR Representative'.
--7 Set the department ID of all employees in department 30 to null.
--8 Increase the salary of all employees in department 50 by 5%.
--9 Update the hire date of all employees in department 20 to the current date.
--10 Modify the email addresses of all employees by appending '@company.com' to their existing email addresses.


/* Perform Delete */
--1 Delete the employee with Employee ID = 101 from the employees table.
--2 Remove all employees in the department with Department ID = 50.
--3 Delete the job history records for the employee with Employee ID = 102.
--4 Remove all employees with a hire date earlier than '01-JAN-2005'.
--5 Delete the department with Department ID = 60 from the departments table.
--6 Remove all employees who have a job title of 'Programmer'.
--7 Delete all employees who have a salary greater than 10000.
--8 Remove all job history records where the end date is before '01-JAN-2010'.
--9 Delete the location with Location ID = 3000 from the locations table.
--10 Remove all employees whose last name starts with the letter 'S'.


/* Performing multi table Inserts */
--1 Insert a new department and an associated employee into the departments and employees tables. The department details are Department ID = 80, Department Name = 'Quality Assurance', Manager ID = 103, and Location ID = 2000. The employee details are Employee ID = 107, First Name = 'David', Last Name = 'Johnson', Email = 'davidjohnson@example.com', Phone Number = '8765432109', Hire Date = '2023-06-01', Job ID = 'QA_ANALYST', Salary = 5500, Commission Percentage = NULL, Manager ID = 103, and Department ID = 80.
--2 Add a new employee into the employees and job_history tables. Insert an employee with Employee ID = 108, First Name = 'Amy', Last Name = 'Brown', Email = 'amybrown@example.com', Phone Number = '7654321098', Hire Date = '2023-06-01', Job ID = 'IT_PROG', Salary = 4500, Commission Percentage = NULL, Manager ID = 102, and Department ID = 60. Also, insert a job history record for the employee with Start Date = '2023-06-01', End Date = NULL, Job ID = 'IT_PROG', Department ID = 60.
--3 Insert a new employee into the employees and job_history tables, selecting data from existing employees. Insert an employee with Employee ID = 109, retrieving the First Name, Last Name, Email, Phone Number, Hire Date, Job ID, Salary, Commission Percentage, Manager ID, and Department ID from an existing employee with Employee ID = 106. Also, insert a job history record for the new employee with Start Date = '2023-06-01', End Date = NULL, Job ID = (same as the new employee), and Department ID = (same as the new employee).
--4 Add a new department into the departments and locations tables, selecting data from existing departments. Insert a new department with Department ID = 90, retrieving the Department Name, Manager ID, and Location ID from an existing department with Department ID = 80.
--5 Insert multiple employees into the employees and job_history tables using a single INSERT statement. Add two new employees with Employee ID = 110 and Employee ID = 111, along with their respective details. Also, insert job history records for the new employees with Start Date = '2023-06-01', End Date = NULL, Job ID = (same as the new employees), and Department ID = (same as the new employees).

/* Performing Merge statements
Perform the following command for making the questions:
create table employees_staging as select * from  employees;
create table departments_staging as select * from  departments; */

--1 Merge the data from the employees_staging table into the employees table. Match the records based on the employee_id column. If a match is found, update the existing record in the employees table with the values from the employees_staging table. If a match is not found, insert the record from the employees_staging table into the employees table.
--2 Merge the data from the employees_staging table into the employees table, but only for employees who belong to department_id = 50. Match the records based on the employee_id column. If a match is found, update the existing record in the employees table with the values from the employees_staging table. If a match is not found, insert the record from the employees_staging table into the employees table.
--3 Merge the data from the employees_staging table into the employees table, but only for employees who have a salary greater than 5000. Match the records based on the employee_id column. If a match is found, update the existing record in the employees table with the values from the employees_staging table. If a match is not found, insert the record from the employees_staging table into the employees table.
--4 Merge the data from the departments_staging table into the departments table. Match the records based on the department_id column. If a match is found, update the existing record in the departments table with the values from the departments_staging table. If a match is not found, insert the record from the departments_staging table into the departments table.
--5 Merge the data from the departments_staging table into the departments table, but only for departments located in region_id = 1. Match the records based on the department_id column. If a match is found, update the existing record in the departments table with the values from the departments_staging table. If a match is not found, insert the record from the departments_staging table into the departments table.

