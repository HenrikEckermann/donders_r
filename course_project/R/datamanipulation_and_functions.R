library(tidyverse)

# load data 
childcare <- read_csv("data/childcare.csv")



#####################################################################
##########               Homework session 3                ##########
#####################################################################



# 5. Create another new R file called dataframes.R. Open it. In R, there is a preloaded dataframe called "mtcars". Using only the methods we learned today, try to perform the following actions:
#    - Take a look at the first 10 rows and last 10 rows

head(mtcars)

tail(mtcars)


# - Create a new dataframe that only retains the columns mpg, disp and hp of cars that have 6 cylinders (cyl is the column for the number of cylinders). First use the base R method using the brackets. Then use dplyr functions to achieve the same!

# base R
df <- mtcars[mtcars$cyl == 6, c("mpg", "disp", "hp")]

# dyplyr 
df <- mtcars %>%
  filter(cyl == 6) %>%
  select(mpg, disp, hp)

# Note that the rownames are gone because the use of rownames in tidyverse 
# is deprecated. You can use rownames_to_column("name_of_column")
# e.g. 

dfr <- mtcars %>% 
  rownames_to_column("car") %>%
  filter(cyl == 6) %>%
  select(car, mpg, disp, hp)


# - How many observations are in this new dataframe?
dim(df)
df

# - export that file to an excel file in your data folder
writexl::write_xlsx(df, path = "data/select_cars.xlsx")








#####################################################################
##########               Data manipulation                 ##########
#####################################################################

# add new variables that are functions of exising ones with mutate 
childcare

# the mutate function always adds a new variables to your dataframe 
mutate(childcare, bf_perc = bf_ratio * 100) %>%
  select(id, bf_ratio, bf_perc, everything()) %>%
  tail(5)
  
# you can also use it to replace exising variables:
mutate(childcare, birthweight = round(birthweight)) %>%
  head()
  
childcare
# or you can use transmute if you only want to keep the new variables:
childcare_s <- transmute(
  childcare, 
  age_d_s = (age_d - mean(age_d, na.rm = T)) / sd(age_d, na.rm = T),
  shannon_s = scale(shannon)[, 1],
  birthweight_s = scale(birthweight)[, 1]
)

# Show why we have to use the [, 1]
scale(childcare$birthweight)
  
  



# There are many functions for creating new variables that you can use with mutate(). The key property is that the function must must take a vector of values as input, return a vector with the same number of values as output.






# Grouped summaries with summarise()
# summarise() collapses a dataframe to a single row:

summarise(
  childcare, 
  mean_birthweight = mean(birthweight, na.rm = TRUE),
  sd_birthweight = sd(birthweight, na.rm = TRUE),
  n = n()
)


# This summary function is much more useful if you pair it with the group_by
# function!

childcare

childcare %>% group_by(csection) %>%
  summarise(
    mean_birthweight = mean(birthweight, na.rm = TRUE),
    sd_birthweight = sd(birthweight, na.rm = TRUE),
    n = n()
  )
  
  
childcare %>% group_by(csection, sibling) %>%
  summarise(
    mean_birthweight = mean(birthweight, na.rm = TRUE),
    sd_birthweight = sd(birthweight, na.rm = TRUE),
    n = n()
  )
  


# How many distinct ages are there?
childcare %>% summarise(n = n(), n_dis_age = n_distinct(age_d))

# how many non missing values in birthweight ?
childcare %>% summarise(n = n(), n_birthweight = sum(!is.na(birthweight)))


# there is a shortcut to group_by() %>% summarise(n = n())
childcare %>% count(csection)

# the same function can be uses to sum a "weight" variable instead of just 
# counting 
head(childcare)
childcare %>% count(csection, wt = age_d)

# Remember from the first lecture that logical values are great 
# to count or summarise:
childcare %>% group_by(sibling) %>% 
  summarise(
    older_than60d_count = sum(age_d > 70),
    older_than60d_prop = mean(age_d > 70)
  )


# grouped mutates (and filters)
# summarise is most useful with group_by but also mutate and filter make sense
# using so called windows functions. See for many examples
# https://dplyr.tidyverse.org/articles/window-functions.html

# e.g. find the 2 youngest children in each subgroup of sex * sibling
childcare %>%
  group_by(sex, sibling) %>%
  filter(rank(age_d, ties.method = "average") <= 2)



# standardize per group 
childcare %>% group_by(sex) %>%
  mutate(s_persex_birthweight = scale(birthweight)[, 1])
  
# to stop working with the grouped dataframe you need to use ungroup()
childcare %>% group_by(sex) %>%
  # ... %>%
  ungroup() %>%
  mutate(s_persex_birthweight = scale(birthweight)[, 1])
  
  
  
# see e.g. https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html
# for repetition and also google other dplyr possibilities of interest 






#####################################################################
##########               Functions                         ##########
#####################################################################



# structure of functions 
function_name <- function(argument1, argument2) {
  # this is the body of a function
  
  # return something using return() 
}





# simple example: create table for regression model

# fit the model 
lm_fit <- lm(mpg ~ 1 + cyl + wt + disp , data = mtcars)


# instead of typing over and over:
coef_table <- lm_fit %>% 
  summary() %>%
  coef() %>%
  as.data.frame() %>%
  rownames_to_column("Coefficient") %>%
  mutate_if(is.numeric, round, 2)
  
  
# you can write a function:

coefs <- function(model) {
  coef_table <- model %>% 
    summary() %>%
    coef() %>%
    as.data.frame() %>%
    rownames_to_column("Coefficient") %>%
    mutate_if(is.numeric, round, 3)
    
  return(coef_table)
}


# and then write 

coefs(model)
  
# this function can easily be extended like this:

summarise_regression <- function(data, formula) {
  # fit model
  
  # test assumptions
  
  # create output table in APA format 
  
  # return list(model, assumptions summary (incl plots), apa table)
}

# we only covered the very basics of writing functions. For repetition or more 
# content start e.g. here: https://www.tutorialspoint.com/r/r_functions.htm





#####################################################################
##########          Conditional execution                  ##########
#####################################################################

condition <- FALSE 
if (condition) print("Hi") else print("Bye")


if (!TRUE) print("Hi") else if (!!FALSE) print("Bye") else print("Ciao")

# To make this more readable we use curly brackets"

x <- 2
if (condition) {
  x <- x^2
 } else {
  x <- x - 2
}

# for if statements use && and || instead of & and | because 
# the latter are vectorized 

if (TRUE && TRUE) print("hi")

# if always take a value of length 1, otherwise you get a warning:

if(c(TRUE, FALSE)) print("hi")
# we can use ifelse for that 
ifelse(c(TRUE, FALSE, TRUE, TRUE, FALSE), "hi", "ciao")


# now we can use our new skills in combination with the mutate function:

# example 1
childcare %>%
  mutate(groups = ifelse(csection & sibling, 1, 2)) %>%
  select(id, csection, sibling, groups)

# example 2
mtcars %>%
  mutate_if(is.numeric, function(var) var * 2)

# read more about mutate_if, mutate_all with custom functions at 
# https://dplyr.tidyverse.org/reference/mutate_all.html


# to read about control flow from another source see e.g.
# https://data-flair.training/blogs/r-control-structures/

# we will cover loops (for, while etc.) next week







