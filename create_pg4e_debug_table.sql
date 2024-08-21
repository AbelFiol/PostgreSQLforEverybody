-- Create the 'pg4e_debug' table with an auto-incrementing primary key.
CREATE TABLE pg4e_debug (
  id SERIAL,  -- Primary key.
  query VARCHAR(4096),  -- Stores the query.
  result VARCHAR(4096),  -- Stores the query result.
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of record creation.
  PRIMARY KEY(id)
);

-- Select the query, result, and creation timestamp from 'pg4e_debug'.
SELECT query, result, created_at 
FROM pg4e_debug;