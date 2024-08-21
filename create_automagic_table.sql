-- Create the 'automagic' table to store ID, name, and height information.
CREATE TABLE automagic (
  id SERIAL PRIMARY KEY,  -- Auto-incrementing ID field.
  name VARCHAR(32) NOT NULL,  -- Name field with a maximum of 32 characters, required.
  height REAL NOT NULL  -- Height field as a floating-point number, required.
);