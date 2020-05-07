library(tidyverse)

# load data 
childcare <- read_csv("data/childcare.csv")




#####################################################################
##########                      mutate                     ##########
#####################################################################

# add new variables that are functions of exising ones with mutate 
childcare %>% head()

# the mutate function always adds a new variables to your dataframe 
mutate(childcare, bf_perc = bf_ratio * 100) %>%
  select(id, bf_ratio, bf_perc, everything()) %>%
  tail(5)
  
# you can also use it to replace exising variables:
mutate(childcare, birthweight = round(birthweight)) %>%
  head()
  
# or you can use transmute if you only want to keep the new variables:
childcare_s <- transmute(
  childcare, 
  age_d_s = (age_d - mean(age_d, na.rm = TRUE)) / sd(age_d, na.rm = TRUE), 
  shannon_s = scale(shannon)[, 1], 
  birthweight_s = scale(birthweight)[, 1]
)



# Show why we have to use the [, 1]
scale(childcare$birthweight) %>% class()



# There are many functions for creating new variables that you can use with
# mutate(). The key property is that the function must must take a vector of
# values as input and return a vector with the same number of values as output.


#####################################################################
##########               summarise                         ##########
#####################################################################



# Grouped summaries with summarise()
# summarise() summarises a variable of choice according to functions of choice:

summary_df <- summarise(
  childcare, 
  mean_birthweight = mean(birthweight, na.rm = TRUE),
  sd_birthweight = sd(birthweight, na.rm = TRUE),
  n = n()
)

summary_df

# This summary function is much more useful if you pair it with the group_by
# function!


# we can create summaries for subgroups:
childcare %>% group_by(csection) %>%
  summarise(
    mean_birthweight = mean(birthweight, na.rm = TRUE),
    sd_birthweight = sd(birthweight, na.rm = TRUE),
    n = n()
  )
  
# and also for multiple groups, e.g. here are 4 subgroups
childcare %>% group_by(csection, sibling) %>%
  summarise(
    mean_birthweight = mean(birthweight, na.rm = TRUE),
    sd_birthweight = sd(birthweight, na.rm = TRUE),
    n = n()
  )
  

# some examples how these functions can be used:

# How many distinct ages are there?
childcare %>% summarise(n = n(), n_dis_age = n_distinct(age_d))

# how many non missing values in birthweight ?
childcare %>% summarise(n = n(), n_birthweight = sum(!is.na(birthweight)))

# google "dplyr summary functions" for more possibilities and try to understand 
# the common principles of all these functions!


# there is a shortcut to group_by() %>% summarise(n = n())
childcare %>% count(csection)



# Remember from the first lecture that logical values are suitable
# to count or summarise? Here is another example of that:
childcare %>% group_by(sibling) %>% 
  summarise(
    older_than60d_count = sum(age_d > 70),
    older_than60d_prop = mean(age_d > 70)
  )


# grouped mutates (and filters)
# summarise() is most useful with group_by() but also mutate and filter make
# sense using so called windows functions. See for many examples
# https://dplyr.tidyverse.org/articles/window-functions.html

# e.g. find the 2 youngest children in each subgroup of sex * sibling
childcare %>%
  group_by(sex, sibling) %>%
  filter(rank(age_d, ties.method = "average") <= 2)


# ... or standardize per group instead of all values combined
childcare %>% group_by(sex) %>%
  mutate(s_persex_birthweight = scale(birthweight)[, 1])
  
# to stop working with the grouped dataframe you need to use ungroup()
childcare %>% group_by(sex) %>%
  # ... %>%
  ungroup() %>%
  mutate(s_persex_birthweight = scale(birthweight)[, 1])
  
  
  
# see e.g. https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html
# for repetition and also google other dplyr possibilities of interest 

# For many of these operations, there are already functions (even in base R but 
# especially in other packages). E.g.
summary(childcare)

# However, you probabaly want to be able to create your own specific statistic
# of interest and also for the specific groups of your interest. Once you learn 
# dplyr functions you will get very flexible in manipulating and summarising
# your data!






#####################################################################
##########               Functions                         ##########
#####################################################################



# structure of functions 
function_name <- function(argument1, argument2) {
  
  # this is the body of a function
  
  # return the output using return() 
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
  mutate_if(is.numeric, round, 3)

coef_table
  
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

coefs(model = lm_fit)




# an even simpler example: standardize
x <- c(1, 2, 3, 4)

# to standardize we write: 
(x - mean(x)) / sd(x)

# assuming there was no scale function in R we could create one:
standardize <- function(x) {
  x_s <- (x - mean(x)) / sd(x)
  return(x_s)
}

standardize(x)








  
# the coef function can easily be extended like this:

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

# To make this more readable we use curly brackets {}

x <- 2
if (condition) {
  x <- x^2
 } else {
  x <- x - 2
}



# for if statements use && and || instead of & and | because 
# the latter are vectorized 


# "if" always take a value of length 1, otherwise you get a warning:

if(c(TRUE, FALSE)) print("hi")
# we can use ifelse for vectors
ifelse(c(TRUE, FALSE, TRUE, TRUE, FALSE), "hi", "ciao")


# now we can use our new skills in combination with the mutate function:

# example 1
childcare %>%
  mutate(groups = ifelse(csection & sibling, 1, 2)) %>%
  select(id, csection, sibling, groups) %>%
  tail(20)

# example 2
mtcars %>%
  mutate_if(is.numeric, function(var) var * 2) 



# read more about mutate_if, mutate_all with custom functions at 
# https://dplyr.tidyverse.org/reference/mutate_all.html


# to read about control flow from another source see e.g.
# https://data-flair.training/blogs/r-control-structures/

# we will cover loops (for, while etc.) next week







