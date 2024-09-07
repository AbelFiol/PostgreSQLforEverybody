-- Select all records from the 'track' table.
SELECT * FROM track;

-- Select all records from the 'genre' table.
SELECT * FROM genre;

-- Create the 'student' table.
CREATE TABLE student (
    id SERIAL,
    name VARCHAR(128),
    email VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

-- Create the 'course' table.
CREATE TABLE course (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

-- Create the 'member' table to establish relationships between students and courses.
CREATE TABLE member (
    student_id INTEGER REFERENCES student(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course(id) ON DELETE CASCADE,
    role INTEGER,
    PRIMARY KEY (student_id, course_id)
);

-- Insert students into the 'student' table.
INSERT INTO student (name, email) VALUES ('Jane', 'jane@tsugi.org');
INSERT INTO student (name, email) VALUES ('Ed', 'ed@tsugi.org');
INSERT INTO student (name, email) VALUES ('Sue', 'sue@tsugi.org');

-- Select all records from the 'student' table.
SELECT * FROM student;

-- Insert courses into the 'course' table.
INSERT INTO course (title) VALUES ('Python');
INSERT INTO course (title) VALUES ('SQL');
INSERT INTO course (title) VALUES ('PHP');

-- Select all records from the 'course' table.
SELECT * FROM course;

-- Insert membership records into the 'member' table.
INSERT INTO member (student_id, course_id, role) VALUES (1, 1, 1);
INSERT INTO member (student_id, course_id, role) VALUES (2, 1, 0);
INSERT INTO member (student_id, course_id, role) VALUES (3, 1, 0);
INSERT INTO member (student_id, course_id, role) VALUES (1, 2, 0);
INSERT INTO member (student_id, course_id, role) VALUES (2, 2, 1);
INSERT INTO member (student_id, course_id, role) VALUES (2, 3, 1);
INSERT INTO member (student_id, course_id, role) VALUES (3, 3, 0);

-- Select all records from the 'student', 'course', and 'member' tables.
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM member;

-- Select student name, role, and course title by joining tables, ordered by course title, role, and student name.
SELECT student.name, member.role, course.title
FROM student
JOIN member ON member.student_id = student.id
JOIN course ON member.course_id = course.id 
ORDER BY course.title, member.role DESC, student.name;