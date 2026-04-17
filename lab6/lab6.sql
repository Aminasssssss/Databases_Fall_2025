CREATE DATABASE lab_queries;

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    course_code VARCHAR(10),
    credits INTEGER
);

CREATE TABLE professors (
    professor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    major VARCHAR(50),
    year_enrolled INTEGER
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    professor_id INTEGER REFERENCES professors(professor_id),
    enrollment_date DATE
);


--3
SELECT
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    c.course_name,
    p.last_name AS professor_last_name

FROM students s
JOIN enrollments e ON s.student_id=e.student_id
JOIN courses c ON e.course_id=c.course_id
JOIN professors p ON e.professor_id=p.professor_id;


select
    s.first_name as student_first_name,
    s.last_name as student_last_name,
    c.course_name,
    p.last_name as professor_last_name

from students s
join enrollments e on s.student_id= e.student_id
join courses c on e.course_id= c.course_id
join professors p on e.professor_id= p.professor_id;




--4
SELECT DISTINCT
    s.first_name,
    s.last_name
FROM students s
JOIN enrollments e ON s.student_id=e.student_id
JOIN courses c ON e.course_id= c.course_id
WHERE c.credits >3;

select distinct
    s.first_name,
    s.last_name
from students s
join enrollments e on s.student_id= e.student_id
join courses c on e.course_id = c.course_id
where c.credits>3;




--5
SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS number_of_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


select
    c.course_name,
    count(distinct e.student_id) as number_of_students
from courses c
left join enrollments e on c.course_id = e.course_id
group by c.course_id, c.course_name;

select
    c.course_name,
    count(distinct e.student_id) as number_of_students
from courses c
left join enrollments e on c.course_id= e.course_id;
group by c.course_id, c.course_name;


--6
SELECT DISTINCT
    p.first_name,
    p.last_name
FROM professors p
JOIN enrollments e ON p.professor_id = e.professor_id;


select distinct
    p.first_name,
    p.last_name
from professors p
join enrollments e on p.professor_id= e.professor_id;




--7
SELECT DISTINCT
    s.first_name,
    s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN professors p ON e.professor_id = p.professor_id
WHERE p.department = 'Computer Science';


select distinct
    s.first_name,
    s.last_name
from students s
join enrollments e on s.student_id=e.student_id
join professors p on e.professor_id = p.professor_id
where p.department = 'Computer Science';



--8
SELECT
    c.course_name,
    p.last_name AS professor_last_name,
    SUM(c.credits) AS total_credits
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN professors p ON e.professor_id = p.professor_id
WHERE p.last_name LIKE 'S%'
GROUP BY c.course_name, p.last_name;

select
    c.course_name,
    p.last_name as professor_last_name,
    sum(c.credits) as total_credits
from courses c
join enrollments e on c.course_id = e.course_id
join professors p on e.professor_id= p.professor_id
where p.last_name LIKE 'S%'
group by c.course_name, p.last_name;



--9
SELECT DISTINCT
    s.first_name,
    s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_date < '2022-01-01';


select distinct
    s.first_name,
    s.last_name
from students s
join enrollments e on s.student_id= e.student_id
where e.enrollment_date< '2022-01-01';


--10
SELECT
    c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


select
    c.course_name
from courses c
left join enrollments e on c.course_id = e.course_id
where e.enrollment_id is null;

