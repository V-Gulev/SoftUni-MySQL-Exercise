CREATE DATABASE mountains;
USE mountains;

CREATE TABLE `mountains` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE peaks(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_peaks_mountain_id_mountains_id
    FOREIGN KEY (mountain_id)
    REFERENCES mountains(id)
);

SELECT
	v.driver_id,
    v.vehicle_type,
    CONCAT(c.first_name, ' ', c.last_name) AS 'driver_name'
FROM vehicles AS v
JOIN campers AS c ON v.driver_id = c.id;

select *
from campers;

SELECT
	r.starting_point,
    r.end_point,
    r.leader_id,
    CONCAT(c.first_name, ' ', c.last_name) AS  'leader_name'
FROM routes AS r
JOIN campers AS c ON  r.leader_id = c.id;

CREATE TABLE `mountains` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE peaks(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_peaks_mountain_id_mountains_id
    FOREIGN KEY (mountain_id)
    REFERENCES mountains(id)
    ON DELETE CASCADE
);

CREATE DATABASE clients;
CREATE TABLE clients(
	id	INT  AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100)
);

CREATE TABLE projects(
	id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    project_lead_id INT,
    CONSTRAINT fk_projects_clients
    FOREIGN KEY (client_id)
    REFERENCES clients(id)
);

CREATE TABLE employees(
	id INT  AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(30),
    last_name varchar(30),
    project_id INT,
    CONSTRAINT fk_employees_project_id_prohjects_id
    FOREIGN KEY (project_id)
    REFERENCES projects(id)
);

ALTER TABLE projects
ADD CONSTRAINT fk_projects_employees
	FOREIGN KEY (project_lead_id)
    REFERENCES employees(id);