select * from retail_sales limit 10;

--- DATA CLEANING

-- check NULL
select * from retail_sales
where
transactions_id is null
or gender is null 
or sale_date is null
or sale_time is null
or quantity  is null  
or cogs is null
or total_sale  is null;

-- Delete
delete from retail_sales 
where
transactions_id is null
or gender is null 
or sale_date is null
or sale_time is null
or quantity is null  
or cogs is null
or total_sale  is null;


-- DATA EXPLORATION
-- how many sale we have ? 2000 sales
select count(*) as total_sales from retail_sales;


-- how many customers we have ? 155 customers
select count(distinct customer_id) as total_customer
from retail_sales; 


-- how many category we have ? 3 categories
select distinct category from retail_sales;


-- how many gender we have ?
select count(*) , gender from public.retail_sales
group by 2;


select * from retail_sales limit 10;


-- DATA ANALYSIS & business key problems & answers

-- My Analysis & Findings


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales rs 
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select  from retail_sales rs 
where 
category = 'Clothing'
and quantity > 4
and to_char(sale_date, 'yyyy-mm') = '2022-11';



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category. 
select sum(total_sale) total_orders, category
from retail_sales rs 
group by 2;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) avg_age from retail_sales rs 
where category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where 
total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(*) , gender , category from retail_sales rs 
group by 2;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select avg_sales,
year_, 
month_
from
(
select
avg(total_sale) avg_sales , 
extract( year from sale_date) year_,
extract( month from sale_date) month_,
rank() over(partition by extract( year from sale_date) order by avg(total_sale) desc) rank
from retail_sales rs 
group by 2,3
)p where rank =1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select  
sum(total_sale) total_sales 
, customer_id 
from retail_sales rs 
group by 2
order by total_sales desc
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
select count(distinct customer_id), category
from retail_sales rs 
group by 2;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
sale_time,
CASE
	when extract(hour from sale_time) <= 12 then 'Moraning sale'
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	when extract(hour from sale_time) >17 then 'Evening'
end as shift 
from  retail_sales rs
group by 1;






