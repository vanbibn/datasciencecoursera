# Nathan W. Van Bibber
# 3/28/20

# Coursera Getting and Cleaning Data 
## Week 1 Quiz

library(tidyverse)

## 1. How many properties are worth $1,000,000 or more? ----

dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(dataurl, "Data/ACS_2006Idaho_housing.csv")

mydata <- read_csv("Data/ACS_2006Idaho_housing.csv")
head(mydata)
class(mydata)



# VAL = Property value - categorical variable
        #24 = $1,000,000 +

mydata %>% 
    select(VAL) %>% 
    filter(VAL >= 24) %>% 
    count()

# [1] 53



## Use the data from Question 1. Consider the variable FES in the code book. 
## 2. Which of the "tidy data" principles does this variable violate? ----

# FES = Family type and employment status --> tidy data only 1 var/ column



## 3. Download the Excel spreadsheet on Natural Gas Aquisition Program ----
##    Read rows 18-23 and columns 7-15 into R and assign result to "dat"
##    What is the value of: `sum(dat$Zip*dat$Ext,na.rm=T)` 
library(readxl)
# url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# download.file(url3, "Data/NGAP.xlsx")
dat <- read_xlsx("Data/NGAP_2.xlsx", range = "G18:O23")

sum(dat$Zip*dat$Ext,na.rm=T)

# [1] 36534720



## 4. 
library(XML)
url4 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

doc4 <- xmlTreeParse(url4, useInternal = T)
rootNode <- xmlRoot(doc4)
names(rootNode)
rootNode[[1]]
rootNode[[2]]
rootNode[[1]][[1]]
rootNode[[1]][[1]][[1]]
rootNode[[1]][[1]][[2]]  # there's the zipcode!

A <- xmlSApply(rootNode[[1]],"//row[@class='zipcode']", xmlValue)
els_zipcode <- getNodeSet(rootNode, "//zipcode")
zips <- xmlSApply(els_zipcode, xmlValue)
sum(zips == "21231")

# [1] 127



## 5. Download the 2006 microdata survey using download.file() ----
##    using the fread() command load the data into an R object "DT"
##    The following are ways to calculate the avg value of the var `pwgtp15`
##    broken down by sex. 
##    Using the data.table package, which will deliver the fastest user time?
library(data.table)
url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url5,"Data/ACS_5")

DT <- fread("Data/ACS_5")

system.time(rowMeans(DT)[DT$SEX==1])
;rowMeans(DT[DT$SEX==2]))
DT$pwgtp15


# Not sapply