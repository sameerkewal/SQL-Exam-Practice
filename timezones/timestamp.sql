create table date_table(
    date_1 date,
    date_2 timestamp,
    date_3 timestamp with TIME ZONE
);

/* sysdate returns the current date and time for the server
current_timestamp returns the current date and time for user session(timestamp with timezone)
  The session for the user could be different from the server. The dba can change the user session
  according to location */

  insert into date_table values(sysdate, current_timestamp, current_timestamp);

  select * from date_table;
