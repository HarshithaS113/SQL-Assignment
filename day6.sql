--M1. Show employee_id, first_name, and LENGTH(last_name) as last_name_length.
select employee_id, first_name, length(last_name) as last_name_length
from employees;

--M2. List employees hired in 2004 using EXTRACT(YEAR FROM hire_date).
select *from employees
where extract(year from hire_date) = 2004;

--M3. Add a column job_type: 'Sales' if job_id like 'SA%', else 'Other'. Use CASE.
select employee_id, job_id,
case
    when job_id like 'sa%' then 'sales'
    else 'other'
end as job_type
from employees;

--M4. Show first_name, last_name, and tenure in months (MONTHS_BETWEEN(SYSDATE, hire_date)).
select first_name, last_name,
months_between(sysdate, hire_date) as tenure_months
from employees;

--M5. List employees with salary between 4000 and 8000 and department_id 50 or 60. Use parentheses.
select *from employees
where salary between 4000 and 8000
and (department_id = 50 or department_id = 60);

--M6. Display employee_id, salary, and salary_level: 'Tier1' if salary < 5000, 'Tier2' if < 10000, else 'Tier3'.
select employee_id, salary,
case
    when salary < 5000 then 'tier1'
    when salary < 10000 then 'tier2'
    else 'tier3'
end as salary_level
from employees;

--M7. Show last_name and INITCAP(last_name).
select last_name, initcap(last_name)
from employees;

--M8. List employees where department_id is in the set (10, 20, 30) from hr.departments
select *
from employees where department_id in (
    select department_id
    from departments
    where department_id in (10,20,30)
);

--M9. Add column hire_month as EXTRACT(MONTH FROM hire_date).
select employee_id, extract(month from hire_date) as hire_month
from employees;

--M10. Show phone_number and COALESCE(phone_number, 'No Phone').
select phone_number,
coalesce(phone_number, 'no phone') as contact
from employees;

--M11. List employees with (department_id = 50 AND salary > 5000) OR (department_id = 60).
select * from employees
where (department_id = 50 and salary > 5000)
or department_id = 60;

--M12. Display hire_date and ADD_MONTHS(hire_date, 12) as one_year_later.
select hire_date,
add_months(hire_date, 12) as one_year_later
from employees;

--M13. Show first_name, last_name, and SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) as initials.
select first_name, last_name,
substr(first_name,1,1) || substr(last_name,1,1) as initials
from employees;

--M13. Show first_name, last_name, and SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) as initials.
select first_name, last_name,
substr(first_name,1,1) || substr(last_name,1,1) as initials
from employees;
--M14. List employees hired after 2006-01-01.
select *
from employees
where hire_date > date '2006-01-01';

--M15. Add column has_commission: 'Yes' if commission_pct is not null, 'No' otherwise. Use NVL2 or CASE.
select employee_id,
nvl2(commission_pct, 'yes', 'no') as has_commission
from employees;

--M16. Show salary and ROUND(salary, -2) (rounded to nearest hundred).
select salary,
round(salary, -2) as salary_rounded
from employees;

--M17. List employees where job_id is SA_REP or SA_MAN and salary > 8000.
select *
from employees
where job_id in ('sa_rep','sa_man')
and salary > 8000;

--M18. Display employee_id, hire_date, and TRUNC(hire_date) (same day at midnight).
select employee_id, hire_date,
trunc(hire_date) as hire_day
from employees;

--M19. Show last_name and LOWER(last_name).
select last_name,
lower(last_name) as last_lower
from employees;

--M20. List employees with tenure (MONTHS_BETWEEN/12) >= 10 years.
select *
from employees
where months_between(sysdate, hire_date)/12 >= 10;






