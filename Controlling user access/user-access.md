# Controlling User Access:


2 types of security:
- System security
- Data security


A privilege is the right to execute particular SQL statements. The database adminisistrator
DBA is a high level user with the ability to create users and grant users access to the database and its
objects. Users require system privileges to gain access to the database and object privileges to manipulate the content of the objects in the database. Users can also be given the privilege to grant
additional privilege to other users or to roles, which are named groups of related privileges.

A schema is a collection of objects, such as tables, views and sequences. The schema is owned by a db user
and has the same name as that user. A system privilege is the right to perform a particular action,
or to perform an action on any schema objects of a particular type. An object privilege provides the user
the ability to perform a particular action on a specific schema objects


## System privileges:
- More than 200 privileges available
- The db administrator has high level system privileges for tasks such as
    - Creating new users
    - Removing users
    - Removing table
    - Backing up tables

Table SYSTEM_PRIVILEGE_MAP contains all the system privileges available

![Alt text](<../resources/dba privileges.png>)




![Alt text](<../resources/privilege syntax.png>)