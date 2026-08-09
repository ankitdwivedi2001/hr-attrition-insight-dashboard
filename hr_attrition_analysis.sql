-- HR Attrition Analysis
-- SQL queries to answer key business questions about employee attrition
-- Tables: employees, compensation, performance (joined via EmployeeNumber)


CREATE TABLE employees AS
SELECT
    EmployeeNumber,
    Age,
    Gender,
    MaritalStatus,
    Department,
    JobRole,
    JobLevel,
    Education,
    EducationField,
    DistanceFromHome,
    BusinessTravel,
    OverTime,
    Attrition
FROM employee_data_raw;

UPDATE employees
SET Gender = 'Male'
WHERE TRIM(UPPER(Gender)) = 'MALE';

UPDATE employees
SET Gender = 'Female'
WHERE TRIM(UPPER(Gender)) = 'FEMALE';

SELECT * FROM employees;

CREATE TABLE compensation AS
SELECT
    EmployeeNumber,
    DailyRate,
    HourlyRate,
    MonthlyIncome,
    MonthlyRate,
    PercentSalaryHike,
    StockOptionLevel,
    NumCompaniesWorked,
    TotalWorkingYears,
    YearsAtCompany
FROM employee_data_raw;

SELECT * FROM compensation;


CREATE TABLE performance AS
SELECT
    EmployeeNumber,
    EnvironmentSatisfaction,
    JobSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance,
    JobInvolvement,
    PerformanceRating,
    TrainingTimesLastYear,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager
FROM employee_data_raw;

SELECT * FROM performance;

SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_percent
FROM employees
GROUP BY Department;

-- 29 employee records had missing Department data (labelled 'Unknown' during cleaning).
-- Excluded here to avoid misleading attrition % from a small, non-representative group.
-- These records are still kept for other analyses (e.g. salary, age).

SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_percent
FROM employees
WHERE Department != 'Unknown'
GROUP BY Department;

SELECT
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_percent
FROM employees
GROUP BY Gender;

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_percent
FROM employees
GROUP BY JobRole
ORDER BY attrition_percent DESC;



-- Employees who left earn ~29% less on average (£4,840) than those who stayed (£6,807).
-- Note: this may be linked to seniority/age rather than salary alone, since younger
-- employees also show higher attrition (see age group query above).
SELECT
    e.Attrition,
    ROUND(AVG(c.MonthlyIncome), 0) AS avg_monthly_income,
    COUNT(*) AS total_employees
FROM employees e
JOIN compensation c ON e.EmployeeNumber = c.EmployeeNumber
GROUP BY e.Attrition;


-- Findings on attrition by years at company:
-- • Highest attrition in first year (36.6%) and years 1-3 (24.8%)
-- • Attrition drops sharply after year 5 (11.0%)
-- • Suggests the company may be losing people during onboarding/early career stage
-- • Note: "Under 1 year" group is small (41 employees) — treat as an early signal, not a precise number
SELECT
    CASE
        WHEN c.YearsAtCompany < 1 THEN 'Under 1 year'
        WHEN c.YearsAtCompany BETWEEN 1 AND 3 THEN '1-3 years'
        WHEN c.YearsAtCompany BETWEEN 4 AND 5 THEN '4-5 years'
        ELSE '5+ years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN e.Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(SUM(CASE WHEN e.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_percent
FROM employees e
JOIN compensation c ON e.EmployeeNumber = c.EmployeeNumber
GROUP BY tenure_group
ORDER BY tenure_group;


