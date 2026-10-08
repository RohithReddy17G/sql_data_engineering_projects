 /*
We will take the median salary of Data Engineer posts,
focus on remote jobs, and compare skill demand with salary.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    ROUND(LN(COUNT(jpf.job_id)), 2) AS ln_demand_count,
    ROUND(
        (MEDIAN(jpf.salary_year_avg) * COUNT(jpf.job_id)) / 100000,
        2
    ) AS optimal_score,
    COUNT(jpf.job_id) AS demand_count

FROM job_postings_fact AS jpf

INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE

GROUP BY
    sd.skills

HAVING
    COUNT(jpf.job_id) > 1000

ORDER BY
    demand_count DESC

LIMIT 25;
/*
   skills   │ median_salary │ ln_demand_count │ optimal_score │ demand_count │
│  varchar   │    double     │     double      │    double     │    int64     │
├────────────┼───────────────┼─────────────────┼───────────────┼──────────────┤
│ sql        │      130000.0 │           10.28 │       37987.3 │        29221 │
│ python     │      135000.0 │           10.27 │       38847.6 │        28776 │
│ aws        │      137320.0 │            9.79 │       24474.6 │        17823 │
│ azure      │      128000.0 │            9.56 │      18103.04 │        14143 │
│ spark      │      140000.0 │            9.46 │       17918.6 │        12799 │
│ airflow    │      150000.0 │            9.21 │       14994.0 │         9996 │
│ snowflake  │      135500.0 │            9.06 │      11705.85 │         8639 │
│ databricks │      132750.0 │            9.01 │      10862.93 │         8183 │
│ java       │      135000.0 │            8.89 │       9810.45 │         7267 │
│ gcp        │      136000.0 │            8.77 │       8766.56 │         6446 │
│ kafka      │      145000.0 │            8.77 │       9301.75 │         6415 │
│ scala      │      137290.0 │            8.75 │       8654.79 │         6304 │
│ redshift   │      130000.0 │            8.65 │        7458.1 │         5737 │
│ hadoop     │      135000.0 │             8.6 │       7353.45 │         5447 │
│ pyspark    │      140000.0 │             8.5 │        6857.2 │         4898 │
│ git        │      140000.0 │            8.44 │        6497.4 │         4641 │
│ power bi   │      120000.0 │            8.43 │        5520.0 │         4600 │
│ nosql      │      134415.0 │            8.41 │       6067.49 │         4514 │
│ tableau    │      115000.0 │            8.39 │        5062.3 │         4402 │
│ docker     │      135000.0 │            8.37 │        5826.6 │         4316 │
│ kubernetes │      150500.0 │            8.34 │       6324.01 │         4202 │
│ sql server │      120000.0 │            8.28 │        4717.2 │         3931 │
│ bigquery   │      135000.0 │            8.17 │       4756.05 │         3523 │
│ mongodb    │      135750.0 │            8.16 │       4767.54 │         3512 │
│ postgresql │      122500.0 │            8.12 │        4116.0 │         3360 │
├────────────┴───────────────┴─────────────────┴───────────────┴──────────────┤
│ 25 rows                                                           5 columns │
└─────────────────────────────────────────────────────────────────────────────┘
*/