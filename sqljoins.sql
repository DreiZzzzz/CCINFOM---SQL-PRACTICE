-- 1. Completeness and Accuracy (What parts of the result, computations,
-- decimal places)
-- 2. Presentability (Sorting and Presentation of Results)
-- 3. Verifiability (Adding of other fields)

-- Correct/Checked
-- R1: Generate a report showing the employees (employee no and complete name)
-- and their current longevity in the company 
SELECT de.emp_no, CONCAT(s.first_names, ' ', s.last_names) AS complete_name, YEAR(NOW()) - YEAR(s.hire_dates)AS longevity
FROM dept_emp de
LEFT JOIN staff s ON de.emp_no = s.emp_number
WHERE de.to_date > DATE(NOW())
ORDER by de.emp_no ASC;


-- Correct/Checked
-- R2: Generate a report showing the employee number, complete name,
-- and department name of current managers of the organization
SELECT s.emp_number, CONCAT(s.first_names, ' ', s.last_names) as complete_name, d.dept_name
FROM staff s 
JOIN dept_manager dm ON s.emp_number = dm.emp_no 
JOIN departments d ON dm.dept_no = d.dept_no
WHERE YEAR(dm.to_date) = 9999
ORDER BY s.first_names; 

-- Correct/Checked
-- R3: Generate a report showing all the employees
-- (employee number, complete name, department name
-- if they are assigned to a department). 
-- (Outer Join problem)
SELECT s.emp_number, CONCAT(s.first_names, ' ', s.last_names) AS complete_name, d.dept_name
FROM staff s
LEFT JOIN dept_emp de ON de.emp_no = s.emp_number
LEFT JOIN departments d ON de.dept_no = d.dept_no
ORDER BY s.emp_number; 

SELECT * FROM dept_emp -- 331603 rows
SELECT * FROM staff -- 300026 rows


-- Correct/Checked
-- R4: Generate the list of all departments (no and name) and the
-- complete name of former department managers (if there were).
-- Outer Join problem
SELECT d.dept_no, d.dept_name, CONCAT(s.first_names, ' ', s.last_names) AS manager_complete_name
FROM departments d
LEFT JOIN dept_manager dm ON d.dept_no = dm.dept_no
LEFT JOIN staff s ON dm.emp_no = s.emp_number
WHERE YEAR(dm.to_date) != 9999
ORDER BY d.dept_no; 


-- Correct/Checked
-- R5: Generate a report showing for each department (no and name)
-- the average longevity of its current employees
SELECT d.dept_no, d.dept_name, AVG(YEAR(NOW()) - YEAR(de.from_date)) AS avg_emp_longevity
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE YEAR(de.to_date) = '9999'
GROUP BY d.dept_no, d.dept_name
ORDER BY avg_emp_longevity DESC; 


-- Correct/Checked
-- R6: Generate a report showing for each employee (no and complete name)
-- the number of departments they were employed before
SELECT s.emp_number, CONCAT(s.first_names, ' ', s.last_names) AS complete_name, COUNT(de.dept_no) AS total_dept_employed
FROM staff s
LEFT JOIN dept_emp de ON s.emp_number = de.emp_no
where YEAR(NOW()) > YEAR(de.to_date)
GROUP BY s.emp_number, complete_name
ORDER BY total_dept_employed DESC; 


-- Correct/Checked
-- R7: Generate the list of all departments (no and name) and the
-- number of current employees it employs. This list is used to
-- award the departments based on the number of employees it employs.
SELECT d.dept_no, d.dept_name, COUNT(dm.dept_no) AS total_emp
FROM departments d
JOIN dept_emp dm ON d.dept_no = dm.dept_no
WHERE YEAR(dm.to_date) = '9999'
GROUP BY d.dept_no, d.dept_name
ORDER BY total_emp DESC;






