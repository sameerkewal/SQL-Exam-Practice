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