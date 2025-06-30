CREATE DATABASE KMS_DB

----NAME: KULTRA MEGA STORE INVENTORY ANALYSIS----

-----IMPORT TABLE..... 
SELECT * FROM KMS_Sales_Table

-----CASE SCENARIO 1
---Product Category with the Highest sales

 select top 1 
  Sales, Product_Category
 from KMS_Sales_Table
 order by Sales desc
 ---more detailed query--- 
Select top 1
order_ID, Order_Quantity, Customer_Segment, Customer_Name, 
       Product_Category, Product_Name, Region, Sales
  FROM KMS_Sales_Table
  ORDER BY Sales desc

---THE TOP 3 AND BOTTOM 3 REGION IN TERMS OF SALES--
-----Top 3 Region-----	
select top 3 
order_ID, Order_Quantity, Customer_Segment, Customer_Name, 
       Product_Category, Product_Name, Region, Sales, Profit
  FROM KMS_Sales_Table
  Order BY Sales desc
  ------Bottom 3 Region----
 select top 3 
order_ID, Order_Quantity, Customer_Segment, Customer_Name, 
       Product_Category, Product_Name, Region, Sales, Profit
  FROM KMS_Sales_Table 
  Order BY Sales ASC  

  ---TOTAL SALES OF APPLIANCES IN ONTARIO---
  
    SELECT  SUM(Sales) AS TOTALSALES
	from KMS_Sales_Table
	WHERE Product_Sub_Category ='Appliances' and Region ='Ontario' 

     -----MOST SHIPPING COST -----
	 SELECT Top 1 
    Order_ID,
	Order_Quantity,
	Shipping_Cost,
	Sales,
    Profit,
	Product_Category,
	Ship_Mode,
    Customer_Segment
	from KMS_Sales_Table 
	 ORDER BY Ship_Mode DESC
    OR
	 SELECT TOP 1
			Shipping_Cost, Ship_Mode
	from KMS_Sales_Table
	
		

----CASE SCENARIO 2----
------most valuable customers and product they purchase----
 ---query with some selected parameters---
 Select Top 10
       Customer_Name,
       Order_ID,
	   Order_Quantity,
	   Product_Name,
	   Product_Category,
	   Profit,
	   Sales
From KMS_Sales_Table
Order by Profit DESC

----Bottom 10 Customers---
 Select Top 10
       Customer_Name,
       Order_ID,
	   Order_Quantity,
	   Product_Name,
	   Product_Category,
	   Profit,
	   Sales
From KMS_Sales_Table
Order by Profit ASC

----SMALL BUSINESS OWNER WITH THE HIGHEST SALE----
select top 1
    Order_ID
	Order_Quantity,
	Customer_Name,
    Customer_Segment,
	Sales
 FROM KMS_Sales_Table
 where Customer_Segment = 'Small Business'
 Order by Sales desc

 ------CORPORATE CUSTOMER THAT PLACED MOST NUMBER OF ORDER IN 2009 to 2012----

 select Top 1 * FROM
 KMS_Sales_Table
  where Year  (Order_Date) IN (2009,2010,2011,2012) and Customer_Segment = 'Corporate'
  Order by Order_Quantity desc
	
	--- a detailed query with some selected parameters--- 
select
  Customer_Name,
  Order_Quantity,
  Order_Date,
  Customer_Segment
  from KMS_Sales_Table
  where Customer_Segment = 'Corporate' and Customer_Name = 'Barry Weirich'
  order by Order_Quantity desc

  -----CONSUMER CUSTOMER WITH THE MOST PROFIT-----
  select Top 1
  Order_ID,
  Order_Quantity,
  Profit,
  Customer_Name,
  Customer_Segment
  from KMS_Sales_Table
  where Customer_Segment = 'Consumer'
  Order by Profit desc
  or
  select Top 1 * from KMS_Sales_Table
	where Customer_Segment = 'Consumer'
	order by Profit desc

---importing Table II----

  Select * from Order_Status

  ----joining table II to table the main table (kMS detailed table)
  ---CUSTOMER THAT RETURNED ITEMS AND SEGMENT THEY BELONG TO---
	Select * from 
		 [dbo].[Order_Status] as Ord
		JOIN(
	Select Order_ID,Customer_Name,Customer_Segment
		   from KMS_Sales_Table) as KMS
		ON Ord.Order_ID = KMS.Order_ID

------Ship method that is economical compare to an expensive one by order of priority----- 
--- creating view with some selected parameters for a more compact data---

Create view vw_NEW_KMS_tbl
AS
select
  Order_Quantity,Order_Priority,Customer_Name,
  Customer_Segment,Product_Category,Shipping_Cost,
  Ship_Mode,Sales,Discount,Profit
from KMS_Sales_Table

Select * from vw_NEW_KMS_tbl

 SELECT Order_Quantity, Order_Priority, Ship_Mode, Shipping_Cost
   FROM vw_NEW_KMS_tbl
    where  Ship_Mode = 'Delivery Truck'
    

SELECT Order_Quantity, Order_Priority, Ship_Mode, Shipping_Cost
   FROM vw_NEW_KMS_tbl
where  Ship_Mode = 'Express Air'

----Product returned due to mismatch shipping method a potential result of profit loss----
Select * from 
		 [dbo].[Order_Status] as Ord
		JOIN(
	Select Order_ID, Order_Quantity,Order_Priority,
	Ship_Mode,Shipping_Cost,Profit,Sales 
		   from KMS_Sales_Table) as KMS
		ON Ord.Order_ID = KMS.Order_ID
		where status = 'Returned' AND Profit < 3 And Order_Priority = 'Critical'

---- Discount is not uniformed for a Specific Number of Purchase----
 Select Order_Quantity, Discount, Profit, Product_Category
   from vw_NEW_KMS_tbl

  ---- Shipping Cost does Not Match Order Of Priority/Shipping Method----
   Select Order_Quantity, Order_Priority, Ship_Mode, Shipping_cost
     from vw_NEW_KMS_tbl

 select distinct Ship_Mode
	 from vw_NEW_KMS_tbl
	 order by Ship_Mode desc 

 Select distinct Product_Category
  from vw_NEW_KMS_tbl
  order by Product_Category desc
	  
	  
