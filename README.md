 Before vs After Data Cleaning — Excel, SQL & Python
A hands-on data cleaning portfolio project that takes a messy, real-world-style business dataset and transforms it into clean, analysis-ready data — using three different tools: Microsoft Excel, PostgreSQL, and Python (pandas).

📌 Project Overview
Raw data is rarely clean. In this project, I worked with a business dataset containing common real-world issues — duplicate records, inconsistent formatting, merged fields, null values, and formula errors. I cleaned the same dataset three times, once in each tool, to compare approaches and document the process step by step.
This project was built as part of my data analyst portfolio to demonstrate practical data cleaning skills across multiple tools.

❓ Problem Statement
The raw dataset had several quality issues that would cause incorrect results in any analysis:

🔁 Duplicate rows — same records appearing more than once
⬜ Extra whitespace — leading/trailing spaces in names and fields
🔡 Inconsistent capitalization — mixing of UPPER, lower, and Title Case
❌ Formula errors — #DIV/0! in the Profit Margin column
🕳️ Null/missing values — blank Payment and Revenue fields
🔗 Combined fields — Department and City stored together in one column (e.g., Cloud Tech_Texas)


🛠️ Tools Used
ToolPurposeMicrosoft ExcelManual cleaning with formulas and built-in featuresPostgreSQL (SQL)Query-based cleaning and transformationPython (pandas)Programmatic cleaning and automation

📂 Dataset Details

File: Data_cleaning_file_ET207.xlsx
Records: ~30 rows of business transaction data
Columns: Date, Client, Contact, Department, Payment, Revenue, Profit, Profit Margin


🧽 Cleaning Process
🟢 Excel Cleaning Steps
Excel is a great starting point for visual, hands-on data cleaning.

TRIM() — removed extra spaces from Client and Contact columns
LOWER() — standardized all text to lowercase for consistency
PROPER() — converted names and company titles to Title Case
Find & Replace — cleaned up #DIV/0! errors and stock ticker suffixes like (XNAS:AMZN)
Remove Duplicates — used the built-in feature under the Data tab to eliminate duplicate rows
IFERROR() — wrapped Profit Margin formula to return "Null" instead of error values
Text to Columns + Filters — split the combined Department_City field and filtered for validation


🔵 SQL Cleaning Steps
SQL allows fast, scalable cleaning directly on the database.
sql-- Remove extra spaces and normalize casing
SELECT LOWER(TRIM(client)) AS clean_client FROM business_data;

-- Split combined Department_City column
SELECT
    SPLIT_PART(department, '_', 1) AS department,
    SPLIT_PART(department, '_', 2) AS city
FROM business_data;

-- Replace formula errors with NULL
SELECT
    CASE WHEN profit_margin = '#DIV/0!' THEN 'Null'
         ELSE profit_margin
    END AS profit_margin
FROM business_data;

-- Handle missing values
SELECT COALESCE(payment, 'NA') AS payment FROM business_data;

-- Remove duplicates and apply all cleaning in final query
SELECT DISTINCT
    date,
    INITCAP(TRIM(SPLIT_PART(client, '(', 1))) AS client,
    INITCAP(REGEXP_REPLACE(TRIM(contact), '\s+', ' ', 'g')) AS contact,
    INITCAP(SPLIT_PART(department, '_', 1)) AS department,
    INITCAP(SPLIT_PART(department, '_', 2)) AS city,
    COALESCE(payment, 'NA') AS payment,
    COALESCE(revenue, 'NA') AS revenue,
    profit,
    CASE WHEN profit_margin = '#DIV/0!' THEN 'Null'
         ELSE profit_margin END AS profit_margin
FROM business_data
WHERE client IS NOT NULL
ORDER BY date;
Key SQL functions used: TRIM(), LOWER(), INITCAP(), SPLIT_PART(), REGEXP_REPLACE(), COALESCE(), CASE WHEN, DISTINCT

🟡 Python Cleaning Steps
Python (pandas) is ideal for repeatable, automated data cleaning pipelines.
pythonimport pandas as pd

df = pd.read_excel("Data_cleaning_file_ET207.xlsx")

# Remove duplicates
df = df.drop_duplicates()

# Strip extra spaces
df['client'] = df['client'].str.strip()
df['contact'] = df['contact'].str.strip()

# Normalize capitalization
df['client'] = df['client'].str.title()
df['contact'] = df['contact'].str.title()

# Clean client names (remove stock tickers)
df['client'] = df['client'].str.replace(r'\s*\(.*?\)', '', regex=True)

# Split Department_City into two columns
df[['department', 'city']] = df['department'].str.split('_', expand=True)

# Replace errors and fill nulls
df['profit_margin'] = df['profit_margin'].replace('#DIV/0!', 'Null')
df['payment'] = df['payment'].fillna('NA')
df['revenue'] = df['revenue'].fillna('NA')
Key Python functions used: drop_duplicates(), fillna(), str.strip(), str.title(), str.replace(), str.split()

📊 Before vs After Results
Before (Raw Data)

Client names in ALL CAPS with stock tickers: AMAZON.COM, INC. (XNAS:AMZN)
Contact names with inconsistent spacing: Bill SmITH, JoSE  Roach
Department and City merged: Cloud Tech_Texas, Big Data_California
Profit Margin showing errors: #DIV/0!
Missing payment values shown as [null]

After (Clean Data)

Client names properly formatted: Amazon.Com, Inc.
Contact names normalized: Bill Smith, Jose Roach
Department and City in separate columns: Cloud Tech | Texas
Error values replaced: Null
Missing values filled: NA


📸 Before/After screenshots are included in the /screenshots folder.


💡 Key Learnings

The same dataset can be cleaned in multiple tools — each has its strengths. Excel is visual, SQL is fast for large data, Python is best for automation.
TRIM() and stripping whitespace is one of the most overlooked but important cleaning steps.
Splitting combined columns early makes downstream analysis much easier.
Handling #DIV/0! and null values separately requires different approaches in each tool.
A consistent naming convention (Title Case) makes data more readable and join-friendly.


📁 Project Files
📦 data-cleaning-portfolio/
├── 📄 README.md
├── 📊 Data_cleaning_file_ET207.xlsx       ← Raw dataset
├── 🐍 Python_Data_Cleaning.ipynb          ← Python cleaning notebook
├── 🗄️ CLEANING.sql                        ← SQL cleaning queries
└── 📸 screenshots/
    ├── BEFORE_EXCEL.png
    ├── AFTER_EXCEL.png
    ├── Before_python.png
    ├── AFTER_PYTHON.png
    ├── Before_SQL.png
    └── after_SQL.png

🔗 Connect With Me
If you found this project helpful or have feedback, feel free to connect on LinkedIn or check out my other projects on GitHub.

Built as part of my Data Analyst Portfolio — showcasing practical data cleaning skills across Excel, SQL, and Python.ShareContentPython Data Cleaning.ipynbipynbData cleaning file ET207.xlsxxlsxCLEANING.sql130 linessql
