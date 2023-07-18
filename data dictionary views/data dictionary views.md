![Alt text](<../resources/data dictionary.png>)

## Data dictionary has the following stuff in it:
- Definitions of all schema objects in the db(tables, views, indexes, synonyms, sequences, procedures,
functions, packages, triggers, and so on)
- Default values for columns
- Integrity constraint information
- Names of Oracle users
- Privileges and roles that each user has been granted
- Other general database information

## Naming conventions:
- USER => user's view(what is in your schema; what you own)
- ALL => Expanded user's view(what you can access)
- DBA => Database administrator's view(what is in everyone's schema)
         DBA objects contains information about all objects that are owned by all users
- V$ => Performance related data
        These views are dynamic in nature and hold information about performance. Dynamic performance
        tables are not true tables, and they shouldn't be accessed by most users. However
        db admins dan query and create views on the tables and grant access to those views to other users.
        


## Dictionary:
- It contains the names and descriptions of the dictionary tables and views


## The CAT view:
For a simpliefied query and output you can query the cat view. This view contains only 2 columns.
Table_name and table_type. It provides the names of all your index, table, cluster, view,
synonum, sequence or undefined objects
User objects geeft tables, indexes, sequences and views, procedures and triggers
user catalog geeft tables, sequences, views