-- Create the 'bigtext' table with a single TEXT column.
CREATE TABLE bigtext (
    content TEXT
);

-- Insert 100,000 records with numbers from 100000 to 199999.
INSERT INTO bigtext (content)
SELECT 'This is record number ' || generate_series(100000,199999) || ' of quite a few text records.';