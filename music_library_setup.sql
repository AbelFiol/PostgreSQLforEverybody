-- Drop tables if they exist, including any dependencies.
DROP TABLE album CASCADE;
DROP TABLE track CASCADE;
DROP TABLE artist CASCADE;
DROP TABLE tracktoartist CASCADE;

-- Create 'album' table with a unique title.
CREATE TABLE album (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

-- Create 'track' table with a foreign key reference to 'album'.
CREATE TABLE track (
    id SERIAL,
    title TEXT, 
    artist TEXT, 
    album TEXT, 
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE, -- Deletes track if related album is deleted.
    count INTEGER, 
    rating INTEGER, 
    len INTEGER,
    PRIMARY KEY(id)
);

-- Create 'artist' table with a unique name.
CREATE TABLE artist (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

-- Create 'tracktoartist' table to associate tracks with artists.
CREATE TABLE tracktoartist (
    id SERIAL,
    track VARCHAR(128),
    track_id INTEGER REFERENCES track(id) ON DELETE CASCADE, -- Deletes association if related track is deleted.
    artist VARCHAR(128),
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE, -- Deletes association if related artist is deleted.
    PRIMARY KEY(id)
);

-- Import data into 'track' table from 'library.csv' file.
\COPY track(title, artist, album, count, rating, len) FROM 'library.csv' WITH DELIMITER ',' CSV;

-- Insert distinct album titles into 'album' table.
INSERT INTO album (title) SELECT DISTINCT album FROM track;

-- Update 'track' table to set 'album_id' based on album titles.
UPDATE track SET album_id = (SELECT album.id FROM album WHERE album.title = track.album);

-- Insert distinct track and artist pairs into 'tracktoartist'.
INSERT INTO tracktoartist (track, artist) SELECT DISTINCT title, artist FROM track;

-- Insert distinct artist names into 'artist' table.
INSERT INTO artist (name) SELECT DISTINCT artist FROM track;

-- Update 'tracktoartist' to set 'track_id' based on track titles.
UPDATE tracktoartist SET track_id = (SELECT track.id FROM track WHERE track.title = tracktoartist.track);

-- Update 'tracktoartist' to set 'artist_id' based on artist names.
UPDATE tracktoartist SET artist_id = (SELECT artist.id FROM artist WHERE artist.name = tracktoartist.artist);

-- Drop 'album' and 'artist' columns from 'track' table as they are now redundant.
ALTER TABLE track DROP COLUMN album;
ALTER TABLE track DROP COLUMN artist;

-- Drop 'track' and 'artist' columns from 'tracktoartist' table as they are now redundant.
ALTER TABLE tracktoartist DROP COLUMN track;
ALTER TABLE tracktoartist DROP COLUMN artist;

-- Select track titles, album titles, and artist names, and order by track titles, limiting results to 3.
SELECT track.title, album.title, artist.name
FROM track
JOIN album ON track.album_id = album.id
JOIN tracktoartist ON track.id = tracktoartist.track_id
JOIN artist ON tracktoartist.artist_id = artist.id
ORDER BY track.title
LIMIT 3;