drop table cart;

create global temporary table cart(
    item_no number,
    qty number
)
on commit delete rows;


insert into cart
values(1, 10);

insert into cart
values(2, 20);

select * from cart;
commit;


--because you specified on commit delete rows
select * from cart;

drop table cart;

create global temporary table cart(
    item_no number,
    qty number
)
on commit preserve rows;


insert into cart
values(1, 10);

insert into cart
values(2, 15);

insert into cart
values(3, 20);

commit;

--Despite committing all the rows still there
select * from cart;


drop table cart;


--Global temporary tables can have constraints
create global temporary table cart(
    item_no number primary key,
    qty number
);

--They can also have indexes and and triggers associated with them
select * from user_ind_columns
where table_name='CART';

truncate table gtt_emp;
drop table gtt_emp;

-- Views can be created against temporary tables and combinations of temporary and permanent tables
-- Als je in een andere session inlogged en die view queued ga je ofc 0 rows krijgen
-- tenzij je ofc zelfs een row insert in die gtt_emp en daarna die view queued
create global temporary table gtt_emp(
    id constraint gtt_temp_pk primary key deferrable initially immediate,
    first_name,
    last_name,
    dept_id
)on commit delete rows
as select  employee_id,
           first_name,
           last_name,
           department_id
from employees;


select * from gtt_emp;



create or replace view gtt_vw
as select  first_name,
           last_name,
           dept.department_name
from gtt_emp e
join departments dept
on e.dept_id=dept.department_id;

--Checking out the index
--ook andere sessions kunnen die indexes zien
select * from user_ind_columns
where table_name='GTT_EMP';


insert into gtt_emp
values(1, 'Sameer', 'kewal', 90);
commit;

--You need to commit first before other sessions can do ddl statements on the table
