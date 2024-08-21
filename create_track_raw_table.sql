-- Create the 'track_raw' table to store track information.
CREATE TABLE track_raw (
  title TEXT,  -- Track title.
  artist TEXT,  -- Artist name.
  album TEXT,  -- Album name.
  count INTEGER,  -- Play count.
  rating INTEGER,  -- Rating of the track.
  len INTEGER  -- Length of the track.
);

-- Select the title and album from 'track_raw', ordered by title, limited to the first 3 results.
SELECT title, album 
FROM track_raw 
ORDER BY title 
LIMIT 3;