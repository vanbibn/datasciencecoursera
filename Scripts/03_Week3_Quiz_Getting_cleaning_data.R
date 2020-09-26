# Nathan W. Van Bibber
# 04/30/20

# Coursera Getting and Cleaning Data 
## Week 3 Quiz

library(tidyverse)

# 1.
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

dat <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# agLogical_1 <- dat %>% 
#     filter(ACR == 3 & AGS == 6) %>% 
#     print()
# agLogical <- dat[dat$ACR == 3 & dat$AGS == 6,]
# which(agLogical)

dat[which(dat$ACR == 3 & dat$AGS == 6),]

# Ans: 125, 238, 262

# 2. 

library(jpeg)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "Data/hw3pic.jpg")
pic <- readJPEG("Data/hw3pic.jpg", native = TRUE)
quantile(pic, probs = c(0.3, 0.8))

638 + quantile(pic, probs = c(0.3, 0.8))

# Ans: -15259150 -10575416



# 3.
#Ans: 189 matches, 13th country is St. Kitts and Nevis


ds1 <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", skip = 4)
ds2 <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
ds3 <- ds1[1:190,c(1,2,4,5)]

names(ds3) <- c("CountryCode", "Ranking", "Country.Name", "GDP")

ds4 <- ds3 %>% 
    mutate(GDP = as.double(GDP), Ranking = as.double(Ranking))

# data are Rank and GDP getting all fucked up by this join
tot <- merge(ds4, ds2, by = "CountryCode")
tot1 <- merge(ds4, ds2, sort = TRUE)

data.frame(ds2, ds4, check.rows = TRUE)

# And this one! WTF!!!
total <- inner_join(ds2, ds4)

total %>% arrange(desc(Ranking))

sort(tot1$Ranking, decreasing = TRUE)


# 4.

tot %>% group_by(Income.Group) %>% 
    select(GDP) %>% 
    summarise()

F1 <- tot %>% filter(Income.Group == "High income: OECD")

class(F1$Ranking)
mean(F1$Ranking)    

#High income: nonOECD = 91.91304
#High income: OECD = 32.966667



# 5.

# Ans 0 or 5 (not 3 or 18 already tried those)