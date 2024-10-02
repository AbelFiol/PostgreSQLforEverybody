-- Select all columns from the album table.
SELECT * FROM album;

-- Select all columns from the artist table.
SELECT * FROM artist;

-- Select album titles and artist names using a JOIN on the artist_id and id columns.
SELECT album.title, artist.name
FROM album JOIN artist
ON album.artist_id = artist.id;

-- Select specific columns from the album and artist tables using an INNER JOIN.
SELECT album.title, album.artist_id, artist.id, artist.name
FROM album INNER JOIN artist ON album.artist_id = artist.id;

-- Select track titles and genre names using a CROSS JOIN between the track and genre tables.
SELECT track.title, track.genre_id, genre.id, genre.name
FROM track CROSS JOIN genre;

-- Select all columns from the track table.
SELECT * FROM track;

-- Select all columns from the genre table.
SELECT * FROM genre;

-- Select track titles and genre names using a JOIN on the genre_id and id columns.
SELECT track.title, genre.name
FROM track JOIN genre
ON track.genre_id = genre.id;

-- Select track titles, artist names, album titles, and genre names by joining track, genre, album, and artist tables.
SELECT track.title, artist.name, album.title, genre.name
FROM track
JOIN genre ON track.genre_id = genre.id
JOIN album ON track.album_id = album.id
JOIN artist ON album.artist_id = artist.id;

-- Delete all entries from the genre table where the genre name is 'Metal'.
DELETE FROM genre WHERE name ='Metal';

-- Select all columns from the track table to see the updated data after the deletion.
SELECT * FROM track;