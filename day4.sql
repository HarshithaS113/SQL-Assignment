--DML – Insert, Update, Delete

INSERT INTO hr_emp_backup (employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (999, 'John', 'Doe', 'JDOE', SYSDATE, 'SA_REP', 5000, 50);

UPDATE hr_emp_backup
SET salary = salary * 1.10
WHERE department_id = 60;

DELETE FROM hr_emp_backup
WHERE department_id IS NULL;

CREATE TABLE emp_backup AS
SELECT * FROM employees;

--M1. Insert one row into hr_emp_backup with employee_id 990, first_name 'Test', last_name 'User', salary 4000, department_id 50.
INSERT INTO emp_backup
(employee_id,first_name,last_name,email,hire_date,job_id,salary,department_id)
VALUES(990,'Test','User','TUSER',SYSDATE,'IT_PROG',4000,50);

DESC emp_backup;
--M2. Update salary to 6000 for employee_id 990 in hr_emp_backup.
update emp_backup set salary = 6000 where employee_id = 990;

--M3. Delete the row where employee_id = 990 from hr_emp_backup
delete from emp_backup where employee_id = 990;

--M4. Insert into hr_emp_backup from hr.employees only for department_id 80.
INSERT INTO emp_backup SELECT * FROM employees
WHERE department_id = 80;

--M5. Update first_name to 'Updated' for employee_id 100 in hr_emp_backup.
UPDATE emp_backup
SET first_name = 'Updated'
WHERE employee_id = 100;

--M6. Delete all rows from hr_emp_backup where department_id = 90.
DELETE FROM emp_backup
WHERE department_id = 90;

--M7. Insert two rows into hr_emp_backup (e.g. employee_id 991 and 992) using two separate INSERT statements.
INSERT INTO emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (991, 'Demo1', 'User1', 'DEMO1@COMPANY.COM',
        SYSDATE, 'IT_PROG', 5000, 50);

INSERT INTO emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (992, 'Demo2', 'User2', 'DEMO2@COMPANY.COM', SYSDATE, 'IT_PROG', 5200, 60);

COMMIT;

--M8. Update salary by 5% for all employees in hr_emp_backup in department 50.
UPDATE emp_backup
SET salary = salary * 1.05
WHERE department_id = 50;

--M9. Delete rows from hr_emp_backup where salary is NULL
DELETE FROM emp_backup
WHERE salary IS NULL;

--M10. Insert into hr_emp_backup from hr.employees where job_id = 'SA_REP' (all columns that exist in backup).
INSERT INTO emp_backup
SELECT *FROM employees
WHERE job_id = 'SA_REP';

--M11. Update department_id to 60 for employee_id 105 in hr_emp_backup.
UPDATE emp_backup
SET department_id = 60
WHERE employee_id = 105;

--M12. Delete the single row with employee_id 999 from hr_emp_backup (if it exists).
DELETE FROM emp_backup
WHERE employee_id = 999;

--M13. Insert one row with employee_id 993, last_name 'Lee', first_name 'Amy', salary 5500, department_id 60.
INSERT INTO emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (993, 'amy', 'lee', 'DEMO3@example.COM',SYSDATE, 'IT_PROG', 5500, 60);

--M14. Update last_name to 'Smith' for all employees in hr_emp_backup with first_name 'John'.
UPDATE emp_backup
SET last_name = 'Smith'
WHERE first_name = 'John';

--M15. Delete rows from hr_emp_backup where hire_date is before 2000.
DELETE FROM emp_backup
WHERE hire_date < DATE '2000-01-01';

--M16. Insert from hr.employees where salary between 5000 and 7000 into hr_emp_backup.
INSERT INTO emp_backup
SELECT *
FROM employees
WHERE salary BETWEEN 5000 AND 7000;

--M17. Update job_id to 'IT_PROG' for one specific employee (e.g. employee_id 200) in hr_emp_backup.
UPDATE emp_backup
SET job_id = 'IT_PROG'
WHERE employee_id = 200;

--M18. Delete rows from hr_emp_backup where commission_pct is not null.
DELETE FROM emp_backup
WHERE commission_pct IS NOT NULL;

--M19. Insert a row with hire_date = SYSDATE for a new employee in hr_emp_backup.
INSERT INTO emp_backup
(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (993, 'jhon', 'dorth', 'jhon@example.COM',SYSDATE, 'IT_PROG', 60000, 670);

--M20. Update salary to 10000 for the employee with the highest employee_id in hr_emp_backup (use subquery: WHERE employee_id = (SELECT MAX(employee_id) FROM hr_emp_backup)).
UPDATE emp_backup
SET salary = 10000
WHERE employee_id = (SELECT MAX(employee_id)
       FROM emp_backup);

--H1. Use MERGE to sync hr_emp_backup with hr.employees: when employee_id matches, update salary and hire_date; when not matched, insert the row from hr.employeesMERGE INTO hr_emp_backup t
MERGE INTO emp_backup t
USING employees s
ON (t.employee_id = s.employee_id)

WHEN MATCHED THEN
    UPDATE SET
        t.salary = s.salary,
        t.hire_date = s.hire_date

WHEN NOT MATCHED THEN
    INSERT VALUES (
        s.employee_id,
        s.first_name,
        s.last_name,
        s.email,
        s.phone_number,
        s.hire_date,
        s.job_id,
        s.salary,
        s.commission_pct,
        s.manager_id,
        s.department_id
    );
    
--H2. Update hr_emp_backup so that salary equals the salary from hr.employees for the same employee_id (only for employees in department 60).
UPDATE emp_backup e
SET salary =
    (SELECT salary
     FROM employees h
     WHERE h.employee_id = e.employee_id)
WHERE e.employee_id IN
      (SELECT employee_id
       FROM employees
       WHERE department_id = 60);
       
--H3. Delete from hr_emp_backup all employees who do not exist in hr.employees (e.g. test rows).
INSERT INTO emp_backup
SELECT *FROM employees e
WHERE NOT EXISTS (SELECT 1 FROM emp_backup b WHERE b.employee_id = e.employee_id);

--H4. Insert into hr_emp_backup only employees from hr.employees whose employee_id is not already in hr_emp_backup (use INSERT ... SELECT ... WHERE NOT EXISTS).
INSERT INTO emp_backup
SELECT *FROM employees e
WHERE NOT EXISTS (
SELECT 1 FROM emp_backup b WHERE b.employee_id = e.employee_id);

--H5. Update hr_emp_backup: set salary to the average salary of the department (from hr.employees) for that employee's department_id.
UPDATE emp_backup b
SET salary =(SELECT AVG(salary) FROM employees e
WHERE e.department_id = b.department_id);

--H6. Delete from hr_emp_backup the single row with the smallest employee_id.
DELETE FROM emp_backup
WHERE employee_id = (SELECT MIN(employee_id) 
FROM emp_backup);





