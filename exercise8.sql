SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees e
JOIN addresses a ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;

SELECT e.first_name, e.last_name, t.name, a.address_text
FROM employees e
JOIN addresses a ON a.address_id = e.address_id
JOIN towns t ON t.town_id = a.town_id
ORDER BY first_name, last_name
LIMIT 5;

SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees e
JOIN departments d ON d.department_id = e.department_id AND d.name = "Sales"
ORDER BY e.employee_id DESC;

SELECT employee_id, first_name, salary, d.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id AND salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

SELECT employee_id, first_name
FROM employees
WHERE employee_id NOT IN
	(SELECT DISTINCT employee_id
	FROM employees_projects
	ORDER BY employee_id)
ORDER BY employee_id DESC
LIMIT 3;

SELECT DISTINCT employee_id
FROM employees_projects
ORDER BY employee_id;

SELECT first_name, last_name, hire_date, d.name
FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE hire_date > '1999-01-01' AND d.name IN ('Sales', 'Finance')
ORDER BY hire_date;

SELECT e.employee_id, e.first_name, p.name
FROM employees e
JOIN employees_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON p.project_id = ep.project_id AND DATE(p.start_date) > '2002-08-13' AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;

SELECT e.employee_id, e.first_name,
CASE
	WHEN YEAR(p.start_date) >= 2005 THEN NULL
    ELSE p.name
END AS 'project_name'
FROM employees e
JOIN employees_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON p.project_id = ep.project_id
WHERE e.employee_id = 24
ORDER BY p.name;

SELECT e.employee_id, e.first_name, e.manager_id, m.first_name AS 'manager_name'
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id AND e.manager_id IN (3,7)
ORDER BY e.first_name;

SELECT
	e.employee_id,
    CONCAT(e.first_name, ' ' , e.last_name) AS 'employee_name',
    CONCAT(m.first_name, ' ' , m.last_name) AS 'manager_name',
    d.name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;

SELECT AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;

SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM mountains_countries mc
JOIN mountains m ON mc.mountain_id = m.id
JOIN peaks p ON p.mountain_id = mc.mountain_id
WHERE mc.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;

SELECT mc.country_code, COUNT(m.mountain_range) AS 'mountain_range'
FROM mountains_countries mc
JOIN mountains m ON mc.mountain_id = m.id
WHERE mc.country_code IN ('BG', 'US', 'RU')
group by mc.country_code
ORDER BY `mountain_range` DESC;

SELECT c.country_name, r.river_name
FROM countries c
LEFT JOIN countries_rivers cr ON cr.country_code = c.country_code
LEFT JOIN rivers r ON r.id = cr.river_id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

SELECT COUNT(*)
FROM countries
WHERE country_code NOT IN (SELECT DISTINCT country_code FROM mountains_countries);

SELECT c.country_name, MAX(p.elevation) AS 'highest_peak_elevation', MAX(r.length) AS 'longest_river_length'
FROM countries c
LEFT JOIN mountains_countries mc ON c.country_code = mc.country_code
LEFT JOIN peaks p ON p.mountain_id = mc.mountain_id
LEFT JOIN countries_rivers cr ON cr.country_code = c.country_code
LEFT JOIN rivers r ON cr.river_id = r.id
GROUP BY country_name
ORDER BY `highest_peak_elevation` DESC, `longest_river_length` DESC, c.country_name
LIMIT 5;

