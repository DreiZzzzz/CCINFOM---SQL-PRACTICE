-- @author Andrei Zarmin D. De Jesus

-- SQL Writing Part 2
-- DATABASE: dbsales.sql

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement? 


-- Get the username of employees with
-- more than 1,000 points
	SELECT * 
	FROM employee e
    WHERE e.currentpoints > 1000;

-- Get the username and complete name of
-- employees, that requested for kitchen items, include
-- the name of the item requested.
	SELECT e.username, e.completename, i.itemname, i.itemkind
    FROM employee e
    JOIN itemrequest ir ON e.username = ir.username
    JOIN items i ON ir.itemno = i .itemNo 
    WHERE i.itemkind = 'Kitchen';
    
-- 1. Generate a list of customers from Singapore.
-- (Returns 3 rows)
	SELECT *
    FROM customers c
    WHERE c.country = 'Singapore'
    ORDER BY c.customername; 

-- 2. Get the list of orders which were not fulfilled on
-- time. (Returns 2 rows)
	SELECT *
    FROM orders o 
    WHERE o.shippedDate > o.requiredDate
    ORDER BY o.orderNumber; 

-- 3. Get the total amount of payments made in
-- 2003. (Returns 1 row)
	SELECT FORMAT(SUM(o.amount), 2) AS payment_amount
    FROM payments o
    WHERE YEAR(o.paymentDate) = '2003'; 
    

-- 4. Get the total number of customers per country.
-- (Returns 27 rows)
	SELECT c.country, COUNT(c.customerNumber) AS total_customers
	FROM customers c
    GROUP BY c.country 
    ORDER BY country; 


-- 5. Get the number of products per vendor.
-- (Returns 13 rows)
	SELECT p.productVendor, COUNT(p.productCode) as total_products
	FROM products p 
    GROUP BY p.productVendor
    ORDER BY p.productVendor; 
    
-- END OF LESSON EXERCISE 

-- 1. Generate a report showing the customers (customer number and
-- complete name), the country they are located and the complete
-- name of the sales representative handling her/him. (100 rows) 
	SELECT c.customerNumber, c.customerName, c.country, CONCAT(e.firstName, ' ', e.lastName) AS sales_representative
	FROM customers c 
    JOIN employees e ON c.salesRepEmployeeNumber =  e.employeeNumber 
    ORDER BY c.customerNumber; 
    
-- 2. Generate the list of orders completed in May 2005 showing the
-- order number, the order date, shipped date, and the complete
-- name of the customer who made the order.
	SELECT o.orderNumber, o.orderDate, o.shippedDate, c.customerName 
    FROM orders o
    JOIN customers c ON o.customerNumber = c.customerNumber 
    WHERE YEAR(o.shippedDate) = '2005' AND MONTH(o.shippedDate) = '5' AND o.status = 'Shipped' 
    ORDER BY o.orderNumber; 

-- 3. Generate the list of products below 300 pieces. Show in the list
-- the product’s code and name, and the product line the product
-- belongs to.
	SELECT p.productCode, p.productName, p.productLine, p.quantityInStock
    FROM products p 
    WHERE p.quantityInStock < 300 
    ORDER BY p.productCode;

-- 4. Generate the complete directory of employees, showing their
-- complete name, email, extension number, the office code they
-- belong to as well as the office phone number.
	SELECT e.lastName, e.firstname, e.email, e.extension, e.officeCode, o.phone
	FROM employees e
    JOIN offices o ON e.officeCode = o.officeCode 
    ORDER BY e.lastName, e.firstName; 
    
    



    



