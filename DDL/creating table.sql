--Wat betreft het gebruiken van double quotes voor table names of kolommen is het niet recommended.
--Aangezien je dan continu forced bent om op dezelfde manier te refereren naar die table
create table test(
    "test" varchar2(20)
);


insert into test("test")values('sameer');

--doesnt work
select test from sameer;

--need to do this
--also dan is het nu case sensitive geworden, which isnt the handiest
select "test" from test;


--die header is dan ook case sensitive, dus het appeared precies als hoe je het hebt defined
select * from test;


---------------Using Default----------------

create table test(
    emp_id number,
    eName varchar2(100),
    salary number(8,2),
    start_date date default sysdate,
    commission number(2, 2)
);


insert into test(emp_id, ename)
            values(1, 'Sam');

select * from test;
commit;


--See the tables of current schema pretty epic



select table_name from ALL_TABLES
where owner='HR';

select * from all_tables;











