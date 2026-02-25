-- Create Table
CREATE TABLE Orders (
    Order_ID NUMBER PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR2(10),
    Customer_Name VARCHAR2(100),
    Product_Category VARCHAR2(100),
    Product_Name VARCHAR2(150),
    Quantity NUMBER,
    Unit_Price NUMBER(10,2),
    Payment_Mode VARCHAR2(50),
    Store_Location VARCHAR2(100)
);

-- Insert Data
INSERT ALL
    INTO Orders VALUES (1001, TO_DATE('2026-02-01','YYYY-MM-DD'), 'C001', 'Ravi Kumar', 'Electronics', 'Wireless Mouse', 2, 799, 'UPI', 'Bangalore')
    INTO Orders VALUES (1002, TO_DATE('2026-02-02','YYYY-MM-DD'), 'C002', 'Sneha Reddy', 'Grocery', 'Basmati Rice 5kg', 1, 650, 'Credit Card', 'Hyderabad')
    INTO Orders VALUES (1003, TO_DATE('2026-02-03','YYYY-MM-DD'), 'C003', 'Arjun Mehta', 'Fashion', 'Men''s T-Shirt', 3, 499, 'Cash', 'Chennai')
    INTO Orders VALUES (1004, TO_DATE('2026-02-04','YYYY-MM-DD'), 'C004', 'Priya Sharma', 'Electronics', 'Bluetooth Speaker', 1, 1499, 'Debit Card', 'Mumbai')
    INTO Orders VALUES (1005, TO_DATE('2026-02-05','YYYY-MM-DD'), 'C005', 'Kiran Rao', 'Home & Kitchen', 'Mixer Grinder', 1, 2499, 'UPI', 'Bangalore')
    INTO Orders VALUES (1006, TO_DATE('2026-02-06','YYYY-MM-DD'), 'C006', 'Neha Verma', 'Beauty', 'Face Cream', 4, 299, 'Credit Card', 'Delhi')
    INTO Orders VALUES (1007, TO_DATE('2026-02-07','YYYY-MM-DD'), 'C007', 'Rahul Das', 'Grocery', 'Cooking Oil 1L', 5, 180, 'Cash', 'Kolkata')
    INTO Orders VALUES (1008, TO_DATE('2026-02-08','YYYY-MM-DD'), 'C008', 'Anjali Nair', 'Fashion', 'Women''s Jeans', 2, 1199, 'UPI', 'Kochi')
    INTO Orders VALUES (1009, TO_DATE('2026-02-09','YYYY-MM-DD'), 'C009', 'Suresh Patel', 'Electronics', 'Smartphone', 1, 15999, 'Debit Card', 'Ahmedabad')
    INTO Orders VALUES (1010, TO_DATE('2026-02-10','YYYY-MM-DD'), 'C010', 'Meena Iyer', 'Home & Kitchen', 'Pressure Cooker', 1, 1899, 'Credit Card', 'Pune')
SELECT * FROM DUAL;

COMMIT;

select * from Orders
-- string functions

--1)Write a query to convert all customer names to uppercase.
select UPPER(Customer_Name) AS Customer_Name_Upper
FROM Orders;

--2)Extract first 5 characters from Product_Name
SELECT SUBSTR(Product_Name, 1, 5) AS First_5_Chars
FROM Orders;

--3)Find length of each Customer_Name
SELECT Customer_Name, LENGTH(Customer_Name) AS Name_Length
FROM Orders;

--4)Replace "Rice" with "Premium Rice"
select replace(product_name,'rice','premim rice') as updated_product
from orders;

--5)Remove leading and trailing spaces
select trim(customer_name) as trimmed_name
from orders;

--6)Concatenate First_Name and Last_Name as Full_Name
select customer_id , customer_name||'(customer)' as Full_name
from orders;

--7)Customers whose names start with 'A'
SELECT *FROM Orders
WHERE Customer_Name LIKE 'A%';

-- 8. Extract domain name from Email_ID


-- 9. Find position of '@' in Email_ID


-- 10. Reverse Product_Name
SELECT REVERSE(Product_Name) 
FROM Orders;

-- 11. Convert first letter of each word to uppercase
SELECT INITCAP(Product_Name) 
FROM Orders;

-- 12. Extract last 3 characters from Order_ID
SELECT SUBSTR(Order_ID,-3) 
FROM Orders;

-- 13. Count how many times letter 'a' appears in Customer_Name
SELECT Customer_Name,
LENGTH(Customer_Name) - LENGTH(REPLACE(LOWER(Customer_Name),'a',''))
FROM Orders;

-- 14. Mask last 4 digits of phone number


-- 15. Split Full_Name into First_Name and Last_Name
SELECT SUBSTR(Customer_Name,1,INSTR(Customer_Name,' ')-1) AS First_Name,
SUBSTR(Customer_Name,INSTR(Customer_Name,' ')+1) AS Last_Name
FROM Orders;

-- 16. Remove special characters from Product_Code

-- 17. Compare two columns ignoring case
SELECT *FROM Orders
WHERE UPPER(Product_Category) = UPPER(Product_Category);

-- 18. Customers whose name contains 'kumar'
SELECT Customer_Name FROM Orders
WHERE LOWER(Customer_Name) LIKE '%kumar%';

-- 19. Pad Order_ID with leading zeros (6 digits)
SELECT LPAD(Order_ID,6,'0') FROM Orders;

-- 20. Extract substring between two characters
SELECT SUBSTR(Customer_Name,
INSTR(Customer_Name,' ')+1) FROM Orders;




--NUMERICAL FUNCTIONS

-- 1. Round Unit_Price to 2 decimal places
SELECT ROUND(Unit_Price,2)
FROM Orders;

-- 2. Find total sales per order
SELECT Order_ID, Quantity * Unit_Price AS Total_Sales
FROM Orders;

-- 3. Calculate average order value
SELECT AVG(Quantity * Unit_Price)
FROM Orders;

-- 4. Find highest product price
SELECT MAX(Unit_Price) 
FROM Orders;

-- 5. Find lowest product price
SELECT MIN(Unit_Price)
FROM Orders;

-- 6. Calculate percentage discount applied
-- Example (10% discount)
SELECT Unit_Price * 0.10 AS Discount
FROM Orders;

-- 7. Find modulus of Quantity divided by 2
SELECT MOD(Quantity,2) 
FROM Orders;

-- 8. Convert negative values to positive
SELECT ABS(Unit_Price) 
FROM Orders;

-- 9. Truncate price without rounding
SELECT TRUNC(Unit_Price,2)
FROM Orders;

-- 10. Find square root of total sales
SELECT SQRT(Quantity * Unit_Price)
FROM Orders;

-- 11. Calculate exponential value
SELECT EXP(2)
FROM orders;

-- 12. Calculate power of 2^5
SELECT POWER(2,5) 
FROM dual;

-- 13. Find absolute difference between two prices
SELECT ABS(799 - 650)
FROM dual;

-- 14. Calculate sales growth percentage


-- 15. Random number between 1 and 100
SELECT ROUND(DBMS_RANDOM.VALUE(1,100)) 
FROM dual;

-- 16. Divide total sales by number of orders
SELECT SUM(Quantity*Unit_Price)/COUNT(Order_ID)
FROM Orders;

-- 17. Find ceiling value of price
SELECT CEIL(Unit_Price)
FROM Orders;

-- 18. Find floor value of price
SELECT FLOOR(Unit_Price) 
FROM Orders;

-- 19. Convert decimal to integer
SELECT ROUND(Unit_Price)
FROM Orders;

-- 20. Calculate compound interest



--date functions

--1)Extract Year from Order_Date
SELECT EXTRACT(YEAR FROM Order_Date) AS Year
FROM Orders;

--2)Extract Month from Order_Date
select extract(month from order_date) as month
from orders;

--3)extract day from order_date
select extract(day from order_date) as day
from orders;

--4)find current date
select sysdate 
from dual;

--5)find current timestamp
select systimestamp 
from dual;

--6)add 7 days to order_date
select order_date + 7 as new_date
from orders;

--7)subtract 30 days from order
select order_date - 30 as new_date
from orders;

--8)difference between 2 dates
select sysdate - order_date as differnce_date
from orders;

--9)months between 2 dates
select months_between(sysdate , order_date)
from orders;

--10) last day of month
select last_day(order_date)
from orders;

--11)GET FIRST DAY OF YEAR
select trunc(order_date, 'year')
from orders;

--12) formate date
select to_char(order_date,'dd/mm/yyyy')
from orders;

--13) string to date
select to_date('25/02/2026' , 'dd/mm/yyyy')
from orders;

--14)date to string
select to_char(order_date, 'dd-mm-yyyy')
from orders;

--15) week number of year
select to_char(order_date,'ww')
from orders;

--16) day number from date
select to_char(order_date,'dd')
from orders;

--17)quater of year
select to_char(order_date,'q')
from orders;

--18)calculate age from dob
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, DOB)/12) AS Age
FROM orders;

ALTER TABLE Orders
ADD DOB DATE;

update Orders
set DOB = to_date('15-08-2000','DD-MM-YYYY')
where Order_id = 1;

--19)check weekend 
select case when to_char(order_date,'dy','nls_date_language=english')
in('sat','sun')
then('weekend')
end as day_type
from orders;

--20)next monday after order_date
select  next_day(order_Date,'MONDAY')
from orders;



--NULL FUNCTION


--1)Replace NULL price with 0
select nvl(unit_price,0) as price
from orders;

--2)Replace NULL Customer_Name with 'Unknown'
select nvl(customer_name,'unknown')
from orders;

--3)Count NULL values in Product_Name
select count(*) as null_count
from orders
where product_name is null;

--4)Find rows where Order_Date is NULL
select * from orders where order_date is null;

--5)Use COALESCE to return first non-null value
select coalesce(customer_name,product_name,'no data')
from orders;

--6)Use NVL to replace NULL
select nvl(product_name,'not avaliable')
from orders;

--7)Use IFNULL function
select nvl(unit_price,0)
from orders;

--8)check if column is null
select * from orders where unit_price is null;

--9)check if column is not null
select * from orders where unit_price is not null

--10)use nullif between 2 columns
select nullif(quantity, unit_price)
from orders;

--11) replace blank value as null
select nullif(customer_name,'')
from orders;

--12)Count non-NULL values
select count(unit_price)
from orders;

--13)filter records where price is null or 0
select *from orders where unit_price is null or unit_price = 0
 
--14)use case to handle null
select case 
when customer_name is Null
then 'unknown' else customer_name
end as customer
from orders;

--15)Compare NULL values properly 
where unit_price is null

--16)handle null in aggregation
--sum handling null
SELECT SUM(NVL(Unit_Price,0)) AS Total_Price
FROM Orders;
--avg halndling null
select avg(nvl(unit_price,0)) as avg_price
from orders;
--count imcluding null 
select count(nvl(unit_price,0))
from orders;

--17) average excluding null values
select avg(unit_price)
from orders;

--18)sum ignoring null values
select sum(unit_price)
from orders;

--19) identify columns containg null
select column_name from user_tab_columns where table_name = 'orders' and nullable = 'y';

--20) convert null to default system date
select nvl(order_date,sysdate) as order_date
from orders;



