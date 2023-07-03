## Sequences:
- Automatically generates unique numbers
- Is shareable object
- Can be used to create a PK value
- Replaces application code
- Speeds up the efficiency of accessing sequence values when cached in memory


**Rules:**
You can use nextval and currval in the following contexts:
- select list of a select statement that is not part of a subquery
- select list of a subquery in an insert statement
- values clause of an insert statement
- set clause of an update statement

You can not use nextval and currval in the following contexts:
- select list of a view
- select statement with the distinct keyword
- select statement with group by, having, order clause
- a subquery in a select, update delete statement

![Alt text](../resources/sequences.png)



## Psuedocolumns:
- A column which u can use in a select statement, but this column isn't a part of the original table







## Synonyms

- Is a database object
- Can be created to give an alternative name to a table or to another database object
- Requires no storage other than its definition in the data dictionary
- Is useful for hiding the identity and location of an underlying schema object

