Create Database Customer_Order;
Use Customer_Order;

Create Table Customer_Orders(
Order_ID Varchar(20) unique, 
Customer_ID Varchar(20) unique,
Customer_Name Varchar(50),
Order_Date Date,
Segment Varchar(20),
Region Varchar(20),
Product_Category varchar(20),
Product_Name Varchar(20),
Order_Value Decimal(10,2),
Discount varchar(5),
Profit decimal(10,2)
);

Select*from Customer_Orders;

ALTER TABLE customer_orders
ADD COLUMN Order_Date_New DATE,
ADD COLUMN Order_Value_New DECIMAL(10,2),
ADD COLUMN Profit_New DECIMAL(10,2);

UPDATE customer_orders
SET 
    Order_Date_New = STR_TO_DATE(`Order Date`, '%d-%b-%y'),
    Order_Value_New = CAST(`Order Value` AS DECIMAL(10,2)),
    Profit_New = CAST(Profit AS DECIMAL(10,2));

ALTER TABLE customer_orders
DROP COLUMN `Order Date`,
DROP COLUMN `Order Value`,
DROP COLUMN Profit;

ALTER TABLE customer_orders
RENAME COLUMN Order_Date_New TO Order_Date,
RENAME COLUMN Order_Value_New TO Order_Value,
RENAME COLUMN Profit_New TO Profit;

Select* from customer_orders;

Select sum(Order_value) as Total_Revenue
from customer_orders;

Select sum(Profit) as Total_Net_Profit
from customer_orders;

Select round((sum(Profit)/sum(Order_value))*100, 2) as Profit_Margin
from customer_orders;

SELECT AVG(Order_Value) AS Avg_Order_Value
FROM customer_orders;

#By Region

Select Region,
sum(order_value) as Total_Order_Revenue,
sum(Profit) as Total_Region_Profit from customer_orders
Group by Region
Order by Total_Order_Revenue desc;

#By Product_Category

Select Product_Category,
sum(order_value) as Total_Product_Category_Revenue,
sum(Profit) as Total_Product_Category_Profit from customer_orders
Group by Product_Category
Order by Total_Product_Category_Revenue desc;

#By Segment

Select Segment,
sum(Order_Value) as Total_segment_Revenue,
sum(Profit) as Total_Segment_Profit
from Customer_orders
group by Segment
order by Total_segment_Revenue desc;

# Top 10 Products

Select Product_Name,
sum(order_Value) as Total_Product_Revenue,
sum(profit) as Total_Product_Profit
from customer_orders
group by Product_name
order by Total_Product_Revenue desc
limit 10;

#Monthly Trend

Select Month(order_date) as Month,
sum(Order_Value) as Total_Monthly_Revenue,
Sum(Profit) as Total_Monthly_profit
from customer_orders
group by month(Order_date)
order by month;

#total salery - department wise

Select * total_salery from employee
sum(salery) as total_salery
group by department_name


