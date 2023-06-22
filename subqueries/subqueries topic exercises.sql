/* Using Subqueries to Solve Queries

Using Single Row Subqueries */
--1 Retrieve the employee details for the employee(s) with the highest salary in the company.
select FIRST_NAME, EMP.SALARY from employees emp where salary = (select max(salary) from EMPLOYEES);



--2 Display the employee details along with their job title for employees whose salary is greater than the average salary 
--of their respective departments.
--antwoord:
select a.FIRST_NAME, a.DEPARTMENT_ID, salary, j.JOB_TITLE from EMPLOYEES a 
join jobs j on j.job_id=a.JOB_ID
where salary>(select avg(salary) from EMPLOYEES b where a.department_Id=b.DEPARTMENT_ID)
order by a.DEPARTMENT_ID;

 select department_id, avg(salary) from EMPLOYEES group by DEPARTMENT_ID order by DEPARTMENT_ID;

select FIRST_NAME,DEPARTMENT_ID, SALARY from EMPLOYEES order by DEPARTMENT_ID;


--3 Find the department name(s) where the average salary is higher than the average salary of the 'Sales' department.

select dep.DEPARTMENT_NAME, avg(salary) from employees e join departments dep
on dep.DEPARTMENT_ID=e.DEPARTMENT_ID 
group by dep.DEPARTMENT_NAME
having avg(salary) > (select avg(salary) from EMPLOYEES 
where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Sales')
group by DEPARTMENT_ID);



select DEPARTMENT_ID, avg(SALARY)
from EMPLOYEES where DEPARTMENT_ID=80
group by DEPARTMENT_ID;


select DEPARTMENT_ID, avg(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID;


select dep.DEPARTMENT_NAME, avg(salary)
from departments dep join employees e on e.DEPARTMENT_ID=dep.DEPARTMENT_ID group by dep.DEPARTMENT_NAME
having avg(salary)>9013.235294117647058823529411764705882353;





--4 Display the employee details for the employee(s) who have a manager with a higher salary.

select worker.FIRST_NAME, worker.SALARY, manager.FIRST_NAME, manager.SALARY 
from EMPLOYEES worker 
join EMPLOYEES manager on worker.MANAGER_ID=MANAGER.EMPLOYEE_ID
where worker.salary>manager.SALARY;


select WORKER.FIRST_NAME, WORKER.SALARY
from EMPLOYEES worker
where worker.salary>(select manager.salary from employees manager where worker.manager_id=manager.EMPLOYEE_ID);


--5 List the employee details who have a salary greater than the average salary of employees in the same job title.
select JOB_ID, avg(salary) from EMPLOYEES
group by JOB_ID;


select a.FIRST_NAME, a.LAST_NAME, a.SALARY from EMPLOYEES a join jobs j on j.JOB_ID=a.JOB_ID
where salary>(select avg(salary)from employees b where a.job_id=b.JOB_ID)
order by  a.JOB_ID;



--6 Find the employee details for the employee(s) who have the lowest salary in the 'IT' department.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from EMPLOYEES
where salary=(select min(salary) from employees where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='IT'))
and DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='IT');




--7 Display the employee details along with their job title for employees whose salary is greater than the salary of 
--their immediate supervisor.

select worker.FIRST_NAME, j.job_title
from EMPLOYEES worker join jobs j 
on j.JOB_ID=worker.JOB_ID
where salary>(select salary from employees manager where manager.EMPLOYEE_ID=worker.manager_id);



select worker.FIRST_NAME, worker.SALARY, manager.FIRST_NAME, manager.SALARY, j.JOB_TITLE from EMPLOYEES worker 
join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
join jobs j on j.JOB_ID=worker.JOB_ID
where manager.salary<worker.SALARY;






--8 Find the employee details for the employee(s) who have the highest salary among all employees working in the same job title.
select * from employees A
where salary=(select max(salary) from EMPLOYEES b where a.job_id=b.JOB_ID);

select * from EMPLOYEES;



--9 List the employee details for the employee(s) who have a salary higher than the average salary of their department and work 
--in the 'Finance' department.

--omdat ze toch anw in de department finance moeten zijn dus dan pak ik gelijk de average van department Finance
select * from EMPLOYEES a where salary>(select avg(SALARY)
from EMPLOYEES
where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME ='Finance')
group by DEPARTMENT_ID)
and A.DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Finance');


select * from EMPLOYEES a
where salary>(select avg(salary) from employees b where a.department_id=b.DEPARTMENT_ID)
and a.DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where department_name = 'Finance')



select DEPARTMENT_ID, avg(SALARY)
from EMPLOYEES
where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME ='Finance')
group by DEPARTMENT_ID
;

select department_id, avg(salary)
from EMPLOYEES
group by DEPARTMENT_ID;

select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Finance';


--10 Retrieve the employee details for the employee(s) who have the lowest salary among all employees working in the same department.
select A.FIRST_NAME, A.SALARY, a.DEPARTMENT_ID from EMPLOYEES a
where salary=(select min(salary) from EMPLOYEES b where a.department_id=b.department_Id)
order by A.DEPARTMENT_ID;


select * from EMPLOYEES
order by DEPARTMENT_ID, SALARY;

/* Using multiple row subqueries */
--1 List the department names where the number of employees is greater than the average number of employees across all departments.


select DEPARTMENT_ID
from EMPLOYEES where count(DEPARTMENT_ID) in(select count(*)/count(distinct department_id) from EMPLOYEES)


select DEPARTMENT_ID
from EMPLOYEES 
group by DEPARTMENT_ID
having count(EMPLOYEE_ID)>(select count(*)/count(distinct DEPARTMENT_ID)
from EMPLOYEES);







select distinct DEPARTMENT_ID from EMPLOYEES;


--2 Retrieve the employee details for the employee(s) who have a salary greater than the maximum salary in their respective departments.
select *
from EMPLOYEES a
where salary >(select max(salary) from EMPLOYEES b where a.DEPARTMENT_ID=b.department_Id);



--3 Display the employee details along with their job title for employees whose salary is greater than the average salary of employees
-- in the same department.
select * from EMPLOYEES a
where salary>any(select avg(salary) from EMPLOYEES b where a.department_Id=b.DEPARTMENT_ID);


--4 Find the employee details for the employee(s) who have a salary higher than any employee working in the 'Sales' department.

select * from EMPLOYEES where salary>any(
    select salary from EMPLOYEES where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Sales')
)
order by SALARY;


 select FIRST_NAME, salary, DEPARTMENT_ID from EMPLOYEES 
 where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Sales')
 order by SALARY;









--5 List the department names where all employees have a salary greater than the average salary of 
--employees in the 'Administration' department.
select * from EMPLOYEES where salary>;

select DEPARTMENT_ID, avg(salary)
from EMPLOYEES
where DEPARTMENT_ID=(
    select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Administration')
group by DEPARTMENT_ID;


select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID from EMPLOYEES
where salary>(select avg(salary)
from EMPLOYEES
where DEPARTMENT_ID=(
    select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='Administration')
group by DEPARTMENT_ID);











--6 Retrieve the employee details for the employee(s) who have a salary greater than the second highest salary in the company.
select * from EMPLOYEES 
where salary>all(select salary from EMPLOYEES order by salary desc offset 1 row fetch first 1 row with ties);

select salary from EMPLOYEES
order by SALARY desc
offset 2 row;

select SALARY
from EMPLOYEES
order by salary desc
fetch first 3 row with ties;


--7 Display the employee details for the employee(s) who have a salary higher than the minimum salary in their respective departments.
select A.FIRST_NAME, A.SALARY, departments.DEPARTMENT_NAME
from EMPLOYEES a join DEPARTMENTS on a.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
where salary>all(
    select min(salary) from EMPLOYEES b where a.DEPARTMENT_ID=b.DEPARTMENT_ID
)
order by DEPARTMENT_NAME;


select DEPARTMENT_NAME,min(salary)
from EMPLOYEES join DEPARTMENTS DEP on EMPLOYEES.DEPARTMENT_ID=dep.DEPARTMENT_ID
group by DEP.DEPARTMENT_NAME
order by dep.DEPARTMENT_NAME;

select FIRST_NAME, salary, dep.department_name from EMPLOYEES
join DEPARTMENTS dep on dep.DEPARTMENT_ID=employees.DEPARTMENT_ID;


--8 Find the department names where the number of employees is greater than the number of employees in the 'IT' department.



select d.department_name
from departments D
where(
    select count(*) from employees e where e.department_id=d.department_id
    ) > (
        select count(*) from EMPLOYEES 
        where DEPARTMENT_ID=(select department_id from DEPARTMENTS where department_name='IT')
        group by DEPARTMENT_ID);


select department_name, count(*)
from EMPLOYEES join departments dep on employees.DEPARTMENT_ID=dep.DEPARTMENT_ID
group by department_name;


select emp.department_id, count(*)
from EMPLOYEES emp
join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
where dep.DEPARTMENT_NAME='IT' 
group by emp.DEPARTMENT_ID;



--9 List the employee details for the employee(s) who have a salary higher than the average salary of employees in the same job title.
SELECT * from EMPLOYEES a 
where salary>all(select avg(salary) from EMPLOYEES b where a.job_id=b.JOB_ID);


--10 Retrieve the employee details for the employee(s) who have a salary greater than the minimum salary in the 'IT' department.
SELECT
from EMPLOYEES
where salary>(select min(salary) 
              from EMPLOYEES 
              where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='IT'));




/* Using Correlated subqueries */
--1 Retrieve the employee details for the employee(s) who have a salary greater than the average salary of their department.
select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES a
where salary>(
    select avg(salary) from EMPLOYEES b where a.department_id=b.DEPARTMENT_ID
);



--2 List the department names along with the number of employees who have a salary greater than the average salary of their department.
select DEP.DEPARTMENT_NAME, count(*)
from EMPLOYEES a join departments dep on a.DEPARTMENT_ID=dep.DEPARTMENT_ID
where salary>(
    select avg(salary) from EMPLOYEES b where a.department_id=b.DEPARTMENT_ID
)
group by DEPARTMENT_NAME;





--3 Display the employee details for the employee(s) who have a hire date later than any employee in the 'IT' department.
select *
from EMPLOYEES a 
where HIRE_DATE>any(
    select HIRE_DATE from EMPLOYEES where DEPARTMENT_ID=(select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME='IT') 
)
order by A.HIRE_DATE;






--4 Find the employee details for the employee(s) who have a salary greater than the average salary of employees
--in the same job title and department.
select *
from EMPLOYEES a
where salary > (
    select avg(salary) from EMPLOYEES b where a.DEPARTMENT_ID=b.department_Id and a.JOB_ID=b.job_id
);

--5 Retrieve the department names along with the number of employees whose salary is less than the average salary of employees
--in the same department.
select dep.department_name, count(*) from EMPLOYEES emp join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
where salary<(
    select avg(SALARY) from EMPLOYEES b where emp.department_id=b.DEPARTMENT_ID
)
group by DEP.DEPARTMENT_NAME;

--6 Display the employee details for the employee(s) who have a manager with a higher salary in the same department.
select *
from EMPLOYEES a
where a.salary<(select salary from EMPLOYEES b where a.manager_id=b.EMPLOYEE_ID and a.department_id=b.DEPARTMENT_ID);


select WORKER.FIRST_NAME, worker.salary, manager.FIRST_NAME, manager.SALARY
from employees worker join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
where worker.SALARY<manager.salary and worker.DEPARTMENT_ID=manager.DEPARTMENT_ID;




--7 List the employee details for the employee(s) who have a salary greater than the average salary of 
--employees in the same department and have the same job title.
select A.FIRST_NAME, A.LAST_NAME, A.SALARY, A.DEPARTMENT_ID, a.JOB_ID
from EMPLOYEES a
where salary>(select avg(salary) from EMPLOYEES b where a.department_id=b.DEPARTMENT_ID and a.job_id=b.JOB_ID);


--8 Find the department names along with the number of employees who have a salary higher than the 
--average salary of their department and joined after the average hire date of the department.
select DEPARTMENT_ID
from EMPLOYEES a
where salary>(
    select avg(salary) from EMPLOYEES b where a.DEPARTMENT_ID=b.department_id
)
and to_number(to_char(hire_date, 'DDMMyyyy'))>(
    select avg(to_number(to_char(hire_date, 'DDMMyyyy'))) from EMPLOYEES c where a.department_Id=c.DEPARTMENT_ID
)
group by A.DEPARTMENT_ID;


--9 Retrieve the employee details for the employee(s) who have a salary greater than the average salary of employees 
--in the same department but joined before the average hire date of the department.
SELECT *
from EMPLOYEES a
where salary>(
    select avg(salary) from EMPLOYEES b where a.department_id=b.DEPARTMENT_ID 
) and to_number(to_char(hire_date, 'DDMMyyyy'))<(
    select avg(to_number(to_char(hire_date, 'DDMMyyyy'))) from employees c where a.department_id=c.DEPARTMENT_ID
);



--10 Display the employee details for the employee(s) who have a salary greater than the average salary of their department 
--and have a job title that starts with the same letter as their last name.

select A.LAST_NAME, J.JOB_TITLE, a.DEPARTMENT_ID, a.SALARY
from EMPLOYEES a join jobs j on a.JOB_ID=j.JOB_ID
where salary>(select avg(salary) from employees b where a.department_Id=b.DEPARTMENT_ID)
and substr(j.JOB_TITLE, 1,1)=(select substr(LAST_NAME, 1, 1) from EMPLOYEES c where c.EMPLOYEE_ID=a.employee_id);


select department_id, avg(salary)
from EMPLOYEES
group by DEPARTMENT_ID;


select LAST_NAME, j.job_id, j.JOB_TITLE
from EMPLOYEES e
join jobs j on j.JOB_ID=e.JOB_ID
where substr(LAST_NAME, 1, 1)=substr(J.JOB_TITLE, 1, 1);




