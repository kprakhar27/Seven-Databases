-- Homework

/*
There are three match types:
MATCH FULL, MATCH PARTIAL, and MATCH SIMPLE (which is the default).
MATCH FULL will not allow one column of a multicolumn foreign key 
to be null unless all foreign key columns are null; if they are all null, 
the row is not required to have a match in the referenced table. 
MATCH SIMPLE allows any of the foreign key columns to be null; 
if any of them are null, the row is not required to have a match 
in the referenced table. MATCH PARTIAL is not yet implemented. 
(Of course, NOT NULL constraints can be applied to the 
referencing column(s) to prevent these cases from arising.)

Normally, a referencing row need not satisfy the foreign key constraint 
if any of its referencing columns are null. If MATCH FULL is added to 
the foreign key declaration, a referencing row escapes satisfying the 
constraint only if all its referencing columns are null (so a mix of 
null and non-null values is guaranteed to fail a MATCH FULL constraint). 
If you don't want referencing rows to be able to avoid satisfying the 
foreign key constraint, declare the referencing column(s) as NOT NULL.
*/

/* Select all the tables we created (and only those) from pg_class and examine
the table to get a sense of what kinds of metadata Postgres stores about
tables. */
SELECT * FROM pg_class WHERE relname IN ('cities','countries','events','venues');

/* Write a query that finds the country name of the Fight Club event. */
SELECT e.title, c.country_name
FROM events e
JOIN venues v ON e.venue_id = v.venue_id
JOIN countries c ON v.country_code = c.country_code;

/* Alter the venues table such that it contains a Boolean column called active
with a default value of TRUE. */
ALTER TABLE venues
ADD COLUMN active BOOLEAN DEFAULT TRUE;

SELECT * FROM venues;