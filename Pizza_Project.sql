create database if not exists pizza_db;
use pizza_db;

create table pizza_sales(
pizza_id int primary key, 
order_id int,	
pizza_name_id varchar(100),	
quantity int,	
order_date date,	
order_time time,	
unit_price float,	
total_price float,	
pizza_size varchar(100), 	
pizza_category varchar(100),	
pizza_ingredients varchar(100),
pizza_name varchar(100)
);
select * from pizza_sales;

use pizza_db;
-- Pizza_Kpi

-- 1. Total Revenue: The sum of the total price of all pizza orders.
	Select Round(Sum(Total_price),2) as "Total Revenue" from pizza_sales;

-- 2. Average Order Value: The average amount spent per order.
	Select Round(sum(total_price)/Count(distinct(order_id)),2) as "Average Order Value" from pizza_sales; 
    
-- 3. Total Pizzas Sold: The sum of the quantities of all pizza sold.
	Select Sum(quantity) as "Total Pizzas Sold" from pizza_sales;

-- 4. Total Orders: The total number of orders placed.
	Select Count(distinct(order_id)) as "Total Orders" from pizza_sales;
    
-- 5. Average Pizza Per Order: The average number of pizzas sold per order.
	Select Round(sum(quantity)/Count(distinct(order_id))) as "Average Pizza Per Order" from pizza_sales;
    
-- pizza_chart

    -- 1. Daily trend for total Orders.alter
	Select Day(order_date) as Day, Count(order_id) as "Total Orders" from pizza_sales
    Group by Day;
    
-- 2. Monthly Trend for Total Orders.
	Select hour(order_time) as Hours,count(order_id) as "Total Orders" from pizza_sales
    Group by Hours;

-- 3. Percentage of Sales by Pizza Category.
	Select pizza_category,Sum(quantity) as Sales from pizza_sales
    Group by pizza_category;

-- 4. Percentage of Sales by Pizza Size.
	Select pizza_size,Sum(quantity) as Sales from pizza_sales
    Group by pizza_size;

-- 5. Total Pizza Sold by Pizza Category.
	Select pizza_category,Count(*) as Total_Pizza_Sold from pizza_sales
    Group by pizza_category;

-- 6. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders.
	Select pizza_name, Round(sum(Total_price),2) as Revenue, sum(quantity) as Total_Quantity, count(*) as Total_Orders
    from pizza_sales
    Group by pizza_name
    Order by Revenue desc,Total_Quantity desc,Total_Orders desc limit 5;

-- 7. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders.
	Select pizza_name, Round(sum(Total_price),2) as Revenue, sum(quantity) as Total_Quantity, count(*) as Total_Orders
    from pizza_sales
    Group by pizza_name
    Order by Revenue,Total_Quantity,Total_Orders limit 5;