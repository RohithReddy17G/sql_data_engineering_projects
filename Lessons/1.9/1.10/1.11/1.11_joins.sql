SELECT 
  job_title,
  job_title_short,
  cd.name AS company_name,
  jpf.job_location
  FROM
  job_postings_fact AS jpf
  FULL OUTER JOIN company_dim AS cd
      ON jpf.company_id = cd.company_id;
SELECT*
FROM Skills_job_dim
LIMIT 10;
select * 
FROM skills_dim
LIMIT 10;
SELECT  
 jpf.job_id,
jpf.job_title_short,
sjd.skill_id,
sd.skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
    