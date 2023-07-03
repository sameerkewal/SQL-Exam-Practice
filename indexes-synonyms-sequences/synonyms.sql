--create synonym e for employees
create SYNONYM E
for EMPLOYEES;


select * from e;


select e.first_name, e.last_name, dep.DEPARTMENT_NAME
from e e 
join departments dep on e.department_id=dep.DEPARTMENT_ID;


--Data dictionary
select * from USER_SYNONYMS;
select * from ALL_SYNONYMS;



--Need privilege called create public synonym(connect with hr user to test this)
--Before die privilege moest sys user doen "select * from hr.employees"
--now he doesnt need to do that no more
create public synonym employees for hr.EMPLOYEES;
create public synonym jobs for jobs;
create public synonym deps for DEPARTMENTS;

--Public synonym droppen is andere syntax dan private synonym droppen
--Verder ook nog je hebt ook nog "drop public synonym" privilege nodig hiervoor
drop public synonym deps;  

