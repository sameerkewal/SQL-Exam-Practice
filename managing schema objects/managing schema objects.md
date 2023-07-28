## [Probably worth reading the Oracle documentation for constraints](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/constraint.html#GUID-1055EA97-BA6F-4764-A15F-1024FD5B6DFE)




You cannot alter the deferrability of a constraint. Whether you specify either of these parameters, or make the constraint NOT DEFERRABLE implicitly by specifying neither of them, you cannot specify this clause in an ALTER TABLE statement. You must drop the constraint and re-create it.



The INITIALLY clause establishes the default checking behavior for constraints that are DEFERRABLE. The INITIALLY setting can be overridden by a SET CONSTRAINT(S) statement in a subsequent transaction.

- Specify INITIALLY IMMEDIATE to indicate that Oracle should check this constraint at the end of each subsequent SQL statement. If you do not specify INITIALLY at all, then the default is INITIALLY IMMEDIATE.

- If you declare a new constraint INITIALLY IMMEDIATE, then it must be valid at the time the CREATE TABLE or ALTER TABLE statement is committed or the statement will fail.

- Specify INITIALLY DEFERRED to indicate that Oracle should check this constraint at the end of subsequent transactions.

- This clause is not valid if you have declared the constraint to be NOT DEFERRABLE, because a NOT DEFERRABLE constraint is automatically INITIALLY IMMEDIATE and cannot ever be INITIALLY DEFERRED.

- A constraint that's DEFERRABLE though uses a non-unique index instead of a unique index (because it has to record changes that may violate the unique constraint while constraint checking is being deferred).


Als je in die data dictionary view kijkt gaat het je die originele deferrable value wijzen
--bc the set immediate switch you did is only for this session


- It does roll back your **whole** transaction until the last time u implicitly or explicitly committed


## We cannot alter the constraint **ever**, only thing we can do is drop and recreate it


## Global Temporary Tables

- The global temporary tables is only for the current session, other users wont be able to see the data
- They can see that the table exists but not the data inside the table
- Meaning they can also see the structure of the table
- They can also insert into the table but the data they inserted is only visible for them itself
- Other sessions will not be able to see the data they inserted
- Export and Import utilities can be used to transfer the table definitions, but no data rows are processed
- Views can be made on them and combined with normal tables
- indexes can be made on em
- Also constraints(work on all other sessions)
- Triggers can be associated with them
- You need to commit first before other sessions can do ddl statements on the table
- You can make them by using a subquery as seen in [global tables.sql](<global tables.sql>)
- No redo is generated for gtt, however undo is generated for the gtt and redo for the undo must be generated


## External Tables:
- External data is a read only table whose metadata is stored in the db
- but whose data is stored outside of the db
- no dml allowed
- no indexes can be created on external tables
- You can access the data with 2 methods(oracle_loader or oracle_datapump)
- default for reject method is 0 
- To read external data, first u need to create a directory in the db
- to create directory you need create any directory privilege
- The directory owner will always be sys, regardless of who actually created it
- You can specify only NOT NULL, unique, primary key, and foreign key constraints on external tables. Unique, primary key, and foreign key constraints are supported only in RELY DISABLE mode.
- You must create the directory object before you create the external table; otherwise, an error is generated.
- Data Pump supports character set conversion for both direct path and external tables. Most of the restrictions that exist for character set conversions in the original Import utility do not apply to Data Pump. The one case in which character set conversions are not supported under the Data Pump is when using transportable tablespaces.


## Oracle_Loader and Oracle_Datapump
- The Oracle_Loader access driver is the default. It can perform only data loads, and the data must come from text datafiles. Loads
from external tables to internal tables are done by reading from the external tables' only datafiles
- The Oracle_Datapump access driver can perform both loads and unloads. The data must come from binary dump files. Loads to external tables are done by populating the external tables' binary dump files. 


- Data Pump supports character set conversion for both direct path and external tables. Most of the restrictions that exist for character set conversions in the original Import utility do not apply to Data Pump. The one case in which character set conversions are not supported under the Data Pump is when using transportable tablespaces.