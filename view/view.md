# Views:

![Alt text](<../resources/simple views and complex views.png>)



## Syntax:
![Alt text](<../resources/view syntax.png>)



Je kan constraints op views zetten in disabled novalidate mode. This may sound useless and it mostly is. Hier is wat chatgpt zegt
over de use ervan. Provides a logical representation of the constraints defined on the underlying base tables.


## Rules for performing DML operations on a view:
- You can not remove a row if the view contains the following:
 - Group functions
 - A group by clause
 - Distinct keyword
 - pseudocolumn rownum keyword

 ## You can not modify data in a view if it contains:
 - Group functions
 - Group by clause
 - Distinct keyword
 - Pseudocolumn rownum keyword
 - Columns defined by expressions(e.g: salary*12)


## You can not insert data through a view if the view includes:
- Group functions
- Group by clause
- Distinct keyword
- Pseudocolumn rownum keyword
- Columns defined by expressions
- Not null columns without default value in the base tables that are not selected by the view



## Constraints and stuff:
- Je kan constraints definen zolang ze disabled zijn
- Je kan geen check constraint definen I think 


If the view definition contains any constraints, CREATE VIEW ... FORCE will fail if the base table does not exist or the referenced object type does not exist. CREATE VIEW ... FORCE will also fail if the view definition names a constraint that does not exist.



- Views and synonyms are objects, so they have an object number, but a view does not consume physical space in the database, so it does not have a segment