----------------Practice---------------------------



--Retrieve the details of all employees who have at least one dependent
select * from DEPARTMENTS dept where exists(
    select emp.DEPARTMENT_ID from EMPLOYEES emp where salary > 20000 and emp.DEPARTMENT_ID=dept.DEPARTMENT_ID);


--List the job titles of employees who have at least one colleague working in the same department.
select * from employees emp where exists(
    select 1 from employees subemp where SUBEMP.DEPARTMENT_ID=emp.DEPARTMENT_ID
    and emp.EMPLOYEE_ID!=SUBEMP.EMPLOYEE_ID 
);


--Get the employee IDs and names of all employees who have at least one subordinates working under them.


/* the EXISTS operator checks for the existence of at least one row returned by the subquery. 
Since the subquery is correlated to the outer query by comparing worker.MANAGER_ID with manager.EMPLOYEE_ID, 
the condition worker.MANAGER_ID = manager.EMPLOYEE_ID ensures that the subquery is evaluated for each row of the outer query. */

select manager.FIRST_NAME
from EMPLOYEES manager where exists(
    SELECT 1 from employees worker where worker.MANAGER_ID=manager.EMPLOYEE_ID);


    SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME
FROM EMPLOYEES e
WHERE EXISTS (
  SELECT 1
  FROM EMPLOYEES subordinate
  WHERE subordinate.MANAGER_ID = e.EMPLOYEE_ID
)
order by e.EMPLOYEE_ID;




select manager.EMPLOYEE_ID, count(worker.EMPLOYEE_ID)
from employees worker right join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID where worker.EMPLOYEE_ID is not null
group by manager.EMPLOYEE_ID
order by manager.EMPLOYEE_ID
;

--Find the department names that have at least one employee who joined the company before the year 2000.
select * from departments dep where exists(
    select 1 from EMPLOYEES emp where emp.DEPARTMENT_ID=dep.department_id and EMP.HIRE_DATE>to_date('13-01-2008', 'DD-MM-yyyy')
);


select * from employees where salary>20000;



select EMP.FIRST_NAME, EMP.LAST_NAME, EMP.SALARY, j.JOB_TITLE
from employees emp join jobs j on emp.job_id = j.JOB_ID
where salary=(select max(salary) from EMPLOYEES where employees.JOB_ID=emp.job_id)
;



/* Exercise 4:
Write a query to retrieve the department IDs, names, and locations of departments that
have the highest number of employees within their respective locations.
 */





select loc.LOCATION_ID, count(EMP.EMPLOYEE_ID)
from locations loc 
left join departments depart on loc.LOCATION_ID=depart.LOCATION_ID
left join employees emp on emp.DEPARTMENT_ID=depart.DEPARTMENT_ID
group by loc.LOCATION_ID
having count(emp.EMPLOYEE_ID)>0;






