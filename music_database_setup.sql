-- Create the music database with UTF-8 encoding and specified owner.
CREATE DATABASE music
    WITH OWNER 'owner_name' 
    ENCODING 'UTF8';

-- Create the artist table with unique names.
CREATE TABLE artist (
    id SERIAL, -- Auto-incrementing primary key.
    name VARCHAR(128) UNIQUE, -- Unique artist name.
    PRIMARY KEY(id) -- Primary key on id.
);

-- Create the album table with unique titles and foreign key reference to artist.
CREATE TABLE album (
    id SERIAL, -- Auto-incrementing primary key.
    title VARCHAR(128) UNIQUE, -- Unique album title.
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE, -- Foreign key to artist, with cascading delete.
    PRIMARY KEY(id) -- Primary key on id.
);

-- Create the genre table with unique names.
CREATE TABLE genre (
    id SERIAL, -- Auto-incrementing primary key.
    name VARCHAR(128) UNIQUE, -- Unique genre name.
    PRIMARY KEY(id) -- Primary key on id.
);

-- Create the track table with foreign key references to album and genre, and a unique constraint on title and album_id.
CREATE TABLE track (
    id SERIAL, -- Auto-incrementing primary key.
    title VARCHAR(128), -- Track title.
    len INTEGER, -- Length of the track.
    rating INTEGER, -- Rating of the track.
    count INTEGER, -- Play count of the track.
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE, -- Foreign key to album, with cascading delete.
    genre_id INTEGER REFERENCES genre(id) ON DELETE CASCADE, -- Foreign key to genre, with cascading delete.
    UNIQUE(title, album_id), -- Unique constraint on title and album_id combination.
    PRIMARY KEY(id) -- Primary key on id.
);

-- Insert artist records.
INSERT INTO artist (name) VALUES ('Led Zeppelin');
INSERT INTO artist (name) VALUES ('AC/DC');

-- Select all records from the artist table.
SELECT * FROM artist;

-- Insert album records.
INSERT INTO album (title, artist_id) VALUES ('Who Made Who', 2);
INSERT INTO album (title, artist_id) VALUES ('IV', 1);

-- Select all records from the album table.
SELECT * FROM album;

-- Insert genre records.
INSERT INTO genre (name) VALUES ('Rock');
INSERT INTO genre (name) VALUES ('Metal');

-- Select all records from the genre table.
SELECT * FROM genre;

-- Insert track records.
INSERT INTO track (title, rating, len, count, album_id, genre_id)
    VALUES ('Black Dog', 5, 297, 0, 2, 1);

INSERT INTO track (title, rating, len, count, album_id, genre_id)
    VALUES ('Stairway', 5, 482, 0, 2, 1);

INSERT INTO track (title, rating, len, count, album_id, genre_id)
    VALUES ('About to Rock', 5, 313, 0, 1, 2);

INSERT INTO track (title, rating, len, count, album_id, genre_id)
    VALUES ('Who Made Who', 5, 207, 0, 1, 2);

-- Select all records from the track table.
SELECT * FROM track;