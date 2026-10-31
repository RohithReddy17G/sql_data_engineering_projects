-- duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"

-- STEP 1: DW - CREATE STAR SCHEMA TABLES
.read 01_create_tables_dw.sql

-- STEP 2: DW - LOAD DATA FROM CSV FILES INTO TABLES
.read 02_load_schema_dw.sql