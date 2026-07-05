CREATE DATABASE Customer_Churn;

USE Customer_Churn;
GO

SELECT TOP 10 *
FROM dbo.Telco_Customer_Churn_Cleaned;

SELECT COUNT(*) AS Total_Customers
FROM dbo.Telco_Customer_Churn_Cleaned;


-- Query 1: Total Churned Customers.

SELECT COUNT(*) AS Churned_Customers
FROM dbo.Telco_Customer_Churn_Cleaned
WHERE Churn = 'Yes';

-- Query 2: Churn Rate

SELECT
    ROUND(
        COUNT(CASE WHEN Churn='Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM dbo.Telco_Customer_Churn_Cleaned;

-- Query 3: Churn by Gender

SELECT
    gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY gender;

-- Query 4: Churn by Contract Type

SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY Contract;

-- Query 5: Churn by Payment Method

SELECT
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY PaymentMethod;

-- Query 6: Churn by Internet Service

SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY InternetService;

-- Query 7: Churn by Tenure Group

SELECT
    Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY Tenure_Group;

-- Query 8: Average Monthly Charges by Churn

SELECT
    Churn,
    AVG(MonthlyCharges) AS Avg_Monthly_Charges
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY Churn;

-- Query 9: Average Total Charges by Churn

SELECT
    Churn,
    AVG(TotalCharges) AS Avg_Total_Charges
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY Churn;

-- Query 10: Customer Risk Segmentation (CASE Statement)

SELECT
    customerID,
    MonthlyCharges,
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Risk'
        WHEN MonthlyCharges BETWEEN 35 AND 70 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS Risk_Category
FROM dbo.Telco_Customer_Churn_Cleaned;

-- Query 11: Top 10 Highest Paying Customers

SELECT TOP 10
    customerID,
    TotalCharges
FROM dbo.Telco_Customer_Churn_Cleaned
ORDER BY TotalCharges DESC;

-- Query 12: Window Function (ROW_NUMBER)

SELECT
    customerID,
    TotalCharges,
    ROW_NUMBER() OVER(ORDER BY TotalCharges DESC) AS Customer_Rank
FROM dbo.Telco_Customer_Churn_Cleaned;

-- Query 13: Churn Rate by Risk Segment
SELECT
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Risk'
        WHEN MonthlyCharges BETWEEN 35 AND 70 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS Risk_Category,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM dbo.Telco_Customer_Churn_Cleaned
GROUP BY
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Risk'
        WHEN MonthlyCharges BETWEEN 35 AND 70 THEN 'Medium Risk'
        ELSE 'High Risk'
    END;

