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


Recommendation is to use Table level constraintsf
