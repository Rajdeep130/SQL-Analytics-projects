
# 🛒 Retail Business Sales Analysis Project

# 📖 Overview
This project focuses on exploring and analyzing a Retail Sales Database containing customers, products, and sales data using SQL. The goal is to perform data exploration, business metrics calculation, segmentation, and ranking analysis to derive actionable business insights.

### The analysis covers:

- Data Exploration (Tables, Columns, and Dimensions)
- Customer Demographics and Segmentation
- Product Category Insights
- Sales Trends (First and Last Order Dates)
- Key Business Metrics (Revenue, Orders, Products, Customers)
- Magnitude Analysis (By Country, Gender, Category)
- Ranking Analysis (Top/Bottom Products and Customers)
- Pre-built SQL report generation with UNION ALL
- The results of this project will help businesses understand customer behavior, product performance, and revenue generation trends.

## 📂 Project Structure
   ```
Retail-Sales-SQL-Analysis/
│
├── README.md                        # Project Overview and Structure
├── SQL/
│   ├── 01_data_exploration.sql      # Explore tables, columns, and dimensions
│   ├── 02_dimension_exploration.sql # Customer countries, product categories
│   ├── 03_date_exploration.sql      # First/Last order, order range, age insights
│   ├── 04_key_metrics.sql           # Total Sales, Orders, Products, Customers
│   ├── 05_report_summary.sql        # Pre-built summary report using UNION ALL
│   ├── 06_magnitude_analysis.sql    # Segmentation by country, gender, category
│   ├── 07_ranking_analysis.sql      # Top/Bottom products and customers analysis
│
├── Images/
│   ├── data_exploration.png
│   ├── dimension_exploration.png
│   ├── date_exploration.png
│   ├── key_metrics.png
│   ├── magnitude_analysis.png
│   ├── ranking_analysis.png
│
└── Dashboard/
    ├── Insights.pptx                 # Optional PowerPoint for business storytelling
    └── dashboard_sample.png          # Optional visualization preview
  ```
## 🚀 SQL Queries & Analysis
Describe the key SQL operations performed:
## 1. Data Exploration : 
**Explore All Objects in the Database**
   ```sql
   SELECT * FROM INFORMATION_SCHEMA.TABLES;
   ```
![image](https://github.com/user-attachments/assets/6683e233-2079-4b49-a67b-6407c26b6a84)

**Explore All columns in the Database**
   ```sql
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'gold.dim_customers'
```
![image](https://github.com/user-attachments/assets/90174b98-47db-4e09-b9d8-fc6e3c4449b5)

## 2. Dimension Exploration:

**Explore All Countries our Customers come from.**
   ```sql
SELECT DISTINCT country
FROM
	[gold.dim_customers]
   ```


**All the product categories "The Major Division".**

```sql
SELECT DISTINCT category
FROM
	[gold.dim_products];

SELECT DISTINCT category,subcategory
FROM
	[gold.dim_products];

SELECT DISTINCT category,subcategory, product_name
FROM
	[gold.dim_products]
 ```
![image](https://github.com/user-attachments/assets/8ccc826d-261f-4834-8bb1-1c100677497f)

## 3. Date Exploration :
** Find the date of the first and last order **
```sql
SELECT order_date FROM [gold.fact_sales]

SELECT min(order_date) AS first_order_date,
max(order_date) AS last_order_date
FROM [gold.fact_sales]
```
![image](https://github.com/user-attachments/assets/d1f6aee6-673e-46b7-b97c-c0b095f93e68)

**How many years of sales are available**
```sql
SELECT min(order_date) AS first_order_date,
max(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date),max(order_date)) AS order_range_in_years
FROM [gold.fact_sales]
```
![image](https://github.com/user-attachments/assets/118c9594-21d4-4818-9dca-f51e2a6a1dce)

**How many month of sales are available**
```sql
SELECT min(order_date) AS first_order_date,
max(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date),max(order_date)) AS order_range_in_years
FROM [gold.fact_sales]
```
![image](https://github.com/user-attachments/assets/929de17b-5932-420b-9efa-d44c5b04d0d0)
**Find the youngest and oldest customer**
```sql
SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate
FROM
	[gold.dim_customers]
```
![image](https://github.com/user-attachments/assets/5c338e8f-2ec4-4637-85a6-1f98bb5a0920)

## 📊 Measures Exploration

Below are the key business metrics calculated using SQL.

### 📌 Key Business Metrics Queries

- **Total Sales**  
  ```sql
  SELECT SUM(sales_amount) AS total_sales FROM [gold.fact_sales];
  ```
![image](https://github.com/user-attachments/assets/f3d522b2-4b9e-4305-afad-30afe3a0047c)

  **Find how many items are sold**
    ```sql
    SELECT SUM(quantity) AS total_quantity FROM [gold.fact_sales]
        ```
![image](https://github.com/user-attachments/assets/3b890e4f-0436-43a4-ad1c-b36684fc3833)

**Find the average selling price**
   ```sql
   SELECT AVG(price) AS Avg_selling_price FROM [gold.fact_sales]
 ```
![image](https://github.com/user-attachments/assets/e687e9d2-06e3-4875-8a80-5b0cc553ceb9)

**Find the total number of orders**
   ```sql
SELECT COUNT(order_number) AS total_orders FROM [gold.fact_sales];

SELECT COUNT(DISTINCT order_number) AS total_orders FROM [gold.fact_sales];
   ```
![image](https://github.com/user-attachments/assets/6b58b80a-cd1e-4be8-9ed4-d146b518171e)

**Find the total number of products**
   ```sql
SELECT COUNT(DISTINCT product_name) AS total_products FROM [gold.dim_products]
   ```
![image](https://github.com/user-attachments/assets/a2e7c81f-e12b-447e-8539-df04b1d58509)


**Find the total number of customers**
   ```sql
SELECT COUNT(customer_key) AS total_customers FROM [gold.dim_customers];
   ```
![image](https://github.com/user-attachments/assets/5a716139-f37f-46f2-b46d-0b938d5e9f7e)

**Find the total number of customers that has placed an order**
   ```sql
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM [gold.fact_sales]
 ```
![image](https://github.com/user-attachments/assets/7b19ca8c-4c8c-4b9c-8313-4d57f4738f48)

## 📃Generate a Report that shows all key metrics of the business
   ```sql
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM [gold.fact_sales]
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM [gold.fact_sales]
UNION ALL
SELECT 'Avg Selling Price' AS measure_name, AVG(price) AS measure_value FROM [gold.fact_sales]
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM [gold.fact_sales]
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(DISTINCT product_name) AS measure_value FROM [gold.dim_products]
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM [gold.dim_customers]
UNION ALL
SELECT 'Total Active Customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM [gold.fact_sales];
   ```
![image](https://github.com/user-attachments/assets/d9477f7d-684d-46fc-994d-5db7f57d8e6a)

**to Create a Report like this  using CHART GPT then write this PROMPT: 
Create a SQL report using a UNION ALL format, where each measure
has a descriptive name in the measure_name column and its calculated 
value in the measure_value column.**

## Magniture

**Find total customers by countries**
   ```sql
SELECT
country,
COUNT(customer_key) AS total_customers
FROM
	[gold.dim_customers]
GROUP BY country
ORDER BY total_customers DESC
   ```
![image](https://github.com/user-attachments/assets/b68555b8-ff94-4899-9332-f279b977aab5)
![image](https://github.com/user-attachments/assets/b07d662b-9e6c-41fa-a986-029d20404520)

**Find total customers by gender**
 ```sql
SELECT
gender,
COUNT(customer_key) AS total_customers
FROM
	[gold.dim_customers]
GROUP BY gender
ORDER BY total_customers ASC
 ```
![image](https://github.com/user-attachments/assets/674d4dc8-24fb-4a48-8b04-d4ff36b22b3b)

![image](https://github.com/user-attachments/assets/9780c88d-9bff-40b9-bc72-bfbcb399a573)
**Find total products by category**
 ```sql
SELECT
category,
COUNT(product_id) AS total_products
FROM
	[gold.dim_products]
GROUP BY category
ORDER BY total_products ASC
 ```
![image](https://github.com/user-attachments/assets/ae6addfd-154d-4ec7-bdd6-fa7c6a90a293
![image](https://github.com/user-attachments/assets/646e1b4f-cf1f-438f-b286-144ce9ec4ca4)


**What is the average costs in each category?**

 ```sql
SELECT
category,
AVG(cost) AS Avg_costs
FROM
[gold.dim_products]
GROUP BY category
ORDER BY Avg_costs ASC
 ```
![image](https://github.com/user-attachments/assets/e65fd5ce-1297-4ef4-8c41-17a5315ed34e)
![image](https://github.com/user-attachments/assets/6c27edc3-caae-4daa-8b08-5c7b4ac6e1c9)

**What is the total revenue generated for each category?**
 ```sql
SELECT 
p.category,
sum(f.sales_amount) AS Total_Revenue
FROM
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] p
ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY Total_Revenue ASC
 ```
![image](https://github.com/user-attachments/assets/633f0840-9bcb-4fa1-92b1-09805d9d11b5)
![image](https://github.com/user-attachments/assets/11c8453f-c2f9-4f89-95ff-20576fa84af9)


**What is the total revenue generated by each customers?**

 ```sql
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
 ```
![image](https://github.com/user-attachments/assets/2a348e61-968e-4dca-b2b6-bd39c8fcebf0)

**What is the distribution of sold items across countries?**
 ```sql
SELECT 
c.country,
sum(f.quantity) AS Total_sold_items
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_customers] c ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY Total_sold_items ASC
 ```
![image](https://github.com/user-attachments/assets/f6dc1276-1509-4212-ae78-810b18fb374b)
![image](https://github.com/user-attachments/assets/0e2cd809-446b-4afe-abe7-ed30e2a4093f)

## Ranking_Analysis
**Which 5 Products generate the highest revene**
 ```sql
SELECT TOP 5
c.product_name,
sum(f.sales_amount) AS Total_revenue
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] c ON f.product_key = c.product_key
GROUP BY c.product_name
ORDER BY Total_revenue DESC

-- Using Window Function

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
 ```
![image](https://github.com/user-attachments/assets/4eda40b5-90f9-4b4e-8619-03ecd21dd5c6)

**What are the 5 worst-perfoming products in terms of sales**
 ```sql
SELECT TOP 5
c.product_name,
sum(f.sales_amount) AS Total_revenue
FROM 
[gold.fact_sales] f
LEFT JOIN [gold.dim_products] c ON f.product_key = c.product_key
GROUP BY c.product_name
ORDER BY Total_revenue ASC

-- Using Window Function

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
 ```
![image](https://github.com/user-attachments/assets/73da7379-670c-44ff-8ebc-55abffc32ec7)

**Find the Top 10 Customers Who have Generated the highest Revenue**
 ```sql
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
 ```
![image](https://github.com/user-attachments/assets/06f1645a-c094-4519-a327-d94ecdb899c8)

**The 3 Customers with the Fewest orders placed**

 ```sql
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

-- Using Window Function

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
 ```

## Advance Analytics

**Changes Over time Analysis: Analyze Sales Performance Over Time**

 ```sql

SELECT 
YEAR(order_date) AS order_year,
sum(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity 
from [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date) DESC
 ```
![image](https://github.com/user-attachments/assets/d0020708-5582-4657-a8d6-341b144498aa)

 **A high_level overview insights that hleps with strategic decision-making.**

 ```sql
SELECT 
MONTH(order_date) AS order_month,
sum(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity 
from [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date) DESC
 ```
 ![image](https://github.com/user-attachments/assets/bb8c0e87-f217-48f0-a8b0-656e92b19ba8)

 ```sql
 SELECT 
DATETRUNC(month, order_date) AS order_month,
sum(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity 
from [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)
 ```
-- one thing you will notice here that output will have sorted date here 
-- beacuse output is Date not string.
![image](https://github.com/user-attachments/assets/7d735b10-c2a5-4b50-8286-d21d23aa6503)

 ```sql
SELECT
FORMAT(order_date, 'yyyy-MMM') AS order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM [gold.fact_sales]
WHERE order_date IS NOT NULL 
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER BY FORMAT(order_date,'yyyy-MMM');
 ```
-- If you look into the output you will found result is 
-- not sorted accounding to order date 
-- beacuse order_date is in string format

## Cumulative Analysis
**Purpose:**

    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

**Calculate the total sales per month and the running total of sales over time.**
 ```sql
-- First Create subquery like this then go for cumulative total

SELECT 
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM [gold.fact_sales]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)
 ```
 ```sql

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
 ```
![image](https://github.com/user-attachments/assets/a4b102f5-788f-4aee-ae24-e7b7e1afd24c)


**If you want to look for moving Avg also**
 ```sql
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
 ```

## Performance Analysis (Year-over-Year, Month-over-Month)
**Purpose:**

    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

**SQL Functions Used:**

    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.

** Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales**

-- Year over Year Analysis
 ```sql
WITH yearly_product_sales AS
(SELECT 
	YEAR(f.order_date) AS order_year,
	p.product_name,
	SUM(f.sales_amount) AS current_sales
FROM
	[gold.fact_sales] f
LEFT JOIN
	[gold.dim_products] p ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY YEAR(f.order_date),
		 p.product_name)

SELECT
	order_year,
	product_name,
	current_sales,
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
	CASE 
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) >0 THEN 'Above Avg'
		WHEN current_sales- AVG(current_sales) OVER(PARTITION BY product_name) <0 THEN 'Below Avg'
		ELSE 'Avg'
	END AS avg_change,
-- Year-over-Year Analysis
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS py_sales,
	current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_py,
	CASE 
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) >0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) <0 THEN 'Decrease'
		ELSE 'No Change'
		END AS py_change
FROM
	yearly_product_sales
ORDER BY product_name, order_year;
 ```
![image](https://github.com/user-attachments/assets/2d5eef7d-e0bb-43bc-a83d-53d80d229404)
