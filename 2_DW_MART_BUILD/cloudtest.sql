
WITH tables AS (
SELECT job_title_short, salary_year_avg, skills, type
FROM job_postings_fact 
LEFT JOIN data_jobs.skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN data_jobs.skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
)


SELECT type, MEDIAN(salary_year_avg)
FROM tables
GROUP BY ALL;