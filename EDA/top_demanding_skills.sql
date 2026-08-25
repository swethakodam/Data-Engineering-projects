    /*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT skills_dim.skills, COUNT(skills_dim.skills) AS demanding
FROM skills_dim
LEFT join skills_job_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
LEFT join job_postings_fact
ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE job_postings_fact.job_title_short = 'Data Engineer' AND job_postings_fact.job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY demanding DESC
LIMIT 10;

