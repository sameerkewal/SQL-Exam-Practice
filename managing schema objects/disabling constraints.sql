select *
from user_constraints
where table_name IN ('EMP2', 'DEPT2')
and constraint_type in ('P', 'R');


select *
from user_indexes
where table_name in ('EMP2', 'DEPT2');




alter table emp2
disable constraint emp2_pk;

--Nu is je status op disabled
select *
from user_constraints
where table_name IN ('EMP2', 'DEPT2')
and constraint_type in ('P', 'R');


--The index seemingly got nuked from existence(atleast in the data dictionary view)
select *
from user_indexes
where table_name in ('EMP2', 'DEPT2');



--------Here we enable the constraint once again------------
alter table
emp2 enable constraint emp2_pk;

--The constraint is now on enabled again
select *
from user_constraints
where table_name IN ('EMP2', 'DEPT2')
and constraint_type in ('P', 'R');


--En die index bestaat weer
select *
from user_indexes
where table_name in ('EMP2', 'DEPT2');



--Kinda logisch maar dit gaat, net als before, bij drop column voor een master table gaat dit niet werken

-- cannot disable constraint (HR.DEP2_PK) - dependencies exist
alter table dept2 
disable constraint dep2_pk;

alter table dept2
disable constraint dep2_pk cascade;


--Nu zijn both je primary key en je foreign key which was referring to your foreign key disabled
select *
from user_constraints
where table_name IN ('EMP2', 'DEPT2')
and constraint_type in ('P', 'R');


--Je index is weer genuked
select *
from user_indexes
where table_name in ('EMP2', 'DEPT2');


select  first_name,
        substr(first_name, length(first_name), -2)
from emp2;


select 'sameer', substr('sameer', 1, )
from dual;

select count(-)
from dual;


select salary+null
from employees;


 SELECT * FROM employees WHERE NVL2(salary + commission_pct, salary + commission_pct, salary) >= 20000;