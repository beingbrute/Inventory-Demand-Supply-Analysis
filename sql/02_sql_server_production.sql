
CREATE DATABASE PROD;
USE PROD;


-- Inspect Production Data
SELECT *
FROM [dbo].[Production Env Inventory Dataset];

SELECT *
FROM [dbo].[Products];


-- Check for Missing Dates
SELECT DISTINCT [Order_Date_DD_MM_YYYY]
FROM [dbo].[Production Env Inventory Dataset]
WHERE [Order_Date_DD_MM_YYYY] IS NULL
   OR [Order_Date_DD_MM_YYYY] = '';


-- Validate Product IDs
SELECT DISTINCT [Product_ID]
FROM [dbo].[Production Env Inventory Dataset]
ORDER BY [Product_ID];


-- Correct Confirmed Product ID Mappings
-- Invalid Product IDs were identified during validation.
-- Confirmed mappings:
-- 21 -> 7
-- 22 -> 11

UPDATE [dbo].[Production Env Inventory Dataset]
SET [Product_ID] = 7
WHERE [Product_ID] = 21;

UPDATE [dbo].[Production Env Inventory Dataset]
SET [Product_ID] = 11
WHERE [Product_ID] = 22;


-- Revalidate Product IDs After Correction
SELECT DISTINCT [Product_ID]
FROM [dbo].[Production Env Inventory Dataset]
ORDER BY [Product_ID];


-- Check Product IDs Against Product Master
-- Expected result: zero rows.
-- Any returned Product ID does not exist in the product master.

SELECT DISTINCT a.product_id
FROM [dbo].[Production Env Inventory Dataset] AS a
LEFT JOIN [dbo].[Products] AS b
    ON a.product_id = b.product_id
WHERE b.product_id IS NULL;


-- Preview Joined Production Data
SELECT
    a.[Order_Date_DD_MM_YYYY],
    a.product_id,
    a.availability,
    a.demand,
    b.product_name,
    b.unit_price
FROM [dbo].[Production Env Inventory Dataset] AS a
LEFT JOIN [dbo].[Products] AS b
    ON a.product_id = b.product_id;


-- Create Reporting-Ready Table for Power BI
SELECT *
INTO inventory_reporting
FROM
(
    SELECT
        a.[Order_Date_DD_MM_YYYY],
        a.product_id,
        a.availability,
        a.demand,
        b.product_name,
        b.unit_price
    FROM [dbo].[Production Env Inventory Dataset] AS a
    LEFT JOIN [dbo].[Products] AS b
        ON a.product_id = b.product_id
) AS x;


-- Validate Final Reporting Table
SELECT *
FROM inventory_reporting;