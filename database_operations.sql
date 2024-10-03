-- Generate a URL by concatenating a base URL, a random number, a repeated string, and a series.
SELECT 'https://www.pg4e.com/neon/' || trunc(random()*1000000) || repeat('Lemon', 5) || generate_series(1,5);

-- Create a table named cr1 with an auto-incrementing id, a unique url, and a content column.
CREATE TABLE cr1 (
    id SERIAL,
    url VARCHAR(128) UNIQUE,
    content TEXT
);

-- Insert into cr1 a repeated string and a series as url data.
INSERT INTO cr1(url)
SELECT repeat('Neon', 1000) || generate_series(1,5000);

-- Create a table named cr2 with an auto-incrementing id, url, and content columns.
CREATE TABLE cr2 (
    id SERIAL,
    url TEXT,
    content TEXT
);

-- Insert into cr2 a repeated string and a series as url data.
INSERT INTO cr2 (url)
SELECT repeat('Neon', 1000) || generate_series(1,5000);

-- Check the size of the cr2 table and its indexes.
SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- Create a unique index on the url column of cr2.
CREATE UNIQUE INDEX cr2_unique ON cr2 (url);

-- Check the size of the cr2 table and its indexes after creating the unique index.
SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- Drop the unique index on cr2.
DROP INDEX cr2_unique;

-- Check the size of the cr2 table and its indexes after dropping the unique index.
SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- Create a unique index on the md5 hash of the url column in cr2.
CREATE UNIQUE INDEX cr2_md5 ON cr2 (md5(url));

-- Check the size of the cr2 table and its indexes after creating the md5-based index.
SELECT pg_relation_size('cr2'), pg_indexes_size('cr2');

-- Explain the execution plan for querying cr2 where url equals 'lemons'.
EXPLAIN SELECT * FROM cr2 WHERE url = 'lemons';

-- Explain the execution plan for querying cr2 where the md5 hash of url equals the md5 hash of 'lemons'.
EXPLAIN SELECT * FROM cr2 WHERE md5(url) = md5('lemons');

-- Analyze the query performance for selecting from cr2 where url equals 'lemons'.
EXPLAIN ANALYZE SELECT * FROM cr2 WHERE url = 'lemons';

-- Analyze the query performance for selecting from cr2 where the md5 hash of url equals the md5 hash of 'lemons'.
EXPLAIN ANALYZE SELECT * FROM cr2 WHERE md5(url) = md5('lemons');

-- Drop the md5-based index on cr2.
DROP INDEX cr2_md5;

-- Create a unique index on the sha256 hash of the url (converted to bytea) in cr2.
CREATE UNIQUE INDEX cr2_sha256 ON cr2 (sha256(url::bytea));

-- Explain the execution plan for querying cr2 where the sha256 hash of the url equals the sha256 hash of 'bob' (converted to bytea).
EXPLAIN SELECT * FROM cr2 WHERE sha256(url::bytea) = sha256('bob'::bytea);

-- Create a table named cr3 with an auto-incrementing id, url, url_md5 (as a UUID), and content columns.
CREATE TABLE cr3 (
    id SERIAL,
    url TEXT,
    url_md5 uuid UNIQUE,
    content TEXT
);

-- Insert into cr3 a repeated string and a series as url data.
INSERT INTO cr3 (url)
SELECT repeat('Neon', 1000) || generate_series(1,5000);

-- Check the size of the cr3 table and its indexes.
SELECT pg_relation_size('cr3'), pg_indexes_size('cr3');

-- Update the cr3 table by setting the url_md5 column to the md5 hash of the url (cast as UUID).
UPDATE cr3 SET url_md5 = md5(url)::uuid;

-- Check the size of the cr3 table and its indexes after the update.
SELECT pg_relation_size('cr3'), pg_indexes_size('cr3');

-- Analyze the query performance for selecting from cr3 where url_md5 equals the md5 hash of 'lemons' (cast as UUID).
EXPLAIN ANALYZE SELECT * FROM cr3 WHERE url_md5 = md5('lemons')::uuid;

-- Create a table named cr4 with an auto-incrementing id, url, and content columns.
CREATE TABLE cr4 (
    id SERIAL,
    url TEXT,
    content TEXT
);

-- Insert into cr4 a repeated string and a series as url data.
INSERT INTO cr4 (url)
SELECT repeat('Neon', 1000) || generate_series(1,5000);

-- Create a hash index on the url column of cr4.
CREATE INDEX cr4_hash ON cr4 USING HASH (url);

-- Check the size of the cr4 table and its indexes.
SELECT pg_relation_size('cr4'), pg_indexes_size('cr4');

-- Analyze the query performance for selecting from cr4 where url equals 'lemons'.
EXPLAIN ANALYZE SELECT * FROM cr4 WHERE url = 'lemons';

-- Drop all the created tables: cr1, cr2, cr3, and cr4.
DROP TABLE cr1;
DROP TABLE cr2;
DROP TABLE cr3;
DROP TABLE cr4;