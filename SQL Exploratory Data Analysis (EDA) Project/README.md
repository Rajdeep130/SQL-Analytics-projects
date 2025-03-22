
# 📊 SQL Project: [Project Name]

## 📝 Overview
Briefly describe your project:
- What is the project about?
- What problem does it solve?
- What datasets are used?
- What insights are derived?

## 📂 Project Structure
Describe the folder structure if applicable:

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

