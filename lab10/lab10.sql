CREATE DATABASE lab10;


DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Movies (
    movie_id INTEGER PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    price_per_day DECIMAL(5,2),
    available_copies INTEGER
);

CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Rentals (
    rental_id SERIAL PRIMARY KEY,
    movie_id INTEGER REFERENCES Movies(movie_id),
    customer_id INTEGER,
    rental_date DATE,
    quantity INTEGER
);

INSERT INTO Movies (movie_id, title, genre, price_per_day, available_copies) VALUES
(1, 'The Matrix', 'Sci-Fi', 5.00, 8),
(2, 'Titanic', 'Romance', 3.50, 12),
(3, 'Avengers: Endgame', 'Action', 6.00, 5);

INSERT INTO Customers (customer_id, name, email) VALUES
(201, 'Alice Johnson', 'alice.j@example.com'),
(202, 'Bob Smith', 'bob.smith@example.com');

INSERT INTO Rentals (rental_id, movie_id, customer_id, rental_date, quantity) VALUES
(1, 1, 201, '2024-11-01', 2),
(2, 2, 202, '2024-11-03', 1),
(3, 3, 201, '2024-11-05', 3);

-- 1
BEGIN;
INSERT INTO Rentals (movie_id, customer_id, rental_date, quantity)
VALUES (1, 201, CURRENT_DATE, 2);
UPDATE Movies SET available_copies = available_copies - 2
WHERE movie_id = 1;
COMMIT;




-- 2
BEGIN;
DO $$
    DECLARE available INT;
    BEGIN
    SELECT available_copies INTO available FROM Movies WHERE movie_id = 3;
    IF available >= 10 THEN
        INSERT INTO Rentals (movie_id, customer_id, rental_date, quantity)
        VALUES (3, 202, CURRENT_DATE, 10);
        UPDATE Movies SET available_copies = available_copies - 10
        WHERE movie_id = 3;
    ELSE
        RAISE NOTICE 'not enough copies';
        ROLLBACK;
    END IF;
END $$;
COMMIT;





-- 3
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Movies SET price_per_day = 7.00 WHERE movie_id = 1;
COMMIT;


BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price_per_day FROM Movies WHERE movie_id = 1;
COMMIT;


BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price_per_day FROM Movies WHERE movie_id = 1;
COMMIT;









-- 4
BEGIN;
UPDATE Customers SET email = 'alice.new@example.com' WHERE customer_id = 201;
COMMIT;



