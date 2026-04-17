

CREATE DATABASE lab_2;



CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary INT

);


INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Amina', 'Zhumatayeva', 2, 55000);

INSERT INTO employees (first_name, last_name)
VALUES ('Ayazhan', 'Azamatkyzy');

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Assylzhan', 'Zhumatayeva', NULL, 60000);

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES
('John', 'Coe', 2, 55000),
('Dmitry', 'Kuznetsov', 3, 80000),
('Elena', 'Popova', 3, 48000),
('Sergey', 'Volkov', 2, 72000),
('Anna', 'Fedorova', NULL, 65000);


ALTER TABLE employees
ALTER COLUMN first_name SET DEFAULT 'John';

INSERT INTO employees(last_name, department_id, salary)
VALUES('Zhumatayev', 3,70000);

INSERT INTO employees DEFAULT VALUES;



CREATE TABLE employees_archive (LIKE employees INCLUDING ALL);


INSERT INTO employees_archive
SELECT * FROM employees;


UPDATE employees
SET department_id = 1
WHERE department_id IS NULL;


UPDATE employees
SET salary = salary * 1.15
WHERE salary > 0;


DELETE FROM employees
WHERE salary<50000;


DELETE FROM employees_archive
WHERE employee_id IN (SELECT employee_id FROM employees)
RETURNING *;


DELETE FROM employees
RETURNING *;








