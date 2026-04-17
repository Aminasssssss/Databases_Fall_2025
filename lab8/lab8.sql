CREATE DATABASE library_db;
\c library_db;


CREATE TABLE librarians (
    librarian_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission NUMERIC(3,2)
);


CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    member_name VARCHAR(100),
    city VARCHAR(100),
    membership_level INTEGER,
    librarian_id INTEGER REFERENCES librarians(librarian_id)
);

CREATE TABLE borrowings (
    borrowing_id INTEGER PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INTEGER REFERENCES members(member_id),
    librarian_id INTEGER REFERENCES librarians(librarian_id),
    book_id INTEGER
);


INSERT INTO librarians (librarian_id, name, city, commission) VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);

INSERT INTO members (member_id, member_name, city, membership_level, librarian_id) VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

INSERT INTO borrowings (borrowing_id, borrow_date, return_date, member_id, librarian_id, book_id) VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-20', '2024-02-29', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);


-- 3
CREATE VIEW new_york_librarians AS
    SELECT * FROM librarians
WHERE city = 'New York';





-- 4
CREATE VIEW borrowing_details AS
    SELECT
    b.borrowing_id,
    b.borrow_date,
    b.return_date,
    m.member_name,
    l.name AS librarian_name,
    b.book_id
FROM borrowings b
JOIN members m ON b.member_id = m.member_id
JOIN librarians l ON b.librarian_id = l.librarian_id;

GRANT SELECT ON borrowing_details TO library_user;






-- 5
CREATE VIEW highest_level_members AS
    SELECT * FROM members
WHERE membership_level = (SELECT MAX(membership_level) FROM members);

GRANT SELECT ON highest_level_members TO library_user;







-- 6
CREATE VIEW librarians_by_city AS
    SELECT city, COUNT(*) AS librarian_count
FROM librarians
GROUP BY city;





-- 7
CREATE VIEW librarians_multiple_members AS
    SELECT l.librarian_id, l.name, l.city, l.commission, COUNT(DISTINCT m.member_id) AS unique_members_count
FROM librarians l
JOIN members m ON l.librarian_id = m.librarian_id
GROUP BY l.librarian_id, l.name, l.city, l.commission
HAVING COUNT(DISTINCT m.member_id) > 1;






-- 8
CREATE ROLE intern;
GRANT library_user TO intern;



