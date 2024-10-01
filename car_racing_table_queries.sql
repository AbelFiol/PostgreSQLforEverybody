-- Drop the table if it exists to avoid conflict when recreating it.
DROP TABLE IF EXISTS racing;

-- Create the 'racing' table with columns for car make, model, year, and price.
CREATE TABLE racing (
   make VARCHAR,   -- The car manufacturer.
   model VARCHAR,  -- The car model.
   year INTEGER,   -- The year of the car.
   price INTEGER   -- The price of the car.
);

-- Insert multiple rows into the 'racing' table with specific values for make, model, year, and price.
INSERT INTO racing (make, model, year, price)
VALUES
('Nissan', 'Stanza', 1990, 2000),
('Dodge', 'Neon', 1995, 800),
('Dodge', 'Neon', 1998, 2500),
('Dodge', 'Neon', 1999, 3000),
('Ford', 'Mustang', 2001, 1000),
('Ford', 'Mustang', 2005, 2000),
('Subaru', 'Impreza', 1997, 1000),
('Mazda', 'Miata', 2001, 5000),
('Mazda', 'Miata', 2001, 3000),
('Mazda', 'Miata', 2001, 2500),
('Mazda', 'Miata', 2002, 5500),
('Opel', 'GT', 1972, 1500),
('Opel', 'GT', 1969, 7500),
('Opel', 'Cadet', 1973, 500);

-- Select distinct car manufacturers from the 'racing' table.
SELECT DISTINCT make FROM racing;

-- Select distinct car models from the 'racing' table.
SELECT DISTINCT model FROM racing;

-- Select distinct combinations of make, model, and year, retaining the first entry for each model.
SELECT DISTINCT ON (model) make, model, year FROM racing;

-- Select distinct combinations of make, model, and year, ordering by model and year in ascending order.
SELECT DISTINCT ON (model) make, model, year FROM racing ORDER BY model, year;

-- Select distinct combinations of make, model, and year, ordering by model and year in descending order.
SELECT DISTINCT ON (model) make, model, year FROM racing ORDER BY model, year DESC;

-- Select the first two distinct combinations of make, model, and year, ordering by model and year in descending order.
SELECT DISTINCT ON (model) make, model, year FROM racing ORDER BY model, year DESC LIMIT 2;