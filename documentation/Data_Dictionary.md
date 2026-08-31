
# Data Dictionary

This document describes the main fields used in the Inventory Demand & Supply Analysis project.

## Inventory Data

| Column | Description |
|---|---|
| `Order_Date_DD_MM_YYYY` | Date associated with the inventory record |
| `product_id` | Unique identifier used to associate inventory records with products |
| `availability` | Number of product units available |
| `demand` | Number of product units demanded |

## Product Data

| Column | Description |
|---|---|
| `product_id` | Unique product identifier |
| `product_name` | Name of the product |
| `unit_price` | Selling price per unit in USD |

## Reporting Table

The `inventory_reporting` table is created by joining the inventory data with the product master using `product_id`.

It contains:

| Column | Description |
|---|---|
| `Order_Date_DD_MM_YYYY` | Inventory record date |
| `product_id` | Product identifier |
| `availability` | Available inventory units |
| `demand` | Demanded units |
| `product_name` | Product name obtained from the product master |
| `unit_price` | Selling price per unit |

## Power BI Calculated Column

### Inventory Status

The `Inventory Status` calculated column classifies each inventory record based on demand and availability:

- **Demand Met** — Availability is greater than or equal to Demand.
- **Shortage** — Demand is greater than Availability.
