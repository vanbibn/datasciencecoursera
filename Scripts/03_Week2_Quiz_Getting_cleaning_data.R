# Nathan W. Van Bibber
# 3/28/20

# Coursera Getting and Cleaning Data 
## Week 2 Quiz


# 1.  Register an application with the Github API.  Use this data to find ----
#     the time that the datasharing repo was created. What time was it created?

#### No idea how. (correct!) Guessed 2013-11-07  based on pull request history


# 2. Which of the following commands will select only the data for the ----
#    probability weights pwgtp1 with ages less than 50?

# Guessed(X-incorrect): sqldf("select * from acs where AGEP < 50 and pwgtp1")


# 3. what is the equivalent function to unique(acs$AGEP)  ----

# Ans. sqldf("select distinct AGEP from acs")


# 4. How many characters are in the 10th, 20th, 30th and 100th lines of HTML from:
#    http://biostat.jhsph.edu/~jleek/contact.html

library(httr)
library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
 
html <- GET(url)
cont <- content(html, as = "text")
parsedHtml <- htmlTreeParse(html, useInternalNodes = TRUE)
length(parsedHtml)

html[10]

nchar(html[30])

#### Not working guessed 45, 31, 7, 25 (correct!)




# 5. Read this data set into R and 
#    report the sum of the numbers in the fourth of the nine columns.
library(tidyverse)

# data: "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

nino <- read_table("Data/getdata_wksst8110.for", skip = 3)

temp <- readLines("Data/getdata_wksst8110.for")
Nnames <- c("Week", "SST_12", "SSTA_12", "SST_3", "SSTA_3", "SST_34", "SSTA_34", "SST_4", "SSTA_4")
nino2 <- read_fwf(temp, fwf_widths(c(10,rep(c(9,4), 4)), c(Nnames)), skip = 4)

sum(nino2[4])


