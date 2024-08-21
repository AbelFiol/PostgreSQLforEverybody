-- Create the 'ages' table to store names and ages.
CREATE TABLE ages ( 
  name VARCHAR(128),  -- Person's name.
  age INTEGER  -- Person's age.
);

-- Delete all existing records from the 'ages' table.
DELETE FROM ages;

-- Insert a new record into the 'ages' table with the name 'Derin' and age 27.
INSERT INTO ages (name, age) VALUES ('Derin', 27);

-- Insert a new record into the 'ages' table with the name 'Fay' and age 22.
INSERT INTO ages (name, age) VALUES ('Fay', 22);

-- Insert a new record into the 'ages' table with the name 'Irmak' and age 26.
INSERT INTO ages (name, age) VALUES ('Irmak', 26);

-- Insert a new record into the 'ages' table with the name 'Rosina' and age 29.
INSERT INTO ages (name, age) VALUES ('Rosina', 29);

-- Insert a new record into the 'ages' table with the name 'Tommy' and age 36.
INSERT INTO ages (name, age) VALUES ('Tommy', 36);