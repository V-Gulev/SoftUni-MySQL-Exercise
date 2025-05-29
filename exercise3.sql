SELECT * FROM categories;
SELECT * FROM products;

SELECT * FROM departments;
SELECT * FROM employees;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT *
FROM employees;

SELECT
	department_id,
	COUNT(*),
    COUNT(1),
    COUNT(id),
    COUNT(last_name)
FROM employees
GROUP BY department_id;

SELECT
	department_id,
    COUNT(id) AS 'Number of employess'
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, MAX(salary), MAX(first_name)
FROM employees
GROUP BY department_id;

SELECT
	department_id,
	ROUND(AVG(salary), 2) AS 'Average Salary'
FROM employees
GROUP BY department_id;

SELECT department_id, MIN(salary) AS 'Min Salary'
FROM employees
GROUP BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 4200;

SELECT department_id, MIN(salary) AS 'Min Salary'
FROM employees
GROUP BY department_id
HAVING `Min Salary` > 800;

SELECT *
FROM categories;

SELECT COUNT(*)
FROM products
WHERE price > 8 AND category_id = 2;

SELECT
	category_id,
    ROUND(AVG(price), 2) AS 'Average Price',
    MIN(price) AS 'Cheapest Product',
    MAX(price) AS 'Most Expensive Product'
FROM products
GROUP BY category_id;