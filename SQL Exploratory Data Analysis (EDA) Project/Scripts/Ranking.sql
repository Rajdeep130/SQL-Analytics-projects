-- Which 5 Products generate the highest revene

SELECT TOP 5
c.product_name,
sum(f.sales_amount) AS Total_revenue
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] c ON f.product_key = c.product_key
GROUP BY c.product_name
ORDER BY Total_revenue DESC

-- Using Window function 
SELECT *
FROM
(SELECT 
c.product_name,
sum(f.sales_amount) AS Total_revenue,
RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] c ON f.product_key = c.product_key
GROUP BY c.product_name) t
WHERE t.rank_products<=5

-- What are the 5 worst-perfoming products in terms of sales
SELECT TOP 5
c.product_name,
sum(f.sales_amount) AS Total_revenue
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] c ON f.product_key = c.product_key
GROUP BY c.product_name
ORDER BY Total_revenue ASC

-- using Window function 

SELECT product_name, Total_revenue  
FROM (  
    SELECT  
        c.product_name,  
        SUM(f.sales_amount) AS Total_revenue,  
        RANK() OVER (ORDER BY SUM(f.sales_amount) ASC) AS rank_products  
    FROM [gold.fact_sales] f  
    LEFT JOIN [gold.dim_products] c  
        ON f.product_key = c.product_key  
    GROUP BY c.product_name  
) t  
WHERE rank_products <= 5  

-- Find the Top 10 Customers Who have Generated the highest Revenue 

SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
sum(f.sales_amount) AS Total_Revenue
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY Total_Revenue desc

-- The 3 Customers with the Fewest orders placed 
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(f.order_number) AS orders,
RANK() OVER(ORDER BY COUNT(f.order_number) ASC) as total_order_rank
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name

SELECT *
FROM
(SELECT 
    c.customer_key, 
    c.first_name, 
    c.last_name, 
    COUNT(f.order_number) AS orders, 
    DENSE_RANK() OVER(ORDER BY COUNT(f.order_number) ASC) AS total_order_rank
FROM [gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c 
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name)t
WHERE t.total_order_rank<=3

SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT f.order_number) AS Total_order
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY Total_order ASC
