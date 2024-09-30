-- Select the first 20 rows from the pg_timezone_names view.
SELECT * FROM pg_timezone_names LIMIT 20;

-- Count the total number of rows in the pg_timezone_names view.
SELECT COUNT(*) FROM pg_timezone_names;

-- Select distinct values of the is_dst column to check the different daylight saving time statuses.
SELECT DISTINCT is_dst FROM pg_timezone_names;

-- Count the number of rows for each distinct value of is_dst (true/false) and group by is_dst.
SELECT COUNT(is_dst), is_dst FROM pg_timezone_names GROUP BY is_dst;

-- Count the number of rows for each distinct abbreviation and group by the abbrev column.
SELECT COUNT(abbrev), abbrev FROM pg_timezone_names GROUP BY abbrev;

-- Count the abbreviations for daylight saving time (is_dst = 't') where the count of abbreviations is greater than 10.
SELECT COUNT(abbrev) AS ct, abbrev FROM  pg_timezone_names WHERE is_dst= 't' GROUP BY abbrev HAVING COUNT(abbrev) > 10;

-- Count the abbreviations where the count of abbreviations is greater than 10.
SELECT COUNT(abbrev) AS ct, abbrev FROM  pg_timezone_names GROUP BY abbrev HAVING COUNT(abbrev) > 10;

-- Count the abbreviations where the count of abbreviations is greater than 10 and order by count in descending order.
SELECT COUNT(abbrev) AS ct, abbrev FROM  pg_timezone_names GROUP BY abbrev HAVING COUNT(abbrev) > 10 ORDER BY COUNT(abbrev) DESC;