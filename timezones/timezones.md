# Datetime data types

Several options datetime data types:
- Timestamp => Date with fractional seconds
- Interval year to month => Stored as an interval of years and month(year can be any positive or negative number)
- Interval day to second => Stored as interval of days, hours, minutes and seconds(day can be any positive or negative number)(also stores fractional seconds)

![Alt text](../resources/timestamp.png)

![Alt text](../resources/extract.png)
https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/EXTRACT-datetime.html#GUID-36E52BF8-945D-437D-9A3C-6860CABD210E


## Timestamp:
- Sysdate returns the current date and time for the server
- current_timestamp returns the current date and time for user session(timestamp with timezone)
  The session for the user could be different from the server. The dba can change the user session
  according to location

  