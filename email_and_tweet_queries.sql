-- Create the 'em' table with columns: 'id' (auto-incremented) and 'email' (text field).
CREATE TABLE em (id SERIAL, PRIMARY KEY(id), email TEXT);

-- Insert email addresses into the 'em' table.
INSERT INTO em (email) VALUES ('csev@umich.edu');
INSERT INTO em (email) VALUES ('coleen@umich.edu');
INSERT INTO em (email) VALUES ('sally@uiuc.edu');
INSERT INTO em (email) VALUES ('ted79@umuc.edu');
INSERT INTO em (email) VALUES ('glenn1@apple.com');
INSERT INTO em (email) VALUES ('nbody@apple.com');

-- Select emails containing 'umich'.
SELECT email FROM em WHERE email ~ 'umich';

-- Select emails that start with 'c'.
SELECT email FROM em WHERE email ~ '^c';

-- Select emails that end with 'edu'.
SELECT email FROM em WHERE email ~ 'edu$';

-- Select emails that start with 'g', 'n', or 't'.
SELECT email FROM em WHERE email ~ '^[gnt]';

-- Select emails containing at least one digit.
SELECT email FROM em WHERE email ~ '[0-9]';

-- Select emails containing two consecutive digits.
SELECT email FROM em WHERE email ~ '[0-9][0-9]';

-- Extract and select the first numeric substring from emails containing digits.
SELECT substring(email FROM '[0-9]+') FROM em WHERE email ~ '[0-9]';

-- Extract and select the domain part of the email addresses.
SELECT substring(email FROM '.+@(.*)$') FROM em;

-- Select distinct domain parts from the emails.
SELECT DISTINCT substring(email FROM '.+@(.*)$') FROM em;

-- Group by the domain and count how many emails share the same domain.
SELECT substring(email FROM '.+@(.*)$'), count(substring(email FROM '.+@(.*)$')) 
FROM em GROUP BY substring(email FROM '.+@(.*)$');

-- Select all rows from 'em' where the domain is 'umich.edu'.
SELECT * FROM em WHERE substring(email FROM '.+@(.*)$') = 'umich.edu';

-- Create the 'tw' table with columns: 'id' (auto-incremented) and 'tweet' (text field).
CREATE TABLE tw (id SERIAL, PRIMARY KEY(id), tweet TEXT);

-- Insert tweets into the 'tw' table.
INSERT INTO tw (tweet) VALUES ('This is #SQL and #FUN stuff');
INSERT INTO tw (tweet) VALUES ('More people should learn #SQL FROM #UMSI');
INSERT INTO tw (tweet) VALUES ('#UMSI also teaches #PYTHON');

-- Select all tweets.
SELECT tweet FROM tw;

-- Select the id and tweet for rows containing '#SQL'.
SELECT id, tweet FROM tw WHERE tweet ~ '#SQL';

-- Extract and select all hashtags from tweets.
SELECT regexp_matches(tweet,'#([A-Za-z0-9_]+)', 'g') FROM tw;

-- Select distinct hashtags from tweets.
SELECT DISTINCT regexp_matches(tweet,'#([A-Za-z0-9_]+)', 'g') FROM tw;

-- Select id and hashtags from each tweet.
SELECT id, regexp_matches(tweet,'#([A-Za-z0-9_]+)', 'g') FROM tw;