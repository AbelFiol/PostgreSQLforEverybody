-- Select three random numbers.
SELECT random(), random(), trunc(random()*100);

-- Repeat the string 'Neon ' five times.
SELECT repeat('Neon ', 5);

-- Generate a series of numbers from 1 to 5.
SELECT generate_series(1,5);

-- Concatenate 'Neon' with the series of numbers from 1 to 5.
SELECT 'Neon' || generate_series(1,5);

-- Create a table 'textfun' with a single 'content' column of type TEXT.
CREATE TABLE textfun (
  content TEXT
);

-- Insert rows into 'textfun' by concatenating 'Neon' with numbers from 1 to 5.
INSERT INTO textfun (content) SELECT 'Neon' || generate_series(1,5);

-- Select all rows from 'textfun'.
SELECT * FROM textfun;

-- Delete all rows from 'textfun'.
DELETE FROM textfun;

-- Create an index on the 'content' column of the 'textfun' table.
CREATE INDEX textfun_b ON textfun (content);

-- Show the size of the 'textfun' table and its indexes.
SELECT pg_relation_size('textfun'), pg_indexes_size('textfun');

-- Generate URLs with random paths and numbers between 1000 and 1005.
SELECT (CASE WHEN (random() < 0.5)
        THEN 'https://www.pg4e.com/neon/'
        ELSE 'https://www.pg4e.com/LEMONS/'
        END) || generate_series(1000,1005);

-- Insert rows into 'textfun' with generated URLs and large ranges of numbers.
INSERT INTO textfun (content)
SELECT (CASE WHEN (random() < 0.5)
        THEN 'https://www.pg4e.com/neon/'
        ELSE 'https://www.pg4e.com/LEMONS/'
        END) || generate_series(100000,200000);

-- Show the updated size of the 'textfun' table and its indexes.
SELECT pg_relation_size('textfun'), pg_indexes_size('textfun');

-- Select rows from 'textfun' where 'content' contains '150000'.
SELECT content FROM textfun WHERE content LIKE '%150000%';

-- Select uppercased content where 'content' contains '150000'.
SELECT upper(content) FROM textfun WHERE content LIKE '%150000%';

-- Select lowercased content where 'content' contains '150000'.
SELECT lower(content) FROM textfun WHERE content LIKE '%150000%';

-- Select the last 4 characters of 'content' where 'content' contains '150000'.
SELECT right(content, 4) FROM textfun WHERE content LIKE '%150000%';

-- Select the first 4 characters of 'content' where 'content' contains '150000'.
SELECT left(content, 4) FROM textfun WHERE content LIKE '%150000%';

-- Find the position of 'ttps://' in 'content' where 'content' contains '150000'.
SELECT strpos(content, 'ttps://') FROM textfun WHERE content LIKE '%150000%';

-- Extract a substring from 'content', starting at the 2nd character and returning 4 characters, where 'content' contains '150000'.
SELECT substr(content, 2, 4) FROM textfun WHERE content LIKE '%150000%';

-- Split 'content' by '/' and return the 4th part where 'content' contains '150000'.
SELECT split_part(content, '/', 4) FROM textfun WHERE content LIKE '%150000%';

-- Replace specific characters in 'content' where 'content' contains '150000'.
SELECT translate(content, 'th.p/', 'TH!P_') FROM textfun WHERE content LIKE '%150000%';

-- Select rows from 'textfun' where 'content' contains '150000'.
SELECT content FROM textfun WHERE content LIKE '%150000%';

-- Select rows from 'textfun' where 'content' matches a specific pattern ('150_00').
SELECT content FROM textfun WHERE content LIKE '%150_00%';

-- Select specific rows where 'content' exactly matches certain URLs.
SELECT content FROM textfun WHERE content IN ('https://www.pg4e.com/neon/150000', 'https://www.pg4e.com/neon/150001');

-- Drop the 'textfun' table.
DROP TABLE textfun;