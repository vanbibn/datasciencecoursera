# Nathan W. Van Bibber
# 3/23/2020
# Coursera - R Programming ####
# 
## Week 3 Quiz ====

### 1. In the iris dataset:                                                ---- 
###    what is the mean of 'Sepal.Length' for the species virginica? 
# Please round your answer to the nearest whole number.

library(datasets)
data("iris")
?iris
head(iris)
tapply(iris$Sepal.Length, iris$Species, summary)

# mean of virgincia == 6.588 which rounds up to 7

### 2. Continuing with the 'iris' dataset from the previous Question,       ----
###    What R code returns a vector of the means of the variables 'Sepal.Length', 
###    'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

apply(iris[, 1:4], 2, mean) # 2 indicates columns - see documentation
colMeans(iris[,1:4])


### 3. Load the 'mtcars' dataset in R                                      ----
###    How can one calculate the average miles per gallon (mpg) 
###    by number of cylinders in the car (cyl)? Select all that apply.

data("mtcars")
# lapply(mtcars, mean)
# sapply(mtcars, cyl, mean)
# apply(mtcars, 2, mean)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$mpg, mtcars$cyl, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
# mean(mtcars$mpg, mtcars$cyl)


### 4. Continuing with the 'mtcars' dataset from the previous Question,    ----
###    what is the absolute difference between the average horsepower of 
###    4-cylinder cars and the average horsepower of 8-cylinder cars?

avg_hp <- sapply(split(mtcars$hp, mtcars$cyl), mean)
avg_hp["8"] - avg_hp["4"] # 126.5779 rounds to 127



### 5. If you run `debug(ls)`                                              ----
###    what happens when you next call the 'ls' function?

debug(ls)
ls()
