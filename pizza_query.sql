use Pizza_Database
select * from pizza_sales


--1. Total Revenue:
select sum(total_price) as Total_revenue from pizza_sales

--2. Average Order Value
select sum(total_price)/count(distinct order_id) as Average_order from pizza_sales

--3. Total Pizzas Sold
select sum(quantity) as Total_sold from pizza_sales

--4. Total Orders
select count(distinct order_id) as total_order from pizza_sales

--5. Average Pizzas Per Order

select cast(cast (sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal (10,2)) as Average_pizza
from pizza_sales

--6.Daily Trend for Total Orders
select DATENAME(DW,order_date) as Days,count(distinct order_id)as orders
from pizza_sales group By DATENAME(DW,order_date)

--Hourly Trend for Orders
select DATEPART(hour,order_time) as Hourly,count(distinct order_id)as orders
from pizza_sales
group by DATEPART(hour,order_time)
order by count(distinct order_id)  desc

--D. % of Sales by Pizza Category

select pizza_category,cast(sum(total_price)as decimal(10,2))as total_revenue,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales)as decimal(10,2))
as perc_sales from pizza_sales
group by pizza_category

--E. % of Sales by Pizza Size
select pizza_size,cast(sum(total_price)as decimal(10,2))as total_revenue,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales)as decimal(10,2))
as perc_sales from pizza_sales
group by pizza_size
order by sum(total_price) desc

--F. Total Pizzas Sold by Pizza Category
select pizza_category,sum(quantity)as Total_quantity,sum(total_price) as Total_sold
from pizza_sales
group by pizza_category

--G. Top 5 Best Sellers by Total Pizzas Sold
select pizza_name,sum(quantity) as Most_sold
from pizza_sales 
group by pizza_name
order by Most_sold desc

--H. Bottom 5 Best Sellers by Total Pizzas Sold
select top 5 pizza_name,sum(quantity) as bottom_sold
from pizza_sales 
group by pizza_name
order by bottom_sold asc