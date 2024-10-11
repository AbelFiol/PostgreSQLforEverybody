-- Create the 'make' table with unique names for car manufacturers.
CREATE TABLE make (
    id SERIAL,  -- Auto-incrementing primary key for 'make'.
    name VARCHAR(128) UNIQUE,  -- Unique name for each car manufacturer.
    PRIMARY KEY(id)  -- Primary key constraint on 'id'.
);

-- Create the 'model' table with a reference to the 'make' table.
CREATE TABLE model (
    id SERIAL,  -- Auto-incrementing primary key for 'model'.
    name VARCHAR(128),  -- Name of the car model.
    make_id INTEGER REFERENCES make(id) ON DELETE CASCADE,  -- Foreign key linking to 'make' table. Deletes models if the corresponding make is deleted.
    PRIMARY KEY(id)  -- Primary key constraint on 'id'.
);

-- Insert distinct car manufacturers into the 'make' table.
INSERT INTO make (name) 
VALUES 
    ('Chevrolet'),
    ('Isuzu');

-- Insert car models into the 'model' table, linking each to its corresponding make using 'make_id'.
INSERT INTO model (name, make_id)
VALUES
    ('Express Passenger (Bi-fuel)', 1),
    ('Express Passenger (dedicated CNG)', 1),
    ('G10/20 Sport Van 2WD', 1),
    ('Rodeo Sport 4WD', 2),
    ('Stylus', 2);

-- Retrieve and display car models along with their corresponding make names.
SELECT 
    make.name,  -- Name of the make.
    model.name  -- Name of the model.
FROM
    model
JOIN 
    make ON model.make_id = make.id  -- Join the 'model' table with the 'make' table on 'make_id'.
ORDER BY
    make.name  -- Order results by make name.
LIMIT 5;  -- Limit the results to 5 rows.