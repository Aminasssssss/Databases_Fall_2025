CREATE DATABASE lab4;

\c lab4

CREATE TABLE Warehouses(
    code INT PRIMARY KEY,
    location VARCHAR(50),
    capacity INT
);

CREATE TABLE Packs(
    code VARCHAR(10) PRIMARY KEY,
    contents VARCHAR(50),
    value INT,
    warehouses INT REFERENCES Warehouses(code)
);


CREATE VIEW Boxes AS
SELECT code, contents, value, warehouses FROM Packs;

INSERT INTO Warehouses(code, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Rocks', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TUSS', 'Papers', 90, 5);


--4
SELECT* FROM Warehouses;

--5
SELECT* FROM Boxes WHERE value>150;

--6
SELECT DISTINCT contents from Boxes;

--7
SELECT
    w.code AS warehouse_code,
    COUNT(b.code) AS box_count
FROM Warehouses w
LEFT JOIN Boxes b ON w.code=b.warehouses
GROUP BY w.code
ORDER BY w.code;


--8
SELECT
    w.code AS warehouse_code,
    COUNT(b.code) AS box_count
FROM Warehouses w
LEFT JOIN Boxes b ON w.code= b.warehouses
GROUP BY w.code
HAVING COUNT(b.code)>2
ORDER BY w.code;

--9
INSERT INTO Warehouses(code, location, capacity)
VALUES(6, 'New York', 3);

--10
INSERT INTO Packs(code, contents, value, warehouses)
VALUES('H5RT', 'Papers', 200, 2);

--11
WITH ranked AS(
    SELECT code, value,
           ROW_NUMBER() OVER (ORDER BY value DESC) AS rnk
    FROM Packs
)
UPDATE Packs
SET value= ROUND(value*0.85, 2)
WHERE code=(SELECT code FROM ranked WHERE rnk=3)
RETURNING *;

--12
DELETE FROM Packs
WHERE value<150
RETURNING *;

--13
DELETE FROM Packs p
USING Warehouses w
WHERE p.warehouses= w.code
    AND w.location= 'New York'
RETURNING p.*;

--14
SELECT* FROM Warehouses;
SELECT* FROM Packs ORDER BY value DESC, code;



