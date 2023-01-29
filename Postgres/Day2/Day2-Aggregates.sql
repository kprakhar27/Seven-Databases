-- Aggregate Functions

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Moby', '2018-02-06 21:00', '2018-02-06 23:00', (
	SELECT venue_id
	FROM venues
	WHERE name = 'Crystal Ballroom')
);

INSERT INTO countries (country_code, country_name)
VALUES ('in','India');

INSERT INTO cities
VALUES ('Lucknow','226010','in');

INSERT INTO venues (name, postal_code, country_code)
VALUES ('My Place', '226010', 'in');

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Wedding', '2018-02-26 21:00', '2018-02-26 23:00', (
	SELECT venue_id
	FROM venues
	WHERE name = 'Voodoo Doughnut')
	),
	('Dinner with Mom', '2018-02-26 18:00', '2018-02-26 20:30', (
		SELECT venue_id
		FROM venues
		WHERE name = 'My Place')
	),
	('Valentine''s Day', '2018-02-14 00:00', '2018-02-14 23:59', (
		SELECT venue_id
		FROM venues
		WHERE name = null)
	);

SELECT * FROM events;

-- Count
SELECT count(title)
FROM events
WHERE title LIKE '%Day%';

-- Min, Max
SELECT min(starts), max(ends)
FROM events INNER JOIN venues
	ON events.venue_id = venues.venue_id
WHERE venues.name = 'Crystal Ballroom';

SELECT count(*) FROM events WHERE venue_id = 1;
SELECT count(*) FROM events WHERE venue_id = 2;
SELECT count(*) FROM events WHERE venue_id = 3;
SELECT count(*) FROM events WHERE venue_id IS NULL;