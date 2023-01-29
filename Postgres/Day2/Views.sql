-- Views

CREATE VIEW holidays AS
	SELECT event_id AS holiday_id, title AS name, starts AS date
	FROM events
	WHERE title LIKE '%Day%' AND venue_id IS NULL;

SELECT name, to_char(date, 'Month DD, YYYY') AS date
FROM holidays
WHERE date <= '2018-04-01';

-- Sub Query instead of View
SELECT e.name, to_char(e.date, 'Month DD, YYYY') AS date
FROM (
SELECT event_id AS holiday_id, title AS name, starts AS date
	FROM events
	WHERE title LIKE '%Day%' AND venue_id IS NULL
) as e
WHERE date <= '2018-04-01';

ALTER TABLE events
ADD colors text ARRAY;

SELECT * FROM events;

CREATE OR REPLACE VIEW holidays AS
	SELECT event_id AS holiday_id, title AS name, starts AS date, colors
	FROM events
	WHERE title LIKE '%Day%' AND venue_id IS NULL;

UPDATE holidays SET colors = '{"red","green"}' where name = 'Christmas Day';

SELECT name, to_char(date, 'Month DD, YYYY') AS date, colors
FROM holidays;

-- VIEWS vs MATERILIZED VIEWS
/*
Though VIEWs like the holidays view mentioned previously are a convenient abstraction,
they don’t yield any performance gains over the SELECT queries that they alias. If you
want VIEWs that do offer such gains, you should consider creating materialized views,
which  are  different  because  they’re  stored  on  disk  in  a  “real”  table  and  thus  yield
performance gains because they restrict the number of tables that must be accessed
to exactly one.
*//*
You can create materialized views just like ordinary views, except with a CREATE MATE-
RIALIZEDVIEW rather than CREATEVIEW statement. Materialized view tables are populated
whenever you run the REFRESH command for them, which you can automate to run
at defined intervals or in response to triggers. You can also create indexes on materi-
alized views the same way that you can on regular tables.
*//*
The downside of materialized views is that they do increase disk space usage. But in
many cases, the performance gains are worth it. In general, the more complex the
query and the more tables it spans, the more performance gains you’re likely to get
vis-à-vis plain old SELECT queries or VIEWs.
*/