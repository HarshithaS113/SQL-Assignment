CREATE TABLE employees (
    employee_id      NUMBER(6) PRIMARY KEY,
    first_name       VARCHAR2(20),
    last_name        VARCHAR2(25) NOT NULL,
    email            VARCHAR2(25) NOT NULL UNIQUE,
    phone_number     VARCHAR2(20),
    hire_date        DATE NOT NULL,
    job_id           VARCHAR2(10) NOT NULL,
    salary           NUMBER(8,2),
    commission_pct   NUMBER(2,2),
    manager_id       NUMBER(6),
    department_id    NUMBER(4)
);

INSERT ALL
  INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
  VALUES (301, 'Asha', 'Rao', 'ARAO', SYSDATE, 'IT_PROG', 6000)

  INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
  VALUES (302, 'Kiran', 'Das', 'KDAS', SYSDATE, 'SA_REP', 4500)

  INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
  VALUES (303, 'Manoj', 'Nair', 'MNAIR', SYSDATE, 'HR_REP', 5000)

SELECT * FROM dual;
 
select * from employees
COMMIT;

SELECT employee_id, first_name, last_name
FROM employees;

SELECT first_name || ' ' || last_name AS full_name
FROM employees;

SELECT employee_id, first_name, last_name, salary, salary * 12 AS annual_salary
FROM employees;

select distinct job_id
from employees;

select commission_pct, salary 
from employees
fetch first 10 rows only

select employee_id,'HR' as department
from employees;

select employee_id, hire_date,'employee' as record_type 
from employees;

select first_name, last_name, substr(first_name,1,1)|| substr(last_name,1,1) as initials 
from employees;

select email,'@company.com' as email_domain
from employees;


SELECT employee_id, salary, commission_pct, NVL(commission_pct, 0) AS effective_commission
FROM employees;

select employee_id, salary, salary*12 as salary, salary*12*1.1 as annual_plus_bonus
from employees;

CREATE TABLE Departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50),
    manager_id VARCHAR(10)
);

INSERT INTO Departments VALUES
('D001', 'Human Resources', 'Head Office', 'M101');

INSERT INTO Departments VALUES
('D002', 'Finance', 'Head Office', 'M102');

INSERT INTO Departments VALUES
('D003', 'Information Technology', 'Tech Park', 'M103');

select * from departments;

select department_id, department_name, manager_id,location
from departments;

select employee_id, 'Emp#' || TO_CHAR(employee_id) AS description
FROM employees;

select job_id, salary,'Standard' as salary_band
from employees;

select employee_id, first_name, last_name, last_name || ', ' || first_name AS display_name
from employees;

SELECT department_id,1 as sort_order
FROM departments;

select salary, salary*0.85 as monthly_net
from employees;

select employee_id, commission_pct,NVL(commission_pct, 0) as commission_display
from employees;

select first_name, last_name, salary,salary * (1 + NVL(commission_pct, 0)) as compensation
from employees;

SELECT department_name,'HQ' AS region
FROM departments;

select employee_id, hire_date,'years of service' as years_label
from employees;

select employee_id, salary, salary*2 as double_salary
from employees;

select manager_id, NVL2(manager_id, 'Yes', 'No') as has_manager
from employees;

select department_id, department_name,SUBSTR(department_name, 1, 3) AS dept_code
from departments;



SELECT employee_id, first_name,last_name,salary,
CASE WHEN salary >= 10000 THEN 'High'
     WHEN salary >= 5000 THEN 'Medium'
     ELSE 'Low'
     END AS salary_rank_label
FROM employees;


