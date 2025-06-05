SELECT * FROM employees;
SELECT * FROM departments;

SELECT e.first_name, e.last_name, e.department_id, d.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY e.last_name
LIMIT 5;

SELECT COUNT(*)
FROM addresses a
INNER JOIN towns t ON a.town_id = t.town_id;

SELECT COUNT(*)
FROM addresses a
LEFT JOIN towns t ON a.town_id = t.town_id;

SELECT COUNT(*)
FROM towns t
LEFT JOIN addresses a ON t.town_id = a.town_id;

SELECT
	e.employee_id,
	CONCAT(e.first_name, ' ', e.last_name) AS 'full_name',
    d.department_id,
    d.name
FROM employees e
JOIN departments d ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;

SELECT *
FROM addresses;

SELECT *
FROM towns;

SELECT t.town_id, t.name, a.address_text
FROM addresses a
JOIN towns t ON a.town_id = t.town_id
WHERE a.town_id IN (9,15,32)
ORDER BY t.town_id, a.address_id;

SELECT e.employee_id, e.first_name, e.last_name, m.employee_id, m.first_name
FROM employees e
JOIN employees m ON e.manager_id IS NULL;

SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE manager_id IS NULL;

SELECT AVG(e.salary)
FROM employees e;

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(e.salary) FROM employees e);