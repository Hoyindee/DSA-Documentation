 # DSA-PROJECT-Documentation 1

This is where I started building my portfolio after classes are done via the Incubator Hub



## PROJECT TOPIC: KULTRA MEGA STORE ANALYSIS

## TABLE OF CONTENT
  - [Project Overview](#project-overview)
  - [Data Sources](#data-sources)
  - [Tools Used](#tools-used)
  - [Data Cleaning/Preparation](#data-cleaningpreparation)
  - [Exploratory Data Analysis](#exploratory-data-analysis)
  - [Data Analysis](#data-analysis)
  - [Results/Findings](#resultsfindings)
  - [Recommendation](#recommendation)
  - [Limitation](#limitation)
  - [Reference](#reference)

### Project Overview

This Data analysis project aims to generate insight on sales performance for a mega store specialized in Office supplies and Furniture from 2009 to 2012. By analyzing various parameters in the data received, enough for thorough findings and insights to make an informed decision and more logical course of action.

### Data Sources
The Primary source of Data used here is a CSV Data file from DSA Data Analysis Team
* KMS SQL Case Study
* Order Status

### Tools Used
- Ms Excel [download here](https://www.office.com)
   - Data Cleaning and Preparation
- SQL Server [download here](https://www.microsoft.com/en-us/sql-server/sql-server-downloads?ocid=ORSEARCH_Bing&msockid=37f37467cc0868f21a926184cd15692a)
   - For Querying and Analysis

### Data cleaning/Preparation
1. 	Data Loading and Inspection
2. 	Check for missing Values

### Exploratory Data Analysis
EDA involved the exploring of the data to answer some key questions such as;
-	Which **Product category** had the highest sales? 
-	What are the **Top 3** and **Bottom 3** regions in terms of sales? 
-	What were the **Total sales** of appliances in Ontario? 
-	Who are the **10 bottom customers**?
-	KMS incurred the **most shipping cost** using which **shipping method**?
-	Who are the **most valuable customers**, and what products or services do they typically 
  	 purchase? 
-	Which **Small business customer** had the **Highest sales**? 
-	Which **Corporate Customer** placed most number of orders in **2009 – 2012**? 
-	Which **Consumer Customer** was the most **Profitable one**? 
-	Which Customer **Returned items**, and what **Segment** do they belong to? 
-	Was Shipping cost spent on order of priority as regard the shipping method use (Delivery Truck, Express Air)

### Data Analysis
This includes some basic lines of Code or queries worked with 
- Product Category with the highest Sale
``` SQL
     select top 1
  Sales, Product_Category
 from KMS_Sales_Table
 order by Sales desc
```
      
- Total sales in a specified region
 ``` SQL
       Select  Sum(Sales) AS TOTALSALES
	Where Product_Sub_Category ='Appliances' and Region ='Ontario'
  ```
       
- The method of shipping that cost the most
``` SQL
       Select Top 1
	Shipping_Cost, Ship_Mode
	from KMS_Sales_Table
```

- Top 3 And Bottom 3 Region in terms of Sales
- Top 3 Region
``` SQL
      Select Top 3 
Order_ID, Order_Quantity, Customer_Segment, Customer_Name, 
       Product_Category, Product_Name, Region, Sales, Profit
  FROM KMS_Sales_Table
  Order BY Sales desc
```
- Bottom 3 Region
``` SQL
      Select Top 3 
order_ID, Order_Quantity, Customer_Segment, Customer_Name, 
       Product_Category, Product_Name, Region, Sales, Profit
  FROM KMS_Sales_Table 
  Order BY Sales ASC
```

- Corporate Customer That Placed Most Number Of Order In 2009 to 2012
``` SQL
 select Top 1 * FROM
 KMS_Sales_Table
  where Year  (Order_Date) IN (2009,2010,2011,2012) and Customer_Segment = 'Corporate'
  Order by Order_Quantity desc
  ```

- Most Valuable Customers And Product they Purchase
``` SQL
Select Top 10
       Customer_Name,Order_ID,Order_Quantity,Product_Name,
        Product_Category,Profit,Sales
From KMS_Sales_Table
Order by Profit DESC
```

- Customer That Returned Items And Segment They Belong To
``` SQL
	Select * from 
		 [dbo].[Order_Status] as Ord
		JOIN(
	Select Order_ID,Customer_Name,Customer_Segment
		   from KMS_Sales_Table) as KMS
		ON Ord.Order_ID = KMS.Order_ID
```

- Shipping Cost does Not Match Order Of Priority/Shipping Method
``` SQL
   Select Order_Quantity, Order_Priority, Ship_Mode, Shipping_cost
     from vw_NEW_KMS_tbl
```

- Bottom 10 Customers
``` SQL
 Select Top 10
       Customer_Name,Order_ID,Order_Quantity,
       Product_Name, Product_Category,Profit,Sales
       From KMS_Sales_Table
       Order by Profit ASC
  ```

- Small Business Owner With The Highest Sales
``` SQL
select top 1
    Order_IDOrder_Quantity,Customer_Name,
    Customer_Segment,Sales
 FROM KMS_Sales_Table
 where Customer_Segment = 'Small Business'
 Order by Sales desc
```

- Example of Mismathed Shipping Method due to Urgency potentially Result to Product Returned and low or loss in Profit
``` SQL
Select * from 
   [dbo].[Order_Status] as Ord
   JOIN(
  Select Order_ID, Order_Quantity,Order_Priority,
  Ship_Mode,Shipping_Cost,Profit,Sales 
   from KMS_Sales_Table) as KMS
   ON Ord.Order_ID = KMS.Order_ID
   where status = 'Returned' AND Profit < 3 And Order_Priority = 'Critical'
```


### Results/Findings
This Analysis result is summarized as follow:
+ Sales are made but profit is not consistent – Sales is more for the Technology Product Category compare to others and more prominent in regions of Atlantic, Quebec and Prarie are thriving and we have more that are not doing good which is the wests and Yukon. We found out that the most shipping cost is the Regular Air mode. 

+ The KMS Management are not strict when it comes to discounting which majority of time leads to loss instead of profit, discounting is not a fixed amount.

+ We also got to know our valuable Customers about 10 of them, are those who sales, profit and quantity of order is more if not the highest and the category they belong,

+ We found out the name of the customer whose small business had the highest sale, the corporate customer with a consistent patronage from 2009 to 2012 and Consumer Customer that is profitable to our Store.

+ We went further to check if items were returned and we found out some customer returned items and what business segment they belong to could potentially be due to delay in orders reaching them in time due to lack of urgency and wrong shipping method. 

+ Lastly, we get to see that Shipping cost was never due to Order priority and even the mode or method of shipment did not give a sense of urgency.

### Recommendation
Base on the analysis, we recommend the following actions:

- **Discounting Customers should be Revised**
    - A policy should be implemented that guides the application of discount in sales for an agreed number of Orders, anything below should not be applied.
    - Only if the Profit Margin is high then discount should be considered.

- **Promote sales of Product in Technology Category**
  
  we deduced during our query that Technology category brings in the most sales so marketing every product under it
   1. Setting defined goals – Give each sales persons a target. A set number of items should be sold out by a set date
   2. Advertise new product to existing customers to try out
   3. Allow for upgrade of those items ordered when they bring it adding small incentives to appeal to them
   4. Ask for referrals and reviews for those items from returning Customers which could be drop on the store website
   5. Add New Payment Method such as instalment
      
- **Bundling products togethe**
 it could be only Technology product or even an addition of other items sold in the store and packaging them as a set will result in more sales creating awareness for other product sold which can lead to an increase in sales/Revenue.

 - **The Misuse and inconsistency of the Shipping method and order priority should be fixed**
     - Revise Shipping Policy enforcing that:
     -	Low priority or unspecified orders should go with a slower delivery method like the Delivery Truck, while
     -	High or critical priority as the matter of urgency should go with a faster method like the Express air or Regular Air depending on what they can afford

- **Revisit their shipping cost for each shipping method**
A shipping cost should reflect Urgency and Customers expectations
**Optimize Logistics** – we noticed during our Analysis that Regular Air method of shipping is more expensive than Express Air which is all wrong, considering by order of shipping method     Express Air is the most expensive.
    - Ensure Shipping method matches urgency
    - Ensure strict rule against undercharging Customers as regards the urgency of their order
    - Introduce a system that double checks orders to be delivered and Flag mismatch Shipping Choices
    - Payment should be according to urgency of order, number of orders, Product Container used for delivery then implement price list for shipping cost.
      
- **Celebrate our top Customers** 
A great way to build loyalty and increase in repeat business
    - A Personalized Thank You gift (a hand written thank you card, an Item customized with their name on it)
    - Give them a Spotlight- customer of the year or month hall of fame.
    - Start a Referral Reward Program
    - Create a Top Tier Customer Reward
        1. Special exclusive discount
        2. Early access to sales
        3. Birthday or Anniversary gift(which could be a Shoutout)

### Limitation

It was a large data set with some column that were not useful for my analysis. A Unique identifier could not be added to the main table and Unuseful column was not removed so as not to affect the original table instead view was created with a number of selected columns useful for understanding and interpreting my analysis.

### Reference

- DSA CLASS SERIES ON SQL
- 20 strategies to increase revenue [link](https://www.indeed.com/career-advice/career-development/increase-revenues)
- Tips for effectively managing a retail store [link](https://www.indeed.com/recruitment/c/info/effectively-managing-retail-store)










 
