CREATE TABLE album (
    id SERIAL,  -- Unique identifier for each album.
    title VARCHAR(128) UNIQUE,  -- Title of the album, must be unique.
    PRIMARY KEY(id)  -- Set 'id' as the primary key.
);

CREATE TABLE track (
    id SERIAL,  -- Unique identifier for each track.
    title VARCHAR(128),  -- Title of the track.
    len INTEGER,  -- Length of the track in seconds.
    rating INTEGER,  -- User rating of the track.
    count INTEGER,  -- Play count of the track.
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,  -- Foreign key referencing 'album' table.
    UNIQUE(title, album_id),  -- Ensure the combination of title and album_id is unique.
    PRIMARY KEY(id)  -- Set 'id' as the primary key.
);

DROP TABLE IF EXISTS track_raw;  -- Drop the 'track_raw' table if it exists.

CREATE TABLE track_raw (
    title TEXT,  -- Title of the track.
    artist TEXT,  -- Artist of the track.
    album TEXT,  -- Album name.
    album_id INTEGER,  -- Album ID (for reference).
    count INTEGER,  -- Play count of the track.
    rating INTEGER,  -- User rating of the track.
    len INTEGER  -- Length of the track in seconds.
);

\copy track_raw(title, artist, album, count, rating, len) FROM 'library.csv' WITH DELIMITER ',' CSV;  -- Import data from CSV file into 'track_raw'.

INSERT INTO album(title) SELECT DISTINCT album FROM track_raw;  -- Insert distinct albums from 'track_raw' into 'album'.

UPDATE album SET title = NULL;  -- Set all album titles to NULL (this may need clarification).

UPDATE track_raw SET album_id = (SELECT album.id FROM album WHERE album.title = track_raw.album);  -- Update 'track_raw' with the corresponding album_id from 'album'.

INSERT INTO track(title, len, rating, count, album_id) SELECT title, len, rating, count, album_id FROM track_raw;  -- Insert tracks into the 'track' table from 'track_raw'.

SELECT track.title, album.title  -- Select track and album titles.
FROM track
JOIN album ON track.album_id = album.id  -- Join 'track' and 'album' tables on album_id.
ORDER BY track.title LIMIT 3;  -- Order by track title and limit to the first 3 results.