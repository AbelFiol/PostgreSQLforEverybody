-- Create the 'pg4e_result' table with an auto-incrementing primary key.
CREATE TABLE pg4e_result (
  id SERIAL,  -- Primary key.
  link_id INTEGER UNIQUE,  -- Unique identifier for the link.
  score FLOAT,  -- Stores the score.
  title VARCHAR(4096),  -- Title associated with the result.
  note VARCHAR(4096),  -- Note associated with the result.
  debug_log VARCHAR(8192),  -- Log for debugging information.
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of record creation.
  updated_at TIMESTAMP  -- Timestamp of last update.
);