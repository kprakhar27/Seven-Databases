-- CRUD Operations
CREATE TABLE countries (
country_code char(2) PRIMARY KEY,
country_name text UNIQUE
);

INSERT INTO countries (country_code, country_name)
VALUES ('us','United States'), ('mx','Mexico'), ('au','Australia'),
('gb','United Kingdom'), ('de','Germany'), ('ll','Loompaland');

-- Try Duplicating a value 'United Kingdom'
INSERT INTO countries
VALUES ('uk','United Kingdom');

SELECT * FROM countries;

DELETE FROM countries
WHERE country_code = 'll';