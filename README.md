# Exploratory Data Analysis w/SQL: Job Market Analysis

![Project 1 overview](../../images/1_1_Project1_EDA.png)

A SQL Project which analyzes Data Engineer jobs around the world and demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights.**

## EXECUTIVE
- ✅ **Project Scope:** Built **3 analytical queries** that questions about the data enginner job market
- ✅ **Data Modelling:** Used **multi-table joins** across fact and dimension tables to extract insights
- ✅ **Analytics:** Applied **aggregations ,filtering,and sortings** to find top skill by demand ,salary,and overall value
- ✅ **Outcomes :** Delivered **actionable insights** on SQL/Python dominance,cloud trends,and salary patterns
if you  can spare  a minute ,review them :

1.[Top Demand Skill Qeury](./01_top_demanded_skills.sql) - demand analytics with multi - table joins

2.[Top Paying Query](./02_top_paying.sql) - salary analysis with aggregations

3.[Most Optimal Query]( ./03_most_optimal.sql)- combined demand/salary optimization query 

## Problem & Context
Job Market analysis should answer questions as given below:
- 🎯 **Most in-demand :** Which skills are most in-demand for data engineers?*
- 💰 **highest paid:** Which skills will help us in resulting or achiveing for highest salary?*
-⚖️ **Best trade off:** *What is the optimal skill set balancing demand and compenstation?*
This Project analyzes a **data warehouse** built using a star schema design.the warehouse structure consits of : 
![Data Warehouse](../../images/1_2_Data_Warehouse.png)
- **Fact Table:** job_postings_fact -central table containing job postings
- **Dimension Tables:**
- 'company_dim' - Company information linked to job postings
- 'skills_dim' - skills catalog with skil names and types
- **Bridge Table:** 'skills_job_dim' - Resolves the many to many relationship between job postings and skills
By querying accross these interconnected tables , extracted insights about skill demand ,salary patterns ,and optimal skill combinations for data engineering roles.
## Tech Stack
- 🐤 **Query Engine:** DuckDB for Fast QLAP-style analytical queries.
-🧱 **Languages:** SQL (ANSI -style with analytical functions)
-📊 **Data Model:** Star schema with fact+ dimension+ bridge tables
- 🪛 **Development:** VS Code for sql editing +terminal for DuckDB ClI 
- 📦**Version Control:** Git/GitHub for versioned SQL scripts

## Analysis Overview
1.[Top Demand Skill Qeury](./01_top_demanded_skills.sql) - Identifies the 10 most in-demand skills for remote data enginner positions .


2.[Top Paying Query](./02_top_paying.sql) - Analyzes the 25 highest-paying skills with the salary and demand metrics

3.[Most Optimal Query]( ./03_most_optimal.sql)- Calculates an optimal score using natural log of demand combined with median salary to identify the most valulavle skills to learn 
### Key Insights
- 🧠 Core languages: SQL and Python each appear in ~29,000 job postings,making them the most demanded skills 
- ☁️ cloud platform :AWS and Azure are critical for modern data engineering roles-
- 🧱 infra & tooling: Kubernetes ,Docker,and Terraform are associated with premium salaries 
- 🔥 Big data tools: Apache Spark shows strong demand with competitive compensation
## SQL Skills Demonstration
### Query Design & Optimization
- 🔗 **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- 📊 **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- 🔍 **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- 📈 **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis
### 📊 Data Analysis Techniques

- 🗂️ **Grouping:** `GROUP BY` for categorical analysis by skill
- ⚙️ **Conditional Logic:** `CASE WHEN` statements for derived metrics
- 🧮 **Mathematical Functions:** `LN()` for natural logarithm transformation to normalize demand metrics
- 🎯 **Calculated Metrics:** Derived optimal score combining log-transformed demand with median salary
- 🔢 **HAVING Clause:** Filtering aggregated results (skills with ≥ 100 postings)
- 🧹 **NULL Handling:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)