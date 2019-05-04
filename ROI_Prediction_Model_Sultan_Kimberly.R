---
title: "ROI Prediction Model"
author: "Kimberly Sultan"
date: "4/30/2019"
output: html_document
file: ROI_table1_Sultan_Kimberly.rmd
---
  
library(readr)
ROI_table1 <- read_csv("BDAT Capstone/ROI_table1.csv")

library(dplyr)
roi <- ROI_table1[,1:8]

#Factor and assigned new name "chilled"

roi$chilled <- factor(roi$`Is Chiller Stock`)
roi$stock_item <- factor(roi$`Stock Item Category`)
roi$price_zone <- factor(roi$`Price Zone`)

#Rename levels 
#levels(roi$chilled) <- c("notChilled", "chilled")

#Log transformation of numeric variables
roi$ROI_log <- log(roi$ROI)
roi$lead_time_days_log <- log(roi$`Lead Time Days`)
roi$unit_price_log <- log(roi$`Unit Price`)
roi$retail_price_log <- log(roi$`Recommended Retail Price`)

summary(roi)

#Select the analytical data set variables to use.
roi_data <- select(roi, 
                   "ROI_log", 
                   "chilled",
                   "stock_item", 
                   "price_zone",
                   "lead_time_days_log",
                   "unit_price_log",
                   "retail_price_log"
                   )

roi_data_numeric <- select(roi_data,"ROI_log", 
                                       "lead_time_days_log",
                                       "unit_price_log",
                                       "retail_price_log")

cor(roi_data_numeric)
plot(roi_data_numeric)

pairs(roi_data[,c("ROI_log","lead_time_days_log","retail_price_log")])

formula_all<- formula(ROI_log ~ lead_time_days_log + unit_price_log + 
                            retail_price_log + stock_item + price_zone)

mult_lm <- lm(formula_all, data = roi_data)

summary(mult_lm)

formula_sub <- (ROI_log ~ lead_time_days_log + retail_price_log + 
  stock_item)

#TRY gam
library(gam)
gam0 <- gam(formula_sub,
     data=roi_data)

summary(gam0)


gam1 <- gam(ROI_log ~ s(lead_time_days_log, 3) + stock_item, data=roi_data)


gam2 <- gam(ROI_log ~ retail_price_log + s(lead_time_days_log,3) + 
              stock_item, data=roi_data)
 
 
gam3 <- gam(ROI_log ~ s(retail_price_log, 2) + s(lead_time_days_log, 3) 
            + stock_item, data=roi_data)

anova(gam1, gam2, gam3, gam0)

############################### validate model (how well it does on test)

roi_data <- na.omit(roi_data)

set.seed(1)
train <- sample(1:nrow(roi_data), nrow(roi_data)*.8)
test  <- (1:nrow(roi_data))[-train]

library(randomForest)
set.seed(1)
fit_rand_forest <- randomForest(ROI_log ~ lead_time_days_log + 
                                  retail_price_log + stock_item,
                                data = roi_data, subset = train,
                                importance = T)

#Compute the test error using the test data set.

pred_rand_forest <- predict(fit_rand_forest, newdata=roi_data[test,], 
                            type="response")

trueObs= as.matrix(roi_data[-train, "ROI_log"])


MSE_rand_forest  <- mean((trueObs - pred_rand_forest)^2)
MSE_rand_forest


importance(fit_rand_forest)

varImpPlot(fit_rand_forest)
