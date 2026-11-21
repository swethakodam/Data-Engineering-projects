
DROP TABLE IF EXISTS flat_mart.job_postings;

DROP SCHEMA IF EXISTS flat_mart;

CREATE SCHEMA flat_mart;

SELECT '===Loading flat_mart.job_postings===' AS info;
CREATE TABLE flat_mart.job_postings AS 

SELECT 
jpf.job_id,
jpf.job_title_short,
jpf.job_title,
jpf.job_location,
jpf.job_via,
jpf.job_schedule_type,
jpf.job_work_from_home,
jpf.search_location,
jpf.job_posted_date,
jpf.job_no_degree_mentioned,
jpf.job_health_insurance,
jpf.job_country,
jpf.salary_rate,
jpf.salary_year_avg,
jpf.salary_hour_avg,
jpf.company_id,
cd.name,
ARRAY_AGG(STRUCT_PACK(
    skill := sd.skills,
    types := sd.type
))
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
LEFT JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim as sd
ON sjd.skill_id = sd.skill_id
GROUP BY ALL;



SELECT 'flat_mart' AS table_name, COUNT(*) AS count FROM flat_mart.job_postings;

