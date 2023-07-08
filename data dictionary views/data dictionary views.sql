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


--In bovenstaande query vind je dat die PK van emp_dept_fk dept_id_pk heet
--dus dan doe je deze query to find out the actual source(table) for this table
select *
from user_constraints where CONSTRAINT_name='DEPT_ID_PK';


--Self join om te wijzen wat die PK's van die FK's zijn if that makes any sense
select m.owner, m.TABLE_NAME, m.CONSTRAINT_NAME, m.CONSTRAINT_TYPE, m.R_CONSTRAINT_NAME, d.TABLE_NAME
from user_constraints m join user_constraints d on m.R_CONSTRAINT_NAME=d.CONSTRAINT_NAME
where m.TABLE_NAME = 'EMPLOYEES';


--Cannot see which column has which constraint
select * from USER_CONSTRAINTS
where table_name='EMPLOYEES';


select * from USER_CONS_COLUMNS
where table_name='EMPLOYEES';


SELECT m.OWNER, m.TABLE_NAME, m.CONSTRAINT_NAME, m.CONSTRAINT_TYPE
from user_constraints m
where table_name='EMPLOYEES';


SELECT m.OWNER, m.TABLE_NAME, m.CONSTRAINT_NAME, m.CONSTRAINT_TYPE, d.COLUMN_NAME, d.POSITION
from user_constraints m
join USER_CONS_COLUMNS d
on m.CONSTRAINT_NAME = d.CONSTRAINT_NAME
where m.table_name='EMPLOYEES';

select count(1) from USER_CONS_COLUMNS;


--Check the results. Wijst simply gewoon die constraint.
--If it is an fk it shows the PK it references and the columns in which both of the aforementioned
--columns appear
select m.owner, m.table_name, m.constraint_name, m.CONSTRAINT_TYPE, m1.COLUMN_NAME, d.CONSTRAINT_NAME, d1.COLUMN_NAME
from user_constraints m
left join USER_CONSTRAINTS d on m.R_CONSTRAINT_NAME=d.CONSTRAINT_NAME
left join USER_CONS_COLUMNS m1 on m1.CONSTRAINT_NAME=m.CONSTRAINT_NAME
left join user_cons_columns d1 on d1.CONSTRAINT_NAME=d.CONSTRAINT_NAME
where m.TABLE_NAME='EMPLOYEES';









-------------Table Comments and User Comments----------------

comment on table EMP_COPY
is 'This table is a subquery copy of the original employees table';

select * from USER_TAB_COMMENTS where table_name='EMP_COPY';

select * from all_tab_comments where table_name='EMP_COPY';


comment on column emp_copy.SALARY
is 'The salary the employee earns';

select * from USER_COL_COMMENTS WHERE
table_name='EMP_COPY';


comment on column EMP_COPY.SALARY
is 'new comment';

--overwrites old comment
select * from USER_COL_COMMENTS where table_name='EMP_COPY';