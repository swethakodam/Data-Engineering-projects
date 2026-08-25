/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT skills_dim.skills, MEDIAN(job_postings_fact.salary_year_avg) AS median1,
COUNT(job_postings_fact.*) AS demand_count, 
DENSE_RANK() OVER (ORDER BY ROUND((MEDIAN(job_postings_fact.salary_year_avg)*ROUND(LN(COUNT(job_postings_fact.*)),1)),0) DESC) AS optimal_score
FROM skills_dim
INNER join skills_job_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN job_postings_fact
ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE job_postings_fact.job_title_short = 'Data Engineer' AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skills
HAVING COUNT(skills_dim.skills)>100

LIMIT 20
;
/*
┌────────────┬───────────────┬──────────────┬───────────────┐
│   skills   │    median1    │ demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     int64     │
├────────────┼───────────────┼──────────────┼───────────────┤
│ terraform  │      184000.0 │         3248 │             1 │
│ python     │      135000.0 │        28776 │             2 │
│ airflow    │      150000.0 │         9996 │             3 │
│ aws        │   137320.3125 │        17823 │             4 │
│ sql        │      130000.0 │        29221 │             5 │
│ spark      │      140000.0 │        12799 │             6 │
│ kafka      │      145000.0 │         6415 │             7 │
│ golang     │      184000.0 │          912 │             8 │
│ kubernetes │      150500.0 │         4202 │             9 │
│ snowflake  │      135500.0 │         8639 │            10 │
│ azure      │      128000.0 │        14143 │            11 │
│ java       │      135000.0 │         7267 │            12 │
│ gcp        │      136000.0 │         6446 │            13 │
│ databricks │      132750.0 │         8183 │            14 │
│ scala      │ 137290.484375 │         6304 │            15 │
│ pyspark    │      140000.0 │         4898 │            16 │
│ git        │      140000.0 │         4641 │            17 │
│ hadoop     │      135000.0 │         5447 │            18 │
│ rust       │      210000.0 │          232 │            19 │
│ docker     │      135000.0 │         4316 │            19 │
├────────────┴───────────────┴──────────────┴───────────────┤
│ 20 rows                                         4 columns │
*/