-- @author Andrei Zarmin D. De Jesus

-- SQL JOIN CHALLENGES A
-- DATABASE: employees.sql

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement?


-- 1. Generate a list of all the employees (employee number and complete name) hired before 1990.
-- (164797 rows) 
	SELECT s.emp_number, s.last_names, s.first_names, s.hire_dates
    FROM staff s
    WHERE YEAR(s.hire_dates) < 1990
    ORDER BY s.emp_number; 

-- 2. Generate the list of all the departments (department name) and the number of employees they currently have.
-- (9 rows) 
	SELECT d.dept_name, COUNT(de.emp_no) as num_emp
    FROM departments d 
    INNER JOIN dept_emp de ON d.dept_no = de.dept_no 
    WHERE YEAR(de.to_date) = '9999'
    GROUP BY de.dept_no
    ORDER BY num_emp DESC; 

-- 3. Generate a list of staff members (employee number and complete name), and the department (department no) they are currently assigned.
-- (240124 rows)
	SELECT s.emp_number, s.last_names, s.first_names, de.dept_no 
    FROM staff s
    INNER JOIN dept_emp de ON s.emp_number = de.emp_no
    WHERE YEAR(de.to_date) = '9999'
    ORDER BY s.emp_number; 
    

-- 4. Human Resources wanted to investigate the movements of department managers in the past. They requested for a report that shows how many
-- departments were handled by each manager in the past. The report should show the complete name of the manager and the number of departments
-- they managed in the past. (15 rows)
	SELECT s.last_names, s.first_names, COUNT(dm.dept_no) as total_dept_handled
    FROM staff s
    INNER JOIN dept_manager dm ON s.emp_number = dm.emp_no 
    WHERE YEAR(dm.to_date) != '9999'
    GROUP BY dm.emp_no 
    ORDER BY dm.emp_no ASC;
    

-- 5. Human Resources also wanted to do an audit on the titles assigned to employees. They requested for a report that shows how many employees are
-- currently assigned to each title. (7 rows)
	SELECT t.title, COUNT(t.emp_no) as total_per_title
    FROM titles t
    WHERE YEAR(t.to_date) = '9999'
    GROUP BY t.title 
    ORDER BY t.title; 

-- 6. Human Resources in its audit of titles also requested for a report showing for each employee, how many titles were or currently assigned to each
-- employee. The report should show the complete name of all the employees and the number of currently assigned or past titles given to the employee.
-- (300,024 rows)
	SELECT s.last_names, s.first_names, COUNT(t.title) AS total_titles
	FROM titles t
    INNER JOIN staff s ON t.emp_no = s.emp_number
    GROUP BY t.emp_no
    ORDER BY t.emp_no; 

-- 7. The President inquired about the total current monthly expenses for salaries.
-- (1 row => '17,291,866,123.00')
	SELECT FORMAT(SUM(s.salary), 2) AS monthly_current_expenses
    FROM salaries s
    WHERE YEAR(s.to_date) = 9999; 

-- 8. The President upon seeing the report in #4, wanted a detailed version of the report per title.
-- (7 rows)
    SELECT t.title, COUNT(t.emp_no) AS total_per_title
    FROM titles t 
    WHERE YEAR(t.to_date) != '9999'
    GROUP BY t.title
    ORDER BY t.title; 
    

-- 9. The President further wanted to know the current monthly expense for salaries per department (department name)
-- (9 rows)
    SELECT d.dept_name, FORMAT(SUM(sl.salary), 2) AS curr_monthly_dept_salary
    FROM salaries sl
    INNER JOIN staff s ON sl.emp_no = s.emp_number
    INNER JOIN dept_emp de ON s.emp_number = de.emp_no
    INNER JOIN departments d ON de.dept_no = d.dept_no
    WHERE YEAR(sl.to_date) = '9999' AND YEAR(de.to_date) = '9999'
    GROUP BY d.dept_no
    ORDER BY d.dept_no; 
	
