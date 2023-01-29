-- Crosstabs

SELECT extract(year from starts) as year,
	extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month;

-- Temporary table will be deleted automatically on session end
CREATE TEMPORARY TABLE month_count(month INT);
INSERT INTO month_count VALUES (1),(2),(3),(4),(5),
(6),(7),(8),(9),(10),(11),(12);

-- Create extension for crosstab
CREATE EXTENSION tablefunc;

-- ERROR:  a column definition list is required for functions returning "record"
SELECT * FROM crosstab(
	'SELECT extract(year from starts) as year,
		extract(month from starts) as month, count(*)
	FROM events
	GROUP BY year, month
	ORDER BY year, month',
	'SELECT * FROM month_count'
);

SELECT * FROM crosstab(
	'SELECT extract(year from starts) as year,
		extract(month from starts) as month, count(*)
	FROM events
	GROUP BY year, month
	ORDER BY year, month',
	'SELECT * FROM month_count'
) AS (
	year int,
	jan int, feb int, mar int, apr int, may int, jun int,
	jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;