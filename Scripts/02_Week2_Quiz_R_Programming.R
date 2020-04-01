# Nathan W. Van Bibber
# 3/30/20

# Coursera - R Programming 
## Week 2 Quiz

# Note the directory "Data/specdata/" is not tracked with git
# data can be downloaded here:  
#    https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip

list.files("Data/specdata/")
library(tidyverse)

### Part1 ----
# Write a function that calculates the mean of a pollutant (sulfate or nitrate) 
#  across a specified list of monitors. The function takes three arguments: 
#     directory, pollutant, and id. 
#  Given a vector of monitor ID numbers:
#     read the particulate matter data from the specified monitors in directory
#     return the mean of the pollutant across all monitors, ignoring NA values.

pollutantmean <- function(directory, pollutant, id = 1:332) {
    files <- list.files(directory)
    df <- NULL
    for (i in id) {
        df <- rbind.data.frame(df, read.csv(paste0(directory,files[i])))
    }
    return(mean(df[[pollutant]], na.rm = TRUE))
}

pollutantmean("Data/specdata/", "nitrate", 23)
pollutantmean("Data/specdata/", "sulfate", 1:10)
pollutantmean("Data/specdata/", "sulfate", 34)
pollutantmean("Data/specdata/", "nitrate", 70:72)
# pollutantmean("Data/specdata/", "nitrate") # reads every file, takes many secs 
# 
# system.time(pollutantmean("Data/specdata/", "nitrate"))
###  user  system elapsed 
### 14.81    1.45   16.25 


### Part 2 ----
# Write a function that reads a directory full of files and reports the 
# number of completely observed cases in each data file. The function should:
#     return a data frame where: 
#         first column is the name of the file and the 
#         second column is the number of complete cases.

complete <- function(directory, id = 1:332) {
    files <- list.files(directory)
    df <- NULL
    for (i in id) {
        nobs <- sum(complete.cases(read.csv(paste0(directory,files[i]))))
        df <- rbind.data.frame(df, c(i, nobs))
    }
    colnames(df) <- c("id", "nobs")
    df
}

complete("Data/specdata/", 54)
complete("Data/specdata/", c(2, 4, 8, 10, 12))
complete("Data/specdata/", 30:25)

cc <- complete("Data/specdata/", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

#7. What value is printed at end of the following code?
RNGversion("3.5.1")  
set.seed(42)
cc <- complete("Data/specdata/", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])


### Part 3 ----
# Write a function that takes a directory of data files and a threshold for 
# complete cases and: 
#     calcullate correlation btw sulfate and nitrate for monitor locations 
#         complete() > threshold
#     return a vector of correlations for monitors that meet threshold. 
#     return a numeric vector of length 0 If no monitors meet threshold."

comp <- complete("Data/specdata/")


corr <- function(directory, threshold = 0) {
    #comp <- complete("Data/specdata/")
    corrvec <- 0
    if (comp > threshold) {
        #calculate cor
    } 
    return(corvec)
}


sapply(comp, cor)

comp %>% 
    filter(nobs > 129)

###

library(datasets)
s <- split(airquality, airquality$Month)
str(s)

sap <- sapply(s, function(x) {
    colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T)
})

airquality %>% 
    select(Month, Ozone, Solar.R, Wind) %>% 
    group_by(Month) %>%
    summarise(Ozone = mean(Ozone, na.rm = T),
              Solar.R = mean(Solar.R, na.rm = T),
              Wind = mean(Wind, na.rm = T))
