--Bucket Salaries
-- <25 = 'low'
-- 25 - 50 = 'medium'
-- > 50 = 'high'
SELECT 
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
        END AS salary_category
        FROM job_postings_fact
        WHERE salary_hour_avg IS NOT NULL
        LIMIT 20 ;


        --Handling Missing Data(Nulls)
        --Filter NULL salary values
        
     SELECT 
        job_title_short,
        salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
        END AS salary_category
        FROM job_postings_fact
        WHERE salary_hour_avg IS NOT NULL
        LIMIT 20 ;   
--Categorizing Categorical Values
-- Classify the 'Job_title' column values as:
-- 'Data Analyst'
-- 'Data Engineer'
--'Data Scientist'

SELECT 
        job_title,
    CASE 
        WHEN job_title LIKE '%Data' AND job_title LIKE '%Analyst%' THEN 'Data Analyst' 
         WHEN job_title LIKE '%Data' AND job_title LIKE '%Scientist' THEN 'Data Scientist' 
          WHEN job_title LIKE '%Data' AND job_title LIKE '%Engineer%' THEN 'Data Engineer' 
          ELSE 'Other'
        END AS job_title_category,
            job_title_short
     FROM job_postings_fact
     ORDER BY Random()
    LIMIT 10;

    --Conditional Aggreagation
    --Calculate Median Salaries For Different Buckets
    --< $ 100K
    -- >= $100K
    SELECT
        job_title_short,
        COUNT (*) AS total_postings,
        MEDIAN (
            CASE 
                WHEN salary_year_avg < 100_00 THEN salary_year_avg
            END

        ) AS median_low_salary,
        MEDIAN(
            CASE
                 WHEN salary_year_avg >= 100_000 THEN salary_year_avg
            END
        ) AS median_high_salary
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
       GROUP BY job_title_short;

       --Final Example:Conditional Calculations
       --Compute a Standardized_salary using Yearly salary and adjusted hourly salary(e.g 20809 hours/year)
       --Categorize salaries into tiers of :
         -- <75k'low'
         --75k -150k 'Medium'
         -->150K 'High'
WITH salaries AS (
    SELECT  
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
        END AS standardized_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
       OR salary_hour_avg IS NOT NULL
) 
SELECT 
    *,
    CASE 
        WHEN standardized_salary IS NULL THEN 'Missing'
        WHEN standardized_salary < 75000 THEN 'Low'
        WHEN standardized_salary < 150000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM salaries
ORDER BY standardized_salary ASC
LIMIT 10;