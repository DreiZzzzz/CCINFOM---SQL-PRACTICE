-- @author Andrei Zarmin D. De Jesus

-- SQL Writing Part 2B
-- DATABASE: employees.sql

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement?

/*
	1. List all the employees, the department
	currently being or previously managed, and the
	date of assignment as manager (if they manage
	a department). Sort the list by the date of
	assignment as manager (latest assignment
	first). (Returns 300,326 rows)
*/
	SELECT s.emp_number, s.last_names, s.first_names, dm.dept_no, d.dept_name, dm.from_date, dm.to_date
	FROM staff s
	LEFT JOIN dept_manager dm ON s.emp_number = dm.emp_no
	LEFT JOIN departments d ON dm.dept_no = d.dept_no
    ORDER BY dm.from_date DESC, s.last_names, s.first_names; 
    
/*
	2. List all the employees (employee number and
	complete name), and the titles they were
	assigned (if they were assigned titles). Sort the
	list such that employees without titles appear
	first and should they have titles, sort it by
	employee name). (Returns 443,310 rows)
*/
	SELECT s.emp_number, s.last_names, s.first_names, t.title
    FROM staff s
    LEFT JOIN titles t ON s.emp_number = t.emp_no
    ORDER BY t.title ASC, s.last_names, s.first_names;

/*
	3. List all the departments (department name),
	and all the current and previous managers
	(employee number and date of assignment).
	Sort the list by department name and latest
	assignment first. (Returns 24 rows) 
*/
	SELECT d.dept_name, dm.emp_no, dm.from_date
    FROM departments d 
    INNER JOIN dept_manager dm ON d.dept_no = dm.dept_no
    ORDER BY d.dept_name, dm.from_date DESC; 

-- STARTING HERE 
-- USE @DATABASE: dbsales.sql

/*
	1. The sales manager wants to request for products
	whose quantity is below 100. Provide the information
	the manager needs by generating a list of products
	(product code, product line, product name, and
	vendor) that are below 100 pieces in stock. The
	product line and the product name should be
	combined in a single column with the following format:
	“product line: product name”. (Returns 2 rows)
*/ 
	SELECT p.productCode, CONCAT(p.productLine, ': ', p.productName), p.productVendor, p.quantityInStock
    FROM products p 
    WHERE p.quantityInStock < 100 
    ORDER BY p.productCode; 

/*
	2. The sales manager wants to see all products which are
	1999 models. (Returns 2 rows)
	NOTE: Use the SUBSTRING()/SUBSTR() function.
	SUBSTR(string,start,length)
*/
	SELECT *
    FROM products p 
    WHERE SUBSTRING(p.productName, 1, 4) = 1999
    ORDER BY p.productCode; 

/*
	3. The sales manager wants to see all products which are
	1940-1950 models. (Returns 8 rows)
	NOTE: Use the SUBSTRING()/SUBSTR() function.
	SUBSTR(string,start,length)
*/ 
	SELECT *
    FROM products p 
    WHERE SUBSTRING(p.productName, 1, 4) BETWEEN 1940 AND 1950
    ORDER BY p.productCode; 

/* 
	4. The sales manager is investigating the sales in
	2005. Provide the information about the order
	(order number, order date) and the products
	ordered (product code), and the sales amount for
	each product ordered. Only date should be
	displayed under the order date column.
	(Returns 523 rows)
*/ 
	SELECT o.orderNumber, 
		   DATE(o.orderDate) as orderDate, 
		   od.productCode, 
		   SUM(od.quantityOrdered * od.priceEach) AS sales_amount
	FROM orders o
	JOIN orderdetails od ON o.orderNumber = od.orderNumber
	WHERE YEAR(o.orderDate) = 2005
	GROUP BY o.orderNumber, o.orderDate, od.productCode;
	




