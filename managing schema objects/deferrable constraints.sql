
create table emp_sal(
    emp_id number,
    sal number,
    bonus number,
    constraint sal_chk check(sal>100),
    constraint bonus_chk check(bonus>0)
);

select *
from user_constraints
where table_name='EMP_SAL';


--Any statement that doesn't meet the check conditions, will immediately trigger the error
insert into emp_sal
values(1, 90, 5);


insert into emp_sal
values(2, 100, -2);



--Drop the constraints and create them with new options
alter table emp_sal 
drop constraint sal_chk
drop constraint bonus_chk;


alter table emp_sal
add constraint sal_chk check(sal>100) deferrable;


--immediate deferrable is default
select *
from user_constraints
where table_name='EMP_SAL';



--Explicitly
--Als je "deferrable initially" keyword gebruikt kan je switchen tussen deferred en immediate
--Betekent dat die constraint deferred is tot je een commit statement uitoefent
alter table emp_sal
add constraint sal_chk check(sal>100)deferrable initially deferred;

--Betekent dat die constraint immediate is met andere woorden, zodra je probeert te inserten, kan het een
--een error geven
alter table emp_sal
add constraint bonus_chk check(bonus>0) deferrable initially immediate;


select  owner,
        constraint_name,
        constraint_type,
        table_name,
        search_condition,
        status,
        deferrable,
        deferred,
        validated,
        generated
from user_constraints
where table_name='EMP_SAL';


--Checking the first deferrable deferred constraint
--Eventho die salary minder dan 100 is gaat het toch
insert into emp_sal
values(1, 90, 5);

--Commit: dus hier gaat het een error geven
-- ORA-02091: transaction rolled back
-- ORA-02290: check constraint (HR.SAL_CHK) violated
commit;



--Checking the 2nd deferrable immediate constraint
--Error gets triggered immediately
insert into emp_sal
values(2, 200, -1);




--Als je "deferrable initially" keyword gebruikt kan je switchen tussen deferred en immediate
set constraint sal_chk immediate;
set constraint bonus_chk deferred;

--Als je in die data dictionary view kijkt gaat het je die originele deferrable value wijzen
--bc the set immediate switch you did is only for this session
select  owner,
        constraint_name,
        constraint_type,
        table_name,
        search_condition,
        status,
        deferrable,
        deferred,
        validated,
        generated
from user_constraints
where table_name='EMP_SAL';


--Since sal_chk is now immediate i will get an error immeidately when doing this
insert into emp_sal
values(1, 0, 5);


--But now when i close my session and come back!
--I get no error until I commit
insert into emp_sal
values(1, 0, 5);

set constraint sal_chk immediate;
set constraint bonus_chk deferred;


--Okay now that I have switched them again
--When i try to violate bonus_chk I should not immediately get an error
insert into emp_sal
values(1, 101, -1);

--Error when I commit ofc
commit;



drop table emp_sal;


create table emp_sal(
    emp_id number,
    sal number,
    bonus number,
    constraint sal_chk check(sal>100),
    constraint bonus_chk check(bonus>0)
);


select  owner,
        constraint_name,
        constraint_type,
        table_name,
        search_condition,
        status,
        deferrable,
        deferred,
        validated,
        generated
from user_constraints
where table_name='EMP_SAL';


--Als het op not deferrable is dan kan je niet switchen tussen immediate en deferred
-- Je kan alleen switchen als het is op deferrable

--cannot defer a constraint that is not deferrable
set constraint sal_chk immediate;
set constraint bonus_chk deferred;



drop table emp_sal;

--Als je not deferrable gebruikt dan moet die deferablle altijd immediate zijn
-- cannot defer a constraint that is not deferrable
create table emp_sal(
    emp_id number,
    sal number,
    bonus number,
    constraint sal_chk check(sal>100) not deferrable initially deferred,
    constraint bonus_chk check(bonus>0) not deferrable initially immediate
);


--Moet dus immediate zijn. En als het not deferrable is kan je die initally thing helemaal niet veranderen
create table emp_sal(
    emp_id number,
    sal number,
    bonus number,
    constraint sal_chk check(sal>100) not deferrable initially immediate,
    constraint bonus_chk check(bonus>0) not deferrable initially immediate
);

-- Dit gaat dus obviously helemaal niet
set constraint sal_chk deferred;

drop table emp_sal;


create table emp_sal(
    emp_id number,
    sal number,
    bonus number,
    constraint sal_chk check(sal>100),
    constraint bonus_chk check(bonus>0)
);



alter table emp_sal 
