CREATE DATABASE library_db;

\c library_db

CREATE TABLE members (
  member_id INTEGER PRIMARY KEY,
  member_name VARCHAR(100),
  city VARCHAR(50),
  membership_level INTEGER,
  librarian_id INTEGER
);

CREATE TABLE borrowings(
    borrowing_id INTEGER PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INTEGER,
    librarian_id INTEGER,
    book_id INTEGER
);


CREATE TABLE librarians(
    librarian_id INTEGER PRIMARY KEY,
    name VARCHAR(150),
    city VARCHAR(150),
    commission NUMERIC(4,2)
);


INSERT INTO members VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

INSERT INTO borrowings VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-20', '2024-02-29', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);

INSERT INTO librarians VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);


--3

SELECT COUNT(*) AS total_borrowings_20202024
FROM borrowings
WHERE borrow_date BETWEEN '2020-01-01' AND '2024-12-31';

--4

SELECT AVG(membership_level)AS avg_membership_level
FROM members;

--5

SELECT COUNT(*) AS ny_members
FROM members
WHERE city='New York';


--6

SELECT MIN(borrow_date) AS earliest_borrow_date
FROM borrowings;


--7

SELECT member_name, city
FROM members
WHERE member_name LIKE '%n';


--8

SELECT b.*
FROM borrowings b
JOIN librarians l ON b.librarian_id= l.librarian_id
WHERE l.city= 'Paris'
AND b.borrow_date BETWEEN '2021-01-01' AND '2023-12-31';


--9

SELECT *
FROM borrowings
WHERE borrow_date > '2023-01-01';


--10

SELECT m.member_id,
       m.member_name,
       COUNT(b.book_id) AS total_books
FROM members m
LEFT JOIN borrowings b ON m.member_id= b.member_id
GROUP BY m.member_id, m.member_name
ORDER BY m.member_id;


--11
SELECT *
FROM members
WHERE membership_level=3;


--12
SELECT *
FROM librarians
WHERE commission= (SELECT MAX(commission) FROM librarians);





