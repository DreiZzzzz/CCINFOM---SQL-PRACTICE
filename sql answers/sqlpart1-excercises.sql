-- @author Andrei Zarmin D. De Jesus

-- SQL Writing Part 1
-- DATABASE: dbworld.sql 

-- GUIDE QUESTIONS IN WRITING SQL 
-- 01. What tables do we need to access?	
-- 02. What type of JOIN?			
-- 03. What are the conditions?			
-- 04. Group By and Aggregate?			
-- 05. Having? 				
-- 06. Sorting Requirement? 			


-- #1. Get all the cities of Thailand.
	SELECT ct.ID, ct.Name
    FROM city ct 
    WHERE ct.CountryCode = 'THA'
    ORDER BY ct.ID;

-- #2. Get all the cities of Thailand with a population
-- of more than 100,000.
	SELECT ct.ID, ct.Name, ct.Population
	FROM city ct 
    WHERE ct.CountryCode = 'THA' AND ct.Population > 100000
    ORDER BY ct.Population DESC;

-- #3. Get all the countries with a life expectancy of
-- 70 to 80 years old.
	SELECT c.Name, c.LifeExpectancy
    FROM country c
    WHERE c.LifeExpectancy BETWEEN 70 AND 80
    ORDER BY c.LifeExpectancy DESC;

-- #4. Get all the continents with countries having a
-- population below 1,000.
	SELECT DISTINCT c.Continent
	FROM country c
    WHERE c.Population < 1000

-- #5. Get all the countries (name, continent,
-- governmentform) that are Republics.
	SELECT c.Name, c.Continent, c.GovernmentForm
    FROM country c
    WHERE c.GovernmentForm LIKE '%Republic%'
    ORDER BY c.Name ASC; 
    
-- #6. Get all the countries that has celebrated at
-- least 100 years of independence.
	SELECT c.Name, YEAR(NOW()) - c.IndepYear AS years_indep
	FROM country c
    WHERE YEAR(NOW()) - c.IndepYear >= 100 
    ORDER BY years_indep DESC;

-- #7. Get all the districts of Bangladesh.
	SELECT DISTINCT cy.District
    FROM city cy
    WHERE cy.CountryCode = 'BGD'; 

-- #8. Get all the countries where more than 80%
-- speak Arabic.
	SELECT c.Name, cl.CountryCode, cl.Percentage
    FROM country c
    JOIN countrylanguage cl ON c.Code = cl.CountryCode 
    WHERE cl.Language = 'Arabic' 
		  AND cl.Percentage > 80; 