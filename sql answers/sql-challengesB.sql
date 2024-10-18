-- @author Andrei Zarmin D. De Jesus

-- SQL CHALLENGES B 
-- DATABASE: dbsales.sql

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement?


-- 1. Generate a report that shows the customers (customer number and name) and 
-- the total amount of completed orders they have made in 2005. Customers with 
-- the largest amount of orders appear first in the list. (Returns 36 rows)
	SELECT c.customerNumber, c.customerName, 
		   COUNT(o.orderNumber) AS total_completed_orders, 
		   FORMAT(SUM(od.quantityOrdered * od.priceEach), 2) AS total_amount
    FROM customers c
    INNER JOIN orders o ON c.customerNumber = o.customerNumber
    INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE YEAR(o.orderDate) = '2005' AND o.status = 'Shipped' 
    GROUP BY o.customerNumber
    ORDER BY total_completed_orders ASC; 


-- 2. Generate a report that shows the number and total amount of orders involving 
-- diecast 1:10 Classic Carsfor every month (month name, not month number) and year.
-- The manager is only interested in the years and months that did not reach the 
-- quota of 100,000.00. (Returns 28 rows)
    SELECT YEAR(o.orderDate) AS year_num, 
		   MONTHNAME(o.orderDate) AS monthString, 
           COUNT(od.orderNumber) AS num_orders, 
           SUM(od.quantityOrdered * od.priceEach) AS total_amount_order
    FROM orders o 
    INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber 
    INNER JOIN products p ON od.productCode = p.productCode
    WHERE p.productLine = 'Classic Cars' AND
		  p.productScale = '1:10'
	GROUP BY year_num, MONTHNAME(o.orderDate)
    HAVING total_amount_order < 100000
    ORDER BY total_amount_order DESC; 
    
    
    
-- 3. Generate a report that shows the sales representative and their sales for each year, 
-- from 2004-2005. Show the sales representative's complete name, and country he is assigned 
-- to, including the total sales the sales representative was able to generate. This report 
-- will be used to determine the top sales representatives based on sales every year. (Returns 29 rows)
    SELECT YEAR(os.orderDate) AS year_num, e.lastName, e.firstName, o.country, FORMAT(SUM(od.quantityOrdered * od.priceEach),2) AS  salesRep_totalSales
    FROM offices o 
    INNER JOIN employees e ON o.officeCode = e.officeCode 
    INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
    INNER JOIN orders os ON c.customerNumber = os.customerNumber
    INNER JOIN orderdetails od ON os.orderNumber = od.orderNumber
    WHERE YEAR(os.orderDate) BETWEEN 2004 AND 2005 
    GROUP BY c.salesRepEmployeeNumber, year_num
    ORDER BY year_num, salesRep_totalSales DESC;

-- 4. The Sales Office in Japan plans to have an event to reward customers based on their 
-- engagement with the company. They need to have a report that will show the Top 3 customers 
-- (customer number and complete name) and the average amount of orders they have made with 
-- the company from 2003 to 2005. (Returns 3 rows)
	SELECT c.customerNumber, c.customerName, FORMAT(AVG(od.quantityOrdered * od.priceEach), 2) AS avg_amount_order
    FROM offices o 
    INNER JOIN employees e ON o.officeCode = e.officeCode
    INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    INNER JOIN orders os ON c.customerNumber = os.customerNumber 
    INNER JOIN orderdetails od ON os.orderNumber = od.orderNumber
    WHERE e.officeCode = 5 AND YEAR(os.orderDate) BETWEEN 2003 AND 2005
    GROUP BY c.customerNumber
    ORDER BY avg_amount_order DESC
    LIMIT 3;


-- 5. The Sales Manager wanted to know what product lines are selling more than 200,000 from 
-- 2004 to 2005. (Returns 9 rows)
	-- product line is only 7? wtf
	-- 6 rows only
	SELECT YEAR(o.orderDate) AS yearNum, p.productLine, FORMAT(SUM(od.quantityOrdered * od.priceEach), 2) AS total_sales
	FROM orders o 
    INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber 
    INNER JOIN products p ON od.productCode = p.productCode
    WHERE YEAR(o.orderDate) BETWEEN 2004 AND 2005 
    GROUP BY yearNum, p.productLine 
    HAVING SUM(od.quantityOrdered * od.priceEach) > 200000
    ORDER BY yearNum, p.productLine; 


-- 6. There was a situation in the company that the Sales Manager discovered. The prices that 
-- non-US branches of the company do not actually reflect the real price. They discovered that the 
-- price recorded by non-US branches contain a 15% delivery fee. Delivery Fees are not part of sales. 
-- The Sales Manager asked you to prepare a report showing the monthly sales for each year, on record 
-- by non-US branches, and the true sales (removing the 15% delivery fee), and the actual delivery fee.
-- (Returns 29 rows)
	-- 30 rows 
	SELECT YEAR(os.orderDate) AS yearNum,
		   MONTHNAME(os.orderDate) AS monthString, 
		   FORMAT(SUM(od.quantityOrdered * od.priceEach), 2) AS monthly_sales, 
           FORMAT(SUM(od.quantityOrdered * od.priceEach * 0.85), 2) AS actual_sales_only,
           FORMAT(SUM(od.quantityOrdered * od.priceEach * 0.15), 2) AS delivery_fee_only
    FROM offices o
    INNER JOIN employees e ON o.officeCode = e.officeCode 
    INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
    INNER JOIN orders os ON c.customerNumber = os.customerNumber
    INNER JOIN orderdetails od ON os.orderNumber = od.orderNumber 
    WHERE o.country != 'USA'
    GROUP BY yearNum, monthString
    ORDER BY yearNum, monthString; 

	
    
	