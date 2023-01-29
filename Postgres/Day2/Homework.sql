-- Homework

/*
Create a rule that captures DELETEs on venues and instead sets the active
flag (created in the Day 1 homework) to FALSE
*/

SELECT * FROM venues;

CREATE RULE active_venues AS ON DELETE TO venues DO INSTEAD
	UPDATE venues
	SET active = FALSE
	WHERE venue_id = OLD.venue_id;
	
DELETE FROM venues
WHERE venue_id = 1;

/*
A temporary table was not the best way to implement our event calendar
pivot table. The generate_series(a, b) function returns a set of records, from
a to b. Replace the month_count table SELECT with this.
*/

SELECT * FROM month_count;

SELECT * FROM generate_series(1, 12);

SELECT * FROM crosstab(
	'SELECT extract(year from starts) as year,
		extract(month from starts) as month, count(*)
	FROM events
	GROUP BY year, month
	ORDER BY year, month',
	'SELECT * FROM generate_series(1, 12)'
) AS (
	year int,
	jan int, feb int, mar int, apr int, may int, jun int,
	jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;

/*
Build a pivot table that displays every day in a single month, where each
week of the month is a row and each day name forms a column across
the top (seven days, starting with Sunday and ending with Saturday) like a
standard month calendar. Each day should contain a count of the number
of events for that date or should remain blank if no event occurs.
*/

SELECT * FROM crosstab(
    'SELECT 
    extract(WEEK from starts) as week 
    ,extract(month from starts) as month
    ,extract(DOW from starts) as day
    ,count(*) FROM events GROUP BY month, week, day'
    ,'SELECT * FROM generate_series(0, 6)') 
AS 
    (
     week int,month int
     ,Sunday int, Monday int, Tuesday int, Wednesday int
     ,Thursday int, Friday int, Saturday int) 
ORDER BY week