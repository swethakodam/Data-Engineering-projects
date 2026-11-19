ATTACH IF NOT EXISTS 'data_jobs.duckdb' AS data_jobs;
ATTACH IF NOT EXISTS 'job_mart.duckdb' AS job_mart;



CREATE OR REPLACE TABLE job_mart.main.priority_roles_snapshot(   -- creating priority soles snapshot in job mart stagging schema
-- SELECT JPF.job_id, JPF.job_title_short,
-- CD.company_id,
-- JPF.job_work_from_home,
-- CD.name AS Company_name,
-- PR.priority_lvl,
-- JPF.job_location,
-- CURRENT_TIMESTAMP as updated_at,
-- JPF.salary_year_avg
-- FROM data_jobs.job_postings_fact AS JPF
-- LEFT JOIN data_jobs.company_dim AS CD
-- ON JPF.company_id = CD.company_id
-- JOIN job_mart.Stagging.Priority_roles AS PR
-- ON PR.job_roles = JPF.job_title_short;/
    job_id  INTEGER PRIMARY KEY,
    job_title_short VARCHAR,
    company_name    VARCHAR,
    job_posted_date TIMESTAMP,
    salary_year_avg DOUBLE,
    priority_lvl INTEGER,
    updated_at TIMESTAMP
);

-- SELECT * FROM data_jobs.company_dim;

INSERT INTO job_mart.main.priority_roles_snapshot(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    tgt.priority_lvl,
    CURRENT_TIMESTAMP
FROM job_mart.stagging.job_postings_flat AS jpf
JOIN job_mart.stagging.Priority_roles AS tgt
ON jpf.job_title_short = tgt.job_roles;

 







SELECT job_title_short, COUNT(*), updated_at, priority_lvl
FROM job_mart.main.priority_roles_snapshot
GROUP BY job_title_short, updated_at, priority_lvl;

--DESCRIBE
--SELECT COUNT(*),COUNT(DISTINCT job_id) FROM job_mart.main.priority_roles_snapshot;

