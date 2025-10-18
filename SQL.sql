SELECT EOMONTH(GETDATE(), 0), DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)) WHERE 1<2
SELECT 9.5 AS Original, CAST(9.5 AS INT) AS 'int', CAST(9.5 AS DECIMAL(6, 4)) AS 'decimal' WHERE 1<2;
SELECT CAST('2017-08-25' AS date) as 'date' WHERE 1<2;

-- CTE (Common Table Expression)
WITH SalesSummary AS (
    SELECT 
        CustomerID,
        SUM(TotalAmount) AS TotalSpent
    FROM Sales
    GROUP BY CustomerID
)
SELECT *
FROM SalesSummary
WHERE TotalSpent > 1000;

-- Create a temporary table
SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
INTO #SalesSummary
FROM Sales
GROUP BY CustomerID;

SELECT * FROM #SalesSummary WHERE TotalSpent > 1000;

-- Create a global temporary table
SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
INTO ##SalesSummary
FROM Sales
GROUP BY CustomerID;

-- Create a sequence
CREATE SEQUENCE item_counter
	AS INT
    START WITH 10
    INCREMENT BY 1;

SELECT NEXT VALUE FOR item_counter;


CREATE DATABASE testDB;

USE testDB;

CREATE TABLE dbo.promotions (
    promotion_id INT PRIMARY KEY IDENTITY (1, 1),
    promotion_name VARCHAR (255) NOT NULL,
    discount NUMERIC (3, 2) DEFAULT 0,
    start_date DATE NOT NULL,
    expired_date DATE NOT NULL
); 

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

-- GO = Is a batch separator. It tells to SQL Server "stop here and execute all the previous code before moving on". 
-- Is not mandatory but there is a feature for you: if you write GO 10, GO 100, GO 1000 it will execute the same batch of code 10, 100, 1000 times

-- Switch to the desired database 
USE SampleDatabase;
GO

-- Declare a variable
DECLARE @CurrentDate DATETIME;
SET @CurrentDate = GETDATE();

-- Create a temporary table
CREATE TABLE #TempSalesData (
    ProductID INT,
    QuantitySold INT,
    SaleDate DATETIME
);
GO

-- Insert sample data into the temporary table
INSERT INTO #TempSalesData (ProductID, QuantitySold, SaleDate)
VALUES (1, 100, @CurrentDate),
       (2, 150, @CurrentDate),
       (3, 200, @CurrentDate);
GO

-- Select data from the temporary table
SELECT * FROM #TempSalesData;
GO

-- Clean up: Drop the temporary table
DROP TABLE #TempSalesData;
GO