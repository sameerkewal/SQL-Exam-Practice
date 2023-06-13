--1. Write an query to get all employees who’s firstname is equal to the string ‘1223’.
select * from employees where FIRST_NAME='1223';


--2. Write an query to get all employees who’s firstname is equal to the string ‘1223D’.
select * from employees = first_



--3. Write an query to get all employees who earn more then the string ‘500o’


--4. Write an query to get all employees who were hired after 17 JUNI 2003.



--5. For what is the NLS_DATABASE_PARAMETERS table used for?


--6 Change NLS_DATE_FORMAT to ‘DD-MON-YYYY’ and run query of 5 again. 

--7 Write an query to show the hire_date of the employees as ‘Monday, April 2023 12:56 PM’


--8 -Write an query to show the sysdate in string datatype, with format ’23-04-2023’

--9 Write an query to show the sysdate in string datatype, with format ’23-APRIL-2023’


--10 Write an query to show the sysdate in string datatype, with format ’23-APR-2023’


--11 Write an query to show the date of today as ‘23rd of APRIL 2023’.


--12 Write an query to show the month as ‘4th of Month of the year 2023’.


--13 Write an query to show the date of today as ‘Twenty Third of APRIL 2023’.


--14 Write an query to show the month as ‘fourth Month of the year 2023’.


--15 Write an query to show all employees who were hired in February.


--16 Write an query to show all employees who were hired on a Monday.


--17 Write an query to show all employees who were hired in 2002.


--18 Convert 1000 to an char datatype.


--19 Convert 100.0 to an char datatype. The output should be '100.00'. Write both ways of doing this. 


--20 Convert 8777777666.999989 to an char datatype. The output should be '8,777,777,667.000'. Write both ways of doing this.


--21 Convert 8777777666.999989 to an char datatype. The output should be '$8,777,777,667.000'. Write both ways of doing this.


--22 Convert -898 to an char datatype. The output should be '898-'.


--23 Convert -898 to an char datatype. The output should be '<898>'.


--24 Convert 100.56 to an char. And this should show the database currency. The output should '$100.56'


--25 Convert 10909.56 to an char. And this should show the database currency. Also use the group format. The output should be '$10,909.56'


--26 Convert 10909.56 to an char. The output should be 'SRD10,909.56'.


--27 Convert 10909.56 to an char. The output should be 'SRD10.909,56'.

--28 Convert '3345' to an number.

--29 Convert '3345.4545' to an number. The output should be 3345.4545.

--30 Convert '$8777777666.999989' to an number. The output should be 8777777666.999989.


--31 Convert '3345' to an number.

--32 Convert '3345.4545' to an number. The output should be 3345.4545.


--33 Convert '$8777777666.999989' to an number. The output should be 8777777666.999989.


--34 Create a sql query which print the following '29TH of April, 2023'.


--35 Create a sql query which print the following 'Saturday's Special'.

--36 Write an sql query to show the departments of a employee. If an employee has no department then that record should contain string 'Emp has no Dept'.

--37 Write an sql query to show the departments of a employee. If an employee has no department then that record should contain string 'null expr3'
--38 and if emp has a department show that as 'not null expr2'.


--39 Write a query to calculate the total amount after a employee has recieved their commision. If the employee doesn't recieve an comminision show that as 'Emp has no commision'.


--40 Write a query to calculate the total amount after a employee has recieved their commision.


--41 Write a query to show all deparments. If a deparments has no manager then the manger of those deparments are 200.

--42 Write a sql query to check if first_name and last_name are the same. If they are the same the print the null else first_name.



--43 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. When an employee has no commission_pct then return 1. Use nvl and coalesce.


--44 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. When an employee has no commission_pct then manager_id. Use nvl and coalesce.


--45 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. When an employee has no commission_pct then manager_id and when manager_id is null then print the salary. Use nvl and coalesce.


--46 For query above create a new column stating whats being printed. Use nvl2.


--47 Write a query to print the salary of an employee with commission. Use coalesce.


--48 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. When an employee has no commission_pct then return 1 else show the commission. Use case.


--49 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. When an employee has no commission_pct then manager_id else show the commission. Use case.
--50 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. When an employee has no commission_pct then manager_id and when manager_id is null then print the salary. Use case.

--51 For query above create a new column stating whats being printed. Use case.


--52 Write a query to print the salary of an employee with commission. Use case.

--53 Write a sql query which show the salary of IT_PROG when they are given an 10% raise. Other employees salary stay the same.

--54 Write a sql query which show the salary of IT_PROG when they are given an 10% raise. Also show if 'FI_ACCOUNT' were given 12% raise. Other employees salary stay the same.


--55 Write a sql query which show the salary of IT_PROG when they are given an 10% raise. And show if 'FI_ACCOUNT' were given 12% raise. And if 'PU_CLERK' were given 18% raise. Other employees salary stay the same.






