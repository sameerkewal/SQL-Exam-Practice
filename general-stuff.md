# General tips:

1. Je where statement wordt als eerste executed so you cant use column aliases there:
However you can use column aliases in order by and having





## not so general tips???
1. Bij substring en instring dont forget dat je spaces ook included worden
2. Bij instring al begin je vanaf achterin met tellen(so in reverse) die return value van die index gaat nog steeds vanaf voorin zijn
3. Can't trim in the middle



## Data conversion
Er bestaan 2 soorten conversions:
implicit data conversion  => done by oracle
explicit data conversion => done by the user itself



Je kan geen unique constraint zetten als je al een pk constraint hebt.
Omgekeerd obv ook niet



Een index en table mogen dezelfde name sharen, maar een table en sequence mogen niet dezelfde naam hebben
Indexes en constraints mogen ook dezelfde name sharen. You should pay attention to the namespace

- you can totally have a table with a special character if the special character is in the middle
- A role is a database object
- Both ROLES and USERS exist at the database level and share
the same namespace
- The UNUSED column and its data are retained within the table’s
storage allocation and counts against the total limit on the number of
columns the table is allowed to have.
- CREATE DIRECTORY lets you create a database object name for a
directory you choose. Later you can use this object for creating an external
table
- cant have a subquery in a check constraint bv 
 create table myTable(
    name,
    constraint name_chk check(name in (select DEPARTMENT_NAME from DEPARTMENTS))
);

- Als je numerics vergelijkt die in de vorm van strings zijn moet je naar die eerste character kijken. Bv
    als je sort 130 and 75 bij descending order gaat 75 eerst komen omdat die 7 groter dan die 1 is. 
    dates are greater, and August 29, 2010, should list before June 25,
    2010. Finally, with regard to numeric values treated as strings, you have to
    think about how they would appear in the dictionary—the first character is
    the most important, and in this case, the 7 in 75 indicates that character
    string is higher than 130, so in a descending pattern, the 75 would be listed
    before 130.

- Between is een replacement voor **and**, niet voor *or*
- the lack of an ORDER BY
    renders WITH TIES ineffective, but the syntax is acceptable nonetheless.
    There is no syntax error.
- . LEAD returns data from a row following the
current row, as determined by the offset and sorted by the LEAD function’s
ORDER BY clause
- Having **must** occur after the where clause
- Don't use any V$ tables in joins. C. The V$ prefix indicates that V$DATAFILE is a public synonym
for a dynamic performance view, for which Oracle Corporation does not
guarantee read consistency. Therefore, you are recommended to limit your
direct access of V$ objects to simple queries
- create index doesn't exist. Create table is wat je nodig hebt om een index te maken, since
creating a table with pk or uk automatically makes an index for it
- als je updateable view hebt you dont need access to the table to update it. Just have privilege to the view and update that. Same with selecting from the view/table
- You can grant  a role to another role but that user first needs to enable that 2nd role to make it actually work

- Redo log files are generally used for instance recovery and media recovery. The data needed for such operations is automatically recorded in the redo log files. However, a redo-based application may require that additional columns be logged in the redo log files. The process of logging these additional columns is called supplemental logging.
- distinct doesnt ignore null values, so als je in 1 column multiple nulls hebt gaat het voor die distinct gewoon eentje pakken
- normal or regular view can be indexed

### In read-only mode, the following operations are permitted on the table:
- Select
- management indexes, constraints, supplemental log
- Dropping and deallocation of unused columns
- Renaming and moving of the table
- Altering the table for physical property changes, row movement, and shrinking the segment
- Drop table

### The following operations are disabled on a table in read-only mode:
- DML on table or any table partitions
- Truncation of table
- Select for update
- Adding, removing, renaming, dropping, or setting a column to unused
- Dropping a partition or sub partition belonging to the table
- Online redefinition
- Flashback on the table

## Long:
- Table can only have one long column
- Long columns cannot appear anywhere in the where clauses or in integrity constraints
- Long columns cannot be indexed
- Cannot be specified in regular expressions
- Cannot be used in group by clauses, order by clauses, connect clauses or with the distinct
  operator in select statements
- unique operator of a select statement
- SQL built in functions, expressions or conditions
- select list of queries containing group by clauses
- select list of subqueries or queries combined by the union, intersect, or minus set operator
- select lists of create table...as select statements
- alter table...move statements select lists in subqueries in insert statements


## Datatypes:
- Long does not support characters I think
- Raw does!!
- Neither does long raw
- Long cannot be indexed but raw can





## More stuff!!!!
- rownum is processed before order by is processed. As a result you cannot sort rows
and then use rownum as a way of displaying
- Where clause mag niet before join clause!!
- Oracle Database issues an implicit COMMIT under the following circumstances:
Before any syntactically valid data definition language (DDL) statement, even if the statement results in an error After any data definition language (DDL) statement that completes without an error

- Yes, there is a difference between adding a WHERE statement after the JOIN condition and adding it to the WHERE clause. The WHERE clause filters the result set after the join is performed. The JOIN condition filters the rows before they are joined. If you add a WHERE statement after the JOIN condition, it will filter the result set further. If you add it to the WHERE clause, it will filter the rows before they are joined. In general, it is better to use the JOIN condition to filter rows because it can improve performance by reducing the number of rows that need to be joined

- Al maak jij die table, als die table in iemand anders zn scheme is heb je geen privileges erop. Not even select. Vraag 384 in pdf

- Als je composite key hebt en je dropped een van die parent kolommen met die cascade constraints dan wordt die hele pk constraint erased samen met die fk constraint 