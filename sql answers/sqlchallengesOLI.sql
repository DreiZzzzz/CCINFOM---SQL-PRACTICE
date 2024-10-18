-- @author Andrei Zarmin D. De Jesus

-- SQL CHALLENGES OLI 
-- DATABASE: dbhr.qsl

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement?


-- R1: Generate the list of current employees (complete name) and
--     the complete name of their supervising manager.
--     The list are only for those whose supervising manager is
--     the same as their department manager (32 rows)
    SELECT		e.last_name, e.first_name,
		        e2.last_name	as	supervisor_lastname,
		        e2.first_name	as	supervisor_firstname,
                e2.job_id as supervisor_job_id -- extra
	FROM		employees e 
    JOIN departments d ON e.department_id=d.department_id
	JOIN employees e2  ON e.manager_id=e2.employee_id
	WHERE		e.manager_id = d.manager_id
	ORDER BY	e.last_name, e.first_name;
    
-- R2: Generate a report for each country (name), how many departments are located, and 
--     the number of employees currently assigned (4 rows)
	SELECT c.country_name, 
		   COUNT(DISTINCT d.DEPARTMENT_ID) AS totalDeptPerCountery, 
           COUNT(e.employee_id) AS total_emp
    FROM countries c
    INNER JOIN locations l ON c.country_id = l.country_id
    INNER JOIN departments d ON l.location_id = d.location_id
    INNER JOIN employees e ON d.department_id = e.department_id
    GROUP BY c.country_name
    ORDER BY total_emp DESC; 
    

-- R3: Generate a report that shows for all employees (complete name, department name,
--     country they are assigned to), how many times they changed jobs in the past 
--     (if they did). Arrange the report such that those with more salary changes
--     appear first
	   SELECT e.last_name, e.first_name, d.department_name, c.country_name, 
			  COUNT(jh.employee_id) AS total_sal_changes
       FROM employees e
       LEFT JOIN departments d ON e.department_id = d.department_id
       LEFT JOIN locations l ON d.location_id = l.location_id
       LEFT JOIN countries c ON l.country_id = c.country_id
       LEFT JOIN job_history jh ON e.employee_id = jh.employee_id
       GROUP BY e.employee_id
       ORDER BY total_sal_changes DESC; 
       

-- R4:	Generate a report that will show the jobs for each country, the number of
--      employees assigned. Show only those with more than 10 employees. (2 rows) 
		SELECT c.country_name, j.job_title, COUNT(e.employee_id) AS total_emp
        FROM jobs j 
        INNER JOIN employees e ON j.job_id = e.job_id
        INNER JOIN departments d ON e.department_id = d.department_id
        INNER JOIN locations l ON d.location_id = l.location_id
        INNER JOIN countries c ON l.country_id = c.country_id
        GROUP BY c.country_name, j.job_title
		HAVING total_emp > 10
        ORDER BY total_emp DESC; 
        
        
-- R5:	Generate the list of employees assigned to departments 
-- 		not particularly listed under the authorized list of countries 
--      (34 rows)
        SELECT		e.employee_id, e.last_name, e.first_name, l.STREET_ADDRESS
		FROM		employees e 
        LEFT JOIN departments d ON e.department_id = d.department_id
		LEFT JOIN locations l   ON d.location_id = l.location_id
		LEFT JOIN countries c   ON l.country_id = c.country_id
		WHERE		c.country_ID IS NULL 
		AND 		d.department_id IS NOT NULL
		ORDER BY	e.last_name, e.first_name;
        
        -- USING subquerries
        SELECT		e.employee_id, e.last_name, e.first_name
		FROM		employees e 
        JOIN departments d ON e.department_id=d.department_id
		JOIN locations l   ON d.location_id=l.location_id
		WHERE		l.country_id NOT IN (	SELECT 	country_id
							FROM	countries	 )
		ORDER BY	e.last_name, e.first_name;
        
        
-- R6:	Generate the list of all commission-based employees (complete name,
--      department name and current job title) that are not assigned   
--      to an authorized country. Include in the report the number of
--      past jobs they had. (34 rows) 
		-- own solution => right as well 
		SELECT e.last_name, e.first_name, d.department_name, j.job_title, COUNT(jh.employee_id) num_pastJobs
        FROM jobs j
        JOIN employees e ON j.job_id = e.job_id
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
        LEFT JOIN countries c ON l.country_id = c.country_id
        JOIN job_history jh ON e.employee_id = jh.employee_id
        WHERE e.commission_pct != 0 AND c.country_id IS NULL
        GROUP BY e.employee_id
        ORDER BY e.last_name, e.first_name;
        
        -- sub queries => the right answer
        SELECT		e.last_name, e.first_name, d.department_name, j.job_title,
					COUNT(jh.employee_id)	AS	numberofpastjobs
		FROM		employees e 
        JOIN departments d  ON e.department_id = d.department_id
		JOIN locations l    ON d.location_id   = l.location_id
		JOIN jobs j	        ON e.job_id        = j.job_id
	    JOIN job_history jh ON jh.employee_id  = e.employee_id
		WHERE		e.commission_pct != 0
		AND		l.country_id NOT IN ( SELECT country_id
							  FROM   countries )
		GROUP BY	e.employee_id
		ORDER BY	e.last_name, e.first_name;
        
        
        