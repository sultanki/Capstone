---Joined tables from Dimensions and Fact Sales on Customers and Salesperson and Location
SELECT Customer, 
       D.Date, 
       Location.Lat AS Latitude, 
       Location.Long AS Longitude, 
       SUM([Total Excluding Tax]) AS [Total Excluding Tax], 
       SUM([Total Including Tax]) AS [Total Including Tax], 
       SUM(Profit) AS Profit, 
       Employee AS SalesPerson
FROM Fact.Sale S
     JOIN Dimension.Customer C ON S.[Customer Key] = C.[Customer Key]
     JOIN Dimension.Employee E ON S.[Salesperson Key] = E.[Employee Key]
     JOIN Dimension.City Ci ON S.[City Key] = Ci.[City Key]
     JOIN Dimension.Date D ON S.[Invoice Date Key] = D.Date
GROUP BY Customer, 
         D.Date, 
         Location.Lat, 
         Location.Long, 
         Employee;


---Joined tables for Orders Fact and Stock Dimension
SELECT [Order Date Key], 
       [WWI Backorder ID], 
       [Stock Item], 
       [Lead Time Days], 
       [Quantity], 
       O.[Unit Price], 
       [Total Excluding Tax]
FROM [Fact].[Order] O
     JOIN Dimension.[Stock Item] S ON O.[Stock Item Key] = S.[Stock Item Key]
WHERE [WWI Backorder ID] IS NOT NULL;