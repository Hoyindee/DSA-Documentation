 # DSA-PROJECT-Documentation 1

This is where I started building my portfolio after classes are done via the Incubator Hub

I have Learnt quite a number of things ranging from Microsoft Excel to SQL down to use of Power BI and even Portfolio building

## PROJECT TOPIC: KULTRA MEGA STORE ANALYSIS

### PROJECT OVERVIEW

This Data analysis project aims to generate insight on sales performance for a mega store specialized in Office supplies and Furniture from 2009 to 2012. By analyzing various parameters in the data received, enough for thorough findings and insights to make an informed decision and more logical course of action.

### Data Sources
The Primary source of Data used here is a CSV Data file from DSA Data Analysis Team
* KMS SQL Case Study
* Order Status

### Tools Used 
- Ms Excel 
   - Data Cleaning and Preparation
- SQL Server
   - For Querying and Analysis

### Data cleaning/preparation
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

**Product Category with the highest Sales**
``` select top 1
  Sales, Product_Category
 from KMS_Sales_Table
 order by Sales desc```

Total sales in a particular region (Ontario)
```Select  Sum(Sales) AS TOTALSALES
	Where Product_Sub_Category ='Appliances' and Region ='Ontario'






 
