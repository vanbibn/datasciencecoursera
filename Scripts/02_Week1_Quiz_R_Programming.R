# Nathan W. Van Bibber
# 3/30/20

# Coursera - R Programming 
## Week 1 Quiz

library(tidyverse)

dat <- read_csv("Data/hw1_data.csv")
dat
head(dat)

# 15. What is the value of Ozone in the 47th row?
dat[47,]

# 16. How many missing values are in the Ozone column of this data frame?

dat %>% 
    select(Ozone) %>% 
    is.na() %>% 
    sum()


# 17. What is the mean of the Ozone column in this dataset? Exclude missing values

mean(dat$Ozone, na.rm = T)

# 18. Extract the subset of rows where Ozone values are above 31 and 
#     Temp values are above 90. What is the mean of Solar.R in this subset?

sub1 <- dat %>% 
    filter(Ozone > 31 & Temp > 90)
sub1
mean(sub1$Solar.R)

# 19. What is the mean of "Temp" when "Month" is equal to 6?

sub2 <- dat %>% 
    filter(Month == 6)
sub2
mean(sub2$Temp)


# 20. What was the maximum ozone value in the month of May (i.e. Month = 5)?

dat %>% 
    filter(Month == 5) %>% 
    arrange(desc(Ozone))


# 9. Suppose I have a vector x <- 1:4 and y <- 2:3. 
#    What is produced by the expression x + y?

x <- 1:4
y <- 2:3

z <- x + y
class(z)

