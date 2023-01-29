-- Triggers

/*
Triggers automatically fire stored procedures when some event happens, such
as  an  insert  or  update.  They  allow  the  database  to  enforce  some  required
behavior in response to changing data.
*/

CREATE TABLE logs (
	event_id integer,
	old_title varchar(255),
	old_starts timestamp,
	old_ends timestamp,
	logged_at timestamp DEFAULT current_timestamp
);

SELECT * FROM logs;

CREATE OR REPLACE FUNCTION log_event() RETURNS trigger AS $$
DECLARE
BEGIN
	INSERT INTO logs (event_id, old_title, old_starts, old_ends)
	VALUES (OLD.event_id, OLD.title, OLD.starts, OLD.ends);
	RAISE NOTICE 'Someone just changed event #%', OLD.event_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_events
	AFTER UPDATE ON events
	FOR EACH ROW EXECUTE PROCEDURE log_event();
	
UPDATE events
SET ends='2018-05-04 01:00:00'
WHERE title='House Party';

SELECT * FROM events;

SELECT event_id, old_title, old_ends, logged_at
FROM logs;