-- Select all columns from the account table where the email is 'ed@umich.edu'.
SELECT * FROM account 
WHERE email = 'ed@umich.edu';

-- Select the content from the comment table where the account_id is 1.
SELECT content FROM comment WHERE account_id = 1;

-- Select the content from the comment table for the account with email 'ed@umich.edu'.
SELECT content FROM comment 
WHERE account_id = (SELECT id FROM account WHERE email = 'ed@umich.edu');

-- Select timezone abbreviations that are not in daylight saving time (is_dst = 'f') and have more than 10 occurrences.
SELECT ct, abbrev FROM (
    SELECT COUNT(abbrev) AS ct, abbrev FROM  pg_timezone_names WHERE is_dst = 'f' GROUP BY abbrev
) AS zap WHERE ct > 10;

-- Select timezone abbreviations that are not in daylight saving time and have more than 10 occurrences, ordered by the count in descending order.
SELECT ct, abbrev FROM (
    SELECT COUNT(abbrev) AS ct, abbrev FROM  pg_timezone_names WHERE is_dst = 'f' GROUP BY abbrev
) AS zap WHERE ct > 10 ORDER BY ct DESC;