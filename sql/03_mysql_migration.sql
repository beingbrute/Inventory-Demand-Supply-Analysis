
CREATE DATABASE PROD;
USE PROD;


-- Inspect Migrated Production Inventory
SELECT *
FROM prod.`production env inventory dataset`;


-- Inspect Product Master
SELECT *
FROM prod.products;


-- Validate Product IDs Before Correction
SELECT DISTINCT `Product ID`
FROM prod.`production env inventory dataset`
ORDER BY `Product ID`;


-- Apply Confirmed Product ID Corrections
-- Confirmed mappings:
-- 21 -> 7
-- 22 -> 11
UPDATE prod.`production env inventory dataset`
SET `Product ID` = 7
WHERE `Product ID` = 21;

UPDATE prod.`production env inventory dataset`
SET `Product ID` = 11
WHERE `Product ID` = 22;


-- Revalidate Product IDs After Correction
SELECT DISTINCT `Product ID`
FROM prod.`production env inventory dataset`
ORDER BY `Product ID`;


-- Check Product IDs Against Product Master
-- Expected result: zero rows
SELECT DISTINCT a.`Product ID`
FROM prod.`production env inventory dataset` AS a
LEFT JOIN prod.products AS b
    ON a.`Product ID` = b.`Product ID`
WHERE b.`Product ID` IS NULL;


-- Preview Joined Production Data
SELECT
    a.`Order Date (DD/MM/YYYY)` AS `Order_Date_DD_MM_YYYY`,
    a.`Product ID` AS `product_id`,
    a.availability,
    a.demand,
    b.`Product Name` AS `product_name`,
    b.`Unit Price ($)` AS `unit_price`
FROM prod.`production env inventory dataset` AS a
LEFT JOIN prod.products AS b
    ON a.`Product ID` = b.`Product ID`;


-- Create Reporting-Ready Table
CREATE TABLE inventory_reporting AS
SELECT
    a.`Order Date (DD/MM/YYYY)` AS `Order_Date_DD_MM_YYYY`,
    a.`Product ID` AS `product_id`,
    a.availability,
    a.demand,
    b.`Product Name` AS `product_name`,
    b.`Unit Price ($)` AS `unit_price`
FROM prod.`production env inventory dataset` AS a
LEFT JOIN prod.products AS b
    ON a.`Product ID` = b.`Product ID`;


-- Validate Final Reporting Table
SELECT *
FROM inventory_reporting;