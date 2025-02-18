create database data_analysis;

create table reatil_sales
  (
	  transactions_id	int,
	  sale_date date,
	  sale_time time,	
	  customer_id	int,
	  gender	varchar(15),
	  age	int,
	  category varchar(20),	
	  quantiy int,
	  price_per_unit	float,
	  cogs	float,
	  total_sale float
  );
  select * from reatil_sales;
  
  rename table reatil_sales to retail_sales;
  
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



select 
	customer_id,
	count(customer_id)
from retail_sales
group by customer_id
order by customer_id asc;

select gender, count(gender)
from retail_sales
group by gender;

select category from retail_sales
group by category;

select * from retail_sales
where transactions_id is null
      or price_per_unit is null 
      or quantiy is null 
      or cogs is null 
      or category is null 
      or sale_date is null
      or gender is null
      or customer_id is null
      or age is null
      or sale_time is null
      or total_sale is null;
	
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05    
select 
	* 
from retail_sales
where 
	sale_date= '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select 
	* 
from 
	retail_sales 
where 
	category= 'Clothing' and 
    date_format(sale_date, '%Y-%m')= '2022-11'
    and quantiy >3 ;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
	Category,
    sum(total_sale)
from 
	retail_sales
group by 
	category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
	category,
    avg(age)
from 
	retail_sales
where 
	category= 'Beauty'
group by 
	category;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale >'1000';


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
	gender,
	category,
    count(transactions_id)
from
	retail_sales
group by 
	gender, 
    category
order by 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(
	select month(sale_date), year(sale_date),round(avg(total_sale),2),
	rank() over(partition by  year(sale_date) order by round(avg(total_sale),2) desc) as position
	from retail_sales
	group by month(sale_date), year(sale_date)
	order by year(sale_date),round(avg(total_sale),2) desc
) a
where position = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales  
select * from retail_sales 
order by total_sale desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id), category
from retail_sales
group by category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select Shifts, count(*)
from(
select *, 
	case 
		when HOUR(sale_time) <=12 then 'Morning'
		when HOUR(sale_time) between 12 and 17  then 'Afternoon'
		else 'Evening'
   end as 'Shifts'
from retail_sales
   ) as Hourly_Sales
group by Shifts;




