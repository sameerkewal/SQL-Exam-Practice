-----------Constraints------------
drop table emp2;
drop table dept2;

create table emp2
as select * from EMPLOYEES;

create table dept2
as select * from DEPARTMENTS;


-------Many ways to add constraints to a table--------------------

--Zie dit als column level constraint i guess
alter table emp2 modify EMPLOYEE_ID primary key;

--Zo naturally is dit ook mogelijk
alter table emp2 modify EMPLOYEE_ID constraint emp2_pk primary key;


select * from USER_CONSTRAINTS where table_name='EMP2';



---------The more natural way of adding constraints-------------

--Zie dit als table level I guess
alter table emp2 add constraint emp2_pk primary key(EMPLOYEE_ID);



alter table dept2 add constraint dep2_pk primary key(DEPARTMENT_ID);




--------Adding fk. Ook hier kan het ofc met modify of met add constraint

alter table emp2 modify DEPARTMENT_ID references DEPT2(DEPARTMENT_ID);

--Named method(not forced tho ofc bc this is column level ahh constraint)
alter table emp2 modify DEPARTMENT_ID constraint emp2_dept2_fk references DEPT2(DEPARTMENT_ID);



------------The better forced naming method-----------
alter table emp2 add constraint emp2_dept2_fk foreign key(DEPARTMENT_ID)references DEPARTMENTS;\









---------------Adding not null constraints------------------

--Will obviously only work if the table is empty or if you specify like a default value or sth OR there's already values for the column
--which you're making not null

--Hier zijn er al values for first_name in elke row so this will work
alter table emp2 modify FIRST_NAME not null;

--You can add multiple not null constraints in one line like this
alter table emp2 modify(FIRST_NAME not null, LAST_NAME not null);

select * from USER_CONSTRAINTS
where table_name='EMP2';

alter table emp2
drop constraint SYS_C0022334
drop constraint SYS_C0022335;


--Valid syntax btw
alter table EMP2
drop primary key;

--This will not work, alleen met primary key is dat valid
alter table EMP2
drop foreign key(department_id));


select * from user_constraints where table_name='EMP2';



--Ook met unique key gaat het wel
alter table emp2 
modify EMAIL constraint email_uk unique;

alter table EMP2
drop unique(email);


--Check gaat niet, zo alleen pk en unique key kunnen op zo een manier gedropped worden
alter table emp2
drop check(last_name);

alter table emp2
drop check(length(last_name)>0);

alter table emp2 modify last_name constraint name_chk check(length(last_name)>0);




-- this unique/primary key is referenced by some foreign keys
alter table dept2
drop primary key;


--To also drop the foreign key which depends on it you can do this
ALTER
TABLE DEPT2 DROP primary key cascade;


--Die fk which depended on it was in emp2 has now also been removed
select * from user_constraints where
table_name in('EMP2', 'DEPT2');


alter table dept2
    add constraint dept2_pk primary key(department_id);

alter table emp2
    add constraint emp2_dept2_fk foreign key(department_id) references departments(department_id);



--No shit but u cant delete this column bc its a pk
alter table dept2 drop column department_id;


--Same thing as before die depending constraints zijn ook
alter table dept2 drop column department_id cascade constraints;


--Adding multiple constraints in one statement
alter table emp2
add (
    constraint emp2_uk unique(employee_id),
    constraint emp2_dept2_fk foreign key(department_id) references dept2(department_id)
);

alter table emp2
drop constraint emp2_uk
drop constraint SYS_C0022391;



select * from user_constraints where
table_name in('EMP2', 'DEPT2');


alter table dept2 drop primary key cascade;


alter table emp2 add constraint emp2_dept2_fk foreign key(department_id)references departments(department_id);



alter table dept2 add(
    constraint dept2_uk unique(department_id)
);



alter table emp2 add(
    constraint emp2_pk primary key(employee_id),
    constraint emp2_uk unique(email)
);


alter table dept2 add(
    constraint dept2_pk primary key(department_id)
);

alter table emp2 add(
    constraint emp2_dept2_fk foreign key(department_id) references departments
);


alter table dept2 drop primary key cascade;


select * from dept2;
select * from emp2;





------------------Rename column----------------

alter table emp2 rename column first_name to fname;

alter table emp2 rename constraint emp2_dept2_fk to emp2_dept_fk;


rename emp2 to emp3;