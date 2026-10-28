---count rows  - aggregation only 
SELECT
    COUNT(*) 
FROM
    job_postings_fact;


---count rows - Window Function
SELECT 
    job_id,
    COUNT(*) OVER ()

FROM 
    job_postings_fact;



    --PARITION BY -Find Hourly salary
    SELECT 
        job_id,
        job_title_short,
        salary_hour_avg,
        AVG ( salary_hour_avg) OVER ( 
            PARTITION BY job_title_short 
        )
        FROM 
            job_postings_fact
            LIMIT 5 ;
   


     SELECT 
        job_id,
        job_title_short,
        salary_hour_avg,
        AVG ( salary_hour_avg) OVER ( 
            PARTITION BY job_title_short 
        )
        FROM 
            job_postings_fact
        ORDER BY 
         RANDOM()
        LIMIT 10;
        


        
       SELECT 
        job_id,
        job_title_short,
        company_id,
        salary_hour_avg,

        AVG ( salary_hour_avg) OVER ( 
            PARTITION BY job_title_short,company_id
        )
        FROM 
            job_postings_fact
        WHERE 
            salary_hour_avg IS NOT NULL 
        ORDER BY 
         RANDOM()
        LIMIT 10;



        --ORDER BY -Ranking Hourly salary 

        SELECT 
        job_id,
        job_title_short,
      
        salary_hour_avg,

     RANK() OVER ( 
            ORDER BY salary_hour_avg

        )AS rank_hourly_salary
        FROM 
            job_postings_fact
        WHERE 
            salary_hour_avg IS NOT NULL 
        ORDER BY 
         salary_hour_avg DESC 
        LIMIT 10;
        ---PARTITION BY & ORDER BY -Running Average Hourly Salary
        SELECT 
            job_posted_date,
            job_title_short,
            salary_hour_avg,
            AVG(salary_hour_avg) OVER (
                PARTITION BY  job_title_short
                ORDER BY salary_hour_avg DESC 
            )  AS rank_hourly_salary

            FROM    
                 job_postings_fact
                WHERE 
                    salary_hour_avg IS NOT NULL AND
                    job_title_short ='Data Engineer' 
                ORDER BY 
                    job_title_short,
                    job_posted_date
                LIMIT 10;



    SELECT 
        job_id,
        job_title_short,
        salary_hour_avg,

     ROW_NUMBER() OVER ( 
            ORDER BY salary_hour_avg

        )AS rank_hourly_salary
        FROM 
            job_postings_fact
        WHERE 
            salary_hour_avg IS NOT NULL 
        ORDER BY 
         salary_hour_avg DESC 
        LIMIT 20;

    --Row NUmeber () - Providing a new job_id
    SELECT 
     *,
     ROW_NUMBER() OVER(
        ORDER BY job_posted_date
     )
     FROM
        job_postings_fact
        ORDER BY 
        job_posted_date
    LIMIT 20;


    --lag() -Time Base Comparison of Company Yearly Salary
    SELECT
        job_id,
        company_id,
        job_title,
        job_title_short,
        job_posted_date,
        salary_year_avg,
        LAG(salary_year_avg) OVER(
            PARTITION BY company_id
            ORDER BY job_posted_date
        ) AS  previous_posting_salary,
        salary_year_avg,
        LAG(salary_year_avg) OVER(
            PARTITION BY company_id
            ORDER BY job_posted_date
        ) AS salary_change,
    FROM    
        job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    ORDER BY company_id ,job_posted_date
    LIMIT 60;
