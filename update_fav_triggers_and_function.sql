-- Increment the 'howmuch' field by 1 for a specific post and account in the 'fav' table.
UPDATE fav SET howmuch = howmuch + 1
  WHERE post_id = 1 AND account_id = 1
RETURNING *;

-- Create a function to set the 'updated_at' field to the current timestamp.
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();  -- Update the 'updated_at' field to the current timestamp.
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to set the 'updated_at' field before any update on the 'post' table.
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON post
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create a trigger to set the 'updated_at' field before any update on the 'fav' table.
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON fav
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create a trigger to set the 'updated_at' field before any update on the 'comment' table.
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON comment
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();