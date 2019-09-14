##################################################
#
# Author:      	  Kimberly Sultan
# Date:		        May 3, 2019
# Subject:      	Capstone_R_Scripts
# Section:      	SP 02
# Instructor:   	
# File Name:    	ConnectingToSqlServer_Sultan_Kimberly.R
# 
##################################################

#Libraries to install

#install.packages("DBI")
#install.packages("odbc")


#Load Libraries
library(DBI)
library(odbc)

#Create connection object
con <- dbConnect(odbc(), 
                 Driver = "SQL Server", 
                 Server = "DESKTOP-TKNTSC4", 
                 Database = "WideWorldImportersDW", 
                 Trusted_Connection = "True")

#Create a 'results' object to save sql query results and query 
#Include query here as argument to dbGetQuery()

result <- dbGetQuery(con,'SELECT 
       [Stock Item Key], 
       [Stock Item], 
       [Is Chiller Stock], 
       [Lead Time Days], 
       [Selling Package], 
       [Unit Price], 
       [Recommended Retail Price]
FROM [Dimension].[Stock Item]
ORDER BY [Recommended Retail Price] DESC;')

#To review results
summary(result)
head(result)


#Disconnect once your data is loaded into environment 
#This will end session
dbDisconnect(con)


