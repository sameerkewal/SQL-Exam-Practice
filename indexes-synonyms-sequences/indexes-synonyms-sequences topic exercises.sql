/* Managing Synonyms */

--1 Create a synonym called "EMP" for the "EMPLOYEES" table in the HR schema.
create synonym EMP for EMPLOYEES;




--2 Retrieve all records from the "EMPLOYEES" table using the "EMP" synonym.
select * from emp;

--3 Alter the synonym "EMP" to point to the "EMPLOYEES" table in a different schema, for example, "SCOTT.EMPLOYEES".
create or replace SYNONYM emp for sameer.employees;
select * from emp;





--4 Remove the synonym "EMP" from the database.
drop SYNONYM emp;

--5 Create a synonym called "DEPTS" for the "DEPARTMENTS" table in the HR schema.
create or replace synonym depts for DEPARTMENTS;

--6 Use the "DEPTS" synonym to retrieve all records from the "DEPARTMENTS" table.
select * from depts;

--7 Modify the "DEPTS" synonym to point to the "DEPARTMENTS" table in a different schema, such as "SCOTT.DEPARTMENTS".

--Create the other table first and give select privileges first.
select * from sameer.EMPLOYEES;
create or replace synonym dept for sameer.departments;
select * from dept;



--8 Create a private synonym called "JOBS" for the "JOBS" table in the HR schema.
create or replace synonym jobss for hr.jobs;


--9 Use the "JOBS" private synonym to retrieve all records from the "JOBS" table.
select * from jobss;

--10 Drop the "JOBS" private synonym.
drop synonym jobss;

--11 Create a public synonym called "EMP" for the "EMPLOYEES" table in the HR schema.

create public synonym locations for hr.LOCATIONS;
create SYNONYM locations for locations;
create public synonym employees for hr.EMPLOYEES;
create public synonym EMP for hr.EMPLOYEES;

drop public synonym emp;

drop PUBLIC synonym EMPLOYEES;

--12 Use the "EMP" public synonym to retrieve all records from the "EMPLOYEES" table.
select * from EMP;

--13 Drop the "EMP" public synonym.
drop public synonym emp;

--14 Create a synonym called "COUNTRIES" for the "COUNTRIES" table in the HR schema, but with a different name in the synonym.
create synonym cntries for hr.countries;

/* Managing SEQUENCE */
--1 Create a sequence called "EMPLOYEE_ID_SEQ" that starts with 1000 and increments by 1.
create or replace sequence employee_id_seq
start with 1000
increment by -1;


--2 Insert a new employee into the "EMPLOYEES" table using the next value from the "EMPLOYEE_ID_SEQ" sequence for the "EMPLOYEE_ID" column.
--3 Retrieve the current value of the "EMPLOYEE_ID_SEQ" sequence.
--4 Increment the "EMPLOYEE_ID_SEQ" sequence by 10 manually.
--5 Alter the "EMPLOYEE_ID_SEQ" sequence to restart from 2000 and increment by 2.
--6 Remove the "EMPLOYEE_ID_SEQ" sequence from the database.
--7 Create a sequence called "DEPARTMENT_ID_SEQ" that starts with 10 and increments by 10.
--8 Use the "DEPARTMENT_ID_SEQ" sequence to insert a new department into the "DEPARTMENTS" table, providing values for other columns as well.
--9 Retrieve the next value from the "DEPARTMENT_ID_SEQ" sequence.
--10 Insert multiple departments into the "DEPARTMENTS" table using the "DEPARTMENT_ID_SEQ" sequence.
--11 Alter the "DEPARTMENT_ID_SEQ" sequence to restart from 100 and increment by 1.
--12 Drop the "EMPLOYEE_ID_SEQ" and "DEPARTMENT_ID_SEQ" sequences.


/* Managing indexes */
--1 Create an index named "IDX_EMPLOYEE_LAST_NAME" on the "LAST_NAME" column of the "EMPLOYEES" table.
--2 Write a query to retrieve all employees with the last name 'Smith' using the created index.
--3 Add a new column, such as "EMAIL", to the index "IDX_EMPLOYEE_LAST_NAME" without recreating the entire index.
--4 Remove the "IDX_EMPLOYEE_LAST_NAME" index from the database.
--5 Attempt to insert a new job into the "JOBS" table with the same job title as an existing row to observe the unique index constraint.
--6 Temporarily disable the "IDX_JOB_TITLE" unique index to allow inserting duplicate job titles.
--7 Enable the "IDX_JOB_TITLE" unique index to enforce the uniqueness constraint again.
--8 Remove the "IDX_JOB_TITLE" unique index from the database.
