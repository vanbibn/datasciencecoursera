# Nathan W. Van Bibber
# 3/30/20

# Coursera - R Programming 
## Week 4 - Programming Assignment


# Note data for assignment not tracked with Git 
# Data can be downloaded here:
# https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip


### Hospital Quality

## 1. Plot the 30-day mortality rates for heart attack ----

#Read the outcome data into R via read.csv and look at the first few rows.
outcome <-  read.csv("Data/data_ProgAssignment3/outcome-of-care-measures.csv", 
                     colClasses = "character")
head(outcome)

# see how many columns
ncol(outcome)
names(outcome)
nrow(outcome) 

names(outcome[11])


# originally read in as character so coerce col to be numeric
outcome[,11] <- as.numeric(outcome[,11])  # warning about NA's included is OK!

# make a simple histogram of the 30-day death rates from heart attack (col 11)
hist(outcome[,11])



## 2. Finding the best hospital in a state ----

##Examples of data validation:
# if (!dir.exists(directory)) {
#     
#     stop("Sorry, Invalid Directory! Please specify a valid directory for data files.")
#     
# }
# 
# if (!grepl("(sulfate|nitrate)",pollutant,ignore.case =TRUE)) {
#     
#     stop("Please specify a valid Pollutant Name ==> either 'sulfate' or 'nitrate'.")
#     
# }
