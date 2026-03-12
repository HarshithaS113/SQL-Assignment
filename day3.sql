CREATE TABLE hr_emp_backup AS
SELECT * FROM employees;

ALTER TABLE hr_emp_backup ADD notes VARCHAR2(200);

alter table hr_emp_backup rename COLUMN notes TO remarks;

-- M1. Create a table hr_dept_backup as a full copy of hr.departments.
create table hr_dept_backup as 
select * from departments;

--M2. Add a column notes VARCHAR2(100) to hr_emp_backup.
alter table hr_dept_backup add notes varchar2(100);

--M3. Create a table emp_50 from employees in department 50 only (all columns).
create table emp_50 as 
select*from employees where department_id = 50;

--M4. Add column updated_at DATE DEFAULT SYSDATE to your backup table.
alter table hr_dept_backup add updated_at date default sysdate;

--M5. Create a table dept_names with only department_id and department_name from hr.departments.
create table dept_names as select 
department_id,department_name from departments;

--M6. Modify column notes in hr_emp_backup to VARCHAR2(500).
alter table hr_emp_backup modify notes varchar2(500); 

--M7. Create an empty table emp_structure with the same structure as hr.employees (no rows).
create table emp_structure as select*from employees where 1 = 0;

--M8. Rename table hr_emp_backup to hr_employees_archive.
rename hr_emp_backup to hr_employees_archive;

--M9. Add two columns to a backup table: created_by VARCHAR2(50) and created_date DATE.
alter table hr_employees_archive 
add( created_by VARCHAR2(50), created_date DATE);
    
--M10. Create table high_earners from hr.employees where salary > 10000 (all columns).
create table high_earner as select * from employees where salary > 10000;

--M11. Drop the column notes from your backup table.
alter table hr_employees_archive drop column notes;

DESC hr_employees_archive;

--M12. Create table emp_salary_dept with only employee_id, salary, department_id from hr.employees.
Create table emp_salary_dept as select employee_id, salary, department_id from employees;

--M13. Truncate the table emp_50 (or whatever copy table you created).
 Truncate table emp_50;

--M14. Rename column remarks to comments in your backup table.
ALTER TABLE hr_employees_archive
RENAME COLUMN remarks TO comments;

--M15. Create a table dept_emp_count with department_id and a literal 0 as column emp_count (one row per department).
create table dept_emp_count as select department_id,0 as emp_count
from employees;

--M16. Add column status VARCHAR2(20) DEFAULT 'ACTIVE' to a backup table.
ALTER TABLE hr_employees_archive
ADD status VARCHAR2(20) DEFAULT 'ACTIVE';

--M17. Create table emp_hire_2005 from hr.employees where EXTRACT(YEAR FROM hire_date) = 2005.
CREATE TABLE emp_hire_2005
AS SELECT *FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 2005;

--M18. Modify column status to VARCHAR2(30).
ALTER TABLE hr_employees_archive
MODIFY status VARCHAR2(30);

--M19. Create an empty table with the same structure as hr.departments. Name it dept_template.
CREATE TABLE dept_template
AS SELECT * FROM departments
WHERE 1 = 0;

--M20. Add column audit_id NUMBER(10) to your backup table.
ALTER TABLE hr_employees_archive
ADD audit_id NUMBER(10);


--H1. Create a table emp_dept_summary that has one row per department with columns department_id, department_name (from hr.departments), and a computed column total_sal (use a subquery or join to get SUM(salary) per department).
Create table emp_dept_summary as select d.department_id, d.department_name
(SELECT SUM(e.salary) FROM employees 
        WHERE e.department_id = d.department_id) AS total_sal
from departments d;

CREATE TABLE emp_dept_summary AS
SELECT d.department_id,
       d.department_name,
       (SELECT SUM(e.salary)
        FROM employees e
        WHERE e.department_id = d.department_id) AS total_sal
FROM departments d;

--using join 

CREATE TABLE emp_dept_summary AS
SELECT d.department_id,
       d.department_name,
       SUM(e.salary) AS total_sal
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

--H2. Create table emp_backup_80 from hr.employees for department 80, but only columns employee_id, first_name, last_name, salary, commission_pct.
CREATE TABLE emp_backup_80 AS
SELECT employee_id, first_name,last_name,salary,commission_pct
FROM employees
WHERE department_id = 80;

--H3. Add a column full_name to a backup table and populate it with first_name || ' ' || last_name for all existing rows (requires UPDATE after ADD; then you could add a default for new rows).
ALTER TABLE hr_employees_archive
ADD full_name VARCHAR2(50);

--UPDATE hr_employees_archive
--SET full_name = first_name || ' ' || last_name;

--H4. Create a table that has department_id, department_name, and a column manager_name (you would need to join hr.departments with hr.employees on manager_id to get manager's name).
CREATE TABLE dept_with_mgr AS
SELECT d.department_id, d.department_name, e.first_name || ' ' || e.last_name AS manager_name
FROM hr.departments d
LEFT JOIN hr.employees e
ON d.manager_id = e.employee_id;

--H5. Create table emp_job_salary with columns job_id, min_sal, max_sal, avg_sal (use GROUP BY job_id with MIN, MAX, AVG on salary from hr.employees).
CREATE TABLE emp_job_salary AS
SELECT job_id, MIN(salary) AS min_sal, MAX(salary) AS max_sal, AVG(salary) AS avg_sal
FROM Semployees
GROUP BY job_id;




