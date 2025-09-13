SELECT *
FROM employee_demographics; 

SELECT first_name,last_name,birth_date,age,age + 10
FROM employee_demographics;

#PEMDAS

# to select just unic value of a field 
SELECT DISTINCT gender
FROM employee_demographics;

-- WHERE CLAUSE // to make a condition i have to select all the fields
SELECT *
FROM employee_salary
WHERE salary >= 50000;


-- Logical operators AND OR NOT 

SELECT * 
FROM employee_demographics
WHERE gender = 'Male'
OR NOT age > 30;


-- LIKE STATEMENT 
-- % and _ 
# give all the fields but first_name start like jer... and whataver it comes after or before
#if we add % before jer 
#'a__' this means a with Two underscore means give the first_name that begins with a and two characters after it 
# no more no less
#'a__%' means begins with a and two characters 
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';




-- Group by 

SELECT gender, avg(age),max(age),min(age),COUNT(age)
FROM employee_demographics
GROUP BY gender;


-- ORDER BY ASC DESN 

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;


-- HAVIND and WHERE 
# WHERE filters rows before grouping, HAVING filters groups after grouping.
SELECT *
FROM employee_demographics
WHERE age > 50;


SELECT occupation , Avg(salary)
FROM employee_salary
GROUP BY occupation;

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation
having avg(salary) < 60000;

SELECT occupation,avg(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING avg(salary) > 75000;

-- limit and aliasing 

SELECT * 
FROM employee_demographics
ORDER BY age DESC
limit 4,1;

-- Aliasing : just to name your field 
SELECT gender,avg(age) as avg_age
FROM employee_demographics
GROUP BY gender
Having avg_age > 40;




-- ########## joins : 

-- inner join : returns only rows that have a match in both tables.

SELECT * 
FROM employee_demographics;

SELECT *
FROM employee_salary;


SELECT dem.employee_id,age,occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- Outer joins : returns all rows from one ( left or right tables )  or both tables, and fills in NULL where there is no match

SELECT * 
FROM employee_demographics;

SELECT *
FROM employee_salary;


SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;


-- Self join : A self join is when a table is joined with itself as if it were two separate tables, usually to compare rows within the same table.

SELECT * 
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- joining multiple tables : 

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;


SELECT * 
FROM parks_departments;

SELECT * 
FROM employee_salary
;



-- UNIONS : 

SELECT first_name,last_name
FROM employee_demographics
UNION ALL
SELECT first_name,last_name
FROM employee_salary;


#use case

SELECT first_name,last_name,'OLD man ' as label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name,last_name,'OLD Lady ' as label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT first_name,last_name,'HIGHLY PAID' as label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name,last_name
;


-- String function : 


-- Length : 

SELECT first_name,LENGTH(first_name)
FROM employee_salary
ORDER BY 2 ;  -- means order by the second field selected ( which is in this case the length ) 

-- UPPER and lower : 


SELECT first_name,upper(first_name),lower(last_name)
FROM employee_demographics
;

-- trim , left trim , right trim : deleting spaces 

SELECT trim('       sky               ');
SELECT ltrim('                     sky');
SELECT rtrim('sky                     ');

-- LEFT , RIGHT , substring

SELECT first_name, 
LEFT(first_name,4),
RIGHT( last_name,4),
SUBSTRING( first_name,3,2),
birth_date,
substring(birth_date,6,2) as month
FROM employee_demographics;


-- replace
SELECT first_name,replace(first_name,'a','b')
FROM employee_demographics;

-- locate

SELECT Locate('a','saif') ; 


SELECT first_name,last_name,
CONCAT(first_name,' ',last_name)
FROM employee_demographics;


-- Case statement : 


SELECT first_name,last_name,age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'OLD'
    WHEN age >= 50 THEN "on death's door"
END AS Age_brackets
FROM employee_demographics ;


SELECT sal.first_name,sal.dept_id,sal.last_name,

CASE
	WHEN dept_id = 6 THEN sal.salary * 0.1 
END as new_salary
FROM employee_salary as sal
;

-- Subqueries

SELECT * 
FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id 
	FROM employee_salary 
    WHERE dept_id = 1
);



SELECT first_name,salary,
(SELECT avg(salary)
FROM employee_salary)
FROM employee_salary
;


SELECT * 
FROM (
SELECT gender,avg(age),max(age),min(age),count(age)
FROM employee_demographics
GROUP BY gender ) as Agg_table
;


SELECT *
FROM employee_demographics;



