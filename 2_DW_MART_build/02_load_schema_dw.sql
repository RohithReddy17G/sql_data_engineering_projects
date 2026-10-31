--step2 Load Data From csv files into tables 

SELECT '=== Loading company_dim Table===' AS info;
INSERT INTO company_dim (company_id,name)
SELECT company_id, name
FROM read_csv('https://storage.googleapis.com/sql_de/company_dim.csv',
AUTO_DETECT =true);

SELECT '=== Loading company_dim Table===' AS info;
INSERT INTO skills_dim(skill_id,skills,type)
SELECT skill_id,skills,type
FROM read_csv('https://storage.googleapis.com/sql_de/skills_dim.csv',
AUTO_DETECT =true);

SELECT '=== Loading company_dim Table===' AS info;
INSERT INTO job_postings_fact(
    job_id, company_id, job_title_short, job_title, job_location,
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance,
    job_country, salary_rate, salary_hour_avg, salary_year_avg
)
SELECT
    job_id, company_id, job_title_short, job_title, job_location,
    job_via, job_schedule_type, job_work_from_home, search_location,
    job_posted_date, job_no_degree_mention, job_health_insurance,
    job_country, salary_rate, salary_hour_avg, salary_year_avg
FROM read_csv('https://storage.googleapis.com/sql_de/job_postings_fact.csv',
    AUTO_DETECT =true);

SELECT '=== Loading company_dim Table===' AS info;
INSERT INTO skills_job_dim(skill_id,job_id)
SELECT skill_id,job_id
FROM read_csv('https://storage.googleapis.com/sql_de/skills_job_dim.csv',
    AUTO_DETECT =true);



    SELECT 'CompanyDim' AS table_name, COUNT(*) AS record_name FROM company_dim
UNION ALL
    SELECT 'Skills Dim' ,COUNT(*) FROM skills_dim
    UNION ALL
    SELECT 'Job Postings Fact',COUNT(*) FROM job_postings_fact
    UNION ALL
    SELECT 'Skills job Dim', COUNT(*) FROM skills_job_dim


    SELECT '=== Company Dimension Sample===' AS info;
    SELECT * FROM company_dim LIMIT 5;

SELECT '=== Skills Dimension Sample===' AS info;
    SELECT * FROM skills_dim LIMIT 5;

    SELECT '=== job postings fact ===' AS info;
    SELECT * FROM job_postings_fact LIMIT 5;

    SELECT '=== Company Dimension Sample===' AS info;
    SELECT * FROM company_dim LIMIT 5;

    SELECT '=== Skills job Bridge Sample===' AS info;
    SELECT * FROM skills_job_dim LIMIT 5;