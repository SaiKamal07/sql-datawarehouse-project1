GITHUB REPOSITORY

Github Link:https://github.com/SaiKamal07/sql-datawarehouse-project1/edit/main

Data Warehouse Project Report
Project Title: CRM–ERP Data Integration Using a Layered Data Warehouse Architecture
Author: CH.PAVAN SAI
Date: 1-11-2025

Abstract
This report documents the design, implementation, and initial results of a small-scale data warehouse
project. The repository contains sample source datasets (CRM and ERP), SQL scripts for reporting, and
example views built in a layered architecture (bronze/silver/gold). The goal of the project is to consolidate
sales and product/customer data from multiple sources into a single analytical store and provide
reusable reporting views.

1. Introduction
Modern analytics require integrated, clean, and historically-aware data. This project demonstrates a
basic Data Warehouse implementation combining CRM and ERP sales data into consolidated reporting
tables/views.
2. Objectives
• Ingest source data from CRM and ERP CSV exports.
• Clean and standardize product and customer records.
• Create dimensional structures (products, customers, date) and a sales fact table.
• Provide analytical views for business reporting (e.g., customer-level KPIs, product performance).
3. Project Scope
This project focuses on a small demonstrative dataset located in datasets/ and contains SQL scripts in
scripts/. It is not a production-grade pipeline but illustrates standard DW patterns: staging, dimensional
modelling, and report creation.
4. Data Sources
The extracted repository contains the following source files (sample list):
• datasets/source_crm/cust_info.csv
• datasets/source_crm/prd_info.csv
• datasets/source_crm/sales_details.csv
• datasets/source_erp/cust_info.csv
• datasets/source_erp/prd_info.csv
• datasets/source_erp/sales_details.csv

These CSV files represent customer master, product master, and transactional sales data from two
systems (CRM and ERP).
5. Architecture and Design
The repository follows a layered approach often described as bronze/silver/gold or staging/dim/fact:
• Staging/Bronze: Raw CSV loads into staging tables without heavy transformation.
• Silver (Cleansed): Standardization and deduplication of master data, surrogate key assignment.
• Gold (Analytics): Aggregated views and reporting tables used by analysts.
This is consistent with the available SQL views located under scripts/Reports/ which create
gold.report_customers and gold.report_products views.


6. ETL / Data Processing
Extraction
Data is exported as CSV from source systems and stored under datasets/.
Transformation
Typical transformations applied (to be adapted with real code where missing):
• Trim and normalize text fields (names, product codes).
• Convert date strings to proper DATE types.
• Join/merge CRM and ERP customer/product records using match rules.
• Compute surrogate keys for dimension tables.
• Handle slowly changing dimensions (SCD Type 2) if historical tracking is needed.

7. Data Warehouse Schema
A common star schema for this project would include:
• dim_product (product_key PK, product_id, product_name, product_line, cost, start_dt,
end_dt, current_flag)
• dim_customer (customer_key PK, customer_id, name, region, segment, start_dt, end_dt,
current_flag)
• dim_date (date_key PK, date, year, quarter, month, day)
• fact_sales (sales_key PK, order_number, date_key, product_key, customer_key, quantity,
unit_price, total_amount)

The repository's reporting SQL references fields like order_number, product_key, and aggregated metrics
(total_sales, total_orders, avg_order_revenue), which aligns with the star schema above.
8. Reporting and Views
The repository includes reporting SQL under scripts/Reports/Report.sql. Two main analytics views are
defined:
• gold.report_customers — customer-level KPI aggregations (total sales, total orders, last order
date, average order revenue, months active).
• gold.report_products — product-level aggregations and lifecycle metrics.
An excerpt from the report SQL (for illustration):
CREATE VIEW gold.report_customers AS
WITH base_query AS (
SELECT f.order_number, f.product_key, ...
)
-- further aggregations to compute total_sales, total_orders, avg_order_revenue--
(Full SQL lives in scripts/Reports/Report.sql.)

9. Results and Examples
The project produces report views as the main output.
To show the results, we can:
• Load the data from the CSV files into the staging tables.
• Apply the cleaning and transformation steps to prepare the final views.
• Run sample analysis like finding top customers, best-selling products, and monthly sales.
• Create simple charts such as monthly revenue trends or product sales comparisons to include in
the report.

10.Conclusion
This project shows how data from different sources like CRM and ERP can be combined into a single data
warehouse for better analysis and reporting.
The use of Bronze, Silver, and Gold layers helps to organize data from raw files to clean and business-ready
information.
By creating report views, we can easily analyze sales, products, and customers.
In the future, the project can be improved by adding automated ETL pipelines, more detailed reports, and data
quality checks to make it production-ready.




