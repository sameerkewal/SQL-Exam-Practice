# Data warehouse

A data warehouse is a relational database designed for query and analysis rather than for transaction processing



## Unconditional insert:
 - For each row returned by the subquery, a row is inserted into each of the target tables
  
## Conditional Insert All:
- For each row returned by the subquery, a row is inserted each target table if the specified condition is met


## Conditional Insert First:
- For each row returned by the subquery, a row is inserted into the very first target table for which the condition is met

## Pivoting insert:
- This is a special case of the unconditional Insert All



## Restrictions on multitable inserts:
- You can perform multitable inserts only on tables, but not on views and materialized views
- You cannot perform a multitable insert on a remote table(table that exists in another db)
- You cannot specify a table collection expression when performing multitable inserts
- in a multitable insert, all_insert_into_clauses cannot combine to specify more than 999 target columns