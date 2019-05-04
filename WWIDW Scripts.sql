
---Selecting a table from, the Stock Item Dim
SELECT [Stock Item Key], 
       [Stock Item], 
       [Is Chiller Stock], 
       [Lead Time Days], 
       [Selling Package], 
       [Unit Price], 
       [Recommended Retail Price]
FROM [Dimension].[Stock Item]
---WHERE [Is Chiller Stock] = 1  optional 
ORDER BY [Recommended Retail Price] DESC;

---Table for Customers DIM
 


---Table for Suppliers DIM


---Table for Movement Fact - Incoming and Outgoing

SELECT [Movement Key], 
       [Date Key], 
       [Stock Item Key], 
       [WWI Stock Item Transaction ID], 
       [WWI Invoice ID], 
       [WWI Purchase Order ID], 
       [Quantity]
FROM [Fact].[Movement];

---Tables for Stock Holding Fact
SELECT *
FROM [Fact].[Stock Holding];

---Table for Purchasing (for initial inventories) Purchase Fact (Qty ordered from Supplier)
SELECT *
FROM [Fact].[Purchase] 

---Table for Order Fact (includes BackOrders wherever field is Not Null)
SELECT  count([WWI Backorder ID] ) as TotalBackOrders
FROM [Fact].[Order] 
Where [WWI Backorder ID] is not null

SELECT [Order Date Key],  [WWI Backorder ID] , Quantity, [Unit Price], [Total Excluding Tax]
FROM [Fact].[Order] 
Where [WWI Backorder ID] is not null

SELECT [Sale Key],[Delivery Date Key],
       [Description], 
       [Quantity], 
       [Total Excluding Tax], 
       [Profit], 
       [Total Dry Items], 
       [Total Chiller Items]
FROM [Fact].[Sale];



Select * 
From [Fact].[Transaction]

Select *
From [Dimension].[Transaction Type]

Select *
From [Dimension].[Payment Method]