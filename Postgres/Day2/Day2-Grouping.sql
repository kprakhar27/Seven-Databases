-- Grouping

SELECT venue_id, count(*)
FROM events
GROUP BY venue_id;

--  Having Function
SELECT venue_id, count(*)
FROM events
GROUP BY venue_id
HAVING count(*) >= 2 AND venue_id IS NOT NULL;

SELECT venue_id FROM events GROUP BY venue_id;

-- Distinct function
SELECT DISTINCT venue_id FROM events;

/*
If you tried to run a SELECT statement with columns not defined under a GROUP BY in
MySQL, you would be shocked to see that it works. This originally made us question
the necessity of window functions. But when we inspected the data MySQL returns
more closely, we found it will return only a random row of data along with the count,
not all relevant results. Generally, that’s not useful (and quite potentially dangerous).
*/