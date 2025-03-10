USe Blinkitdb

select * from blinkit_data;



--Cleaning the Data
--Cleaning the Item_Fat_Content Column
Update Blinkit_data
set Item_Fat_Content = --Mentioning the column name
case -- we gotta update multiple valuewe use Case 
when Item_Fat_Content in ('lf','low fat') then 'Low Fat'
when Item_Fat_Content ='reg' then 'Regular'
Else Item_Fat_Content
end

select distinct(Item_Fat_content) from Blinkit_data;



--Building the Businees Requirements(Total_Sales)
Select round(sum(Total_Sales)/100000,2) as Total_Sales_in_Lakhs
from Blinkit_data;

-- Avrage Sales
select round(avg(Total_Sales),1) as Average_Sales 
from Blinkit_data;

-- Number of Items
select count(*) as Number_Of_Items 
from Blinkit_data;

--Average Ratings
Select Round(AVG(Rating),0) as Average_Rating_Overall from Blinkit_data ;

Select Item_Type,Round(AVG(Rating),0) as Average_Ratings_by_Items_Type from Blinkit_data 
group by Item_Type;


select * from Blinkit_data;

--Granular Requirements
--Total sales by fat Content(with some Key Metrics)
select Item_Fat_Content,
	count(Item_Identifier) as No_of_Items,
	Round(sum(Total_Sales),0) as Total_Sales_in_Lakhs,
	Round(avg(Total_Sales),0) as Average_Sales,
	Round(avg(Rating),0) as Average_Ratings
from Blinkit_data
group by Item_Fat_Content
Order by Total_Sales_in_Lakhs desc;

--Total sales by Item Types(with some Key Metrics)
select Top 5 Item_Type,
	count(Item_Identifier) as No_of_Items,
	Round(sum(Total_Sales)/1000,1) as Total_Sales_in_Thousands,
	Round(avg(Total_Sales),0) as Average_Sales,
	Round(avg(Rating),0) as Average_Ratings
from Blinkit_data
group by Item_Type
Order by Total_Sales_in_Thousands desc;
 
 -- Fat Content by outlet for Total sales
SELECT Outlet_Location_Type,
       ISNULL([Low Fat], 0) AS Low_Fat,
       ISNULL([Regular], 0) AS Regular
FROM
(
    SELECT Outlet_Location_Type, Item_Fat_Content,
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT -- Pivot used to convert columns to rows
(
    SUM(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

--Total Sales by Outlet establishment
select Outlet_Establishment_Year,Round(sum(Total_Sales)/1000,0) as Total_Sales_in_Thousands from Blinkit_data
Group by Outlet_Establishment_Year
order by Outlet_Establishment_Year Desc;

--Percentage of sales by outlet size
SELECT 
    Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage -- sales of a particular outlet divided by total sales
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

--Sales by outlet location
SELECT 
    Outlet_Location_Type,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

--Selectiong all the metrics based on outlet type
select Outlet_Type,
	count(Item_Identifier) as No_of_Items,
	Round(sum(Total_Sales)/1000,1) as Total_Sales_in_Thousands,
	Round(avg(Total_Sales),0) as Average_Sales,
	Round(avg(Rating),2) as Average_Ratings
from Blinkit_data
group by Outlet_Type
Order by Total_Sales_in_Thousands desc;

	 



select * from blinkit_data;










