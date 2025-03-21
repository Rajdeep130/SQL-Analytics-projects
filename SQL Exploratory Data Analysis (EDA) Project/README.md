
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

