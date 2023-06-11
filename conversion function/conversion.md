## Data conversion
Er bestaan 2 soorten conversions:
implicit data conversion  => done by oracle
explicit data conversion => done by the user itself

### Expressions
als je doet
select * from employees where employee_id = '100'
dan convert het die varchar(since its between quotations automatisch om naar number(the actual datatype of the column))
Oracle convert het alleen naar een number als je number between quotations actually een valid number is


select * from employees where hire_date='21-SEP-05';
dit wordt automatisch convert naar datum. Dit is gewoon een string since yk je geen gebruik maakt van to_date or sth
wordt converted naar date omdat het het een valid date vindt dd-MON-RR


![Je hebt ook expression evalation](../resources/conversion.png)
### Expression evaluation


