/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month and the running total of sales over time.

f you wnat to PARTITION OR want to see cumulative sales of paticular year over month

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS running_total_sales
FROM 
(SELECT 
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t


SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales
FROM 
(SELECT 
DATETRUNC(YEAR, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
)t


-- If you want to look for moving Avg also

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales,
AVG(avg_price) OVER(ORDER BY order_date) AS moving_average_price
FROM 
(SELECT 
DATETRUNC(YEAR, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
)t

-- Analyze the yearly performace of products by comparing each product's 
-- sales to both its aveage sales performace and the previous year's sales.

-- Year over Year Analysis

--1st step

SELECT
*
from
	[gold.fact_sales] f
LEFT JOIN [gold.dim_products] p
ON f.product_key = p.product_key


--2nd step
WITH category_sales AS
(SELECT
category,
SUM(sales_amount) AS total_sales
from
	[gold.fact_sales] f
LEFT JOIN [gold.dim_products] p
ON f.product_key = p.product_key
group by category)

SELECT 
category,
total_sales,
SUM(total_sales) OVER() overall_sales,
CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER())*100,2),'%') AS percentage_of_total
FROM category_sales
ORDER BY percentage_of_total desc


-- Data Segmentation 
/* 
Group the data based on a specific range helps understand the correlation between two measures.
*/

WITH cost_range_h AS
(SELECT 
product_key,
product_name,
cost,
CASE WHEN cost <100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END cost_range
FROM
[gold.dim_products]
)
SELECT 
cost_range,
COUNT(product_key) AS total_products,
SUM(COUNT(product_key)) OVER() AS overall_products,
CONCAT((COUNT(product_key)*100)/SUM(COUNT(product_key)) OVER(),'%') AS percentage_of_total
FROM cost_range_h
GROUP BY cost_range
ORDER BY total_products DESC




WITH cost_range_h AS (
    SELECT 
        product_key,
        product_name,
        cost,
        CASE 
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM [gold.dim_products]
)
SELECT 
    cost_range,
    COUNT(product_key) AS total_products,
    SUM(COUNT(product_key)) OVER() AS overall_products,
    (COUNT(product_key) * 100.0) / SUM(COUNT(product_key)) OVER() AS percentage_of_total
FROM cost_range_h
GROUP BY cost_range
ORDER BY total_products DESC;

WITH cost_range_h AS
(SELECT
	product_key,
	product_name,
	cost,
CASE 
	WHEN cost<100 THEN 'Below 100'
	WHEN cost BETWEEN 100 AND 500 THEN 'Below 100'
	WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	ELSE 'Above 1000'
END AS cost_range
FROM
	[gold.dim_products]
	)
SELECT 
cost_range,
COUNT(product_key) AS total_products,
SUM(COUNT(product_key)) OVER() AS overall_product,
CONCAT((COUNT(product_key)*100)/SUM(COUNT(product_key)) OVER(),'%') AS product_percentage
FROM
cost_range_h
GROUP BY cost_range
order by total_products desc

/*
Group customers into three segments based on their spending behavior:
	-VIP: Customers with at least 12 months of history and spending more than 5000.
	- Regular: Customers with at least 12 months of history but spending 5000 or less.
	- New: Customers with a lifrespan less than 12 months 
	and finds the total number of customers by each group
	*/

WITH customer_spending 
AS
(SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,										-- this is the intermediate Result based 
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan		-- on this final result will come
FROM
	[gold.fact_sales] f
LEFT JOIN
	[gold.dim_customers] c
	ON f.customer_key = c.customer_key
GROUP BY c.customer_key)

	SELECT
	CASE WHEN lifespan > 12 AND total_spending > 5000 THEN 'VIP'
			  WHEN lifespan >=12 AND  total_spending<= 5000 THEN 'Regular'
			  ELSE 'New'
			END customer_segment,
	COUNT(customer_key) AS total_customers
	FROM 
		customer_spending
		GROUP BY CASE WHEN lifespan > 12 AND total_spending > 5000 THEN 'VIP'
			  WHEN lifespan >=12 AND  total_spending<= 5000 THEN 'Regular'
			  ELSE 'New'
			END
	ORDER BY COUNT(customer_key) DESC


