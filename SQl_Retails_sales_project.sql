-- sql retail sales project
create database	sql_project;
USE sql_project;

-- create table 
drop table if exists retail_sales;
create table retail_sales
(
transactions_id	 INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT
);
ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

select * from retail_sales
limit 10;

select count(*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantity is null 
or 
price_per_unit is null 
or 
cogs is null 
or 
total_sale is null
;

-- data cleaning

delete from retail_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantity is null 
or 
price_per_unit is null 
or 
cogs is null 
or 
total_sale is null
;

-- data exploration

-- how many sales we have ?
select count(*) as total_sales from retail_sales;

-- how many unique customers we have?
select count(distinct customer_id) as customers from retail_sales;

-- how many categoies we have?


-- data analysis / business key problems

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is atleast 4 in the month of Nov-2022:
select * from retail_sales
WHERE category = 'Clothing' 
AND quantity >= 4
AND date_format(sale_date, '%Y-%m') = '2022-11';

-- OR
SELECT * 
FROM  retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale),count(*) as total_orders from retail_sales
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age)) as average_age from retail_sales
where category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender, count(*) from retail_sales
group by category,gender
order by 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select *  from (
select  year(sale_date) as year , 
		month(sale_date) as month , 
		avg(total_sale),
        rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks
		from retail_sales
        group by 1,2
        ) as t1
        where ranks = 1;
        
-- Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) from retail_sales
group by 1
order by 2 desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count( distinct customer_id)
from retail_sales
group by 1;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17);
with hourly_sale as(
select *,
case
	when hour(sale_time) <= 12 then 'Morning'
    when hour(sale_time) between 12 and 17 then 'Afternoon'
    when hour(sale_time) >= 17 then 'Evening'
    end as shift
 from retail_sales) 
 select shift,count(*) as total_orders from hourly_sale
 group by shift;
 
 -- end of project













