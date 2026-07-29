-- Get the last day of the current month
-- and the first day of the current month
SELECT 
    EOMONTH(GETDATE(), 0), 
    DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)) 
WHERE 1 < 2;


-- Convert number 9.5 to different numeric data types
SELECT 
    9.5 AS Original, 
    CAST(9.5 AS INT) AS 'int',              -- Convert to integer
    CAST(9.5 AS DECIMAL(6, 4)) AS 'decimal' -- Convert to decimal number
WHERE 1 < 2;


-- Convert text value to DATE data type
SELECT 
    CAST('2017-08-25' AS date) as 'date' 
WHERE 1 < 2;


-- Use a CTE to calculate total sales per customer
WITH SalesSummary AS (
    SELECT 
        CustomerID,
        SUM(TotalAmount) AS TotalSpent
    FROM Sales
    GROUP BY CustomerID
)
-- Select only customers who spent more than 1000
SELECT *
FROM SalesSummary
WHERE TotalSpent > 1000;


-- Create a local temporary table with total sales per customer
SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
INTO #SalesSummary
FROM Sales
GROUP BY CustomerID;

-- Select data from the local temporary table
SELECT * 
FROM #SalesSummary 
WHERE TotalSpent > 1000;


-- Create a global temporary table with total sales per customer
-- Global temporary tables start with ## and can be used by other sessions
SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
INTO ##SalesSummary
FROM Sales
GROUP BY CustomerID;


-- Create a sequence for generating numbers
CREATE SEQUENCE item_counter
    AS INT
    START WITH 10
    INCREMENT BY 1;

-- Get the next number from the sequence
SELECT NEXT VALUE FOR item_counter;


-- Create a new database
CREATE DATABASE testDB;

-- Switch to the new database
USE testDB;


-- Create a table for storing promotion data
CREATE TABLE dbo.promotions (
    promotion_id INT PRIMARY KEY IDENTITY (1, 1), -- Auto-generated ID
    promotion_name VARCHAR (255) NOT NULL,        -- Promotion name, required
    discount NUMERIC (3, 2) DEFAULT 0,            -- Discount value, default is 0
    start_date DATE NOT NULL,                     -- Promotion start date
    expired_date DATE NOT NULL                    -- Promotion end date
); 


-- Insert sample promotion rows into the table
INSERT INTO dbo.promotions (
    promotion_name,
    discount,
    start_date,
    expired_date
)
VALUES
    (
        '2019 Summer Promotion',
        0.15,
        '20190601',
        '20190901'
    ),
    (
        '2019 Fall Promotion',
        0.20,
        '20191001',
        '20191101'
    ),
    (
        '2019 Winter Promotion',
        0.25,
        '20191201',
        '20200101'
    );


-- Select promotion data
-- Skip the first row and return only the next one row
SELECT
    promotion_id,
    promotion_name,
    discount
FROM
    dbo.promotions
ORDER BY
    promotion_id
OFFSET 1 ROWS 
FETCH NEXT 1 ROWS ONLY;


-- GO is a batch separator
-- It tells SQL Server to run all previous commands before continuing
-- Example: GO 10 runs the previous batch 10 times

-- Switch to the selected database
USE SampleDatabase;
GO


-- Create a local temporary table
CREATE TABLE #TempSalesData (
    ProductID INT,
    QuantitySold INT,
    SaleDate DATETIME
);
GO


-- Declare a variable with the current date and time
DECLARE @CurrentDate DATETIME;
SET @CurrentDate = GETDATE();

-- Insert sample data into the temporary table
INSERT INTO #TempSalesData (ProductID, QuantitySold, SaleDate)
VALUES 
    (1, 100, @CurrentDate),
    (2, 150, @CurrentDate),
    (3, 200, @CurrentDate);
GO


-- Select data from the temporary table
SELECT * 
FROM #TempSalesData;
GO


-- Drop the temporary table when it is no longer needed
DROP TABLE #TempSalesData;
GO
