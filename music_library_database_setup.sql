-- Create a table to store artist information.
CREATE TABLE artist (
    id SERIAL,                             -- Unique identifier for each artist.
    name VARCHAR(128) UNIQUE,              -- Artist name, must be unique.
    PRIMARY KEY(id)                        -- Primary key constraint on the id column.
);

-- Create a table to store album information.
CREATE TABLE album (
    id SERIAL,                             -- Unique identifier for each album.
    title VARCHAR(128) UNIQUE,             -- Album title, must be unique.
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE,  -- Foreign key referencing the artist table; deletes album if the associated artist is deleted.
    PRIMARY KEY(id)                        -- Primary key constraint on the id column.
);

-- Create a table to store genre information.
CREATE TABLE genre (
    id SERIAL,                             -- Unique identifier for each genre.
    name VARCHAR(128) UNIQUE,              -- Genre name, must be unique.
    PRIMARY KEY(id)                        -- Primary key constraint on the id column.
);

-- Create a table to store track information.
CREATE TABLE track (
    id SERIAL,                           -- Unique identifier for each track.
    title VARCHAR(128),                  -- Track title.
    len INTEGER,                         -- Track length in seconds.
    rating INTEGER,                      -- Track rating.
    count INTEGER,                       -- Play count of the track.
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,  -- Foreign key referencing the album table; deletes track if the associated album is deleted.
    genre_id INTEGER REFERENCES genre(id) ON DELETE CASCADE,  -- Foreign key referencing the genre table; deletes track if the associated genre is deleted.
    UNIQUE(title, album_id),             -- Ensures that each track title within an album is unique.
    PRIMARY KEY(id)                      -- Primary key constraint on the id column.
);

-- Insert data into the artist table.
INSERT INTO artist (name) VALUES ('Led Zeppelin');
INSERT INTO artist (name) VALUES ('AC/DC');

-- Insert data into the album table.
INSERT INTO album (title, artist_id) VALUES ('Who Made Who', 2);
INSERT INTO album (title, artist_id) VALUES ('IV', 1);

-- Insert data into the genre table.
INSERT INTO genre (name) VALUES ('Rock');
INSERT INTO genre (name) VALUES ('Metal');

-- Insert data into the track table.
INSERT INTO track (title, rating, len, count, album_id, genre_id) 
    VALUES ('Black Dog', 5, 297, 0, 2, 1);
INSERT INTO track (title, rating, len, count, album_id, genre_id) 
    VALUES ('Stairway', 5, 482, 0, 2, 1);
INSERT INTO track (title, rating, len, count, album_id, genre_id) 
    VALUES ('About to Rock', 5, 313, 0, 1, 2);
INSERT INTO track (title, rating, len, count, album_id, genre_id) 
    VALUES ('Who Made Who', 5, 207, 0, 1, 2);

-- Query to select album titles and artist names by joining album and artist tables.
SELECT album.title, artist.name FROM album JOIN artist 
    ON album.artist_id = artist.id;

-- Another query to select album details along with artist details.
SELECT album.title, album.artist_id, artist.id, artist.name 
    FROM album INNER JOIN artist ON album.artist_id = artist.id;

-- Query to select all tracks and all genres using a CROSS JOIN.
SELECT track.title, track.genre_id, genre.id, genre.name 
    FROM track CROSS JOIN genre;

-- Query to select track titles and their associated genre names.
SELECT track.title, genre.name FROM track JOIN genre 
    ON track.genre_id = genre.id;

-- Query to select track titles along with their artist, album, and genre details.
SELECT track.title, artist.name, album.title, genre.name 
FROM track 
    JOIN genre ON track.genre_id = genre.id 
    JOIN album ON track.album_id = album.id 
    JOIN artist ON album.artist_id = artist.id;

-- Delete the genre named 'Metal' from the genre table.
DELETE FROM genre WHERE name = 'Metal';