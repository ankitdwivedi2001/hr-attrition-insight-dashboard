HR Attrition Insight Project

1. Business Problem & Requirements (BRD/FRD)

Background: The company has seen a noticeable increase in employees leaving over the past year. Leadership does not currently have a clear, data-backed view of where and why this is happening.

Business Problem: HR does not know which departments, roles, or employee groups are most affected by attrition, making it difficult to take targeted retention action.

Objectives:
- Identify which departments and employee groups have the highest attrition
- Understand what factors (salary, age, years at company) are linked to attrition
- Present findings through an interactive, ongoing dashboard

Scope: Analyzing existing employee data to find attrition patterns and building a dashboard. Does not include predicting future attrition or changing HR policy.

Stakeholders: Higher Management (cost/delay impact), HR Director (owns the problem), Department Managers (directly affected).

Functional Requirements (FRD):
| # | Requirement |
|---|---|
| 1.1 | Show attrition % by department |
| 1.2 | Filter attrition by age, gender, job role |
| 2.1 | Compare salary: left vs. stayed |
| 2.2 | Attrition by years at company |
| 2.3 | Attrition by age group |
| 3.1 | Dashboard must be interactive |
| 3.2 | Dashboard accessible via shareable link |




2. Data & Database Design:

For data, I used the IBM HR Analytics Employee Attrition dataset from Kaggle - it has 1,470 employee records with things like department, salary, age, and whether they left the company or not.

Instead of keeping everything in one big spreadsheet, I split the data into three tables, kind of like how a real company's HR data usually lives across different systems:
- employees - age, gender, department, job role
- compensation - salary and years at the company
- performance - satisfaction scores and ratings

All three are connected using EmployeeNumber, so I can join them together whenever a question needs data from more than one table (like comparing salary against attrition).

I also deliberately messed up a copy of the data on purpose - added missing values, duplicate employees, typos, inconsistent text - because I wanted to practice cleaning data the way it actually shows up in the real world, not a dataset that's already spotless.



3. Data Cleaning (Excel):

Before loading anything into a database, I cleaned the data in Excel:
- Removed 15 duplicate employees using Remove Duplicates
- Fixed inconsistent department names like "SALES", "sales", " Sales " using a TRIM + PROPER formula
- Fixed a typo in Marital Status ("Divorsed" instead of "Divorced") with Find & Replace
- Filled in missing values, but not just randomly - missing departments got labelled "Unknown" since I can't guess someone's department, while missing salary and tenure numbers got filled with the average, and missing satisfaction scores got filled with the most common rating



4. SQL Analysis:

I loaded the cleaned data into MySQL and wrote SQL queries (with joins across the three tables) to answer the main questions:
- Attrition by department, gender, job role, and age group
- Salary comparison between employees who left and those who stayed
- Attrition by how long people had been at the company

One thing worth flagging: 29 employees had missing department data, labelled "Unknown" after cleaning. I left this group out of the department-level analysis since it's a tiny group and not a real department - including it would've made the numbers misleading.



5. Dashboard (Looker Studio):

I built the dashboard in Looker Studio, connected to the SQL results through Google Sheets. It has 6 charts (department, gender, job role, age group, salary, tenure) plus a KPI card showing the company's overall attrition rate (16.1%).

Live dashboard: https://datastudio.google.com/reporting/4b933108-fc2b-4722-9ed6-5c84993db1d1


# HR Attrition Insight Project

## 1. Business Problem & Requirements (BRD/FRD)

**Background:** The company has seen a noticeable increase in employees leaving over the past year. Leadership does not currently have a clear, data-backed view of where and why this is happening.

**Business Problem:** HR does not know which departments, roles, or employee groups are most affected by attrition, making it difficult to take targeted retention action.

**Objectives:**
- Identify which departments and employee groups have the highest attrition
- Understand what factors (salary, age, years at company) are linked to attrition
- Present findings through an interactive, ongoing dashboard

**Scope:** Analysing existing employee data to find attrition patterns and building a dashboard. Does not include predicting future attrition or changing HR policy.

**Stakeholders:** Higher Management (cost/delay impact), HR Director (owns the problem), Department Managers (directly affected).

**Functional Requirements (FRD):**
| # | Requirement |
|---|---|
| 1.1 | Show attrition % by department |
| 1.2 | Filter attrition by age, gender, job role |
| 2.1 | Compare salary: left vs. stayed |
| 2.2 | Attrition by years at company |
| 2.3 | Attrition by age group |
| 3.1 | Dashboard must be interactive |
| 3.2 | Dashboard accessible via shareable link |




## 2. Data & Database Design

For data, I used the IBM HR Analytics Employee Attrition dataset from Kaggle - it has 1,470 employee records with things like department, salary, age, and whether they left the company or not.

Instead of keeping everything in one big spreadsheet, I split the data into three tables, kind of like how a real company's HR data usually lives across different systems:
- employees - age, gender, department, job role
- compensation - salary and years at the company
- performance - satisfaction scores and ratings

All three are connected using EmployeeNumber, so I can join them together whenever a question needs data from more than one table (like comparing salary against attrition).

I also deliberately messed up a copy of the data on purpose - added missing values, duplicate employees, typos, inconsistent text - because I wanted to practice cleaning data the way it actually shows up in the real world, not a dataset that's already spotless.



## 3. Data Cleaning (Excel)

Before loading anything into a database, I cleaned the data in Excel:
- Removed 15 duplicate employees using Remove Duplicates
- Fixed inconsistent department names like "SALES", "sales", " Sales " using a TRIM + PROPER formula
- Fixed a typo in Marital Status ("Divorsed" instead of "Divorced") with Find & Replace
- Filled in missing values, but not just randomly - missing departments got labelled "Unknown" since I can't guess someone's department, while missing salary and tenure numbers got filled with the average, and missing satisfaction scores got filled with the most common rating



## 4. SQL Analysis

I loaded the cleaned data into MySQL and wrote SQL queries (with joins across the three tables) to answer the main questions:
- Attrition by department, gender, job role, and age group
- Salary comparison between employees who left and those who stayed
- Attrition by how long people had been at the company

One thing worth flagging: 29 employees had missing department data, labelled "Unknown" after cleaning. I left this group out of the department-level analysis since it's a tiny group and not a real department - including it would've made the numbers misleading.



## 5. Dashboard (Looker Studio)

I built the dashboard in Looker Studio, connected to the SQL results through Google Sheets. It has 6 charts (department, gender, job role, age group, salary, tenure) plus a KPI card showing the company's overall attrition rate (16.1%).

Live dashboard: https://datastudio.google.com/reporting/4b933108-fc2b-4722-9ed6-5c84993db1d1



## 6. Key Findings

- Sales has the highest attrition among real departments (20.1%), followed by HR (16.9%) and R&D (13.9%). 29 records had missing department data ("Unknown", 27.6%) and were left out of this comparison since it's too small a group to trust.
- Employees under 30 leave the most (27.9%), way more than any other age group. This lines up with a common pattern where younger employees are more likely to change jobs early in their career.
- People who left earned about 29% less on average (£4,840) than people who stayed (£6,807). This is probably tied to seniority though, not just pay on its own, since younger/junior employees already show higher attrition.
- Attrition is highest in the first 3 years at the company - 36.6% in the first year, 24.8% in years 1-3 - then drops a lot after year 5 (11%). This suggests the company might be losing people during onboarding and the early part of their career, more than later on.
- Gender doesn't seem to be a big factor - Male (16.9%) and Female (14.8%) attrition are fairly close.

Overall, the biggest patterns point toward early-career and early-tenure employees being the group most at risk of leaving, more than department or gender.


## 7. Tools Used

- Excel - data cleaning (duplicates, text formulas, missing values)
- MySQL - database design, joins, SQL analysis
- Google Sheets - bridge between SQL results and the dashboard
- Looker Studio - interactive dashboard
- Markdown/GitHub - documentation and hosting
6. Key Findings:

- Sales has the highest attrition among real departments (20.1%), followed by HR (16.9%) and R&D (13.9%). 29 records had missing department data ("Unknown", 27.6%) and were left out of this comparison since it's too small a group to trust.
- Employees under 30 leave the most (27.9%), way more than any other age group. This lines up with a common pattern where younger employees are more likely to change jobs early in their career.
- People who left earned about 29% less on average (£4,840) than people who stayed (£6,807). This is probably tied to seniority though, not just pay on its own, since younger/junior employees already show higher attrition.
- Attrition is highest in the first 3 years at the company - 36.6% in the first year, 24.8% in years 1-3 - then drops a lot after year 5 (11%). This suggests the company might be losing people during onboarding and the early part of their career, more than later on.
- Gender doesn't seem to be a big factor - Male (16.9%) and Female (14.8%) attrition are fairly close.

Overall, the biggest patterns point toward early-career and early-tenure employees being the group most at risk of leaving, more than department or gender.


7. Tools Used:

- Excel - data cleaning (duplicates, text formulas, missing values)
- MySQL - database design, joins, SQL analysis
- Google Sheets - bridge between SQL results and the dashboard
- Looker Studio - interactive dashboard
- Markdown/GitHub - documentation and hosting
