--simple inner join statement:
select e.FIRST_NAME as employee_first_name, m.FIRST_NAME as manager_first_name from employees e inner join employees m on e.MANAGER_ID = 
m.EMPLOYEE_ID;


select e.first_name as employees_first_name, m.first_name as manager_first_name from employees e
inner join employees m on e.MANAGER_ID = m.EMPLOYEE_ID;

--hoort bij het testen van me inner join statement
select * from employees where first_name = 'Tayler';

select * from employees where EMPLOYEE_ID =148;


--difference between full outer join and *join* is that full outer join also includes null values
select emp.first_name, emp.last_name, dep.DEPARTMENT_NAME from employees emp full outer join DEPARTMENTS dep on dep.DEPARTMENT_ID = 
emp.DEPARTMENT_ID;

select emp.first_name, emp.last_name, dep.DEPARTMENT_NAME from employees emp join departments dep on dep.DEPARTMENT_ID = 
emp.DEPARTMENT_ID;



--If u want to use column alias it can't start with a number(unless in double quotes). The number can be in the middle or at the end tho
--furthermore, you cant have special characters in it such as a percentage sign without including it in quotes
--what other special characters not allowed to be included??? I assume the usual ones?
select emp.first_name, emp.last_name, emp.salary, emp.salary+100, emp.salary+(emp.salary*0.10) as "salary%" from EMPLOYEES emp;



--arithemtic expressions containing a null value evaluate to null
select FIRST_NAME, LAST_NAME, COMMISSION_PCT, COMMISSION_PCT+1.0 from EMPLOYEES;


--column aliases
select first_name as fname, last_name lname, salary " salaryy" from EMPLOYEES;


--concatenation(+ a bit of column aliases again)
select FIRST_NAME, LAST_NAME, FIRST_NAME || ' ' || LAST_NAME  as tets from EMPLOYEES;


select emp.first_name || ' works in ' || dep.DEPARTMENT_NAME as "tets" from employees emp 
join departments dep on dep.DEPARTMENT_ID = emp.DEPARTMENT_ID;

--quote character
select FIRST_NAME || q'( works in department )' || DEPARTMENT_ID from EMPLOYEES;



select distinct LAST_NAME from EMPLOYEES;






