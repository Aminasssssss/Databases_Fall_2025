CREATE DATABASE lab3;
-- 2. Create table for Students

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- 3. Create table for Courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(100),
    credits INT
);

-- 4. Create table for Registration (link between students and courses)
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 5. Insert sample data into students table
INSERT INTO students (first_name, last_name, date_of_birth, email, city) VALUES
('Alice', 'Johnson', '2001-05-14', 'alice.johnson@example.com', 'Almaty'),
('Bob', 'Smith', '2000-09-20', 'bob.smith@example.com', 'New York'),
('Cathy', 'Williams', '2002-01-10', 'cathy.williams@example.com', 'Almaty'),
('David', 'Brown', '1999-03-22', 'david.brown@example.com', 'Los Angeles');
-- 6. Insert sample data into courses table
INSERT INTO courses (course_code, course_name, credits) VALUES
('CS101', 'Introduction to Computer Science', 4),
('MATH201', 'Calculus I', 3),
('PHYS301', 'General Physics', 3),
('HIST101', 'World History', 2);

-- 7. Insert sample data into registration table
INSERT INTO registration (student_id, course_id, registration_date, grade) VALUES
(1, 1, '2023-09-01', NULL),  -- Alice registered for CS101
(2, 2, '2023-09-01', NULL),  -- Bob registered for MATH201
(3, 3, '2023-09-01', NULL),  -- Cathy registered for PHYS301
(4, 1, '2023-09-01', NULL),  -- David registered for CS101
(1, 4, '2023-09-01', NULL);  -- Alice registered for HIST101




--3
SELECT last_name FROM students;


--4
SELECT DISTINCT last_name FROM students;

--5
SELECT* FROM students
WHERE last_name= 'Johnson';

--6
SELECT* FROM students
WHERE last_name IN ('Johnson', 'Smith');






--7
SELECT s.*
FROM STUDENTS s
JOIN registration r ON s.student_id=r.student_id
JOIN courses c ON c.course_id=r.course =_id
WHERE c.course_code='CS101';


--8
SELECT s.*
FROM students s
JOIN registration r ON s.student_id = r.student_id
JOIN courses c ON c.course_id=r.course_id
WHERE c.course_code IN ('MATH201', 'PHYS301');




--9
SELECT SUM(credits) AS total_credits
FROM courses;


--10
SELECT
    c.course_id,
    COUNT(*) AS num_students
FROM courses c
JOIN registration r ON r.course_id= c.course_id
GROUP BY c.course_id
ORDER BY c.course_id;






--11
SELECT
    c.course_id
FROM courses c
JOIN registration r ON r.course_id=c.course_id
GROUP BY c.course_id
HAVING COUNT(*)>2;





--12
WITH ranked AS (
    SELECT course_name, credits,
           DENSE_RANK() OVER (ORDER BY credits DESC) AS rnk
    FROM courses
)
SELECT course_name
FROM ranked
WHERE rnk=2;





--13
WITH min_credits AS(
    SELECT MIN(credits) AS min_cr FROM courses
),
min_courses AS(
    SELECT course_id FROM courses, min_credits WHERE credits=min_cr
)
SELECT s.first_name, s.last_name
FROM students s
JOIN registration r ON r.student_id= s.student_id
JOIN min_courses mc ON mc.course_id= r.course_id;


--14
SELECT first_name, last_name
FROM students
WHERE city='Almaty';

--15
SELECT*
FROM courses
WHERE credits>3
ORDER BY credits ASC, course_id DESC;

--16
UPDATE courses
SET credits=credits-1
WHERE credits=(SELECT MIN(credits) FROM courses);

--17
WITH ids AS(
    SELECT
        (SELECT course_id FROM courses WHERE course_code='CS101') AS cs101_id,
        (SELECT course_id FROM courses WHERE course_code='MATH201') AS math201_id
)
UPDATE registration r
SET course_id= ids.cs101_id
FROM ids
WHERE r.course_id= ids.math201_id;


--18
DELETE FROM students s
USING registration r, courses c
WHERE s.student_id = r.student_id
    AND c.course_id =r.course_id
    AND c.course_code ='CS101';

--19
DELETE FROM students;




