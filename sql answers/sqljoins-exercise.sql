-- @author Andrei Zarmin D. De Jesus

-- SQL JOIN EXERCISES
-- DATABASE: employees.sql

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement?


-- R1: Generate a report showing the employees (employee no and complete name)
-- and their current longevity in the company (240124 rows)
	SELECT s.emp_number, s.last_names, s.first_names, YEAR(NOW()) - YEAR(s.hire_dates) AS cur_longevity 
	FROM staff s
    JOIN dept_emp de ON s.emp_number = de.emp_no
    WHERE YEAR(de.to_date) = '9999' 
    ORDER BY s.emp_number; 
    
-- R2: Generate a report showing the employee number, complete name,
-- and department name of current managers of the organization
-- (9 rows)
	SELECT s.emp_number, s.last_names, s.first_names, d.dept_name
	FROM staff s 
    JOIN dept_manager dm ON s.emp_number = dm.emp_no 
    JOIN departments d ON dm.dept_no = d.dept_no 
    WHERE YEAR(dm.to_date) = '9999'
    ORDER BY s.emp_number; 

-- R3: Generate a report showing all the employees
-- (employee number, complete name, department name
-- if they are assigned to a department). (Outer Join problem)
-- (331605 rows)
	SELECT s.emp_number, s.last_names, s.first_names, d.dept_name
    FROM staff s
    LEFT JOIN dept_emp de ON s.emp_number = de.emp_no
    LEFT JOIN departments d ON de.dept_no =  d.dept_no
    ORDER BY s.emp_number; 
    
    
-- R4: Generate the list of all departments (no and name) and the
-- complete name of former department managers (if there were).
-- Outer Join problem (15 rows) 
	SELECT d.dept_no, d.dept_name, s.last_names, s.first_names
	FROM departments d 
    LEFT JOIN dept_manager dm ON d.dept_no = dm.dept_no
    LEFT JOIN staff s ON dm.emp_no = s.emp_number
    WHERE YEAR(dm.to_date) != '9999' 
    ORDER BY d.dept_no; 
    

-- R5: Generate a report showing for each department (no and name)
-- the average longevity of its current employees (9 rows)
	SELECT d.dept_no, d.dept_name, AVG(YEAR(NOW()) - YEAR(de.from_date)) AS avg_longevity
    FROM departments d 
    JOIN dept_emp de ON d.dept_no = de.dept_no 
	WHERE YEAR(de.to_date) = '9999' 
    GROUP BY d.dept_no
    ORDER BY d.dept_no; 

-- R6: Generate a report showing for each employee (no and complete name)
-- the number of departments they were employed before (85108 rows)
	SELECT s.emp_number, s.last_names, s.first_names, COUNT(de.dept_no) AS num_dept_before
    FROM staff s
    INNER JOIN dept_emp de ON s.emp_number = de.emp_no
    WHERE YEAR(de.to_date) != '9999' 
    GROUP BY de.emp_no
    ORDER BY s.emp_number; 

-- R7: Generate the list of all departments (no and name) and the
-- number of current employees it employs. This list is used to
-- award the departments based on the number of employees it employs.
-- (9 rows)
	SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS num_curr_emp
	FROM departments d 
    INNER JOIN dept_emp de ON d.dept_no = de.dept_no 
    WHERE YEAR(de.to_date) = '9999' 
    GROUP BY d.dept_no
    ORDER BY num_curr_emp DESC;


