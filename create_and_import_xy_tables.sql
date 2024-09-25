-- Drop the table xy_raw if it exists.
DROP TABLE IF EXISTS xy_raw;

-- Drop the table y if it exists.
DROP TABLE IF EXISTS y;

-- Drop the table xy if it exists.
DROP TABLE IF EXISTS xy;

-- Create a table xy_raw with columns for x (TEXT), y (TEXT), and y_id (INTEGER).
CREATE TABLE xy_raw (x TEXT, y TEXT, y_id INTEGER);

-- Create a table y with an auto-incremented primary key (id) and a y column (TEXT).
CREATE TABLE y (id SERIAL, PRIMARY KEY(id), y TEXT);

-- Create a table xy with an auto-incremented primary key (id), x (TEXT), and y_id (INTEGER).
-- Ensure that the combination of x and y_id is unique.
CREATE TABLE xy (id SERIAL, PRIMARY KEY(id), x TEXT, y_id INTEGER, UNIQUE(x, y_id));

-- Display the structure of the xy_raw table.
\d xy_raw

-- Display the detailed structure of the y table.
\d+ y

-- Import data into the xy_raw table from a CSV file named '03-Techniques.csv', with comma as the delimiter.
\copy xy_raw(x, y) FROM '03-Techniques.csv' WITH DELIMITER ',' CSV;

-- Select distinct y values from the xy_raw table.
SELECT DISTINCT y FROM xy_raw;

-- Insert distinct y values from xy_raw into the y table.
INSERT INTO y (y) SELECT DISTINCT y FROM xy_raw;

-- Update the y_id in xy_raw based on the corresponding id in the y table where y values match.
UPDATE xy_raw SET y_id = (SELECT y.id FROM y WHERE y.y = xy_raw.y);

-- Select all records from the xy_raw table.
SELECT * FROM xy_raw;

-- Insert data into the xy table by selecting x and y_id from the xy_raw table.
INSERT INTO xy (x, y_id) SELECT x, y_id FROM xy_raw;

-- Join the xy table with the y table on y_id and select all records.
SELECT * FROM xy JOIN y ON xy.y_id = y.id;

-- Drop the y column from the xy_raw table.
ALTER TABLE xy_raw DROP COLUMN y;

-- Drop the xy_raw table as it's no longer needed.
DROP TABLE xy_raw;