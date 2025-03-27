--Find the date of the first and last order

SELECT order_date FROM [gold.fact_sales]

SELECT min(order_date) AS first_order_date,
max(order_date) AS last_order_date
FROM [gold.fact_sales]

-- How many years of sales are available 
SELECT min(order_date) AS first_order_date,
max(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date),max(order_date)) AS order_range_in_years
FROM [gold.fact_sales]


-- How many month of sales are available 
SELECT min(order_date) AS first_order_date,
max(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date),max(order_date)) AS order_range_in_years
FROM [gold.fact_sales]

-- Find the youngest and oldest customer
SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate
FROM
	[gold.dim_customers]
