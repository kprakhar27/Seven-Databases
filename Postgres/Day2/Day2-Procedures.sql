-- Stored Procedures

CREATE OR REPLACE FUNCTION add_event(
	title text,
	starts timestamp,
	ends timestamp,
	venue text,
	postal varchar(9),
	country char(2))
RETURNS boolean AS $$
DECLARE
	did_insert boolean := false;
	found_count integer;
	the_venue_id integer;
BEGIN
	SELECT venue_id INTO the_venue_id
	FROM venues v
	WHERE v.postal_code=postal AND v.country_code=country AND v.name ILIKE venue
	LIMIT 1;
	
	IF the_venue_id IS NULL THEN
		INSERT INTO venues (name, postal_code, country_code)
		VALUES (venue, postal, country)
		RETURNING venue_id INTO the_venue_id;
		
		did_insert := true;
	END IF;
	
	-- Note: this is a notice, not an error as in some programming languages
	RAISE NOTICE 'Venue found %', the_venue_id;
	
	INSERT INTO events (title, starts, ends, venue_id)
	VALUES (title, starts, ends, the_venue_id);
	
	RETURN did_insert;
END;
$$ LANGUAGE plpgsql;

SELECT add_event_2('Daaru Party', '2018-12-31 23:00',
'2019-01-01 00:30', 'My Place', '226010', 'in');

SELECT * FROM events;
SELECT * FROM venues;