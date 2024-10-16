-- Create a table to store key-value pairs.
CREATE TABLE keyvalue ( 
    id SERIAL,  -- Auto-incrementing identifier.
    key VARCHAR(128) UNIQUE,  -- Unique key.
    value VARCHAR(128) UNIQUE,  -- Unique value.
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp for record creation.
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp for last update.
    PRIMARY KEY(id)  -- Set the primary key.
);

-- Create or replace a function to update the timestamp.
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();  -- Set updated_at to the current timestamp.
    RETURN NEW;  -- Return the modified row.
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that calls the update_timestamp function before each row update.
CREATE TRIGGER set_update_timestamp
BEFORE UPDATE ON keyvalue
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Insert a new key-value pair into the keyvalue table.
INSERT INTO keyvalue (key, value)
VALUES ('exampleKey', 'exampleValue');

-- Select the inserted record to verify the insertion.
SELECT * FROM keyvalue WHERE key = 'exampleKey';

-- Update the value for the specified key.
UPDATE keyvalue
SET value = 'newValue'
WHERE key = 'exampleKey';

-- Select the updated record to verify the update.
SELECT * FROM keyvalue WHERE key = 'exampleKey';

-- Drop the keyvalue table if it exists.
DROP TABLE IF EXISTS keyvalue;

-- Drop the update_timestamp function if it exists.
DROP FUNCTION IF EXISTS update_timestamp();