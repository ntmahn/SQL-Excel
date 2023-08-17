select * from pizza_sales

select sum(total_price) as Total_Revenue from pizza_sales

select sum(total_price) / count(distinct order_id) as Avg_Order_Value from pizza_sales

select sum(quantity) as Total_Pizza_Sold from pizza_sales

select count(distinct order_id) as Total_Orders from pizza_sales

select cast(cast(sum(quantity) as Decimal(10, 2)) / cast(count(distinct order_id) as Decimal(10, 2)) AS Decimal(10, 2)) as Avg_Pizzas_Per_Order from pizza_sales

--Daily Trend
select datename(DW, order_date) as Order_Day, count(distinct order_id) as Total_Orders
from pizza_sales
group by datename(DW, order_date)

--Hourly Trend
Select Datepart(hour, order_time) as Order_Hours, count(distinct order_id) as Total_Orders
from pizza_sales
group by datepart(Hour, order_time)
order by datepart(hour, order_time)

--Percentage of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


select pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 /
(select sum(total_price) from pizza_sales where month(order_date) =1) as PCT
from pizza_sales
where month(order_date) = 1  --month(order_date) = 1 indicates that the output is for the month of January
group by pizza_category


Select pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
from pizza_sales
where month(order_date) = 1
group by pizza_category

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


--Percentage of Sales by Pizza Size
select pizza_size, sum(total_price) as Total_Sales, sum(total_price) * 100 /
(select sum(total_price) from pizza_sales) as PCT
from pizza_sales
group by pizza_size
order by PCT Desc


select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales, cast(sum(total_price) * 100 /
(select sum(total_price) from pizza_sales where datepart(quarter, order_date) = 1) as decimal(10,2)) as PCT
from pizza_sales
where datepart(quarter, order_date) = 1 --DATEPART(QUARTER, order_date) = 1 indicates that the output is for the Quarter 1
group by pizza_size
order by PCT Desc

--Total Pizzas Sold by Pizza Category
Select pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_category

--Top 5 Best Seller by Total Pizzas Sold
select top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc

--Bottom 5 Worst Sellers by Total Pizzas Sold
select top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc