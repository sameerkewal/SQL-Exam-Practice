# DML:

A transaction consists of a collection of DML statements that form a logical unit of work.
Bij DML als je bij die insert statement die volgorde verandert dan mag het maar dan moet je logically die values ook veranderen bv
insert into departments(department_name, manager_id, location_id, department_id)
                values('test2', 100, 1700, 71);




## Delete:
- Apparently is je syntax:
  DELETE [FROM] table
  [WHERE CONDITION]

Hierbij is je from optional as well as je where. Obviously weet je wat gebeurt als je je where clause vergeet. 
Die from is ook optional btw


## Difference between delete and truncate:
- Delete is een dml statement en truncate een ddl statement
- You can rollback bij delete and you cannot rollback with truncate
- Fires the triggers and doesn't fire the triggers
- It could have a where clause and cant have a where clause
- Delete doesnt clear the memory. The size in memory doesnt shrink, but with a truncate table the size in memory also is nuked

![Alt text](<../resources/difference truncate and delete.png>)