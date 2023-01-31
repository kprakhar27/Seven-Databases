-- Fuzzy Searching

-- LIKE and ILIKE
SELECT title FROM movies WHERE title ILIKE 'stardust%';

SELECT title FROM movies WHERE title ILIKE 'stardust_%';

-- Regex
SELECT COUNT(*) FROM movies WHERE title !~* '^the.*';

CREATE INDEX movies_title_pattern ON movies (lower(title) text_pattern_ops);

-- Bride of Levenshtein
/*
Levenshtein is a string comparison algorithm that compares how similar two
strings are by how many steps are required to change one string into another.
Each replaced, missing, or added character counts as a step. The distance
is the total number of steps away.
*/
SELECT levenshtein('bat', 'fads');

SELECT levenshtein('bat', 'fad') fad,
	levenshtein('bat', 'fat') fat,
	levenshtein('bat', 'bat') bat;

SELECT movie_id, title FROM movies
WHERE levenshtein(lower(title), lower('a hard day nght')) <= 3;

-- Trigram
/*A trigram is a group of three consecutive characters taken from a string.*/
SELECT show_trgm('Avatar');

CREATE INDEX movies_title_trigram ON movies
USING gist (title gist_trgm_ops);

-- query with misspellings
SELECT title
FROM movies
WHERE title % 'Avatre';