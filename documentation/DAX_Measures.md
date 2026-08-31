
# DAX Measures

This document contains the key DAX measures used in the Inventory Demand & Supply Analysis dashboard.

## Total Demand

```DAX
Total Demand =
SUM('Inventory Reporting'[demand])
```

Calculates the total number of units demanded.

---

## Total Available Inventory

```DAX
Total Available Inventory =
SUM('Inventory Reporting'[availability])
```

Calculates the total number of inventory units available.

---

## Fulfilled Demand

```DAX
Fulfilled Demand =
SUMX(
    'Inventory Reporting',
    MIN(
        'Inventory Reporting'[demand],
        'Inventory Reporting'[availability]
    )
)
```

Calculates the number of demanded units that could actually be fulfilled using available inventory.

---

## Unfulfilled Demand

```DAX
Unfulfilled Demand =
SUMX(
    'Inventory Reporting',
    MAX(
        'Inventory Reporting'[demand]
            - 'Inventory Reporting'[availability],
        0
    )
)
```

Calculates demand that could not be fulfilled because available inventory was insufficient.

---

## Demand Fulfillment Rate

```DAX
Demand Fulfillment Rate =
DIVIDE(
    [Fulfilled Demand],
    [Total Demand],
    0
)
```

Measures the percentage of total demand successfully fulfilled.

---

## Unfulfilled Demand Rate

```DAX
Unfulfilled Demand Rate =
DIVIDE(
    [Unfulfilled Demand],
    [Total Demand],
    0
)
```

Measures the percentage of total demand that remained unfulfilled.

---

## Shortage Events

```DAX
Shortage Events =
COUNTROWS(
    FILTER(
        'Inventory Reporting',
        'Inventory Reporting'[demand]
            > 'Inventory Reporting'[availability]
    )
)
```

Counts inventory records where demand exceeded availability.

---

## Potential Demand Value

```DAX
Potential Demand Value =
SUMX(
    'Inventory Reporting',
    'Inventory Reporting'[demand]
        * 'Inventory Reporting'[unit_price]
)
```

Estimates the total sales value if all recorded demand could be fulfilled.

---

## Fulfilled Demand Value

```DAX
Fulfilled Demand Value =
SUMX(
    'Inventory Reporting',
    MIN(
        'Inventory Reporting'[demand],
        'Inventory Reporting'[availability]
    )
        * 'Inventory Reporting'[unit_price]
)
```

Calculates the sales value associated with fulfilled demand.

---

## Revenue at Risk

```DAX
Revenue at Risk =
SUMX(
    'Inventory Reporting',
    VAR ShortageUnits =
        MAX(
            'Inventory Reporting'[demand]
                - 'Inventory Reporting'[availability],
            0
        )
    RETURN
        ShortageUnits * 'Inventory Reporting'[unit_price]
)
```

Estimates potential revenue exposure associated with inventory shortages. It represents potential revenue at risk rather than confirmed accounting loss.

---

## Value Fulfillment Rate

```DAX
Value Fulfillment Rate =
DIVIDE(
    [Fulfilled Demand Value],
    [Potential Demand Value],
    0
)
```

Measures the percentage of potential demand value that was successfully fulfilled.

---

## Active Inventory Days

```DAX
Active Inventory Days =
DISTINCTCOUNT(
    'Inventory Reporting'[Order_Date_DD_MM_YYYY]
)
```

Counts the number of distinct dates containing inventory records.

---

## Average Daily Demand

```DAX
Average Daily Demand =
DIVIDE(
    [Total Demand],
    [Active Inventory Days],
    0
)
```

Calculates average demand across active inventory dates.

---

## Average Daily Availability

```DAX
Average Daily Availability =
DIVIDE(
    [Total Available Inventory],
    [Active Inventory Days],
    0
)
```

Calculates average available inventory across active inventory dates.

---

## Average Daily Unfulfilled Demand

```DAX
Average Daily Unfulfilled Demand =
DIVIDE(
    [Unfulfilled Demand],
    [Active Inventory Days],
    0
)
```

Calculates average unfulfilled demand across active inventory dates.
