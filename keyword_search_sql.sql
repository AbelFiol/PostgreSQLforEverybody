-- Example of splitting a string into an array using string_to_array function.
SELECT string_to_array('Hello world', ' ');

-- Unnest the array into individual rows.
SELECT unnest(string_to_array('Hello world', ' '));

-- Create a table to store documents with an auto-incrementing ID.
CREATE TABLE docs (
    id SERIAL, 
    doc TEXT, 
    PRIMARY KEY(id)
);

-- Insert sample data into the docs table.
INSERT INTO docs (doc) VALUES
('This is SQL and Python and other fun teaching stuff'),
('More people should learn SQL from UMSI'),
('UMSI also teaches Python and also SQL');

-- Display all rows from the docs table.
SELECT * FROM docs;

-- Extract and list keywords from documents using unnest.
SELECT id, s.keyword AS keyword
FROM docs AS D, unnest(string_to_array(D.doc, ' ')) s(keyword)
ORDER BY id;

-- Extract unique keywords from documents.
SELECT DISTINCT id, s.keyword AS keyword
FROM docs AS D, unnest(string_to_array(D.doc, ' ')) s(keyword)
ORDER BY id;

-- Create a new table to store unique keywords and their associated document IDs.
CREATE TABLE docs_gin (
    keyword TEXT,
    doc_id INTEGER REFERENCES docs(id) ON DELETE CASCADE
);

-- Populate the docs_gin table with unique keywords and document IDs.
INSERT INTO docs_gin (doc_id, keyword)
SELECT DISTINCT id, s.keyword AS keyword
FROM docs AS D, unnest(string_to_array(D.doc, ' ')) s(keyword)
ORDER BY id;

-- Display all rows from the docs_gin table.
SELECT * FROM docs_gin ORDER BY doc_id;

-- Search for documents containing the keyword 'UMSI'.
SELECT DISTINCT keyword, doc_id FROM docs_gin AS G
WHERE G.keyword = 'UMSI';

-- Retrieve documents where the keyword is 'UMSI'.
SELECT DISTINCT id, doc FROM docs AS D
JOIN docs_gin AS G ON D.id = G.doc_id
WHERE G.keyword = 'UMSI';

-- Retrieve documents containing specific keywords: 'fun' or 'people'.
SELECT DISTINCT doc FROM docs AS D
JOIN docs_gin AS G ON D.id = G.doc_id
WHERE G.keyword IN ('fun', 'people');

-- Retrieve documents containing any keyword from the given phrase.
SELECT DISTINCT doc FROM docs AS D
JOIN docs_gin AS G ON D.id = G.doc_id
WHERE G.keyword = ANY(string_to_array('I want to learn', ' '));

-- Retrieve documents containing any keyword from the given complex phrase.
SELECT DISTINCT id, doc FROM docs AS D
JOIN docs_gin AS G ON D.id = G.doc_id
WHERE G.keyword = ANY(string_to_array('Search for Lemons and Neons', ' '));