--DCL and TCL
-- (a) First update
UPDATE hr_emp_backup SET salary = salary * 1.05 WHERE employee_id = 100;

-- (b) Savepoint
SAVEPOINT after_first;

-- (c) Second update
UPDATE hr_emp_backup SET salary = salary * 1.10 WHERE employee_id = 101;

-- (d) Rollback to savepoint (undoes only the second update)
ROLLBACK TO SAVEPOINT after_first;

-- (e) Commit
COMMIT;

--M1. After updating one row in hr_emp_backup, issue COMMIT. Then run a SELECT to verify.
update emp_backup
set salary = salary + 1000
where employee_id = 100;

commit;

select * from emp_backup
where employee_id = 100;

--M2. Update two different rows in hr_emp_backup, then ROLLBACK. Verify both changes are undone.
update emp_backup
set salary = salary + 500
where employee_id = 101;

update emp_backup
set salary = salary + 500
where employee_id = 102;

rollback;

select * from emp_backup where employee_id in (101,102);

--M3. Create a savepoint after one UPDATE, then do another UPDATE, then ROLLBACK TO SAVEPOINT. What is the state before COMMIT?
update hr_emp_backup
set salary = salary + 200
where employee_id = 103;

savepoint sp1;

update emp_backup
set salary = salary + 300
where employee_id = 104;

rollback to sp1;

select *
from emp_backup
where employee_id in (103,104);

--M4. Write the SQL to GRANT SELECT on hr.employees to a role named hr_select_role (run as HR if you have access).
create role select_role;

grant select on employees to select_role;

--M5. Revoke SELECT on hr.departments from a user (use a placeholder user name).
--Hint: REVOKE SELECT ON hr.departments FROM some_user;
revoke select on departments from some_user;

--M6. In one transaction, update salary for employee_id 100, create savepoint sp1, update salary for employee_id 101, then ROLLBACK TO sp1, then COMMIT. Who has the new salary?
--Hint: Only employee 100; 101's update was rolled back.
update emp_backup
set salary = salary + 1000
where employee_id = 100;

savepoint sp1;

update emp_backup
set salary = salary + 1000
where employee_id = 101;

rollback to sp1;

commit;

--M7. Grant INSERT and UPDATE on hr_emp_backup to a role (your own backup table in your schema).
---Hint: GRANT INSERT, UPDATE ON hr_emp_backup TO your_role;
grant insert, update on emp_backup to your_role;

--M8. Run UPDATE on hr_emp_backup for 3 rows, then ROLLBACK. Check SQL%ROWCOUNT after UPDATE (in PL/SQL) and after ROLLBACK.
--Hint: After UPDATE, SQL%ROWCOUNT = 3; after ROLLBACK, the updates are undone.


--M9. Create a role hr_report and grant it SELECT on hr.employees and hr.departments.
--Hint: CREATE ROLE hr_report; GRANT SELECT ON hr.employees TO hr_report; GRANT SELECT ON hr.departments TO hr_report;
create role hr_report;

grant select on employees to report;
grant select on departments to report;

--M10. After a DELETE from hr_emp_backup, do not COMMIT. In another session (or same), can you see the deleted rows before COMMIT?
--Hint: In the same session, the rows are gone; in another session with read consistency, they may still be visible until the first session commits.
delete from emp_backup
where employee_id = 105;

select *
from emp_backup
where employee_id = 105;

--M11. Write a script: UPDATE one row, SAVEPOINT a, UPDATE another row, SAVEPOINT b, UPDATE a third row, ROLLBACK TO SAVEPOINT a, then COMMIT. Which rows are updated permanently?
--Hint: Only the first update; second and third are rolled back.
update emp_backup
set salary = salary + 200
where employee_id = 106;

savepoint a;

update emp_backup
set salary = salary + 200
where employee_id = 107;

savepoint b;

update emp_backup
set salary = salary + 200
where employee_id = 108;

rollback to a;

commit;

--M12. Grant SELECT on hr.employees to a user. Then revoke it.
--Hint: GRANT SELECT ON hr.employees TO user1; REVOKE SELECT ON hr.employees FROM user1;
grant select on employees to user1;

revoke select on employees from user1;

--M13. In a single transaction, run two UPDATEs on hr_emp_backup (different departments). Then COMMIT. How many rows are committed?
--Hint: All rows updated by both UPDATEs are committed together.
update emp_backup
set salary = salary + 100
where department_id = 10;

update emp_backup
set salary = salary + 100
where department_id = 20;

commit;

--M14. Create a role and grant it only SELECT on hr.departments (no other tables).
--Hint: CREATE ROLE dept_reader; GRANT SELECT ON hr.departments TO dept_reader;
create role dept_reader;

grant select on departments to dept_reader;

--M15. After an UPDATE, run SELECT to verify, then ROLLBACK. Why is ROLLBACK useful here?
--Hint: To discard the change if the SELECT showed something wrong.
update emp_backup
set salary = salary + 500
where employee_id = 109;

select *
from emp_backup
where employee_id = 109;

rollback;

--M16. Use two savepoints: after first UPDATE (sp1), after second UPDATE (sp2). Then ROLLBACK TO sp1. What happens to the second update?
--Hint: The second update is undone; first remains in the transaction.
update emp_backup
set salary = salary + 200
where employee_id = 110;

savepoint sp1;

update emp_backup
set salary = salary + 200
where employee_id = 111;

savepoint sp2;

rollback to sp1;

--M17. List the privileges you would need (as DBA) to allow a user to create a table and insert into hr.employees (conceptual).
--Hint: CREATE TABLE (system), INSERT on hr.employees (object), and possibly quota on tablespace.
grant create table to user1;

grant insert on employees to user1;

alter user user1 quota unlimited on users;

--M18. Run UPDATE on hr_emp_backup, then COMMIT. Run another UPDATE, then ROLLBACK. Is the first update still committed?
--Hint: Yes; ROLLBACK only undoes the second update.
update emp_backup
set salary = salary + 300
where employee_id = 112;

commit;

update emp_backup
set salary = salary + 300
where employee_id = 113;

rollback;

--M19. Grant a role to a user: GRANT hr_reader TO app_user; What can app_user do?
--Hint: Whatever privileges were granted to hr_reader (e.g. SELECT on hr.employees and hr.departments).
grant reader to app_user;

--M20. In one transaction, DELETE 5 rows from hr_emp_backup, then ROLLBACK. Verify the 5 rows are back.
--Hint: DELETE ... WHERE ... ; ROLLBACK; SELECT COUNT(*) should show rows restored.
delete from emp_backup
where department_id = 60;

rollback;

select count(*)
from emp_backup
where department_id = 60;
