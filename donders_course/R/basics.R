# Introduce keyboard shortcut Cmd/Ctrl + Enter 



# In general, load packages in the beginning of a script:
library(tidyverse)

# Avoid functions to install packages or settings change in your script such as
# install.packages("tidyverse") or 
# setwd("/users/henrik/...")





# R as calculator ---------------------------
10 + 10 / 5 

(10 + 10) / 5 
2^4

2**4

sqrt(9)


sin(pi / 2)



# Intro to R objects, object assignment and functions ---------------------------

# create new objects using the assignment operator "<-"
x <- 3 * 4


# object names and the combine function

weeks_bf <- c(28, 51, NA, 43, 65)
WeeksBf <- c(28, 51, NA, 43, 65)
weeks.bf <- c(28, 51, NA, 43, 65)

# to check the object name type it and execute
weeks_bf 

# you must be precise: typos matter. Case matters!
week_bf 
week_Bf


# structure of functions 
function_name(arg1 = val1, arg2 = val2, ...)

# example 1
mean(x = weeks_bf)

# if your not familiar with a function type ?function_name in Rstudio or google "function_name R"

?mean 

mean(weeks_bf, na.rm = FALSE)
mean(weeks_bf, na.rm = TRUE)


# example 2
seq(from = 1, to = 10, by = 0.5)
seq(1, 10, 0.5)



# character
"hello"

# must be pairs of "

# same with (





# Vectors  ---------------------------

# 2 key properties that you can check with the functions:
# 1: class(vector) OR typeof(vector)
# 2. length(vector)

character_vector <- c("this", "is", "a", "character", "vector", NA)
class(character_vector)
typeof(character_vector)
length(character_vector)


logical_vector <- c(TRUE, FALSE, FALSE, TRUE)
logical_vector2 <- c(T, F, T, F, F, T)
logical_vector3 <- is.na(character_vector)
logical_vector4 <- c(2 == 3, 4 != 4, 2 * 2 == 4)
logical_vector3

class(logical_vector)

double_vector <- c(0.25, 0.123, 5.838238323232)
class(double_vector)


integer_vector <- c(1L, 5L, 7L)
numeric_vector <- c(1, 5, 7)

class(integer_vector2)
class(numeric_vector)


a_list <- list(logical_vector2, character_vector, numeric_vector)
class(a_list)
a_list



# explicit coercion of vectors
as.numeric(logical_vector)
as.logical(numeric_vector) # never used this
as.numeric(character_vector)
as.character(numeric_vector)

# automatic coercion happens when a function expects a certain type
mean(logical_vector) # this is useful to calculate percentage of TRUE/FALSE
sum(logical_vector)  # ... to calculate the sum of TRUE

 


# behavior of vectors

# example 1
v1 <- 1:10 
v2 <- 10:19
length(v1)
length(v2)

v1 + v2 

# example 2
v3 <- 100
length(v3)

v1 + v3

# example 3
v4 <- c(-100, 100)
length(v1)
length(v4)

v1 + v4

# example 4
v5 <- c(1:3)
length(v4)

v1 + v4



# naming of vectors
named_numeric_vector <- c(Jennifer = 65, Luis = 50, Oliver = 58, Nate = 21)
named_numeric_vector
names(named_numeric_vector)

v1 <- c(10, 12, 9)
names(v1) <- c("Jennifer", "Oliver", "Nate")
v1




# Subsetting vectors: names, integers and logical values

# names
v1["Jennifer"]
v1[c("Jennifer", "Nate")]

# integers
v1[1]
v1[2:3]
v1[c(2, 3)]
v1[-1]
v1[c(-1, 2)]

# logical values 
v1 > 10
v1[v1 > 10]



# factors
# factors are designed to represent categorical data

character_vector <- c("male", "female", "female", "male")
factor_vector <- factor(character_vector, levels = c("male", "female"))
factor_vector



# Lists ---------------------------

# What makes a list a list
a_list <- list("a", 1L, TRUE)
class(a_list)
str(a_list)

another_list <- list(a_list, 3, "2", a_list)
str(another_list)

# subsetting of lists
a_list[1]
class(a_list[1])
a_list[[1]]
class(a_list[[1]])


# for named lists we have more options
a_list_named <- list(a = "a", b = 1L, c = TRUE)
a_list_named["a"] 
a_list_named[["a"]]
# The $ sign is a shortcut to using [[]] for lists
a_list_named$a 



# Dataframes and Tibbles ---------------------------



