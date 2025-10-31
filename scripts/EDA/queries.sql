-- retrive a list of unique countries from which customers originate 

select distinct country from gold.dim_customers;


-- retrive a list of unique categories , sub categories and products

select distinct category,
subcategory,
product_name
from gold.dim_products;

-- DATE Exploration- determine the first and last order date and the total duration in months.

select 
MIN(order_date) as first_order_date,
MAX(order_date) as last_order_date,
DATEDIFF(month,min(order_date),max(order_date)) as order_range_months
from gold.fact_sales;


-- find the youngest and oldest customer based on birthdate 
select
min(birthdate) as oldest_birthdate,
datediff(year,min(birthdate),getdate()) as oldest_Age,
max(birthdate) as youngest_birthdate,
datediff(year,max(birthdate), getdate()) as youngest_Age      -- for checking which is in in which table == see data model image
from gold.dim_customers;


use datawarehouse1;
-- find the Totalsales

select sum(sales_amount) as Total_Sales
from gold.fact_sales;

-- find how many items are sold

select sum(quantity) as total_quantity 
from gold.fact_sales;

-- find the average  selling price
 
select avg(price) as avg_price
from gold.fact_sales;

-- find the total no of customers

select count(distinct(customer_key)) as Total_customers
from gold.dim_customers;

-- find the total products
select count(distinct(product_name)) as Total_products
from gold.dim_products;


-- find the total no of customers that has places an order

select count(distinct customer_key) as total_customers 
from gold.fact_sales

-- find the total no of orders

select count(order_number) as total_orders
from gold.fact_sales;
select count(distinct order_number) as total_orders 
from gold.fact_sales;



-- generate a report which shows KPI's of business

select 'Total_Sales' as measure_name , sum(sales_amount) as measure_value from gold.fact_sales
union all
select 'total_quantity' as measure_name ,sum(quantity) as measure_value from gold.fact_sales
union all
select 'avg_price' as measure_name, avg(price) as measure_value from gold.fact_sales
union all
select 'Total_orders' as measure_name ,count(distinct order_number) from gold.fact_sales
union all 
select 'Total_products' as measure_name,count(distinct product_name) from gold.dim_products
union all
select 'Total_customers' as measure_name,count(distinct customer_key) from gold.dim_customers



--Magnitutde analaysis
--find the total customers by countries

select  country,
count(customer_key) as total_customers
from gold.dim_customers
group by country
order by total_customers desc;



 -- find total customers by gender

 select gender ,
 count(customer_key) as total_customers
 from gold.dim_customers
 group by gender
 order by total_customers desc;

 -- find the total products by category
 select 
    category,
    count(product_key) as total_products
    from gold.dim_products
    group by category
    order by total_products desc;

-- find the average costs in each category 

select category,
avg(cost) as avg_cost
from gold.dim_products
group by category
order by avg_cost desc;


-- what is the total revenue generated for each category?

---select 
  --  p.category,
  --  sum(f.sales_amount) as total_revenue
--from gold.fact_sales f
--left join gold.dim_products p
  --  on p.product_key = f.product_key
--group by p.category
--order by total_revenue desc;


SELECT 
    p.category,
    SUM(CAST(f.sales_amount AS BIGINT)) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- what is the total revenue generated for each customer?

select 
    c.first_name,
    c.last_name,
    sum(f.sales_amount) as total_revenue
from gold.fact_sales f
left join  gold.dim_customers c
on c.customer_key =f.customer_key
group by 
c.first_name,
c.last_name
order by total_revenue desc;

select * from gold.fact_sales


-- what is the distribution of sold items across countries

select 
c.country,
sum(f.quantity) as total_sold_items 
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by c.country 
order by total_sold_items desc;


-- RANKING ANALASIS

-- which 5 products generating the highest Revenue?
-- simple Ranking

select top 5 
p.product_name,
sum(f.sales_amount) as total_Revenue
from gold.fact_sales f 
left join gold.dim_products p
on p.product_key = f.product_key
group by p.product_name 
order by total_revenue desc;


-- which 5 products generating the lowest revenue?

select top 5 
p.product_name,
sum(f.sales_amount) as total_revenue
from gold.fact_sales f 
left join gold.dim_products p
on p.product_key = f.product_key
group by p.product_name
order by total_revenue asc;


-- find the top 10 customers who have generated the highest revenue
select top 10
c.customer_key,
c.first_name,
c.last_name,
sum(f.sales_amount) as total_Revenue
from gold.fact_sales f 
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by c.customer_key,
c.first_name,
c.last_name
order by total_revenue desc;
