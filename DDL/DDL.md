A table is the basic unit of storage; composed of rows


### Oracle table structure
- Tables can be created at any time, even when users are using the database
- You do not need to specify the size of a table. The size is ultimately defined by the amount of space
  allocated to the database as a whole. It is important however to estimate how much space a table will use over time
- Table structures can be modified online


### Naming rules:
Table names and columns must:
- Begin with a letter
- Be 1-30 characters long
- Contain only A-Z, a-z, 0-9, _, $ and #
- Not duplicate the name of another object owned by the same user
- Not be an Oracle server reserved word
- You may also use quoted identifiers to represent the name of an object. A quoted identifier begins and ends with double quotation marks. If you name a schema object using a quoted identifier, you must use the double quotation marks
whenever you refer to that object. Quoted identifiers can be reserved words, although this isn't recommended