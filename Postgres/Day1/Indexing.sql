-- Indexing

-- Hash Index
CREATE INDEX events_title
ON events USING hash (title);

select * from events where event_id = 2;

-- B-Tree Index
CREATE INDEX events_starts
ON events USING btree (starts);

SELECT *
FROM events
WHERE starts >= '2018-04-01';