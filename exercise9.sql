DELIMITER $$

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE result INT;
	SET result := (SELECT COUNT(e.employee_id)
    FROM towns t
    JOIN addresses a ON a.town_id = t.town_id
    JOIN employees e ON e.address_id = a.address_id
    WHERE name = town_name);

    RETURN result;
END$$

DELIMITER ;

SELECT ufn_count_employees_by_town('Bellevue');


DELIMITER $$

CREATE PROCEDURE usp_create_department(
	department_name VARCHAR(50),
    manager_first_name VARCHAR(50),
    manager_last_name VARCHAR(50))
BEGIN
	DECLARE manager_id INT;
    SET manager_id = (
		SELECT employee_id
        FROM employees
        WHERE first_name = manager_first_name AND
			last_name = manager_last_name
    );

    INSERT INTO departments(name, manager_id)
		VALUES(department_name, manager_id);
END$$

DELIMITER ;

CALL usp_create_department('Procedure Dept', 'John', 'Chen');

CREATE TABLE deleted_employees_2 AS
	SELECT
		employee_id,
		first_name,
        last_name,
        middle_name,
        job_title,
        department_id,
        salary
	FROM employees
    WHERE 0 = 1;

SELECT *
FROM deleted_employees;

DELIMITER $$

CREATE TRIGGER trg_copy_deleted_employee
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees(first_name, last_name, middle_name,
		job_title, department_id, salary)
    VALUES(OLD.first_name, OLD.last_name, OLD.middle_name,
			OLD.job_title, OLD.department_id, OLD.salary);
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE usp_raise_salary_by_id(e_id INT)
BEGIN
	DECLARE e_count INT;

    START TRANSACTION;

    SET e_count := (SELECT COUNT(*) FROM employees WHERE employee_id = e_id);

    UPDATE employees
    SET salary = salary * 1.05
    WHERE employee_id = e_id;

    IF e_count = 0 THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(dept_name VARCHAR(50))
BEGIN
	UPDATE employees
    SET salary = salary * 1.05
    WHERE department_id = (
		SELECT department_id FROM departments WHERE name = dept_name
	);
END$$

DELIMITER ;


