-- M1. List employees in department_id 80 with salary greater than 8000.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 80
AND salary > 8000;

-- M2. Find employees whose last_name ends with 'n'.
SELECT employee_id, first_name, last_name
FROM employees
WHERE last_name LIKE '%n';

-- M3. List employees hired after January 1, 2005.
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date > DATE '2005-01-01';

-- M4. Get employees whose job_id is either 'SA_REP' or 'SA_MAN'.
SELECT employee_id, first_name, job_id
FROM employees
WHERE job_id IN ('SA_REP', 'SA_MAN');

-- M5. List employees with salary between 4000 and 7000 (inclusive).
SELECT employee_id, salary
FROM employees
WHERE salary BETWEEN 4000 AND 7000;

-- M6. Find employees who have a manager (manager_id is not null).
SELECT employee_id, first_name, manager_id
FROM employees
WHERE manager_id IS NOT NULL;

-- M7. List departments with department_id 10, 20, or 30.
SELECT department_id, department_name
FROM departments
WHERE department_id IN (10, 20, 30);

-- M8. Get the top 3 employees by hire_date (oldest first).
SELECT employee_id, first_name, hire_date
FROM employees
ORDER BY hire_date ASC
FETCH FIRST 3 ROWS ONLY;

-- M9. List employees in department 50, ordered by last_name ascending.
SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id = 50
ORDER BY last_name ASC;

-- M10. Find employees whose first_name starts with 'J'.
SELECT employee_id, first_name
FROM employees
WHERE first_name LIKE 'J%';

-- M11. List employees with salary not in the range 5000 to 10000.
SELECT employee_id, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 10000;

-- M12. Get employees whose job_id contains 'CLERK'.
SELECT employee_id, job_id
FROM employees
WHERE job_id LIKE '%CLERK%';

-- M13. List employees with commission_pct greater than 0.2.
SELECT employee_id, commission_pct
FROM employees
WHERE commission_pct > 0.2;

-- M14. Find the 10 most recently hired employees.
SELECT employee_id, first_name, hire_date
FROM employees
ORDER BY hire_date DESC
FETCH FIRST 10 ROWS ONLY;

-- M15. List employees in departments 50 or 60, ordered by department_id then salary descending.
SELECT employee_id, department_id, salary
FROM employees
WHERE department_id IN (50, 60)
ORDER BY department_id ASC, salary DESC;

-- M16. Get employees whose last_name has exactly 5 characters.
SELECT employee_id, last_name
FROM employees
WHERE last_name LIKE '_____';

-- M17. List departments where manager_id is not null.
SELECT department_id, department_name, manager_id
FROM departments
WHERE manager_id IS NOT NULL;

-- M18. Find employees with salary >= 10000, ordered by salary ascending.
SELECT employee_id, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary ASC;

-- M19. List employees whose email ends with '.com' or contains 'example'.
SELECT employee_id, email
FROM employees
WHERE email LIKE '%.com'
OR email LIKE '%example%';

-- M20. Get distinct job_id values from employees in department 50.
SELECT DISTINCT job_id
FROM employees
WHERE department_id = 50;

