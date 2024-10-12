-- Create the 'em' table with an auto-incrementing 'id' and 'email' column.
CREATE TABLE em (id SERIAL, PRIMARY KEY(id), email TEXT);

-- Insert email records into the 'em' table.
INSERT INTO em (email) VALUES ('csev@umich.edu');
INSERT INTO em (email) VALUES ('coleen@umich.edu');
INSERT INTO em (email) VALUES ('sally@uiuc.edu');
INSERT INTO em (email) VALUES ('ted79@umuc.edu');
INSERT INTO em (email) VALUES ('glenn1@apple.com');
INSERT INTO em (email) VALUES ('nbody@apple.com');

-- Select all emails that contain 'umich'.
SELECT email FROM em WHERE email ~ 'umich';

-- Select emails that start with the letter 'c'.
SELECT email FROM em WHERE email ~ '^c';

-- Select emails that end with 'edu'.
SELECT email FROM em WHERE email ~ 'edu$';

-- Select emails that start with 'g', 'n', or 't'.
SELECT email FROM em WHERE email ~ '^[gnt]';

-- Select emails that contain at least one digit.
SELECT email FROM em WHERE email ~ '[0-9]';

-- Select emails that contain two consecutive digits.
SELECT email FROM em WHERE email ~ '[0-9][0-9]';

-- Extract the first sequence of digits found in the emails that contain digits.
SELECT substring(email FROM '[0-9]+') FROM em WHERE email ~ '[0-9]';

-- Extract the domain part of each email.
SELECT substring(email FROM '.+@(.*)$') FROM em;

-- Extract distinct domain names from the emails.
SELECT DISTINCT substring(email FROM '.+@(.*)$') FROM em;

-- Count the occurrences of each domain name.
SELECT substring(email FROM '.+@(.*)$'), COUNT(substring(email FROM '.+@(.*)$')) 
FROM em GROUP BY substring(email FROM '.+@(.*)$');

-- Select all emails where the domain is 'umich.edu'.
SELECT * FROM em WHERE substring(email FROM '.+@(.*)$') = 'umich.edu';

-- Create the 'tw' table with an auto-incrementing 'id' and 'tweet' column.
CREATE TABLE tw (id SERIAL, PRIMARY KEY(id), tweet TEXT);

-- Insert tweet records into the 'tw' table.
INSERT INTO tw (tweet) VALUES ('This is #SQL and #FUN stuff');
INSERT INTO tw (tweet) VALUES ('More people should learn #SQL FROM #UMSI');
INSERT INTO tw (tweet) VALUES ('#UMSI also teaches #PYTHON');

-- Select all tweets.
SELECT tweet FROM tw;

-- Select tweets that contain the hashtag '#SQL'.
SELECT id, tweet FROM tw WHERE tweet ~ '#SQL';

-- Extract all hashtags from the tweets.
SELECT regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g') FROM tw;

-- Extract distinct hashtags from the tweets.
SELECT DISTINCT regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g') FROM tw;

-- Select tweet IDs along with extracted hashtags.
SELECT id, regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g') FROM tw;