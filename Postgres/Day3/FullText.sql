-- Full-Text Fun

-- TSVector and TSQuery
SELECT title
FROM movies
WHERE title @@ 'night & day';
/*equivalent to*/
SELECT title
FROM movies
WHERE to_tsvector(title) @@ to_tsquery('english', 'night & day');

SELECT to_tsvector('A Hard Day''s Night'),
to_tsquery('english', 'night & day');

-- NOTICE: text-search query contains only stop words or doesn't contain lexemes, ignored
SELECT *
FROM movies
WHERE title @@ to_tsquery('english', 'a');

SELECT to_tsvector('english', 'A Hard Day''s Night');

SELECT to_tsvector('simple', 'A Hard Day''s Night');

-- Other Languages
SELECT ts_lexize('english_stem', 'Day''s');

SELECT to_tsvector('german', 'was machst du gerade?');

-- Indexing Lexemes
EXPLAIN
SELECT *
FROM movies
WHERE title @@ 'night & day';

CREATE INDEX movies_title_searchable ON movies
USING gin(to_tsvector('english', title));

EXPLAIN
SELECT *
FROM movies
WHERE to_tsvector('english',title) @@ 'night & day';

-- Metaphones
SELECT *
FROM actors
WHERE name = 'Broos Wils';

SELECT *
FROM actors
WHERE name % 'Broos Wils';

SELECT title
FROM movies NATURAL JOIN movies_actors NATURAL JOIN actors
WHERE metaphone(name, 6) = metaphone('Broos Wils', 6);

SELECT name, dmetaphone(name), dmetaphone_alt(name),
metaphone(name, 8), soundex(name)
FROM actors;

-- Combining String Matches
SELECT * FROM actors
WHERE metaphone(name,8) % metaphone('Robin Williams',8)
ORDER BY levenshtein(lower('Robin Williams'), lower(name));

SELECT * FROM actors WHERE dmetaphone(name) % dmetaphone('Ron');