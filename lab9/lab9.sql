CREATE DATABASE lab9;

CREATE TABLE Reviewer (
    reviewerID INT PRIMARY KEY,
    name VARCHAR(100)
);


CREATE TABLE Movie (
    movieID INT PRIMARY KEY,
    title VARCHAR(100),
    releaseYear INT,
    director VARCHAR(100)
);


CREATE TABLE Review (
    reviewerID INT,
    movieID INT,
    rating INT,
    reviewDate VARCHAR(10),
    PRIMARY KEY (reviewerID, movieID),
    FOREIGN KEY (reviewerID) REFERENCES Reviewer(reviewerID),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);


INSERT INTO Reviewer (reviewerID, name) VALUES
(301, 'Alex Johnson'),
(302, 'Maria Gomez'),
(303, 'John Doe'),
(304, 'Linda Brown'),
(305, 'Michael Thompson'),
(306, 'Emily Davis'),
(307, 'Daniel White'),
(308, 'Sophia Lee');


INSERT INTO Movie (movieID, title, releaseYear, director) VALUES
(401, 'Future World', 2024, 'Alice Smith'),
(402, 'The Last Adventure', 2024, 'John Black'),
(403, 'New Horizons', 2024, 'Maria Johnson'),
(404, 'Time Capsule', 2024, 'Chris Martin'),
(405, 'Beyond the Stars', 2024, NULL),
(406, 'The Silent Valley', 2024, 'Laura Green'),
(407, 'Lost in the Echo', 2024, 'Daniel White'),
(408, 'Shadow of Destiny', 2024, 'James Clarke');


INSERT INTO Review (reviewerID, movieID, rating, reviewDate) VALUES
(301, 401, 5, '15/02/24'),
(301, 402, 4, '20/02/24'),
(302, 403, 5, '11/01/24'),
(303, 404, 3, '23/01/24'),
(304, 405, 4, '15/01/24'),
(305, 406, 2, '01/03/24'),
(306, 407, 5, '05/02/24'),
(307, 408, 4, '12/03/24');

--2
CREATE VIEW HighRatedMovieYears AS
SELECT DISTINCT m.releaseYear
FROM Movie m
JOIN Review r ON m.movieID = r.movieID
WHERE r.rating >= 4
ORDER BY m.releaseYear;

create view HighRatedMovieYears as
    select distinct m.releaseYear
from Movie m
join Review r on m.movieID= r.movieID
where r.rating>=4
order by m.releaseYear;



--3
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_movieID ON Review(movieID);
CREATE INDEX idx_movie_releaseYear ON Movie(releaseYear);
CREATE INDEX idx_movie_movieID ON Movie(movieID);

create index idx_review_rating on Review(rating);
create index idx_review_movieID on Review(movieID);
create index idx_movie_movieID on Movie(movieId);
create index idx_movie_releaseYear on Movie(releaseYear);



--4

CREATE ROLE lab9_role WITH LOGIN CREATEROLE;


--5
GRANT ALL PRIVILEGES ON DATABASE postgres TO lab9_role;
GRANT ALL ON SCHEMA public TO lab9_role;




--6
ALTER TABLE Reviewer OWNER TO lab9_role;
ALTER TABLE Movie OWNER TO lab9_role;
ALTER TABLE Review OWNER TO lab9_role;


--7
CREATE VIEW TopRated2024Movies AS
SELECT m.title, rv.name AS reviewer_name
FROM Movie m
JOIN Review r ON m.movieID = r.movieID
JOIN Reviewer rv ON r.reviewerID = rv.reviewerID
WHERE m.releaseYear = 2024 AND r.rating = 5
ORDER BY m.title;



