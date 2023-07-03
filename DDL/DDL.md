A table is the basic unit of storage; composed of rows


### Oracle table structure
- Tables can be created at any time, even when users are using the database
- You do not need to specify the size of a table. The size is ultimately defined by the amount of space
  allocated to the database as a whole. It is important however to estimate how much space a table will use over time
- Table structures can be modified online


### Naming rules:
Table names and columns must:
- Begin with a letter
- Be 1-128 characters long
- Contain only A-Z, a-z, 0-9, _, $ and #
- Not duplicate the name of another object owned by the same user
- Not be an Oracle server reserved word
- You may also use quoted identifiers to represent the name of an object. A quoted identifier begins and ends with double quotation marks. If you name a schema object using a quoted identifier, you must use the double quotation marks
whenever you refer to that object. Quoted identifiers can be reserved words, although this isn't recommended



### Data types:

Number having precision p and scale s. Precision kan tussen 1 en 38 zijn and scale can range from -84 to 127
Bij date datatype kan je date storen tussen january 1, 4712 BC and December 31, 9999 AD. 



- Long => Variable length character data(up to 2 gb)
- Clob => A character LOB containing single byte or multibyte characters. Max size: (4GB-1)*DB_BLOCK_SIZE 
db block size is 1000 btw
- Nclob => A character lob containing unicode characters. Both fixed-width and variable-width characters sets are supported,
both using the db national character set. Max size is same as above. Stores national character set data
- Raw(size) => Raw binary data of variable length up to 2gb. You must specify size for a raw value
(je kan hier audio/video/images storen)
- Long Raw => Raw binary data of variable length up to 2 gigs
- Blob => A binary LOB. Max size is same as clob. Max size is (4 gigabytes - 1) * (database block size)
- Bfile => Binary data stored in an external file(up to 4gb)
- Rowid => Base 64 string representing the unique address of a row in its table. This data type is primarily for values returned by the rowid pseudoclumn


Guidelines:
- A long column is not copied when a table is created using a subquery(create table x as select * from y)
- A long column cannot be included in a group by or order by clause
- Only one long column can be used per table
- No constraints can be defined on a long column
- You might want to use a CLOB column rather than a long column


### Datetime data types:
Timestamp=> date with fractional seconds
interval year to month => stores as an interval of years and months
interval day to second => stored as an interval of dats, hours, minutes and seconds

- Timestamp => Enables storage of time as a date with fractional seconds. It stores the year, month, day, hoir, minute and the second value of the date data type as well as the fractional seconds value. Several variations of this data type suc as with timezone and with local timezone.

- Interval year to month => Enables storage of time as an interval of years and months. Used to represent the difference betweeen two datetime values in which the only significant portions are the year and month

- Interval day to second => Enables storage of time as an interval of days, hours, minutes amd seconds. Used to represent the precise
difference between two datetime values
![Alt text](<../resources/datetime data types.png>)


## Creating tables:
- You must have create table privilege
- Als je in een andere schema een table wilt createn heb je een create any table privilege nodig




## Constraints:
- Enforce rules on the data in a table whenever a row is inserred, updated or deleted from that table.
 The constraints must be satisifed for the operation to succeed.
- Prevent the dropping of a table if there are dependencies from other tables
- Provide rules for Oracle tools, such as Oracle Developer

- Not Null => Specifies that a column cannot contain a null value
- Unique => Specifies that a column or combination of columns whose values must be unique for all rows in the table
- Primary Key => Uniquely identifies each row of the table
- Foreign Key => Establishes and enforces a referential integrity between the column and a column of the referenced table such that values in one table match the values in another table
- Check => Specifies a condition that must be true

### Verschil tussen primary key en unique is dat een primary key geen null mag zijn maar een unique key wel





### Constraint guidelines:
- You can name a constraint or the Oracle server generates a name by using the sys_cn(n refers to number dat oracle maaktf ) format
- Create a constraint at either of the following times:
 - At the same time as the creation of the table
 - After the creation of the table
- Define a constraint at the column or table level
- View a constraint in the data dictionary


Recommendation is to use Table level constraints

When you create a primary key or unique constraint maakt Oracle zelfs een index voor de primary key en unique constraint



### Creating table as subquery
- Not null constraints are inherited, but only the explicit ones. Not the ones from primary keys
- Any other constraints are not passed to the new table
- Je mag je eigen constraints maken wanneer je die table defined, mag zowel op column level als op table level
- Het mag geen FK zijn
- je mag geen constraint definen which will be violated when the inserts happens

![Alt text](<../resources/create table with subquery.png>)


## Alter table

Use alter table to:
- Add a new column
- Modify existing column
- Define a default value for a new column(not existing column?)
- Drop column
- Rename a column
- Change table to read only status
- Add new constraint
- disable constraint
- drop constraint from the table

![Alt text](<../resources/alter table.png>)


- If a table already contains rows when a new column is added, the new column is initially null or takes the default values
for all rows. You can add a not null column to a table that contains data in the other columns only if you specify a default value.
You can add a not null column to an empty table without a default value

## Modifying a column:
- You can change a column's data type, size and default value
- A change to the default value affects only subsequent insertions to the table


Guidelines:
- You can increase the width or precision of a numeric column
- You can increase the width of character columns
- You can decrease the width of a column if:
 - The column contains only null values
 - The table has no rows
 - The decrease in column width is not less than what the existing rows have as width
 - You can change the data type if the column contains only null values. The exception to this is char-to-varchar2 conversions, which can be done with data in the columns
 - You can convert a char column to the varchar2 data type or convert a varchar2 column to a char data type only if the column contains null values or if you do not change the size





 ## Dropping columns

 Guidelines:
 - The column may or may not contain data, it doesn't matter
 - Using the alter table drop column statement only one column can be dropped at a time
 - The table must have atleast one column remaining in it after it's dropped
 - After a column is dropped, it cannot be recovered
 - The primary key that is referenced by another column cannot be dropped unless the cascade option is added
 - Dropping a column can take a while if the column has a large number of values. In this 
   case it might be better to set it to unused and drop it when there are fewer users on the system to avoid extended locks

**Note:** Certain columns can never be dropped, such as columns that form part of the partitioning key of a partitioned table
or columns that form part of the primary key of an index organized table. 








## Set unused

- You can use set unused option to mark one or more columns as unused
- You use the drop unused columns to remove the columns that are marked as unused
- You can specify the online keyword to indicate that DML statements on the table are allowed while marking the column or columns unused
![Alt text](<../resources/set unused.png>)






## Read Only

You can use alter table syntax to put a table into read only which prevents any DML statements or any DDL statements that will change the data. 

Als die table in read only is kan je geen enkele DML statement erop doen of any select....for update statement. You can issue DDL statements as long as they do not modify any data in the table. Operations on indexes associated with the table are allowed when the table is in read only mode

**Note:** You can drop a table which is in read only mode. The drop command is executed only in the data dictionary, so access to the table contents is not required. The space used by the table will not be reclaimed until the tablespace is made read/write again,
and then the required changes can be made to the block segment headers and so on