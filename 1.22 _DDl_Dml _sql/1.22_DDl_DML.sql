CREATE OR REPLACE TABLE staging.job_postings_flatt AS
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
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;

SELECT COUNT(*)
FROM staging.job_postings_flatt;

CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT
    jpf.*
FROM staging.job_postings_flatt AS jpf
JOIN main.priority_roles AS r
    ON jpf.job_title_short = r.role_name
WHERE r.priority_lvl = 1;

ALTER TABLE main.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

SELECT *
FROM main.priority_roles;

UPDATE main.priority_roles
SET role_name = 'Data Engineer'
WHERE role_id = 1;

UPDATE main.priority_roles
SET role_name = 'Senior Data Engineer'
WHERE role_id = 2;

UPDATE main.priority_roles
SET role_name = 'Data Analyst'
WHERE role_id = 3;

SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;
CREATE TEMPORARY TABLE senior_jobs_flat_temp AS 
SELECT  *
FROM staging.priority_jobs_flat_view
WHERE job_title_short = 'Senior Data Enginner';
SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM senior_jobs_flat_temp
GROUP BY job_title_short
ORDER BY job_count DESC;
SELECT COUNT(*)
FROM jobs_mart.staging.job_postings_flatt;

SELECT COUNT(*)
FROM jobs_mart.staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;

SELECT COUNT(*)
FROM senior_jobs_flat_temp;
DELETE jobs_mart.staging.priority_jobs_flat_view
WHERE job_posted_date = '2024-01-01';
SELECT COUNT(*)
FROM jobs_mart.staging.job_postings_flatt;

SELECT COUNT(*)
FROM jobs_mart.staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;
SELECT COUNT(*)
FROM senior_jobs_flat_temp;
SELECT table_catalog, table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'senior_jobs_flat_temp';
SELECT COUNT(*)
FROM staging.senior_jobs_flat_temp;
SELECT COUNT(*) FROM senior_jobs_flat_temp;
SHOW TABLES;
DESCRIBE jobs_mart.staging.job_postings_flatt;
CREATE TEMP TABLE senior_jobs_flat_temp A
FROM jobs_mart.staging.job_postings_flatt;
SELECT *
FROM jobs_mart.staging.job_postings_flatt;
SELECT COUNT(*) FROM senior_jobs_flat_temp;
TRUNCATE TABLE jobs_mart.staging.job_postings_flatt;

INSERT INTO jobs_mart.staging.job_postings_flatt
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
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_posted_date >= '2024-01-01';

SELECT * FROM jobs_mart.staging.job_postings_flatt;
SELECT * FROM jobs_mart.staging.priority_jobs_flat_view;
SELECT * FROM senior_jobs_flat_temp;