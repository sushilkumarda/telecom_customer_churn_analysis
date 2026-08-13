CREATE DATABASE Telecom_Customer_Churn_Analysis;

USE Telecom_Customer_Churn_Analysis
GO

SELECT * FROM  telecom_customer_churn_cleaned;


-- Query 1: Total Churned Customers.

select Churn, count(Customerid) as Total_Customers
from telecom_customer_churn_cleaned
where Churn='Yes'
Group by Churn
Order by Total_Customers desc;

-- Query 2: Churn Rate

select count(case
when Churn='Yes' then 1 end)*100/count(*) as Churn_Rate
from telecom_customer_churn_cleaned;

-- Query 3: Churn by Gender

select Gender, count(*) as Total_Customers,
sum(case when Churn='Yes' then 1 else 0 end) as Churned_by_Gender
from telecom_customer_churn_cleaned
group by Gender;

-- Query 4: Churn by Contract Type

select Contract, count(*) as Total_Customers,
sum(case when Churn='Yes' then 1 else 0 end) as Churned_by_Contract
from telecom_customer_churn_cleaned
group by Contract;

-- Query 5: Churn by Payment Method

select Paymentmethod, count(*) as Total_Customers,
sum(case when Churn='Yes' then 1 else 0 end) as Churned_by_Paymentmethod
from telecom_customer_churn_cleaned
group by Paymentmethod;

-- Query 6: Churn by Internet Service

select Internetservice, count(*) as Total_Customers,
sum(case when Churn='Yes' then 1 else 0 end) as Churned_by_Internetservice
from telecom_customer_churn_cleaned
group by Internetservice;

-- Query 7: Churn by Tenure Group

select Tenure_Group, count(*) as Total_Customers,
sum(case when Churn='Yes' then 1 else 0 end) as Churned_by_Tenure_Group
from telecom_customer_churn_cleaned
group by Tenure_Group;

-- Query 8: Average Monthly Charges by Churn

select  Churn, 
avg(Monthlycharges) as Avg_Monthlycharges
from telecom_customer_churn_cleaned
group by Churn;

-- Query 9: Average Total Charges by Churn

select  Churn, 
avg(Totalcharges) as Avg_Totalcharges
from telecom_customer_churn_cleaned
group by Churn;

-- Query 10: Customer Risk Segmentation 

select Customerid, Monthlycharges,
case 
when Monthlycharges < 35 then 'Row Risk'
when Monthlycharges between 35 and 70  then 'Medium Risk'
else 'High Risk'
end as Risk_Category
from telecom_customer_churn_cleaned;

-- Query 11: Top 10 Highest Paying Customers

select  top 10 Customerid, Totalcharges
from telecom_customer_churn_cleaned 
order by Totalcharges desc;

-- Query 12: Churn Rate by Risk Segment

select case
when Monthlycharges<35 then 'Low Risk'
when Monthlycharges between 35 and 70 then 'Medium Risk'
else 'High Risk'
end as Risk_Category,
count(*) as Total_Customers,
sum(case
when Churn='Yes' then 1 else 0 end) as Churned_Customers,
sum(case
when Churn='Yes' then 1 else 0 end)*100/count(*) as Churn_Rate_Percent
from telecom_customer_churn_cleaned
group by case
when Monthlycharges<35 then 'Low Risk'
when Monthlycharges between 35 and 70 then 'Medium Risk'
else 'High Risk'
end;


