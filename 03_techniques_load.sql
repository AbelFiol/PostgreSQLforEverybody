-- Delete all records from the account table.
DELETE FROM account;

-- Reset the account_id sequence to start from 1.
ALTER SEQUENCE account_id_seq RESTART WITH 1;

-- Reset the post_id sequence to start from 1.
ALTER SEQUENCE post_id_seq RESTART WITH 1;

-- Reset the comment_id sequence to start from 1.
ALTER SEQUENCE comment_id_seq RESTART WITH 1;

-- Reset the fav_id sequence to start from 1.
ALTER SEQUENCE fav_id_seq RESTART WITH 1;

-- Insert three email records into the account table.
INSERT INTO account(email) VALUES 
('ed@umich.edu'), ('sue@umich.edu'), ('sally@umich.edu');

-- Insert posts with title, content, and corresponding account_id.
INSERT INTO post (title, content, account_id) VALUES
( 'Dictionaries', 'Are fun', 3),
( 'BeautifulSoup', 'Has a complex API', 1),
( 'Many to Many', 'Is elegant', (SELECT id FROM account WHERE email = 'sue@umich.edu' ));

-- Insert comments with content, post_id, and corresponding account_id.
INSERT INTO comment (content, post_id, account_id) VALUES
( 'I agree', 1, 1),
( 'Especially for counting', 1, 2),
( 'And I don''t understand why', 2, 2),
( 'Someone should make "EasySoup" or something like that', (SELECT id FROM post WHERE title = 'BeautifulSoup'), (SELECT id FROM account WHERE email = 'ed@umich.edu' )),
( 'Good idea - I might just do that', (SELECT id FROM post WHERE title = 'BeautifulSoup'), (SELECT id FROM account WHERE email = 'sally@umich.edu' ));