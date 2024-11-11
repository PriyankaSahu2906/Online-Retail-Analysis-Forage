create database retail;
use retail;
-- ------------------------------ EASY LEVEL QUESTIONS -------------------------------------------
-- 1. Retrieve all records from the dataset.
SELECT * FROM online_retail;

-- 1.  List all unique countries in the dataset.
SELECT DISTINCT Country 
FROM online_retail;

-- 3. Find the total number of transactions (invoices).
SELECT COUNT(DISTINCT InvoiceNo) AS Total_Transactions
FROM online_retail;

-- 4. Retrieve all records for a specific country, e.g., "United Kingdom".
SELECT * 
FROM online_retail 
WHERE Country = 'United Kingdom';

-- 2. Find all records where the quantity is greater than 10.
SELECT * 
FROM online_retail 
WHERE Quantity > 10;

-- 6. List all transactions that occurred on '01-12-2010'.
SELECT * 
FROM online_retail
WHERE InvoiceDate BETWEEN '01-12-2010 12:00' AND "01-12-2010 11:59";

-- 7. Retrieve all records for a specific customer ID, e.g., '12583'.
SELECT * FROM online_retail 
WHERE CustomerID = 12583;

-- 8. Find the total quantity of items sold.
SELECT SUM(Quantity) AS Total_Quantity
 FROM online_retail;
 
-- 9. List all transactions with a unit price greater than 20.
SELECT * FROM online_retail 
WHERE UnitPrice > 20;

-- 10. Retrieve the first 10 records from the dataset.
SELECT * FROM online_retail LIMIT 10;

-- -------------------INTERMIDEATE LEVEL QUESTIONS -------------------------------------------------

-- 1 .Calculate the total sales amount (Quantity * UnitPrice) for each transaction.
SELECT InvoiceNo, (Quantity * UnitPrice) AS Total_Amount
FROM online_retail;

-- 2. Find the total revenue generated by the company.
SELECT SUM(Quantity * UnitPrice) AS Total_Revenue FROM online_retail;

-- 3. Find the average unit price of items sold.
SELECT AVG(UnitPrice) AS Average_UnitPrice FROM online_retail;

-- 4.List the top 5 countries by the number of transactions.
SELECT Country, COUNT(DISTINCT InvoiceNo) AS Transactions
FROM online_retail
GROUP BY Country
ORDER BY Transactions DESC
LIMIT 5;

-- 5. rieve the most frequently purchased item (StockCode).
SELECT StockCode, COUNT(*) AS Purchase_Count
FROM online_retail
GROUP BY StockCode
ORDER BY Purchase_Count DESC
LIMIT 10;

-- 6. Find the top 3 customers by total purchase amount.
SELECT CustomerID, SUM(Quantity * UnitPrice) AS Total_Purchase
FROM online_retail
GROUP BY CustomerID
ORDER BY Total_Purchase DESC
LIMIT 3;

-- 7. Identify the day with the highest revenue..
SELECT DATE(InvoiceDate) AS InvoiceDay, SUM(Quantity * UnitPrice) AS Daily_Revenue
FROM online_retail
GROUP BY InvoiceDay
ORDER BY Daily_Revenue DESC
LIMIT 1;

-- 6.Find all invoices where more than 10 unique items (StockCodes) were purchased.
SELECT InvoiceNo
FROM online_retail
GROUP BY InvoiceNo
HAVING COUNT(DISTINCT StockCode) > 10;

-- 9. List the 5 most expensive items sold based on UnitPrice.
SELECT Description, UnitPrice
FROM online_retail
ORDER BY UnitPrice DESC
LIMIT 5;

-- 10. Find the number of transactions for each customer in 'Germany'.
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Transactions
FROM online_retail
WHERE Country = 'Germany'
GROUP BY CustomerID;

-- 7.Find the total number of items sold per country.
SELECT Country, SUM(Quantity) AS Total_Items_Sold
FROM online_retail
GROUP BY Country
ORDER BY Total_Items_Sold DESC;

-- 8.Retrieve the top 5 products with stockcode by revenue generated.
SELECT Description, Stockcode, SUM(Quantity * UnitPrice) AS Revenue
FROM online_retail
GROUP BY Description, stockcode
ORDER BY Revenue DESC
LIMIT 5;

-- 13. Calculate the total revenue generated for each product (StockCode).
SELECT StockCode, SUM(Quantity * UnitPrice) AS Total_Revenue
FROM online_retail
GROUP BY StockCode
ORDER BY Total_Revenue DESC;

-- 14. Find the country with the highest average revenue per transaction.
SELECT Country, AVG(Quantity * UnitPrice) AS Avg_Revenue_Per_Transaction
FROM online_retail
GROUP BY Country
ORDER BY Avg_Revenue_Per_Transaction DESC
LIMIT 1;

-- 15.Identify customers who made more than 5 purchases in December 2010.
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Purchase_Count
FROM online_retail
WHERE InvoiceDate BETWEEN '2010-12-01' AND '2010-12-31'
GROUP BY CustomerID
HAVING Purchase_Count > 5;


-- -------------------------------DIFFICULT LEVEL QUESTIONS --------------------------------------------------------------------------

-- 1.Find the total revenue for each country on a monthly basis.

SELECT Country, DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(Quantity * UnitPrice) AS Total_Revenue
FROM online_retail
GROUP BY Country, Month
ORDER BY Country, Month;

-- 2. Calculate the cumulative revenue generated by each customer over time.
SELECT CustomerID, InvoiceDate, 
       SUM(Quantity * UnitPrice) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate) AS Cumulative_Revenue
       FROM online_retail
group by CustomerID;

-- 3.Identify the most popular product in each country.
SELECT Country, StockCode, COUNT(*) AS Purchase_Count
FROM online_retail
GROUP BY Country, StockCode
ORDER BY Country, Purchase_Count DESC;

-- 9.Find the average quantity of items purchased per transaction for each customer.
SELECT CustomerID, AVG(Quantity) AS Avg_Quantity
FROM online_retail
GROUP BY CustomerID;

-- 10. Determine the top 3 products that contributed to the highest revenue in 'United Kingdom’.
SELECT StockCode, SUM(Quantity * UnitPrice) AS Revenue
FROM online_retail
WHERE Country = 'United Kingdom'
GROUP BY StockCode
ORDER BY Revenue DESC
LIMIT 3;

-- 6.Calculate the total revenue for each day of the week across the entire dataset.
SELECT DAYNAME(InvoiceDate) AS DayOfWeek, SUM(Quantity * UnitPrice) AS Total_Revenue
FROM online_retail
GROUP BY DayOfWeek
ORDER BY FIELD(DayOfWeek, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- 7. Find the customer who purchased the most number of different products (StockCode).
SELECT CustomerID, COUNT(DISTINCT StockCode) AS Unique_Products
FROM online_retail
GROUP BY CustomerID
ORDER BY Unique_Products DESC
LIMIT 1;

-- 8. Determine the top 3 countries by average revenue per transaction.
SELECT Country, AVG(Quantity * UnitPrice) AS Avg_Revenue_Per_Transaction
FROM online_retail
GROUP BY Country
ORDER BY Avg_Revenue_Per_Transaction DESC
LIMIT 3;

-- 11. identify the customers who purchased more than 100 items in a single transaction
SELECT CustomerID, InvoiceNo, SUM(Quantity) AS Total_Items
FROM online_retail
GROUP BY CustomerID, InvoiceNo
HAVING Total_Items > 100;

-- 12. Find the average revenue per customer and compare it between two specific countries, e.g., 'Germany' and 'France'.
SELECT Country, AVG(Revenue) AS Avg_Revenue_Per_Customer
FROM (
    SELECT Country, CustomerID, SUM(Quantity * UnitPrice) AS Revenue
    FROM online_retail
    WHERE Country IN ('Germany', 'France')
    GROUP BY Country, CustomerID
) AS RevenueData
GROUP BY Country;

