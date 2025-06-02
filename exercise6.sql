CREATE DATABASE demo1;
USE demo1;

CREATE TABLE passports(
	passport_id INT AUTO_INCREMENT PRIMARY KEY,
    passport_number VARCHAR(30) UNIQUE
);

CREATE TABLE people(
	person_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
	salary DECIMAL(7,2),
    passport_id INT UNIQUE,
    FOREIGN KEY(passport_id)
    REFERENCES passports(passport_id)
);

INSERT INTO passports
VALUES (101,'N34FG21B'),
		(102,'K65LO4R7'),
        (103, 'ZE657QP2');

INSERT INTO people
VALUES (1, 'Roberto', 43300, 102),
		(2, 'Tom', 56100, 103),
        (3, 'Yana', 60200, 101);

SELECT *
FROM people AS pe
JOIN passports AS pa ON pa.passport_id = pe.passport_id;

CREATE TABLE manufacturers (
	manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    established_on DATE
);

CREATE TABLE models(
	model_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    manufacturer_id INT,
    FOREIGN KEY(manufacturer_id)
    REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers
VALUES (1, 'BMW', '1916-03-01'),
		(2, 'Tesla', '2003-01-01'),
        (3, 'Lada', '1966-05-01');

INSERT INTO models
VALUES (101, 'X1', 1),
		(102, 'i6', 1),
        (103, 'Model S', 2),
        (104, 'Model X', 2),
        (105, 'Model 3', 2),
        (106, 'Nova', 3);

SELECT *
FROM manufacturers AS m
JOIN models AS md ON md.manufacturer_id = m.manufacturer_id;

CREATE TABLE exams(
	exam_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE students(
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE students_exams(
	student_id INT,
    exam_id INT,
    FOREIGN KEY(student_id)
    REFERENCES students(student_id),
    FOREIGN KEY(exam_id)
    REFERENCES exams(exam_id),
    PRIMARY KEY(student_id, exam_id)
);

INSERT INTO exams (exam_id, name) VALUES
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

INSERT INTO students (student_id, name) VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

INSERT INTO students_exams (student_id, exam_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

CREATE TABLE teachers(
	teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    manager_id INT,
    FOREIGN KEY(manager_id) REFERENCES teachers(teacher_id)
);

INSERT INTO teachers (teacher_id, name, manager_id) VALUES
(101, 'John', NULL),
(106, 'Greta', 101),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(105, 'Mark', 101),
(104, 'Ted', 105);

SELECT *
FROM teachers AS t
JOIN teachers AS m ON m.manager_id = t.teacher_id;

CREATE TABLE item_types (
    item_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    item_type_id INT NOT NULL,
    FOREIGN KEY(item_type_id) REFERENCES item_types(item_type_id)
);

CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    birthday DATE,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id),
    PRIMARY KEY (order_id, item_id)
);

CREATE DATABASE demo2;
USE demo2;
CREATE TABLE majors (
    major_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12) NOT NULL,
    student_name VARCHAR(50) NOT NULL,
    major_id INT NOT NULL,
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE agenda (
    student_id INT,
    subject_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    PRIMARY KEY (student_id, subject_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    payment_amount DECIMAL(8,2),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

SELECT mountain_range, peak_name, elevation
FROM peaks AS p
JOIN mountains AS m ON p.mountain_id = m.id
WHERE mountain_range = 'Rila'
ORDER BY elevation DESC;
