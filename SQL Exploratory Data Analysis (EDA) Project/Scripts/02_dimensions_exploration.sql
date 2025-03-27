/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Explore All Countries our Customers come from.

SELECT DISTINCT country
FROM
	[gold.dim_customers]

-- All the product categories "The Major Divisions"

SELECT DISTINCT category
FROM
	[gold.dim_products];

SELECT DISTINCT category,subcategory
FROM
	[gold.dim_products];

SELECT DISTINCT category,subcategory, product_name
FROM
	[gold.dim_products]
