-- Drop existing student table if it exists, along with any dependent objects.
DROP TABLE student CASCADE;

-- Create a new student table with a unique ID and name.
CREATE TABLE student (
    id SERIAL,  -- Automatically incremented unique identifier for each student.
    name VARCHAR(128) UNIQUE,  -- Unique name for each student.
    PRIMARY KEY(id)  -- Define 'id' as the primary key.
);

-- Drop existing course table if it exists, along with any dependent objects.
DROP TABLE course CASCADE;

-- Create a new course table with a unique ID and title.
CREATE TABLE course (
    id SERIAL,  -- Automatically incremented unique identifier for each course.
    title VARCHAR(128) UNIQUE,  -- Unique title for each course.
    PRIMARY KEY(id)  -- Define 'id' as the primary key.
);

-- Drop existing roster table if it exists, along with any dependent objects.
DROP TABLE roster CASCADE;

-- Create a new roster table to link students and courses with their roles.
CREATE TABLE roster (
    id SERIAL,  -- Automatically incremented unique identifier for each entry in the roster.
    student_id INTEGER REFERENCES student(id) ON DELETE CASCADE,  -- Foreign key referencing student table.
    course_id INTEGER REFERENCES course(id) ON DELETE CASCADE,  -- Foreign key referencing course table.
    role INTEGER,  -- Role of the student in the course (0 for Learner, 1 for Instructor).
    UNIQUE(student_id, course_id),  -- Ensure each student is linked to each course only once.
    PRIMARY KEY (id)  -- Define 'id' as the primary key.
);

-- Insert student names into the student table.
INSERT INTO student (name) VALUES
('Lachlainn'),
('Bekim'),
('Elana'),
('Rocco'),
('Sidal'),
('Estelle'),
('Ekaterina'),
('Mikaela'),
('Simra'),
('Xida'),
('Katia'),
('Amberlouise'),
('Ciarian'),
('Emer'),
('Morag');

-- Insert course titles into the course table.
INSERT INTO course (title) VALUES
('si106'),
('si110'),
('si206');

-- Insert student-course associations and their roles into the roster table.
INSERT INTO roster (student_id, course_id, role) VALUES
(1, 1, 1),  -- Lachlainn, si106, Instructor.
(2, 1, 0),  -- Bekim, si106, Learner.
(3, 1, 0),  -- Elana, si106, Learner.
(4, 1, 0),  -- Rocco, si106, Learner.
(5, 1, 0),  -- Sidal, si106, Learner.
(6, 2, 1),  -- Estelle, si110, Instructor.
(7, 2, 0),  -- Ekaterina, si110, Learner.
(8, 2, 0),  -- Mikaela, si110, Learner.
(9, 2, 0),  -- Simra, si110, Learner.
(10, 2, 0), -- Xida, si110, Learner.
(11, 3, 1), -- Katia, si206, Instructor.
(12, 3, 0), -- Amberlouise, si206, Learner.
(13, 3, 0), -- Ciarian, si206, Learner.
(14, 3, 0), -- Emer, si206, Learner.
(15, 3, 0); -- Morag, si206, Learner.

-- Query to retrieve student names, course titles, and roles, sorted by course title, role, and student name.
SELECT student.name, course.title, roster.role
FROM student 
JOIN roster ON student.id = roster.student_id
JOIN course ON roster.course_id = course.id
ORDER BY course.title, roster.role DESC, student.name;