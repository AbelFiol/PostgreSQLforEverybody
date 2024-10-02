-- Insert a new row into the 'fav' table and return the result.
INSERT INTO fav (post_id, account_id, howmuch)
    VALUES (1,1,1)
RETURNING *;

-- Update the 'howmuch' value by incrementing it by 1 for the specified post and account, then return the result.
UPDATE fav SET howmuch = howmuch + 1
    WHERE post_id = 1 AND account_id = 1
RETURNING *;

-- Insert a new row or update 'howmuch' if a conflict occurs on post_id and account_id.
INSERT INTO fav (post_id, account_id, howmuch)
    VALUES (1,1,1)
    ON CONFLICT (post_id, account_id) 
    DO UPDATE SET howmuch = fav.howmuch + 1;

-- Same as the above, but return the result after insertion or update.
INSERT INTO fav (post_id, account_id, howmuch)
    VALUES (1,1,1)
    ON CONFLICT (post_id, account_id) 
    DO UPDATE SET howmuch = fav.howmuch + 1
RETURNING *;

-- Begin a transaction.
BEGIN;

-- Lock the row for the specific post and account and select 'howmuch'.
SELECT howmuch FROM fav WHERE account_id = 1 AND post_id = 1 FOR UPDATE OF fav;

-- Update 'howmuch' to 999 for the specific post and account.
UPDATE fav SET howmuch = 999 WHERE account_id = 1 AND post_id = 1;

-- Select the updated 'howmuch' value.
SELECT howmuch FROM fav WHERE account_id = 1 AND post_id = 1;

-- Rollback the transaction, undoing any changes made.
ROLLBACK;

-- Select 'howmuch' to verify that the update was rolled back.
SELECT howmuch FROM fav WHERE account_id = 1 AND post_id = 1;

-- Begin another transaction.
BEGIN;

-- Lock the row for the specific post and account and select 'howmuch'.
SELECT howmuch FROM fav WHERE account_id = 1 AND post_id = 1 FOR UPDATE OF fav;

-- Update 'howmuch' to 999 for the specific post and account.
UPDATE fav SET howmuch = 999 WHERE account_id = 1 AND post_id = 1;

-- Select the updated 'howmuch' value.
SELECT howmuch FROM fav WHERE account_id = 1 AND post_id = 1;

-- Commit the transaction to make the changes permanent.
COMMIT;

-- Select 'howmuch' to verify that the update was committed.
SELECT howmuch FROM fav WHERE account_id = 1 AND post_id = 1;