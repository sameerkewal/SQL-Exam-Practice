
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