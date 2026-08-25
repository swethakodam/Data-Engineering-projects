/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT skills_dim.skills, MEDIAN(job_postings_fact.salary_year_avg) AS salary, COUNT(skills_dim.skills) AS frequency
FROM job_postings_fact
INNER join skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER join skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Engineer' AND job_postings_fact.job_work_from_home = TRUE 
GROUP BY skills_dim.skills
HAVING MEDIAN(job_postings_fact.salary_year_avg) is NOT NULL AND COUNT(skills_dim.skills)>100
ORDER BY salary DESC,frequency DESC
LIMIT 30;

/*
┌────────────┬───────────┬───────────┐
│   skills   │  salary   │ frequency │
│  varchar   │  double   │   int64   │
├────────────┼───────────┼───────────┤
│ rust       │  210000.0 │       232 │
│ terraform  │  184000.0 │      3248 │
│ golang     │  184000.0 │       912 │
│ spring     │  175500.0 │       364 │
│ neo4j      │  170000.0 │       277 │
│ gdpr       │  169615.5 │       582 │
│ zoom       │  168437.5 │       127 │
│ graphql    │  167500.0 │       445 │
│ mongo      │  162250.0 │       265 │
│ fastapi    │  157500.0 │       204 │
│ bitbucket  │  155000.0 │       478 │
│ django     │  155000.0 │       265 │
│ crystal    │  154223.5 │       129 │
│ c          │  151500.0 │       444 │
│ atlassian  │  151500.0 │       249 │
│ typescript │  151000.0 │       388 │
│ kubernetes │  150500.0 │      4202 │
│ airflow    │  150000.0 │      9996 │
│ ruby       │  150000.0 │       736 │
│ css        │  150000.0 │       262 │
│ node       │  150000.0 │       179 │
│ redis      │  149000.0 │       605 │
│ ansible    │ 148798.25 │       475 │
│ vmware     │ 148798.25 │       136 │
│ jupyter    │  147500.0 │       400 │
│ visio      │  146500.0 │       105 │
│ kafka      │  145000.0 │      6415 │
│ spark      │  140000.0 │     12799 │
│ pyspark    │  140000.0 │      4898 │
│ git        │  140000.0 │      4641 │
├────────────┴───────────┴───────────┤
│ 30 rows                  3 columns │
└────────────────────────────────────┘
*/