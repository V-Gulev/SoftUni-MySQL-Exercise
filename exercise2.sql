SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'Sa%';

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

SELECT first_name
FROM employees
WHERE department_id IN (3, 10)
AND EXTRACT(YEAR FROM hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

SELECT *
FROM employees;

SELECT first_name, last_name
FROM employees
WHERE NOT job_title LIKE '%engineer%'
ORDER BY employee_id;

SELECT name
FROM towns
WHERE CHAR_LENGTH(name) IN (5,6)
ORDER BY name;

SELECT *
FROM towns
WHERE LEFT(name, 1) IN ('M','K','B','E')
ORDER BY name;

SELECT *
FROM towns
WHERE NOT LEFT(name, 1) IN ('R','D','B')
ORDER BY name;

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name
FROM employees
WHERE YEAR(hire_date) > 2000;

SELECT *
FROM v_employees_hired_after_2000;

SELECT * FROM employees;

SELECT first_name, last_name
FROM employees
WHERE char_length(last_name) LIKE 5;

SELECT country_name, iso_code
FROM countries
WHERE country_name LIKE '%A%A%A%'
ORDER  BY iso_code;

SELECT peak_name, river_name,
	CONCAT(LOWER(peak_name), LOWER(SUBSTRING(rivers.river_name, 2))) AS 'Mix'
FROM peaks, rivers
WHERE RIGHT(peak_name, 1) = LEFT(LOWER(river_name), 1)
ORDER  BY Mix;

SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS 'start'
FROM games
WHERE YEAR(start) BETWEEN 2011 AND 2012
ORDER BY start, name
LIMIT 50;

SELECT user_name, SUBSTRING(email, LOCATE('@', email) + 1) AS 'email provider'
FROM users
ORDER BY `email provider`, user_name;

SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

SELECT name,
CASE
	WHEN HOUR(start) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN HOUR(start) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS 'Part of the Day',
CASE
	WHEN duration <= 3 THEN 'Extra Short'
    WHEN duration BETWEEN 4 AND 6 THEN 'Short'
    WHEN duration BETWEEN 7 AND 10 THEN 'Long'
    ELSE 'Extra Long'
END AS 'Duration'
FROM games;

SELECT product_name, order_date,
	date_add(order_date, INTERVAL 3 DAY) AS 'pay_due',
    date_add(order_date, INTERVAL 1 MONTH) AS 'delivery_due'
FROM orders;