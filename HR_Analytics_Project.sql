CREATE DATABASE employee_db;
USE employee_db;


SHOW TABLES;

desc hr_1;

ALTER TABLE HR_1
CHANGE COLUMN `ï»¿Age` Age INT;


 desc hr_2;
 
 ALTER TABLE HR_2
CHANGE COLUMN `ï»¿Employee ID` EmployeeNumber INT;

CREATE VIEW HR_DATA AS
SELECT
    h1.*,
    h2.MonthlyIncome,
    h2.MonthlyRate,
    h2.NumCompaniesWorked,
    h2.Over18,
    h2.OverTime,
    h2.PercentSalaryHike,
    h2.PerformanceRating,
    h2.RelationshipSatisfaction,
    h2.StandardHours,
    h2.StockOptionLevel,
    h2.TotalWorkingYears,
    h2.TrainingTimesLastYear,
    h2.WorkLifeBalance,
    h2.YearsAtCompany,
    h2.YearsInCurrentRole,
    h2.YearsSinceLastPromotion,
    h2.YearsWithCurrManager

FROM HR_1 h1
LEFT JOIN HR_2 h2
ON h1.EmployeeNumber = h2.EmployeeNumber;




# Total Employees
SELECT COUNT(*) AS Total_Employees
FROM HR_DATA;


# Attrition Rate %
SELECT
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
*100.0/COUNT(*),2
) AS Attrition_Rate
FROM HR_DATA;


#Average Hourly Rate
SELECT ROUND(AVG(HourlyRate),2) AS Avg_Hourly_Rate
FROM HR_DATA;


# Average Working Years
SELECT ROUND(AVG(TotalWorkingYears),2) AS Avg_Working_Years
FROM HR_DATA;


# Average Attrition Rate for All Departments
SELECT
Department,
ROUND(
AVG(
CASE
WHEN Attrition='Yes' THEN 1
ELSE 0
END
),2
) AS Attrition_Rate
FROM HR_DATA
GROUP BY Department;


# Attrition Rate vs Monthly Income Slab
SELECT

CASE
WHEN MonthlyIncome < 10000 THEN '0-10K'
WHEN MonthlyIncome BETWEEN 10000 AND 20000 THEN '10-20K'
WHEN MonthlyIncome BETWEEN 20001 AND 30000 THEN '20-30K'
WHEN MonthlyIncome BETWEEN 30001 AND 40000 THEN '30-40K'
ELSE '40K+'
END AS Salary_Slab,

ROUND(
AVG(
CASE
WHEN Attrition='Yes' THEN 1
ELSE 0
END
)*100,2
) AS Attrition_Rate

FROM HR_DATA
GROUP BY Salary_Slab
ORDER BY Salary_Slab;


# Job Role vs Work Life Balance
SELECT
JobRole,
WorkLifeBalance,
COUNT(*) AS Employee_Count
FROM HR_DATA
GROUP BY JobRole, WorkLifeBalance
ORDER BY JobRole;


# Attrition Rate vs Years Since Last Promotion
SELECT
YearsSinceLastPromotion,

ROUND(
AVG(
CASE
WHEN Attrition='Yes' THEN 1
ELSE 0
END
),2
) AS Attrition_Rate

FROM HR_DATA
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;

# Average Working Years of Each Department
SELECT
Department,
ROUND(AVG(TotalWorkingYears),2) AS Avg_Working_Years
FROM HR_DATA
GROUP BY Department;














