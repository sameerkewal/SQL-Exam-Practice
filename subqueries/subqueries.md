## Multiple row subqueries:
- Return more than one row
- Use multiple-row comparison operators

Je hebt 3 operators waaronder:

In => Equal to any member in the list
Any => Must be preceded by =, !=, >, <, <=, >=. Returns true if atleast one element exists in the resultset of the subquery
for which the relation is true
All => Must be preceded by =, !=, >, <, <=, >=. Returns true if the relation is true for all elements in the resultset of the subquery
![Alt text](<../resources/multiple row subqueries.png>)


### Difference between "in" and "any" operator:
- They're almost the same maar bij je in operator wordt je value directly compared to the values in the list
- With the any operator wordt je value 1 voor 1 vergeleken met the values returned by the subquery
- Bij je any operator kan je comparison operators gebruiken



![Alt text](<../resources/any in all.png>)




### Null values.
- Bij In is het fine, je null value in die list of values just gets ignored
- Bij not in is als er een null value is, gaat je query niets returnen
- --Retrieves 0 records bc:
--not in is equivalent to <>all
--So als je subquery set contains one null value no records will be retrieved
select *
FROM EMPLOYEES
where MANAGER_ID not in(100, 101, null);


Null is basically unknown zo wanneer je doet 
select *
from EMPLOYEES
where DEPARTMENT_ID < all(110, 100, 90, null)
order by EMPLOYEE_ID desc;

dan ziet het je statement als 
where department_id < 110 or department_id<100 or department_id<90 or department_id<null
bij null it doesnt know wtf to do so it just sees it as unknown waardor je query no results gaat returnen