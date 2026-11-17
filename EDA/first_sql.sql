SELECT * FROM job_postings_fact LIMIT 10;

SELECT COUNT(job_id), COUNT(DISTINCT company_id) FROM job_postings_fact;
SELECT  COUNT(DISTINCT company_id) FROM company_dim;

SELECT COUNT(*)
FROM job_postings_fact AS jpf
LEFT OUTER JOIN skills_job_dim AS sjd 
INNER JOIN 


    ON sjd.job_id = jpf.job_id
LIMIT 50;


-- 1. Create the table structure
-- CREATE TABLE Customers (
--     CustomerID INT PRIMARY KEY,
--     CustomerName VARCHAR(100) NOT NULL
-- );

-- -- 2. Insert your sample data
-- INSERT INTO Customers (CustomerID, CustomerName) VALUES 
-- (1, 'Alice'),
-- (2, 'Bob'),
-- (3, 'Charlie');

-- CREATE TABLE Orders (
--     OrderID INT PRIMARY KEY,
--     CustomerID INT NOT NULL,
--     Product VARCHAR(50) NOT NULL
-- );

-- INSERT INTO Orders (OrderID, CustomerID, Product)
-- VALUES 
--     (101, 1, 'Laptop'),
--     (102, 2, 'Phone'),
--     (103, 9, 'Tablet');
DESCRIBE Customers;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT * FROM Customers
FULL OUTER Join Orders
ON Customers.CustomerID = Orders.CustomerID;


SELECT
    jpf.job_id, jpf.job_title_short, jpf.job_location, jpf.job_work_from_home, cd.name
FROM
    job_postings_fact AS jpf
INNER Join company_dim AS cd
ON jpf.company_id= cd.company_id;

SELECT name, AVG(Marks) FROM Students

GROUP BY name
HAVING AVG(Marks) > 80;


SELECT *
FROM information_schema.columns;
DESCRIBE job_postings_fact;


SELECT 
CAST(job_work_from_home AS INT),
CAST(company_id AS float),
salary_hour_avg, salary_year_avg,
-- (CAST(salary_year_avg AS varchar) || CAST(salary_hour_avg AS varchar)) AS combine
FROM job_postings_fact;
--WHERE (CAST(salary_year_avg AS varchar) || CAST(salary_hour_avg AS varchar)) is Not NULL;


-- duckdb -c "ATTACH 'md:data_jobs'; ATTACH 'Shopping_mall.duckdb' AS local_db; COPY FROM DATABASE data_jobs TO local_db;"



