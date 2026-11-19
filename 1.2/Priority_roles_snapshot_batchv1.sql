ATTACH IF NOT EXISTS 'data_jobs.duckdb' AS data_jobs;
ATTACH IF NOT EXISTS 'job_mart.duckdb' AS job_mart;

CREATE OR REPLACE TEMP TABLE priority_roles_batch AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    tgt.priority_lvl,
    CURRENT_TIMESTAMP AS updated_at
FROM job_mart.stagging.job_postings_flat AS jpf
JOIN job_mart.stagging.Priority_roles AS tgt
ON jpf.job_title_short = tgt.job_roles;

-- SELECT DISTINCT job_title_short FROM job_mart.stagging.job_postings_flat;

-- UPDATE job_mart.main.priority_roles_snapshot AS tgt    -- Update
-- SET priority_lvl = priority_roles_batch.priority_lvl,
--     updated_at = priority_roles_batch.updated_at
-- FROM priority_roles_batch 
-- WHERE tgt.job_id = priority_roles_batch.job_id
-- AND tgt.priority_lvl IS DISTINCT FROM priority_roles_batch.priority_lvl
-- ;



-- INSERT INTO job_mart.main.priority_roles_snapshot(    -- INSERT
--    job_id,
--     job_title_short,
--     company_name,
--     job_posted_date,
--     salary_year_avg,
--     priority_lvl,
--     updated_at
-- )
-- SELECT
--     job_id,
--     job_title_short,
--     name,
--     job_posted_date,
--     salary_year_avg,
--     priority_lvl,
--     CURRENT_TIMESTAMP
-- FROM priority_roles_batch
-- WHERE NOT EXISTS(
--     SELECT 1 FROM job_mart.main.priority_roles_snapshot WHERE priority_roles_batch.job_id = job_mart.main.priority_roles_snapshot.job_id
-- );
-- --SELECT * FROM job_mart.main.priority_roles_snapshot;

-- DELETE FROM job_mart.main.priority_roles_snapshot    -- DELETE
-- WHERE NOT EXISTS(
--     SELECT 1 FROM priority_roles_batch WHERE priority_roles_batch.job_id = job_mart.main.priority_roles_snapshot.job_id
-- );




MERGE INTO job_mart.main.priority_roles_snapshot AS tgt    -- USING MERGE METHOD
USING priority_roles_batch AS src
ON tgt.job_id = src.job_id

WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
UPDATE SET 
priority_lvl = src.priority_lvl,
updated_at = src.updated_at


WHEN NOT MATCHED THEN
INSERT(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
VALUES(
    src.job_id,
    src.job_title_short,
    src.name,
    src.job_posted_date,
    src.salary_year_avg,
    src.priority_lvl,
    src.updated_at
)


WHEN NOT MATCHED BY SOURCE THEN DELETE;

SELECT job_title_short, COUNT(*), updated_at, priority_lvl
FROM job_mart.main.priority_roles_snapshot
GROUP BY job_title_short, updated_at, priority_lvl;