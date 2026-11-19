ATTACH IF NOT EXISTS 'data_jobs.duckdb' AS data_jobs;
ATTACH IF NOT EXISTS 'job_mart.duckdb' AS job_mart;

--.open job_mart.duckdb;
--CREATE SCHEMA job_mart.Stagging;   
CREATE OR REPLACE TABLE job_mart.Stagging.Priority_roles(    -- --- creating priorty roles

    job_id INT,
    job_roles VARCHAR,
    priority_lvl INT
);


INSERT INTO job_mart.Stagging.Priority_roles(job_id,job_roles,priority_lvl)
VALUES
    (1, 'Data Engineer', 1), 
    (2, 'Data Analyst', 1),
    (3, 'Senior Data Engineer', 3),
    (4, 'Machine Learning Engineer', 2)
;


SELECT * FROM job_mart.Stagging.Priority_roles;