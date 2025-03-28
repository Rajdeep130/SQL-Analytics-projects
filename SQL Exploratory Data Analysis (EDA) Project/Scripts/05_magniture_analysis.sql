--Find total customers by countries
SELECT
country,
COUNT(customer_key) AS total_customers
FROM
	[gold.dim_customers]
GROUP BY country
ORDER BY total_customers DESC

-- Find total customers by gender
SELECT
gender,
COUNT(customer_key) AS total_customers
FROM
	[gold.dim_customers]
GROUP BY gender
ORDER BY total_customers ASC

-- Find total products by category
SELECT
category,
COUNT(product_id) AS total_products
FROM
	[gold.dim_products]
GROUP BY category
ORDER BY total_products ASC

-- What is the average costs in each category?
select * from [gold.dim_products]

SELECT
category,
AVG(cost) AS Avg_costs
FROM
[gold.dim_products]
GROUP BY category
ORDER BY Avg_costs ASC

-- What is the total revenue generated for each category?

SELECT 
p.category,
sum(f.sales_amount) AS Total_Revenue
FROM
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] p
ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY Total_Revenue ASC

-- What is the total revenue generated by each customers?

SELECT 
c.customer_key,
c.first_name,
c.last_name,
sum(f.sales_amount) AS Total_Revenue
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY Total_Revenue desc

-- What is the distribution of sold items across countries?

SELECT 
c.country,
sum(f.quantity) AS Total_sold_items
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY Total_sold_items ASC

SELECT * FROM [gold.dim_products]
SELECT * FROM [gold.dim_customers]
SELECT * FROM [gold.fact_sales]
