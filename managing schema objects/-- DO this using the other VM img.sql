-- DO this using the other VM img

create table emp_load(
    empno number,
    fname varchar2(100),
    lname varchar2(100)
);

select * from emp_load;


select * from session_privs;


create or replace directory EMP_DIR
as '/home/oracle/Documents';


--Data dictionary view to get your directories
--The directory owner will always be sys, regardless of who actually created it
select * from all_directories;



--The syntax is apparently standard so no need to focus too much on the syntax
--reject limited unlimited betekent dat if the file contains a large amounts of errors,
--please load it anyways no matter the amount of errors
--you can change the limit to anything you like and when it hits that limit it will not load the data or sth 
create table emp_load_ext(
    employee_number number,
    fname varchar2(100),
    lname varchar2(100)
)
organization external(
    type oracle_loader
    default directory emp_dir
    access parameters(
        records delimited by newline
        fields terminated by ','
    )
    location('old_emp_data.csv')
)
reject limit unlimited;


select * from emp_load_ext;

--cannot do dml operations
delete from emp_load_ext;

--If you want to make changes you have to go into the original file and change it from there
--changes are immediately reflected in emp_load_ext don't have to go into original file and change it

select * from emp_load_ext;


drop table emp_pump;

--If we wanna create the external table we do this
create table emp2_pump(
    employee_number,
    fname,
    lname
)organization external(
    type oracle_datapump
    default directory EMP_DIR
    location('emp2.dmp')
)
as select   employee_id, 
            first_name, 
            last_name
from employees;


--If we wanna read from the external table we do this
create table emp_pump_read(
    employee_number number,
    fname varchar2(100),
    lname varchar2(100)
)
organization external(
    type oracle_datapump
    default directory emp_dir
    location('emp2.dmp')
);


select * from emp_pump_read;

create or replace directory emp_dir
as '/home/oracle/Documents';

select * from all_directories;


create table emp_load_ext2(
    empno number,
    fname varchar2(255),
    lname varchar2(255)
) organization external(
    type oracle_loader
    default directory emp_dir
    access parameters(
        records delimited by newline
        fields terminated by ','
    )
    location ('old_emp_data.csv')
)reject limit unlimited;

select * from emp_load_ext;























drop table emp_load_ext;


create table emp_load_ext(
    empno number,
    fname varchar2(255),
    lname varchar2(255)
)organization external(
    type oracle_loader
    default directory emp_dir
    access parameters(
        records delimited by newline
        fields terminated by ','
    )
    location ('old_emp_data.csv')
)
reject limit unlimited;

select * from emp_load_ext;


delete from emp_load;

select * from emp_load;

grant select any table to shavien;


