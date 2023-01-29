-- Window Functions

-- ERROR:  column "events.title" must appear in the GROUP BY clause or be used in an aggregate function
SELECT title, venue_id, count(*)
FROM events
GROUP BY venue_id;

-- Window functions return all matches and replicate the results of any aggregate function.
SELECT title, venue_id, count(*) OVER (PARTITION BY venue_id) FROM events;