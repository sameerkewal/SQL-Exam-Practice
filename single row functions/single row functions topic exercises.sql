/* Manipulating strings with character functions in SQL SELECT and WHERE clauses 
HR Schema: Character Functions return Char*/


--1 Write an sql query to show the email adress of the employees where only the first letter is in capital.
--2 Write an sql query to show the first_name and last_name is in lower case. Also show only show the column to compare results.
--3 Write an sql query to show the first_name and last_name is in upper case. Also show only show the column to compare results.
--4 The first_name can have up to 20 characters. Write a sql query to show all 20 character. For the positions not used by the first_name show # on the left side. Example '###############Ellen'
--5 The last_name can have up to 25 characters. Write a sql query to show all 25 character. For the positions not used by the last_name show # on the right side. Example 'Abel#####################'
--6 Some phone number start with 515. Remove this and only show the number after 515.
--7 Some job_id in the employees table start with 'IT'. Show only this part of the string, remove the other letters.
--8 Create an query to the job_id of the employees as the following: IT_PROG => IT Programmer, AC_ACCOUNT => AC Accountant, AP_VP => AP Vice President. All other job should stay the same
--9 Write a query to only show the initials of an employee like 'R.R'. Use concat function instead of ||.
--10 Write a query to only show the 2 and 3 letter of an employee first_name.
--11 Write a query to only show the last 2 letters of an employee first_name.

/*HR Schema: Functions Returning Number Values*/
--12 Write a query to show how many characters a the first_name has. Do the same for last_name and email.
--13 Write a query to show the position(number) of first_name where the letters 'll' is located.
--14 Write a query to show only the letters after 'll' in a first_name. If 'll' is not present in the string show the whole name.

/* Performing arithmetic with date data
HR Schema: Arithmetic with date data */
--15 Write a query which shows the date after a employee has worked 2 years for the company.
--16 Write a query to show the date 1 year before stopping working for a job_id or department_Id(Job_history).
--17 Write a query to show the number of days a employee has work for a job_id/department_id.
--18 Write a query to show the number of months a employee has work for a job_id/department_id.
--19 Write a query to show the number of years a employee has work for a job_id/department_id.
--20 Write a query which show the datetime after 12u.
--21 Write a query which show the datetime after 30m.
--22 Write a query which show the datetime after 40s


/* Manipulating dates with the date function
HR Schema: Datetime Functions */
--23 Write a Oracle SQL statement to get the first date of the current month.
--24 Write a Oracle SQL statement to get the last date of the current month.
--25 Write a Oracle SQL statement to get the current date in the specified session time zone.
--26 Write a Oracle SQL statement to determine how many days are left in the current month.
--27 Write a Oracle SQL statement to get the first and last day of the current year.
--28 Write a Oracle SQL statement to get the number of days in current month.
--29 Write a Oracle SQL statement to get number of days between two given dates.
--30 Write a Oracle SQL statement to get the start date and end date of each month in current year from current month.


/* HR Schema: ROUND, TRUNC AND MOD */
--31 Write a query to show the 10% of an employees salary. Salary should include 2 decimals(afgerond). Use round
--32 Write a query to show the 10% of an employees salary. Salary should include 2 decimals. Use trunc
--33 Whats the differnce between trunc and round. Analse your results of 1 and 2. 
--34 Calculte the remainder of 11 divided by 4.
--35 Calculte the remainder of 11 divided by -4.
--36 Calculte the remainder of -11 divided by 4.
--37 Calculte the remainder of -11 divided by -4.





