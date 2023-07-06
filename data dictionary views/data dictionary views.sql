---------Dictionary-------------

select * from DICTIONARY;


select * from DICTIONARY where table_name like '%COL%';

select * from user_tab_cols;

select * from USER_CONS_COLUMNS;
select * from USER_TAB_COL_STATISTICS;
select * from USER_HIVE_COLUMNS;






---------User Objects and All Objects views


--Bij views/procedures/functions/packages/triggers 
--kan het dat je invalid ziet. Wat er dan is gebeurd is dat je een view had gemaakt en een table
--die involved was in die view is bv dropped. 
select * from USER_OBJECTS;

--Ondanks dat die index is generate door Oracle staat er bij generated "N"
select * from USER_OBJECTS
where object_type='INDEX';


--Verkort versie van user_objects
select * from CAT;



--Deze columns zijn volgens Udemy course belangrijk
select object_name, object_id, object_type, created, last_ddl_time, status, GENERATED
from user_objects;


select object_name, object_id, object_type, created, last_ddl_time, status, GENERATED
from user_objects
where object_type not in('PROCEDURE');



select object_name, object_id, object_type, created, last_ddl_time, status, GENERATED
from user_objects
where object_name='EMPLOYEES';


--All objects is all the objects that you have created and the ones you have privileges(???) to access
select owner, object_name, object_id, object_type, created, last_ddl_time, status, generated
from all_objects
where object_name='EMPLOYEES';





--User catalog is dictionary containing only table_name, table_type
--only tables, view, index, synonyms
select * from USER_CATALOG;

--shortcut for bovenstaande statement is the following:
select * from cat;






-------------------User Tables---------------------

--spreekt voor zichzelf. Je tabellen
select * from USER_TABLES; 


--Dit containen je eigen tables and tables waartoe je access hebt via privileges(???)
select owner,TABLE_name from all_tables;


--Je hebt tabs which is a synonym for user_tables
select * from tabs;


--Also pretty obvious: je kolommen
select * from USER_TAB_COLUMNS;


--al je kolommen met hun details
select * from USER_TAB_COLUMNS
where table_name='EMPLOYEES'
order by column_id;






--------------------User Constraints-------------

--Als je gaat naar emp_dept_fk en bij column r_constraint_name referred het naar die PK in die 
-- originele table. r_owner_r is gewoon die scheme owner ig
select * from USER_CONSTRAINTS
where table_name='EMPLOYEES';


select *
from user_constraints where CONSTRAINT_name='DEPT_ID_PK';
