USE data_jobs;
DROP DATABASE IF EXISTS jobs_mart;
CREATE DATABASE IF NOT EXISTS jobs_mart;
SHOW DATABASES;

SELECT *
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

DROP SCHEMA IF EXISTS staging;

CREATE TABLE IF NOT EXISTS main.preferred_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR(100)
);
SELECT *
FROM information_schema.tables
WHERE table_name = 'preferred_roles';
SELECT table_catalog, table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'preferred_roles';
 INSERT INTO main.preferred_roles(role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Data Analyst');

SELECT *
FROM main.priority_lvl;

    ALTER TABLE main.preferred_roles
    ADD COLUMN preferred_role BOOLEAN;
    DESCRIBE main.preferred_roles;



UPDATE main.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 2 OR role_id = 3;
UPDATE main.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 1;
ALTER TABLE main.preferred_roles
RENAME COLUMN priority_roles TO priority_lvl;
ALTER TABLE main.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;
UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;
SELECT *
FROM main.priority_roles;
SELECT current_database();
SHOW DATABASES;
SELECT table_catalog, table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'preferred_roles';
USE jobs_mart;
SHOW TABLES;