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



## Database transactions
 
 A database transaction consists of one of the following:
 - DML statements that constitute one consistent change to the database
      - Bv: Je kan een salary updaten en dan fired een trigger om het te auditen. Dat hele ding is een transaction
      - Of bv een procedure dat bv gelijk alle salaries update or just runs a bunch of statements at once. That is a transaction
 - One DDL statement
 - One DCL statement


![Alt text](<../resources/db transactions.png>)



### Database transactions: Start and end
- Begin when the first DML statement is executed
- End with one of the following events:
  - A Commit or Rollback is issued
  - DDL statement or DCL statement executes
  - User exits SQLDeveloper or SQLPlus
  - The system crashes


### Advantages of Commit and Rollback statements:
- Ensure data consistency
- Preview data changes before making changes permanent changes
- Group logically related operations


### Commit:
Commit ends the current transaction by making all pending data changes permanent

Savepoint "name": marks a savepoint within the current transaction

Rollback: Ends the current transaction by discarding all pending data changes

Rollback to Savepoint "name": rolls back the current transaction to the specified savepoint thereby discarding any changes and or savepoints that were created after the savepoint to which you are rolling back. If you omit the "To savepoint" clause the rollback statement will rollback the entire transaction. Because savepoints are logical there is no way to list the savepoints, which you have created


### Implicit Transaction processing:

An automatic commit occurs in the following circumstances:
- A DDL statement is issued
- A DCL statement is issued
- Exiting SqlPlus or SQLDev without explicitly issuing commit or rollback statements

An Automatic rollback occurs when there is an abnormal termination of SQLDeveloper or SQLPlus or a system failure.



### State of the Data before commit or rollback:
- The previous state of the data can be recovered
- The current session can view the results of the DML operations by using select statements
- Other sessions cannot view the results of the DML statements issued by the current session
- The affected rows are locked; other sessions cannot change the data in the affected rows  



### State of the data after commit:
- Data changes are saved in the database
- The previous state of the data is overwritten
- All sessions can view the results
- Locks on the affected rows are released. Other sessions can now change the data in those rows
- All savepoints are erased






## Savepoints

- When you go to a rollback or savepoint the other safe points made after the one you rolled back to will be deleted
- Als je gewoon savepoint zet and then rollback without doing "rollback to savepoint" dan gaat het helemaal rollbacken
  and all the safepoints after that will be deleted
- If you put the savepoint name between "" hoef je niet de hele tijd zo ernaar te referreren(unless you're not using normal alphabet letters order)
- savepoint, then the earlier savepoint is erased.


