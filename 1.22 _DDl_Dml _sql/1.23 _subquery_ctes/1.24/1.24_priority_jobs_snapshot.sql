-- Step 1: Create the snapshot table if it doesn't exist
CREATE TABLE IF NOT EXISTS main.priority_jobs_snapshot (
    job_id           INTEGER,
    job_title_short  VARCHAR,
    company_name     VARCHAR,
    job_posted_date  TIMESTAMP,
    salary_year_avg  DOUBLE,
    priority_lvl     INTEGER,
    updated_at       TIMESTAMP
);

-- Step 2: Prepare priority jobs
CREATE OR REPLACE TEMP TABLE src_priority_jobs AS
SELECT
    jpf.job_id,
    r.role_name AS job_title_short,
    cd.name AS company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    r.priority_lvl,
    CURRENT_TIMESTAMP AS updated_at
FROM staging.priority_roles AS r
LEFT JOIN data_jobs.job_postings_fact AS jpf
    ON jpf.job_title_short = r.role_name
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;

-- Step 3: Insert new jobs and update changed jobs
MERGE INTO main.priority_jobs_snapshot AS tgt
USING src_priority_jobs AS src
ON tgt.job_id = src.job_id

WHEN MATCHED AND (
    tgt.priority_lvl IS DISTINCT FROM src.priority_lvl
    OR tgt.job_title_short IS DISTINCT FROM src.job_title_short
    OR tgt.company_name IS DISTINCT FROM src.company_name
    OR tgt.job_posted_date IS DISTINCT FROM src.job_posted_date
    OR tgt.salary_year_avg IS DISTINCT FROM src.salary_year_avg
) THEN
    UPDATE SET
        job_title_short = src.job_title_short,
        company_name = src.company_name,
        job_posted_date = src.job_posted_date,
        salary_year_avg = src.salary_year_avg,
        priority_lvl = src.priority_lvl,
        updated_at = src.updated_at

WHEN NOT MATCHED AND src.job_id IS NOT NULL THEN
    INSERT (
        job_id,
        job_title_short,
        company_name,
        job_posted_date,
        salary_year_avg,
        priority_lvl,
        updated_at
    )
    VALUES (
        src.job_id,
        src.job_title_short,
        src.company_name,
        src.job_posted_date,
        src.salary_year_avg,
        src.priority_lvl,
        src.updated_at
    );

-- Step 4: Delete jobs that no longer belong to a priority role
DELETE FROM main.priority_jobs_snapshot AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM src_priority_jobs AS src
    WHERE src.job_id = tgt.job_id
);

-- Step 5: Display the updated snapshot
SELECT *
FROM main.priority_jobs_snapshot
ORDER BY priority_lvl, job_title_short;

-- Step 6: Display all current priority roles and their job counts
SELECT
    r.role_name AS job_title_short,
    COUNT(s.job_id) AS job_count,
    r.priority_lvl,
    COALESCE(
        MIN(s.updated_at),
        CURRENT_TIMESTAMP
    ) AS updated_at
FROM staging.priority_roles AS r
LEFT JOIN main.priority_jobs_snapshot AS s
    ON r.role_name = s.job_title_short
GROUP BY
    r.role_name,
    r.priority_lvl
ORDER BY
    job_count DESC;