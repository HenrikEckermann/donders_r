#####################################################################
##########               ggplot2 basics                    ##########
#####################################################################

# load data 
childcare <- read_csv("data/childcare.csv")

# install.packages("gapminder")
library(gapminder)
library(tidyverse)






head(gapminder)

class(gapminder)

# 1 Scatter plots (also called bivariate plots)
# input: two numerical variables 
head(childcare)

basic_plot <- ggplot(data = childcare, mapping = aes(x = csection, y = shannon)) +
  geom_point()

class(basic_plot)


# we can add another layer of geometric object. E.g. a regression line:
basic_plot + 
  geom_smooth(method = "lm", formula = "y ~ x")





#####################################################################
######### For, while and a glimpse at the convenient: purr ##########
#####################################################################




# A for loop repeats the same code for the number of times that a vector is
# long. Before we do someting useful with tha, lets do something silly to
# understand for loops:




# we have character vector 
thoughts <- c("Corona", "No party", "No barbecue", "Only learning R")


for (i in thoughts) {
  # body
  print("I was thinking about...")
  print(i)
}



for (i in thoughts) {
  print("I was thinking about...")
  print(i)
  
  if (i != "Only learning R") {
    print("Then...")
  } else {
    print("...OK, now I start meditating...")
  }
}


# you could read it as: Let "i" be the element that is in the vector "thoughts"
# starting with the first one so that i <- "Corona". Then execute the code in
# the body {} until "i" has been each element of the vector thoughts once
# starting from first and ending with last.





# now lets try to do something useful with it. Lets say you would want to plot 
# an outome separately with each predictor and store these plots in a list. 

head(mtcars)

outcome <- "mpg"
predictors <- colnames(mtcars)[colnames(mtcars) != "mpg"]
length(predictors)
predictors


# create a list where we store the plots
plots <- list()



# create and store the plots
for (predictor in predictors) {
  p <- ggplot(data = mtcars, aes_string(x = predictor, y = outcome)) +
    geom_point() +
    geom_smooth(method = "lm")
  plots[[predictor]] <- p
  
}


# now inspect your list:
names(plots)
length(plots)
# e.g. 
class(plots)

plots$drat






# I want you to be aware of the more general form of how to apply for loops 
# using indices rather than the elements of a vector directly:


# we need to first learn what seq_along() does. It does the same as:

1:length(thoughts)
# but seq_along is safer to use (the details are not important)
seq_along(thoughts)


for (i in seq_along(thoughts)) {
    print("I was thinking about...")
    print(thoughts[i])
    
    if (thoughts[i] != "Only learning R") {
      print("Then...")
    } else {
      print("...OK, now I start meditating...")
    }
}

# you could read it as: Let "i" be the index of the elements in thoughts
# starting with the first one so that i <- 1. Then execute the code in the body
# {} until "i" has been each index numer once starting from first ending with
# the last.



# while loops
# useful when you do not know how many iterations you need:

# basic structure:
condition <- (FALSE) 
while (condition) {
  # body
}


# e.g. 

i <- 1
while (i <= length(thoughts)) {
  print(thoughts[i])
  i <- i + 1
}




# I can highly recommend that you use the purrr package and the so called map 
# functions. They are a bit harder to understand than the for loop but once 
# master them, you will find yourself using them all the time as they save you
# time and effort. Here is a simple example: 

map(thoughts, function(x) {
  x
})

# or the short version of this 
map(thoughts, ~.x)


# the plot example:
plots <- map(predictors, function(predictor) {
  ggplot(mtcars, aes_string(predictor, outcome)) +
   geom_point() +
   geom_smooth(method = "lm", formula = "y ~ x")
})

plots[[2]]

# start out by reading here if you want to master map:
# https://purrr.tidyverse.org/





