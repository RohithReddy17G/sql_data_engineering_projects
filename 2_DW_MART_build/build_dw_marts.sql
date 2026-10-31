-- duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"

-- STEP 1: DW - CREATE STAR SCHEMA TABLES
.read 01_create_tables_dw.sql

-- STEP 2: DW - LOAD DATA FROM CSV FILES INTO TABLES
.read 02_load_schema_dw.sql

--STEP3 : DW - CREATE FLAT MART
.read 03_create_flat_mart.sql

---STEP 4 :DW - CREATE RECORD MART
.read 04_create_skills_mart.sql
----STEP 5 : DW -CREATE PRIORITY MART
.read 05_create_priority_mart.sql
--STEP 6: DW-UPDATE PRIORITY MART
.read 06_update_priority_mart.sql