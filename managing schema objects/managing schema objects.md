## [Probably worth reading the Oracle documentation for constraints](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/constraint.html#GUID-1055EA97-BA6F-4764-A15F-1024FD5B6DFE)




You cannot alter the deferrability of a constraint. Whether you specify either of these parameters, or make the constraint NOT DEFERRABLE implicitly by specifying neither of them, you cannot specify this clause in an ALTER TABLE statement. You must drop the constraint and re-create it.



The INITIALLY clause establishes the default checking behavior for constraints that are DEFERRABLE. The INITIALLY setting can be overridden by a SET CONSTRAINT(S) statement in a subsequent transaction.

- Specify INITIALLY IMMEDIATE to indicate that Oracle should check this constraint at the end of each subsequent SQL statement. If you do not specify INITIALLY at all, then the default is INITIALLY IMMEDIATE.

- If you declare a new constraint INITIALLY IMMEDIATE, then it must be valid at the time the CREATE TABLE or ALTER TABLE statement is committed or the statement will fail.

- Specify INITIALLY DEFERRED to indicate that Oracle should check this constraint at the end of subsequent transactions.

- This clause is not valid if you have declared the constraint to be NOT DEFERRABLE, because a NOT DEFERRABLE constraint is automatically INITIALLY IMMEDIATE and cannot ever be INITIALLY DEFERRED.



Als je in die data dictionary view kijkt gaat het je die originele deferrable value wijzen
--bc the set immediate switch you did is only for this session


- It does roll back your **whole** transaction until the last time u implicitly or explicitly committed


## We cannot alter the constraint **ever**, only thing we can do is drop and recreate it