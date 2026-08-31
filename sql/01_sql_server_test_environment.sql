

CREATE DATABASE test_env;
USE test_env;

-- Inspect source tables
SELECT * FROM [dbo].[Products];
SELECT * FROM [dbo].[Test Environment Inventory Dataset];

-- Validate key fields
SELECT DISTINCT Product_ID
FROM [dbo].[Test Environment Inventory Dataset];

SELECT DISTINCT [Order_Date_DD_MM_YYYY]
FROM [dbo].[Test Environment Inventory Dataset];

SELECT DISTINCT [Availability]
FROM [dbo].[Test Environment Inventory Dataset];

-- Join inventory with product master
SELECT
    a.[Order_Date_DD_MM_YYYY],
    a.product_id,
    a.availability,
    a.demand,
    b.product_name,
    b.unit_price
FROM [dbo].[Test Environment Inventory Dataset] AS a
LEFT JOIN [dbo].[Products] AS b
    ON a.product_id = b.product_id;

-- Create reporting-ready table for Power BI
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
    FROM [dbo].[Test Environment Inventory Dataset] AS a
    LEFT JOIN [dbo].[Products] AS b
        ON a.product_id = b.product_id
) AS x;

-- Validate final reporting table
SELECT * FROM inventory_reporting;